Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4876C57FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjCVUoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 16:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCVUo1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 16:44:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DB3E1E2;
        Wed, 22 Mar 2023 13:37:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so15090399edb.7;
        Wed, 22 Mar 2023 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679517450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17Wjze2y6t8a4zjcKa53kmqOgCJMw9ntTYn+G4muZxo=;
        b=GUepQa4FzpVnJdj3SwadimZqcabtTzoGmqFjHse67Uu4gkiGslqm6j9V07lBXolcOw
         r4qeHpPt5iGDTtqcul1BUlmiefkYFe/dxTn86OG3OIwWpfwxIfaQ33DwBXXT7dAMgwIB
         IpFOTnS8OofaLs15P51FTOSfr8QY9h3t6AAGjlOLh3FuZQmKqvuN5y4xNiVmFM2jLpdJ
         gVpQqIp43nAwNYTVz8BMmLKFUo6Xku8y3WQIlVOVYGVRweI/aUXPHIzTwogs+v0ogPnl
         Y+rQVDJ8dpScuVUIII53iUNnxyEkw9N2bG2DbC0nghJH8p8RD6SAT57hpC3AoZSpgFfM
         mDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17Wjze2y6t8a4zjcKa53kmqOgCJMw9ntTYn+G4muZxo=;
        b=SXyIfRFrEvEwHkdf/ilhzB0PlUu5FFhY17GhOieekNkGOpiZdqCnIcYS3Cu+cQdzPA
         7Wr7rWBd4Fii7QZ+ETtTsJka0SsPSWU4a7L4/qm93WTHaWB8aYkEJSe0lfDWmba4o57H
         Kkh2GaIBGhgoS4N/xpWa1k/W74i3lO2JtL7rQowgi3QlV/En8JMUwOYkx+vpMWclkMxc
         18miwzGYTvrmVF3dCsB4SYPxii1hoo+3l9hcN38WHsumA64Bx73ilptWOwFLPvGXl7Pq
         M8ZxpCgHfBfSo5AMXTQCT/KWdH+5azAMJcnuawlSRj7o8KJEv9h9MYfJi52qaDbhpMe+
         G6vw==
X-Gm-Message-State: AAQBX9dPjMzWBiY6YrA1e87HoCmesOL+Qwiu9XAeQ319zPPde3RFG5P8
        rO2It8uZ5LM7+Et9vhmD+Vw=
X-Google-Smtp-Source: AK7set/OL6xIAJnNOtJzYybsbaA8EkueTTd9ranGekne3VZDLQzuxhHshbuJ98MDBcimsyp0ApUgsA==
X-Received: by 2002:a05:6402:268e:b0:502:465:28d4 with SMTP id w14-20020a056402268e00b00502046528d4mr563537edd.1.1679517450319;
        Wed, 22 Mar 2023 13:37:30 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id qh7-20020a170906eca700b0092bea699124sm7671936ejb.106.2023.03.22.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:37:30 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     shuah@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests: sched: Add more core schedule prctl calls
Date:   Thu, 23 Mar 2023 00:37:24 +0400
Message-Id: <20230322203724.4757-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The core sched kselftest makes prctl calls only with correct
parameters. This patch will extend this test with more core
schedule prctl calls with wrong parameters to increase code
coverage.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 25e0d95d3713..df8e4629b3b5 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -334,6 +334,14 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(pid) != 0);
 	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
 
+	printf("\n## Try to pass wrong subcommand PR_SCHED_CORE_MAX = %d to prctl (shouldn't succeed)\n", PR_SCHED_CORE_MAX);
+	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_MAX, 0, PIDTYPE_PGID, 0) < 0
+		&& errno == EINVAL);
+
+	printf("\n## Try to pass not-null uaddr with forbidden command (shouldn't succeed)\n");
+	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
+		&& errno == EINVAL);
+
 	if (errors) {
 		printf("TESTS FAILED. errors: %d\n", errors);
 		res = 10;
-- 
2.34.1

