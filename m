Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99774444967
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhKCUQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCUQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 16:16:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F14C061714
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 13:13:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu18so7624526lfb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jz1HALHw2e3PHU1qjzoKG4w3uBh5BQe+CnU54irwwuk=;
        b=rSD2qAcx1HPdKBiGQNjLLwt1XctRU7KMzYWxU3AQ6/xeKhOlQRc9lA2u5Z2vRRvH4N
         iWm8UlOpvSfiY7odM6v6Oq22pQbBLWHc4ZvHZxLgMfWlaqnZ4X//4/FhlDAQRjhls7oC
         GnZgDsGQc7KCSJjLLYZGYorccK00ymvHUwt6r0ePjV7GaBXsPpSI1X6nFDUlM0ytyW1p
         wV7yJc+rc2bSjr1WzeN16OIGB97EphF9it7ptQZumLMX+YBl/7qmPT7JnDBh4P6WBymj
         E0EZ3qSeh86bmB3PqCD0EvXY5/BmkZO9sg28t6ZlUW9IyZIFDmsVMTj7k9qXZsmo+y5x
         2j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jz1HALHw2e3PHU1qjzoKG4w3uBh5BQe+CnU54irwwuk=;
        b=d6zgdwz9k0wZ8Ncw2Faud4wtRiSX8X5qLvwTOYrztSprK08VajnhCxds+7/X5YXFAg
         UY088TK3/oSoH/b2SFF9VdWDisyGFMQFRzKEeYaOqmuipuI4eACb7+Ek/q7EwbgeBX5b
         atPrO5dSjOjQRFTijsvSm7S218ieuy7fvoFIrKhd0Xu0TMBhTFDjVnpb5V4Ce6grKW9F
         VuKet8DZMHnI/dp4ZtcmYDtBoGeB770hBJlRVftG7ogm9/CN5JgeUp3xoPdM1lSgB81Z
         LaUh8W/pRfbzK/wZudrmlVcVg6zctE3QFrf1AuidQip8Y7/+8FwOSBpjkH4eIrFUzKIf
         2JJA==
X-Gm-Message-State: AOAM530doE91dXyLrQuYf4gt6gC0rn7ubZ477O3p7RKMwSJOAvJTmq4k
        oPcJwQt9ESjRgVMO5349xjGTAg==
X-Google-Smtp-Source: ABdhPJz+9xom3Gpd0sWQGb9L5V9xHqwt+zYOwBcgSRixqnzDipT721eEbNH9G2mgAtOSxrewahO5wg==
X-Received: by 2002:a05:6512:33d0:: with SMTP id d16mr15409549lfg.485.1635970436666;
        Wed, 03 Nov 2021 13:13:56 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id u5sm290415lfo.280.2021.11.03.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 13:13:56 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     christian@brauner.io, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: clone3: clone3: add case CLONE3_ARGS_NO_TEST
Date:   Wed,  3 Nov 2021 21:13:50 +0100
Message-Id: <20211103201350.3866089-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building selftests/clone3 with clang warns about enumeration not handled
in switch case:

clone3.c:54:10: warning: enumeration value 'CLONE3_ARGS_NO_TEST' not handled in switch [-Wswitch]
        switch (test_mode) {
                ^

Add the missing switch case with a comment.

Fixes: 17a810699c18 ("selftests: add tests for clone3()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index ede5da0c67b4..3fd49f419466 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -52,6 +52,12 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 		size = sizeof(struct __clone_args);
 
 	switch (test_mode) {
+	case CLONE3_ARGS_NO_TEST:
+		/*
+		 * Uses default 'flags' and 'SIGCHLD'
+		 * assignment.
+		 */
+		break;
 	case CLONE3_ARGS_ALL_0:
 		args.flags = 0;
 		args.exit_signal = 0;
-- 
2.33.0

