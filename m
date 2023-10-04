Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A947B8144
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbjJDNrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjJDNrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 09:47:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3BEA1;
        Wed,  4 Oct 2023 06:47:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b275afb6abso212103766b.1;
        Wed, 04 Oct 2023 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696427266; x=1697032066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4F2v4nK3N7gfvShfOgXb7DHl4c9Ihx7GZf6uMjYMfQ=;
        b=Hoj0CpmIhKHKg3hHIRo7rPMLWBIgNSg4/Fk79K4qlgYCeA20IzrzK/H1mY9kPWScAN
         FMmrNlj6ukMYUXmVXACQJy9zFvpyGpJKirsEanBTODMHNLziGub0e8aPGKFYQJy4xo6e
         rYDoHpuCHf9cUIyvEgbY9XTtt9eniOG/WdyR0GWbLPok5fupdy437FmSr+VwiSqB9CC7
         dRuzL4bKaiG2vlFPqwowItz3wUFfTcChkLQftGVlFp6XeUel0n4rmDqkWyDB407L+BK6
         7z17nEP1c0pEFvIoy1zgzMrrgrgxCjvFDjtn13vNlOwyMH2PtSk4mu21H3zwHwWv0/iR
         G/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696427266; x=1697032066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4F2v4nK3N7gfvShfOgXb7DHl4c9Ihx7GZf6uMjYMfQ=;
        b=rkfwcLMw3KgLTeMaFMDzxhpipKWEx70KiLA1kln09zUHOrMCDHEGcFxjN6G+/UNuIt
         YQheuUObx5NBn7dqY9rCgd2S9iXbO29ZB85/IgAAFS4ADqD+/UkRnfYyup0lAU/im5vW
         SsuaesoJkVk6GDNjIh+4MqKrgUsVp50NKf8nqKNX485uc02gZM4Qoiyszx7gzNE1Kp9Z
         5Lgi3u67PmofO6rj88fsAhXPP/VF8XijJvyz2XMuWRswA+B/DKlevrHX28hsLnrz9bxg
         7BVdAT2wWUrBTdvUUx0/UV99VB4nOLE9VzxrvhNASz0s37LSyHgJu44JvGXlqeRi23WA
         SzQA==
X-Gm-Message-State: AOJu0YyOwuXKTjDglmb1KNwt9ACBoXqJ8Mh7vNH/COLTImjxMAigUfSx
        HF2gdKKQc01eleIMhQczDZU=
X-Google-Smtp-Source: AGHT+IH2qgOky0OB0XAqyBea3yxDMhBPgIycS0J05kPj4JPa6f2C5SQu7LsGej0e/Z7PG9F/kSvSpQ==
X-Received: by 2002:a17:906:c104:b0:9aa:1dc9:1474 with SMTP id do4-20020a170906c10400b009aa1dc91474mr4935556ejc.33.1696427265959;
        Wed, 04 Oct 2023 06:47:45 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id kf1-20020a17090776c100b00992f2befcbcsm2805593ejc.180.2023.10.04.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:47:45 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 04 Oct 2023 15:47:41 +0200
Subject: [PATCH 1/3] selftests/user_events: add gitignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-topic-selftest_gitignore-v1-1-40689bcd23e2@gmail.com>
References: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
In-Reply-To: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696427264; l=550;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=+vdIh2L0R4kZPGAoxXRb3zvnIdlxqlliv1CyY7HvSfQ=;
 b=ZVhJK016F08gfEKPd/zpQS56H/+WD1dnc72ua3BJJzMFJSO+OA+LSNG6tSlXbH/mtgepJjMJl
 x7NQ8MDLmmrBB1G348XYPQtKZoobMi83ga6wx5JVaxfDgmPVZoFPWSb
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

user_events builds a series of binaries that can be ignored by git.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/user_events/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/.gitignore b/tools/testing/selftests/user_events/.gitignore
new file mode 100644
index 000000000000..f570febd211b
--- /dev/null
+++ b/tools/testing/selftests/user_events/.gitignore
@@ -0,0 +1,4 @@
+abi_test
+dyn_test
+ftrace_test
+perf_test

-- 
2.39.2

