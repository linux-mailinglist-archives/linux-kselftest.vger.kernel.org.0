Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11661DBB7
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKEPmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKEPl7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 11:41:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6825D116;
        Sat,  5 Nov 2022 08:41:56 -0700 (PDT)
X-QQ-mid: bizesmtp73t1667662912ts7owgay
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:41:44 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: D6RqbDSxuq55pyzvV3rN3fwltv+7QPqxZ+JJZ7eLlMGfSyvB+T2foKajoIi96
        vgWSQ2veEx+nmZqrqZL1X4EBAv3kp+C86c7tEC1VNnIy1/cdLk7Mw1Q8c7J6j6gCMZwiMJ8
        NMV7wBDEAafW82NV91X2TkFBe7++4Xb/4aSRLjiDybqFVHzOUZ4UfvPdSonC10+iHjs1jp5
        vLDI/w/W8hTrkcPSmfONHeaDI9a9/rudGO2hJxb/8e+ZrSbRVhenDruD75TypDJfpRGOM2K
        L5Hx5LJ6AI7BcXFTCTUs9twIUC1NSDeX2fS0uJa+stS9/J0K195sI3po2h3afjOZhOyxTfp
        tSeBm1EEe19mmaSb48Khdb5rSzEwQnJxF8aLlgaEgRuho2d/Oxj6KPYaQkXSg==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] KVM: selftests: Delete the semicolon after curly braces
Date:   Sat,  5 Nov 2022 11:41:42 -0400
Message-Id: <20221105154142.9003-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The semicolon after curly braces is not needed.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/selftests/kvm/access_tracking_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 1c2749b1481a..35f81e844e38 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -229,7 +229,7 @@ static void vcpu_thread_main(struct perf_test_vcpu_args *vcpu_args)
 		case ITERATION_MARK_IDLE:
 			mark_vcpu_memory_idle(vm, vcpu_args);
 			break;
-		};
+		}
 
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 	}
-- 
2.35.1

