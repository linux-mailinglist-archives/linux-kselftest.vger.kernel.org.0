Return-Path: <linux-kselftest+bounces-1050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09B8037FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6AAB209DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392E28E27;
	Mon,  4 Dec 2023 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="PGObTwzV"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 971 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 07:00:30 PST
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52033A1;
	Mon,  4 Dec 2023 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=WUrV0xv5QN/acorjWX2KEAdt2ICWDXH53A8LzaiykOI=; b=PGObTwzVoq+BOqG1Ep91FZ8Cns
	b4BQlICAoBDrcriTRLtwGT/7B00y49yoxhxbgtQpY1sdFEAq+3KW0LUBcSA7hjAYT4LyyIowtKmZo
	36MIffdrgQR8nVnXT46SMswCHjtWud8KQ5ebKdZ9//CA+RfgDcy+S8eORhiEObAQyxLM=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAQk-00043j-TN; Mon, 04 Dec 2023 15:00:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAABN-00088g-Cc; Mon, 04 Dec 2023 14:44:25 +0000
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
Subject: [PATCH v10 13/19] KVM: selftests / xen: map shared_info using HVA rather than GFN
Date: Mon,  4 Dec 2023 14:43:28 +0000
Message-Id: <20231204144334.910-14-paul@xen.org>
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

v3:
 - Re-work the juggle_shinfo_state() thread

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


