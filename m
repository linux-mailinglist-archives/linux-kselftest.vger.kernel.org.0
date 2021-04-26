Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD16636AB14
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Apr 2021 05:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhDZDbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Apr 2021 23:31:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:8388 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhDZDbq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Apr 2021 23:31:46 -0400
IronPort-SDR: 9z0bDgbut7olTsu01nU4/dd4w0zLLGLxEvV2SF/lhOXxUX39Ynb6kkI4ICQJ3pJh0sWGF2ihmP
 N+Z/+IB6W53Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="176392665"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="176392665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:31:05 -0700
IronPort-SDR: bB9O3aSLWK9aR07i9WUD/2odNc3cEtdDAdTXNinlcUn9ETOOHDjJQJhpItHzXIavkkq7ShGmvg
 0MGfWl0AwxVQ==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="429183762"
Received: from duan-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:31:03 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] selftests: kvm: Fix the check of return value
Date:   Tue, 27 Apr 2021 03:31:38 +0800
Message-Id: <20210426193138.118276-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In vm_vcpu_rm() and kvm_vm_release(), a stale return value is checked in
TEST_ASSERT macro.

Fix it by assigning variable ret with correct return value.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b8849a1aca79..53d3a7eb0d47 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -514,7 +514,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
 	ret = munmap(vcpu->state, vcpu_mmap_sz());
 	TEST_ASSERT(ret == 0, "munmap of VCPU fd failed, rc: %i "
 		"errno: %i", ret, errno);
-	close(vcpu->fd);
+	ret = close(vcpu->fd);
 	TEST_ASSERT(ret == 0, "Close of VCPU fd failed, rc: %i "
 		"errno: %i", ret, errno);
 
@@ -534,7 +534,7 @@ void kvm_vm_release(struct kvm_vm *vmp)
 	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
 		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
 
-	close(vmp->kvm_fd);
+	ret = close(vmp->kvm_fd);
 	TEST_ASSERT(ret == 0, "Close of /dev/kvm fd failed,\n"
 		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
 }
-- 
2.25.1

