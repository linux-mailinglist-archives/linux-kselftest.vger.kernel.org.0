Return-Path: <linux-kselftest+bounces-1054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A4803806
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC71C20AF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC62C1A5;
	Mon,  4 Dec 2023 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="eQtjgR7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0754D3;
	Mon,  4 Dec 2023 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=phFzjY56QcX+1gb6i8CFML6EdpSEnZzV/NxGbDVl3Vg=; b=eQtjgR7HOmnVRKsIRii04iBYvd
	R2F6jefB8+JSCKgI9+fk9rltQGNnbyGj5aURRkMIXuAFr5t1bvKQ0Rc7StotMXVjlqo8yKUX0U3eW
	QqzT7iQWClPK8DW1l1jgv523aJ3Yp5S/bw2l791crcW7G9+nbWrJ/iwAZDm54FUZu2Bk=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAQk-00043b-KN; Mon, 04 Dec 2023 15:00:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAABZ-00088g-IS; Mon, 04 Dec 2023 14:44:37 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 18/19] KVM: pfncache: check the need for invalidation under read lock first
Date: Mon,  4 Dec 2023 14:43:33 +0000
Message-Id: <20231204144334.910-19-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

Taking a write lock on a pfncache will be disruptive if the cache is
heavily used (which only requires a read lock). Hence, in the MMU notifier
callback, take read locks on caches to check for a match; only taking a
write lock to actually perform an invalidation (after a another check).

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v10:
 - New in this version.
---
 virt/kvm/pfncache.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index c2a2d1e145b6..4da16d494f4b 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -29,14 +29,30 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 
 	spin_lock(&kvm->gpc_lock);
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
-		write_lock_irq(&gpc->lock);
+		read_lock_irq(&gpc->lock);
 
 		/* Only a single page so no need to care about length */
 		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
 		    gpc->uhva >= start && gpc->uhva < end) {
-			gpc->valid = false;
+			read_unlock_irq(&gpc->lock);
+
+			/*
+			 * There is a small window here where the cache could
+			 * be modified, and invalidation would no longer be
+			 * necessary. Hence check again whether invalidation
+			 * is still necessary once the write lock has been
+			 * acquired.
+			 */
+
+			write_lock_irq(&gpc->lock);
+			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
+			    gpc->uhva >= start && gpc->uhva < end)
+				gpc->valid = false;
+			write_unlock_irq(&gpc->lock);
+			continue;
 		}
-		write_unlock_irq(&gpc->lock);
+
+		read_unlock_irq(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
 }
-- 
2.39.2


