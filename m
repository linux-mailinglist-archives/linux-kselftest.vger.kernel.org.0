Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4615C351AE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhDASDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 14:03:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15585 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhDAR7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FB51F68bgz19KZq;
        Thu,  1 Apr 2021 22:20:01 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:22:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <kvm@vger.kernel.org>
CC:     <pbonzini@redhat.com>
Subject: [PATCH -next] KVM: selftests: remove redundant semi-colon
Date:   Thu, 1 Apr 2021 22:25:14 +0800
Message-ID: <20210401142514.1688199-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 804ff5ff022d..1f4a0599683c 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -186,7 +186,7 @@ int main(int argc, char *argv[])
 		vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &st);
 	}
 
-	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);;
+	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);
 	rs->state = 0x5a;
 
 	for (;;) {
-- 
2.25.1

