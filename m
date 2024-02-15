Return-Path: <linux-kselftest+bounces-4775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E3856848
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D1E1C23583
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DE1353E9;
	Thu, 15 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="PKyFH96e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E8134745;
	Thu, 15 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011876; cv=none; b=JD2b2bojw5Jyf9A5LBHdjmY6HTbAoyPadkGHqOaAK1RCmeD9E0PyiB+VDebYVWZR9G0pS4OO1V0rYJ6U/E+ItXYL0qRaMXBJ1z/qsx1fSaAnai9IzxR6H681nZUxJiUlhRGgtU1dBPPodaCe5+VpFbZpqrHyyk0w5/EIbi4+Cgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011876; c=relaxed/simple;
	bh=vD0tK+73URbDnBXkj88m52MT44LmjoIEES/dfYqUt+k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=libeWYlxeCClNMmGFqVwFRuITGCr7VNXdn+ygHczpv8oI0dVUIexAyaaHuYZQBgUfZ616ZmFrFLoAgEgBei5HqN947n1PNPeO4kXoUhoSMI10GIsm6cXBDo9vWiqHsdFYQ7MxFLcngcoacqDtuoYQ+HOcptvM0jZo1VIDNNTQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=PKyFH96e; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=tu7qwya2jtZUkrGPS+XN5zC966KqDMkYx6RM2c1jNNc=; b=PKyFH96eF/msDV4UydBnvnU65q
	q7/PuS+babK9499TsL2cxQ/CmKOo9mBDnN1YPI2rwLlUPZr0dtcoCjvGwskfFSkBwcnj2MZrg7tcC
	kmgLHL7N2e3jk8xQUndEVm7Vzj6iKT8gT9QvRyanlj5fIP1zKG9z2bEWJ8BYug6Qly/s=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduM-0001WY-Ah; Thu, 15 Feb 2024 15:44:18 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhK-00089r-41; Thu, 15 Feb 2024 15:30:50 +0000
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
Subject: [PATCH v13 14/21] KVM: selftests: map Xen's shared_info page using HVA rather than GFN
Date: Thu, 15 Feb 2024 15:29:09 +0000
Message-Id: <20240215152916.1158-15-paul@xen.org>
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

Using the HVA of the shared_info page is more efficient, so if the
capability (KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA) is present use that method
to do the mapping.

NOTE: Have the juggle_shinfo_state() thread map and unmap using both
      GFN and HVA, to make sure the older mechanism is not broken.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v13:
 - Patch title change.

v3:
 - Re-work the juggle_shinfo_state() thread.

v2:
 - New in this version.
---
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 9ec9ab60b63e..a61500ff0822 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -389,6 +389,7 @@ static int cmp_timespec(struct timespec *a, struct timespec *b)
 		return 0;
 }
 
+static struct shared_info *shinfo;
 static struct vcpu_info *vinfo;
 static struct kvm_vcpu *vcpu;
 
@@ -404,20 +405,38 @@ static void *juggle_shinfo_state(void *arg)
 {
 	struct kvm_vm *vm = (struct kvm_vm *)arg;
 
-	struct kvm_xen_hvm_attr cache_activate = {
+	struct kvm_xen_hvm_attr cache_activate_gfn = {
 		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
 		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE
 	};
 
-	struct kvm_xen_hvm_attr cache_deactivate = {
+	struct kvm_xen_hvm_attr cache_deactivate_gfn = {
 		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
 		.u.shared_info.gfn = KVM_XEN_INVALID_GFN
 	};
 
+	struct kvm_xen_hvm_attr cache_activate_hva = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA,
+		.u.shared_info.hva = (unsigned long)shinfo
+	};
+
+	struct kvm_xen_hvm_attr cache_deactivate_hva = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.u.shared_info.hva = 0
+	};
+
+	int xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+
 	for (;;) {
-		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate);
-		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate);
+		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate_gfn);
 		pthread_testcancel();
+		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate_gfn);
+
+		if (xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA) {
+			__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate_hva);
+			pthread_testcancel();
+			__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate_hva);
+		}
 	}
 
 	return NULL;
@@ -442,6 +461,7 @@ int main(int argc, char *argv[])
 	bool do_runstate_flag = !!(xen_caps & KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG);
 	bool do_eventfd_tests = !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL);
 	bool do_evtchn_tests = do_eventfd_tests && !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
+	bool has_shinfo_hva = !!(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA);
 
 	clock_gettime(CLOCK_REALTIME, &min_ts);
 
@@ -452,7 +472,7 @@ int main(int argc, char *argv[])
 				    SHINFO_REGION_GPA, SHINFO_REGION_SLOT, 3, 0);
 	virt_map(vm, SHINFO_REGION_GVA, SHINFO_REGION_GPA, 3);
 
-	struct shared_info *shinfo = addr_gpa2hva(vm, SHINFO_VADDR);
+	shinfo = addr_gpa2hva(vm, SHINFO_VADDR);
 
 	int zero_fd = open("/dev/zero", O_RDONLY);
 	TEST_ASSERT(zero_fd != -1, "Failed to open /dev/zero");
@@ -488,10 +508,16 @@ int main(int argc, char *argv[])
 			    "Failed to read back RUNSTATE_UPDATE_FLAG attr");
 	}
 
-	struct kvm_xen_hvm_attr ha = {
-		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
-		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE,
-	};
+	struct kvm_xen_hvm_attr ha = {};
+
+	if (has_shinfo_hva) {
+		ha.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA;
+		ha.u.shared_info.hva = (unsigned long)shinfo;
+	} else {
+		ha.type = KVM_XEN_ATTR_TYPE_SHARED_INFO;
+		ha.u.shared_info.gfn = SHINFO_ADDR / PAGE_SIZE;
+	}
+
 	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
 
 	/*
-- 
2.39.2


