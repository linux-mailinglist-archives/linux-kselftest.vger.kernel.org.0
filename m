Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA34693EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhLFKdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 05:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLFKdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 05:33:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA88C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 02:29:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u3so24165707lfl.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 02:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/aEdQXaORv8l8iP33+Ms57TgKkJAnc4HC3EItYSgUw=;
        b=mxmcxFnHOjLMmFokTw2XUgQVR5hYlqz7gpK5NdCwDT/Og37kuC7I8sAI31JDQ4pxNP
         wQEgf6Veq4K9bGEMtvMAQL7SJlqnUV2c8cRbzdHZ1lNgL381nat2ZFeczfI+zivOp0wE
         U6VqFkBSisSVzWDDRWaIWZ3mKjBEr1MI9G3DozJCfis93f1zNo1krQEel5b7gakSafr9
         a0AIaKcLDtzEbKLxNP7B9bSIv+Pwet0ymg8owabic3CcS7bGL21hTEqaf1pGKcsx0+Up
         hgmnDd7Zab7HCPTg0ptNg3ldIogFkKC3ZAj62yCaMHd/wizDTAWXMlV9MyHeHXBrWRGs
         UU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/aEdQXaORv8l8iP33+Ms57TgKkJAnc4HC3EItYSgUw=;
        b=qGPV+PCGo+Wlxt0q4YXAiJqqyqq+hyTO4f8bau5wvG17H7Sxfa+HENNfPwR7Oq2hRF
         muhbZvt8TqBsKf+U4K3fKXZNHJgfMIgrYDAjDUtYLbzhou3qCOfIc1hdh98n3A6rjBie
         4JRWMXRYLNYaKiAWRSuoDaaiwCKmyUdPBRaANUwxFxopVsO9YZsImUXxlie+wjEZkxK5
         E/8Q6dWOw5xHipIaBSL+U6doXrHgVHvyYdjGgnSdnHXxtiU0ZWUezUN9pPyCOObadWaK
         ONlcdTSUn5rNSIVkOJqTGigpFux9tuG73J82GevKF5vEopKaeG//C2ZXAKSZm/rcJCJF
         tvBg==
X-Gm-Message-State: AOAM532kP9n4UqHdrvRN7EbAUFo2UPGgvZMnbCkkpeq0GTZCTU4/048V
        9gD6NYFdalhV8GxoUpMbnyBsBg==
X-Google-Smtp-Source: ABdhPJz//+sU+FT9yaz5d8hL56MAE1by66Yalv6F4erw1ZQq4HM1mGHiw3GIRqhqoT71z6aied+vLg==
X-Received: by 2002:a05:6512:693:: with SMTP id t19mr34292201lfe.647.1638786583113;
        Mon, 06 Dec 2021 02:29:43 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id u10sm1312802lfb.209.2021.12.06.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:29:42 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: vDSO: parse: warning: fix assignment as a condition
Date:   Mon,  6 Dec 2021 11:29:31 +0100
Message-Id: <20211206102931.1433871-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/vDSO with clang the following warning shows up:

clang -std=gnu99 -Wno-pointer-sign vdso_test_gettimeofday.c parse_vdso.c \
      -o /tmp/kselftest/vDSO/vdso_test_gettimeofday
parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
                if (g = h & 0xf0000000)
                    ~~^~~~~~~~~~~~~~~~

Rework to a parentheses before doing the check.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

v1 -> v2: fixed checkpatch warnings

 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..fdd38f7e0e43 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -62,7 +62,8 @@ static unsigned long elf_hash(const unsigned char *name)
 	while (*name)
 	{
 		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
-- 
2.33.0

