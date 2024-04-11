Return-Path: <linux-kselftest+bounces-7727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B98A2097
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F428283D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD028DCA;
	Thu, 11 Apr 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhYNrTB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A917BCD
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869372; cv=none; b=hSTMcjDvQFXeF81iknLuphHCPdJJCD6DuNbZrsTMeXHaBfXJEXVYxMbKsiE1IQOPcpqbpRswfxEnKUmeZKJ97UtrDMaVCSSN4cs5QM6tiBAZrVpjM0KwflYPI3wt1NzWQ0Vx4VQvkeF72Tic3hA9hGKn34PuettEncCVOaKju+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869372; c=relaxed/simple;
	bh=wPnmRLWj6d+ggNcsyJ+NsrFRGf18SrUolAOIzAQ27HM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nf1QWSTwE4RPPZeeZFTlZJsjOhbaVOGIgob9IByfJfbwcFKJ6XEQ30CRfGFnfohwLWA9vedDd64ksJquZl3gi0+uWHEBLktG5dpp5A9muVYmO7PHn7acJogg1JMXnLdgq9AIssi8aFwBVaBxUAQKGlCnSnvN2UzhQmLEr8VXXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhYNrTB9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712869371; x=1744405371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wPnmRLWj6d+ggNcsyJ+NsrFRGf18SrUolAOIzAQ27HM=;
  b=EhYNrTB994YWK+inxXMOI/4lB3sq4i7Nvp14WOjNxba7GbqSdGh5ednU
   QpbfOceCsNt9FWg7UjcFDga5KwU4ScyhQZyMKNifzCYbuf1hItTBsV5UL
   ypVtB4wmwwvoUc5oXE/QpPJFUYq0pe5K7R/PGsn+JPSl/cCbroK3UXpqw
   UZnUccsQyWbCZhWYJCPpJNiWpPUL8xmaySZpPA91Wii0Wnt7ggG5Xqewq
   PyGYal9iwvfHIQRQLe5A5Sjm9tDMqKSUpRVjOGRtS/ctaITRIkD3oKcpE
   fpHsb3BvKjadjHdnsz0CglXYwSZzRHwSEImFlw0mn8o6ZY+mR4twPOgBF
   w==;
X-CSE-ConnectionGUID: BCgGU6ImQCOd/Ft0Cj7hPQ==
X-CSE-MsgGUID: uaXG8AHXQdq746TeUCFl1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="30790613"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="30790613"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 14:02:43 -0700
X-CSE-ConnectionGUID: D8BeSFUFQx6mXXQnve2wxQ==
X-CSE-MsgGUID: 7vE8uHxUTKKMnY3CMFZlsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="51988085"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 14:02:39 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] KVM: selftests: Make monitor_mwait require MONITOR/MWAIT feature
Date: Thu, 11 Apr 2024 14:02:37 -0700
Message-Id: <20240411210237.34646-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this feature is not supported or is disabled by IA32_MISC_ENABLE on
the host, executing MONITOR or MWAIT instruction from the guest doesn't
cause monitor/mwait VM exits, but a #UD.

So, we need to skip this test if CPUID.01H:ECX[3] is cleared.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
index 853802641e1e..cdbfcf7cac5c 100644
--- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
+++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
@@ -75,6 +75,7 @@ int main(int argc, char *argv[])
 	struct ucall uc;
 	int testcase;
 
+	TEST_REQUIRE(this_cpu_has(X86_FEATURE_MWAIT));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_DISABLE_QUIRKS2));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.34.1


