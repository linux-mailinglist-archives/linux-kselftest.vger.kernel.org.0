Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6426269D109
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjBTQDS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Feb 2023 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBTQDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Feb 2023 11:03:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D196A7B;
        Mon, 20 Feb 2023 08:03:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j2-20020a05600c1c0200b003e1e754657aso1513151wms.2;
        Mon, 20 Feb 2023 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676908996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pGXihfz169wq8vbQ55A6qeCeAolkvlGTPS+YPqxvGk=;
        b=lKBmSTvu26BgzUl2Zzjw/98dkPyHLiKxGTyeDbp1SD5AMbvNgDFAtbbSfC9rsLJxtR
         A9yP0mPzhzgQibvFy+ZhiyAj7VFh2kVO2/l1Vdp76wlnoYWLTASI7/qQo6kOd/Yc3IP7
         CsLLAAhkcf371t4bwSf5prmw2UrRCBusdkHqKlnuNClA9unxqwsNgH8QgnEXx+Ot5lSb
         RGg0SPf1AhNgltPUEiedqp1LeJX+uvRUDRdprJRnOMr9jw07jwyAMnb4ZQDTQQgibjlZ
         WGldx9Nq8Inh7xF3OPbiMT9IacbibYsY+wzjiUtA2I2DZK93keZ5WtEhCaVCik8b0rQ2
         AFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676908996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pGXihfz169wq8vbQ55A6qeCeAolkvlGTPS+YPqxvGk=;
        b=cwikCaiXX6aX8uSXwdo2jHLBj7gNxzUYd0pLssAxb14bTushxP/+fpKUIIRBVd+oKC
         /R/ObEKWxUcRDK2s7qcdSpt/vzRmG3UwKEklbmn8iIASzn2+TvhNaxKmOnji9DBF6wzC
         PkjmySCx5dUCf55YUYOrs9EynvOye2Qh9RccI/aIMPytoWp1YB/9UdYUT2eEDx648yu1
         O81Z/D2U5EtmntV+WdlcyFFQRisYpiyyDA6B4EuUOR6fAPSlcDXoobVrLmWPTWIOzF4s
         X+SkeNL/euakHnHg3AZ1zwUfmZZG3C+JI+uyNmSgL4qp95TvcW4NghA2ibOFQ5KuoNkc
         qPZg==
X-Gm-Message-State: AO0yUKU9MK8BQr3eo8EM/E8QbYfkGBTmYs/OjInq9iDR8I690HMMFhaQ
        TdsQokn+CI7A+5D1ZEFe0JP4oNueHX0jBQ==
X-Google-Smtp-Source: AK7set+B7Vk1SliuOLcO86rQuSrYfVzTWswcPjiN1gE7Qv213tLM4+k/E8RXN4++r8zWq42guPEcYw==
X-Received: by 2002:a05:600c:2318:b0:3df:f7ba:14f8 with SMTP id 24-20020a05600c231800b003dff7ba14f8mr1426028wmo.1.1676908995694;
        Mon, 20 Feb 2023 08:03:15 -0800 (PST)
Received: from mineorpe-virtual-machine.localdomain ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dfe8c4c497sm438528wmc.39.2023.02.20.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:03:15 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     shuah@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Refactor 'peeksiginfo' ptrace test part
Date:   Mon, 20 Feb 2023 19:03:02 +0300
Message-Id: <20230220160302.4679-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

peeksiginfo creates an array of 10 instances of 'siginfo_t',
but actually uses only one. This patch will reduce amount
of memory on the stack used by the peeksiginfo test.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/ptrace/peeksiginfo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index 54900657eb44..a6884f66dc01 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -151,7 +151,7 @@ int check_direct_path(pid_t child, int shared, int nr)
 
 int main(int argc, char *argv[])
 {
-	siginfo_t siginfo[SIGNR];
+	siginfo_t siginfo;
 	int i, exit_code = 1;
 	sigset_t blockmask;
 	pid_t child;
@@ -176,13 +176,13 @@ int main(int argc, char *argv[])
 
 	/* Send signals in process-wide and per-thread queues */
 	for (i = 0; i < SIGNR; i++) {
-		siginfo->si_code = TEST_SICODE_SHARE;
-		siginfo->si_int = i;
-		sys_rt_sigqueueinfo(child, SIGRTMIN, siginfo);
+		siginfo.si_code = TEST_SICODE_SHARE;
+		siginfo.si_int = i;
+		sys_rt_sigqueueinfo(child, SIGRTMIN, &siginfo);
 
-		siginfo->si_code = TEST_SICODE_PRIV;
-		siginfo->si_int = i;
-		sys_rt_tgsigqueueinfo(child, child, SIGRTMIN, siginfo);
+		siginfo.si_code = TEST_SICODE_PRIV;
+		siginfo.si_int = i;
+		sys_rt_tgsigqueueinfo(child, child, SIGRTMIN, &siginfo);
 	}
 
 	if (sys_ptrace(PTRACE_ATTACH, child, NULL, NULL) == -1)
-- 
2.34.1

