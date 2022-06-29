Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2E560A4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiF2T2e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiF2T2d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 15:28:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888FB31;
        Wed, 29 Jun 2022 12:28:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p14so16014370pfh.6;
        Wed, 29 Jun 2022 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0L9Ak2rih0QWqwb2iIsAHFOk1bnc7dnsv5n94hZROM=;
        b=bYonWsLg6KUobudvYp5urS+ZmI6RFZXKRiXZ0m30zyE3tdJ6qP7MTjQWVWhimzvul2
         go8d+H1wP+izwQlxcMlCuLUtyBDtzI4F+IQHvYyEdolqcddO9zWnC9i9RxhEB+4OHILp
         41XoZK+JygXqEpucvuxto3mMa4DtgtBL1LWOE06yTHNg2JjRmTZMagWfseU32vToryL5
         8iOl06VxW6w0mNSqDyXAdt4TwuanqT6zO2HmXKgap6HTdmLXikRIvw7YCP+35ps6+E8C
         8HX3KuCpRlx5dgHmXiOR+1HSta+dW28o4rFLGRKNmc5SSSJPR+Xe/Yj3RNFBGgpDcpve
         96wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0L9Ak2rih0QWqwb2iIsAHFOk1bnc7dnsv5n94hZROM=;
        b=fsRSZ8WfYfG962sPWG595cMYS5PjnudrEytyRl41W/grkjttA52872mpNvkEz/ql0J
         hEUZW2G1zAgWEPkNS3cwIc8vQw/OoPEy+gLTirZzspjN3JDgi/ah67r65fiz1CHBGa8H
         FbLGGaA1RY1iI3HIdHz/HehtKTdjd1hx70VjUopWBo/KjGPWw+IXqIini0PUbq12y3uB
         ya7RNc1ZqG6I2a2fj25QfacbLLRjuqJ/Njj2VT3koEvJMQ8hNzAUdLYDcFX1FWbBwgPH
         JXfNEvFimpjCB5GEmxGm9glKF32KT50/eMPNG+o+PCxg1BvKRPIiz8MrBjcGymQIjDwu
         7QMg==
X-Gm-Message-State: AJIora9NiSVQ1tBOnC6gz3vzjLcznlO0QSJrL0OCgrLcHg4/7OT9AVsI
        NaQSSm/l/I3F6XGUKd/XZFQ=
X-Google-Smtp-Source: AGRyM1uu6WVpdI6B9X7lgvzZqLrkX6ko+p/ABP8tLoZC1Fng+vpKXrtPAltW+JdfMiIq6MQrRB4sPA==
X-Received: by 2002:a05:6a00:2356:b0:525:7c6e:1dca with SMTP id j22-20020a056a00235600b005257c6e1dcamr11522615pfj.28.1656530910863;
        Wed, 29 Jun 2022 12:28:30 -0700 (PDT)
Received: from fedora.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id k11-20020a6555cb000000b0040d87299ca3sm11512389pgs.54.2022.06.29.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:28:30 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/kcmp: Make the test output consistent and clear
Date:   Thu, 30 Jun 2022 00:58:22 +0530
Message-Id: <20220629192822.47577-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make the output format of this test consistent. Currently the output is
as follows:

+TAP version 13
+1..1
+# selftests: kcmp: kcmp_test
+# pid1:  45814 pid2:  45815 FD:  1 FILES:  1 VM:  2 FS:  1 SIGHAND:  2 
+  IO:  0 SYSVSEM:  0 INV: -1
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# # Planned tests != run tests (0 != 3)
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+# # Planned tests != run tests (0 != 3)
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
+ok 1 selftests: kcmp: kcmp_test

With this patch applied the output is as follows:

+TAP version 13
+1..1
+# selftests: kcmp: kcmp_test
+# TAP version 13
+# 1..3
+# pid1:  46330 pid2:  46331 FD:  1 FILES:  2 VM:  2 FS:  2 SIGHAND:  1 
+  IO:  0 SYSVSEM:  0 INV: -1
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+ok 1 selftests: kcmp: kcmp_test


Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..25110c7c0b3e 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -88,6 +88,9 @@ int main(int argc, char **argv)
 		int pid2 = getpid();
 		int ret;
 
+		ksft_print_header();
+		ksft_set_plan(3);
+
 		fd2 = open(kpath, O_RDWR, 0644);
 		if (fd2 < 0) {
 			perror("Can't open file");
@@ -152,7 +155,6 @@ int main(int argc, char **argv)
 			ksft_inc_pass_cnt();
 		}
 
-		ksft_print_cnts();
 
 		if (ret)
 			ksft_exit_fail();
@@ -162,5 +164,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	return 0;
 }
-- 
2.36.1

