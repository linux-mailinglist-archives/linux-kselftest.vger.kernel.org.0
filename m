Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF519EC53
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Apr 2020 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDEP3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Apr 2020 11:29:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37769 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgDEP3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Apr 2020 11:29:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tufld8x_1586100583;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tufld8x_1586100583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 05 Apr 2020 23:29:43 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix parameter order error in kvm_create_max_vcpus
Date:   Sun,  5 Apr 2020 23:29:42 +0800
Message-Id: <20200405152942.95052-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The parameter order of test_vcpu_creation() call is reversed here,
this patch is adjusted to the correct order.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 6f38c3dc0d56..a7f3120b4409 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -60,7 +60,7 @@ int main(int argc, char *argv[])
 
 	if (kvm_max_vcpu_id > kvm_max_vcpus)
 		test_vcpu_creation(
-			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);
+			kvm_max_vcpus, kvm_max_vcpu_id - kvm_max_vcpus);
 
 	return 0;
 }
-- 
2.17.1

