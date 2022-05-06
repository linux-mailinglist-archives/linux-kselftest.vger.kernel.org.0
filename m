Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A572251D4E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390711AbiEFJtI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390710AbiEFJtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 05:49:07 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AD5FD4;
        Fri,  6 May 2022 02:45:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VCRMIRC_1651830313;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCRMIRC_1651830313)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 May 2022 17:45:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pbonzini@redhat.com
Cc:     shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] KVM: selftests: riscv: Remove unneeded semicolon
Date:   Fri,  6 May 2022 17:45:12 +0800
Message-Id: <20220506094512.116729-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/kvm/lib/riscv/processor.c:353:3-4: Unneeded
semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/kvm/lib/riscv/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 3961487a4870..e17333518af2 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -350,7 +350,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 		case 7:
 			id = RISCV_CORE_REG(regs.a7);
 			break;
-		};
+		}
 		set_reg(vm, vcpuid, id, va_arg(ap, uint64_t));
 	}
 
-- 
2.20.1.7.g153144c

