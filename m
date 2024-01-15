Return-Path: <linux-kselftest+bounces-2979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B819982D9A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD02821AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1117BA3;
	Mon, 15 Jan 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="ioaQBr0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D9175B9;
	Mon, 15 Jan 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=z7zH+v6OnxjwAjiPJoCCBsbBFCz5/p3/vhyVHwUde2s=; b=ioaQBr0o5KTn9Br5QwqGYCUaG3
	cA8gKp8XP14OrX09JaP3bWITXuVxtZ4KhlKAPJT0VuhtQoREzz7+C1LEDXb1enNxkELT3/ZO49gsM
	eATdbbyFhpqDdsNdeYA85Ier3DbXG1O1PgbvHWoiGO1qZrjvReY4VwsonrKvX8HJM6SA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMiY-00035a-Ik; Mon, 15 Jan 2024 13:09:30 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXf-0002kM-QU; Mon, 15 Jan 2024 12:58:16 +0000
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
Subject: [PATCH v12 18/20] KVM: pfncache: check the need for invalidation under read lock first
Date: Mon, 15 Jan 2024 12:57:05 +0000
Message-Id: <20240115125707.1183-19-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
References: <20240115125707.1183-1-paul@xen.org>
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
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
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
index ae822bff812f..70394d7c9a38 100644
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


