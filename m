Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34762591BCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiHMP6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiHMP6K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 11:58:10 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BBA458;
        Sat, 13 Aug 2022 08:58:05 -0700 (PDT)
X-QQ-mid: bizesmtp83t1660406280t1mc0nal
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:57:52 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: +ynUkgUhZJkha1rBwRz8Vc/0uJx1dDkEumqKrXgbOOaB1epQK1/6DQ645CptU
        XloZA27Q5CnEwCT7krJab/TVRcXbsm+u80jxqan9mEqkTM3egKZkWex9Bjq9UmrEO4gT2W+
        hsGrBfK0CzkQ8dB4qjQPl9BIPxmRxmSfnFGAtiDH7rb5ECUx+nAMmD1iIVsF9nS0wVJ9HKH
        VfHKIR6xtOibKwblyFI6ib2ENaWCgZQsmABaaNRoUTwicmfUj3vKsPI52Vb1s8kb6WEJRJ5
        lunXRHX6Hy3Mo7Vl0usIVVBYqXl8RZCNDbEX/WilHvnruXKP7umJHNeG2yPa2ucC4/NMcJn
        56h7I3I9wJDwZcaDmpYZ89nrukXBSME5grCAzrxgA0QKPoKbnL9VpYuCue3hw==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] KVM: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:57:40 +0800
Message-Id: <20220813155740.5359-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no semicolon after '}' in line 232.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 tools/testing/selftests/kvm/access_tracking_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index d8909032317a..c9c20d942beb 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -230,7 +230,7 @@ static void vcpu_thread_main(struct perf_test_vcpu_args *vcpu_args)
 		case ITERATION_MARK_IDLE:
 			mark_vcpu_memory_idle(vm, vcpu_id);
 			break;
-		};
+		}
 
 		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
 	}
-- 
2.17.1

