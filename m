Return-Path: <linux-kselftest+bounces-4774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B75856843
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD7A1C23CE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442121350D7;
	Thu, 15 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="wgb4qL0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870121339BD;
	Thu, 15 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011876; cv=none; b=Jh5TeUjCNMrIHciaaVezhZiC0QnFc8kQ8ht1NX0DDLFp+EWcs5AcYvv3COvHezbMbnsnCSdnl3KSyW8/V20u3v+p4Hzh+NEdhXHHO7ecXQ9IJJmzOURGbxHjHs35msHEHBHo4olLOmfqPuIosn1QZHDLtolXJOScdylR5/PnMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011876; c=relaxed/simple;
	bh=JLTFPO4km9t6WgVDF7QUbKbf0ie6nq3sTq43ni7ffp8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzjQ1a86usn7lYtq6AAj/3oD0e6enCn7a5g6aDke8Ae6GZ76lYE3RRVU+3jBbGuKqi/C2sWM1wrHNT1LVOFnWeIO07QcjVa/ZxWOwF+7X984sAASEzJO1wHo++ArtMdA8YRReJySYjywDqG6wRwfX4cC9xfwCr1623P9t65pN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=wgb4qL0E; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=w0IMfkwDRcUALjTNcpBQinShCHJq/t16b2aLsdRf4Ls=; b=wgb4qL0EEr4Ygago0j4nJTNSA6
	yHbImGVQPNUzvKsiEmpBmsO8yvAh4khvPqhE/sP+fM+C1pHWE2YJ18/c+QOoSoS3fdRCnMXlYw7vn
	+usDd9T030T0ZLxDPbVNoo8/QEPVGkFGZBf1nndIv94bFuypayGlIubpbzs4gieQgjGg=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduM-0001WW-8V; Thu, 15 Feb 2024 15:44:18 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhQ-00089r-M1; Thu, 15 Feb 2024 15:30:56 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
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
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 16/21] KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
Date: Thu, 15 Feb 2024 15:29:11 +0000
Message-Id: <20240215152916.1158-17-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
References: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

Now that all relevant kernel changes and selftests are in place, enable the
new capability.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v13:
 - Patch title change.

v2:
 - New in this version.
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31cd5d803dae..9f98c5075629 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4673,7 +4673,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		    KVM_XEN_HVM_CONFIG_SHARED_INFO |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
-		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
+		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE |
+		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA;
 		if (sched_info_on())
 			r |= KVM_XEN_HVM_CONFIG_RUNSTATE |
 			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
-- 
2.39.2


