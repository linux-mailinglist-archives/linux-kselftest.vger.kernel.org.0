Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E729D9AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgJ1XAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbgJ1W6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:58:31 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF8C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:58:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 9so1314719oir.5
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3930iRmn2v3Kax0YMICyLXH418zhIQShLMpjbBJsYVk=;
        b=mBDZ0zu6yqM90QwvYssjTCu2/6XJfEdTwhQn3O3Q+LQ+6pwAu5vOu6/SqTVGWf6GfF
         zeT8h0XW2PUzlDztrhC0mec2e3NsVORVGL5DtkZoZ+JBn1hnXKa26YfLz2Btu7A4TonS
         G18pDBypT1Tga7/s8r1lXoclGg/ZDUE9Js2nFUEygtsObLeUrzhAErlMb0DusAqlxQhi
         /y+nViUcINueaKs6rmzg8O7Fvh5ZS/44eaUQCTeJEOJDhaVefNcdwtb7eTPjDsQW1t8O
         ZaJ1cndCCdk9uFoXX0PVwOPXiqC6stoZT3sV6n/A2V7BVeuyVAYKtrMOEVra2oSk2ihw
         oAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3930iRmn2v3Kax0YMICyLXH418zhIQShLMpjbBJsYVk=;
        b=NT4+TeIglxQY3Xk4+jTM5drHtPdXA0e0d2S3Knu3R3qVAFvmxAfemHvze8kMceRPFd
         eJ1M4HdRkGIoUTkzdc4g9sGXVPOcQ0guCt0I0zW45xMZ6uP8Z+gtNoNyzRHpejScM/ty
         wb+IWav8Cqir/ZLb3djLWtx3le6insW8RbDqcmUzHR4h9/0tnemm5lbvZtsUPp9mkx+z
         dF17A7KJDdm1ZT0pCBokvctXV8oE6xQYfQxnCvJhy/zouDHpg2cQIw4t6211HX+g6ISO
         wWZJTuQmmXZSpRxtyt01UlCDPwUzAJSUXGey6X31lGM8cUQglS7PGuuD6WYWo2v/e24a
         53aQ==
X-Gm-Message-State: AOAM531dlB7syV99mBSK+/xjhhkDKZZ4kOZs6fsfZ55N9+QBzNFTQwjr
        lk2UQn1gvmYo/GMxC/7ZBwp6xqvZuydHRLMf
X-Google-Smtp-Source: ABdhPJzFL28dyXJVDGkldCnxjqLxNFvgziaF4tLGgk4ki+mvWXX2ukfc+qW+Tqj7KSEJtVuIXvzDdQ==
X-Received: by 2002:a17:90b:460e:: with SMTP id ia14mr5622530pjb.7.1603873888670;
        Wed, 28 Oct 2020 01:31:28 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a14sm4995618pfo.203.2020.10.28.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 01:31:28 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH] selftests/run_kselftest.sh: fix dry-run typo
Date:   Wed, 28 Oct 2020 16:31:14 +0800
Message-Id: <20201028083114.3754412-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Should be -d instead of -n for dry-run.

Fixes: 5da1918446a1 ("selftests/run_kselftest.sh: Make each test individually selectable")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/run_kselftest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 609a4ef9300e..97165a83df63 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -48,7 +48,7 @@ while true; do
 		-l | --list)
 			echo "$available"
 			exit 0 ;;
-		-n | --dry-run)
+		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
 		-h | --help)
-- 
2.25.4

