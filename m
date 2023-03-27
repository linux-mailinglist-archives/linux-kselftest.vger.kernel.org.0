Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389E6CAFC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjC0UT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjC0UTV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 16:19:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9825530F5;
        Mon, 27 Mar 2023 13:19:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-930bc91df7bso38300966b.1;
        Mon, 27 Mar 2023 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679948356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZStOGFomeC4iKiC4ctCI52dZV1VdmoFJa9Q3XiMGXSQ=;
        b=V3LSYPuPqzvEay/j0Vd+Wq1wKBAo2Cmzkvh1uIm0oyisM41675tJ4TzpZUP4eIss1A
         MMWYaYdcfdJMs9+YyDCKovpEgfoMIwZf/RBpeMrsHukVwudu5Y1xMdDtdBvm1h0NXv9F
         XQqqb6fL8t0I6IbTLyAaHliB3jM4jQ7ZH0xqOSRJflVC8T/osiQ3nFtt456BaEiQfXdq
         lYAv5zuM9n6Cg8hOBhHqQgAfz226UT+0TOvQzOO2bFnH95QQFEPlHCqPs9z/U1dMGlU0
         esmUIcX6C4Jdg3VRtqm7X6LV3kNXUVgXpCalZuibhkZFZGCfpyao0fBaJIkhAW08Pkf3
         Cz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZStOGFomeC4iKiC4ctCI52dZV1VdmoFJa9Q3XiMGXSQ=;
        b=fT6Ya0rOt3xdhKpzZjyi8L6wfj024wyUKUL4vgWtCGcsXGCyBp6tuFJ3PCSDQ8+mjq
         9bKwLnaKtsCei2zvOOqOePy3Lp26xfQk6oMsyPPuSb6xSIKmt91b26iM6UVGTS6zrlE5
         UL3SL3kkUZp08qv9K9bbq2S0FDXPZL4oXLZ4osOHpBf01CK98gZd0t1wsphPqTZtIUfr
         gz/t6N1PEUBkvaFqR/jEYaLzyebAxPkipUK3ClwPwv3tUxltFTpggHG8Dx5aWPESl4RA
         YQxa6NjTrskJL2Mz91cY7kwPfNQez9K3+YfOKWiijdnDMscxrsXofUi9qHB7hPmlR2NU
         Ie4w==
X-Gm-Message-State: AAQBX9faNRtOui7UefwNGk4CDssKsZksaiLYCX2GgEnO5MhvrkB4+NmD
        KyZbXGBvGy+NdeAQbEqx69i0SJ2KUHnXWA==
X-Google-Smtp-Source: AKy350ZMc3752XxDaCDZ5LFOm0UEG9WexjqCekr5a9D9aOyh+N2fOVWJOxSCcjbVM0CjfJcZN0gABQ==
X-Received: by 2002:a17:906:1ce:b0:931:4285:ea1d with SMTP id 14-20020a17090601ce00b009314285ea1dmr7796064ejj.5.1679948355765;
        Mon, 27 Mar 2023 13:19:15 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id ml23-20020a170906cc1700b0092ce8344078sm14440118ejb.33.2023.03.27.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:19:15 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, himadrispandya@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] selftests: sched: Add more core schedule prctl calls
Date:   Tue, 28 Mar 2023 00:18:55 +0400
Message-Id: <20230327201855.121821-1-ivan.orlov0322@gmail.com>
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
V1 -> V2: Unnecessary printing removed - 'validate' will
automatically print the message in case or error

 tools/testing/selftests/sched/cs_prctl_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 25e0d95d3713..3e1619b6bf2d 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -334,6 +334,12 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(pid) != 0);
 	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
 
+	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_MAX, 0, PIDTYPE_PGID, 0) < 0
+		&& errno == EINVAL);
+
+	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
+		&& errno == EINVAL);
+
 	if (errors) {
 		printf("TESTS FAILED. errors: %d\n", errors);
 		res = 10;
-- 
2.34.1

