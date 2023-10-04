Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F597B8145
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbjJDNrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjJDNrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 09:47:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5DAB;
        Wed,  4 Oct 2023 06:47:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3644631a12.2;
        Wed, 04 Oct 2023 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696427267; x=1697032067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+9+LAlJuD4eyVxS1MQPOCvMMNgYGaznqIXuuksXO7U=;
        b=TDcwnMffpA3jK2RNTEQep+koQWFbXBiGnFcoffWit/XUVjiWXDn0BkLJ3dJB3bo8rN
         XtPH0U+3lFFxGzm2x3aJLWFJ4+TorEVPXkIMcJTSpy5jn0GVoZisA5c9d7jzRYGPuRIW
         n4yVEYYn0CUPRRT8K71bE22m4XKwKuPq5U+yQZh+HMZgWTgXVs3kz6c0Mzkh6jYPm3BR
         5IvQp5E9dkUMkL7zYZPbSF6Dr5spj1LT30nbtEcfw31GBUWAa8uyFBgVdANmVUvL4tpo
         8r8B5NcxC9Qh1wU4a4sFctt7lSLHbCR4Pr8O1BmomJpAMd9BZL0vqgI1uCIn0f65mAht
         NBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696427267; x=1697032067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9+LAlJuD4eyVxS1MQPOCvMMNgYGaznqIXuuksXO7U=;
        b=BQYkUVAyQ3UFlQmF3g9uPJlNHIvjKuef/Sy3SYfkuk7nX2s4oYq9/kEnMZr1W/iUAA
         IuSzdBQgY2CGNR1u2j96Nuc4hRS2LXF/W5DOI/Uw4xs1Le8GGibM+/YGTL1CfHITdaVT
         pSze1UFVzW1EZWYhYwr42AuISk/HAPNUbjgVn1HzthQjFtnacjyfJcD+gIy+3D0WpPJL
         C1NvqXHlDlNThqMcGVCM/tSiijKk/RPFvn1RF5DfthWXZatSy/QTo/xN41kWCLE34Nfx
         LWB9w0EUInhFO1sEms/QPMO/diVMu7HLjTC9IeRlIKasxT6muv2w0K3MwOW3P4tP5nep
         sVhw==
X-Gm-Message-State: AOJu0YxdgaccMXZtQ/TtmG18P/PZyJikCECQiU9raoXhgJBxJiIRouzD
        VeYxJVcP71zLkepBUfOsu8U=
X-Google-Smtp-Source: AGHT+IHX5xcTDs5400RWNQ74u1Kxjf74UdtNP7FawefC7FnI2fnGI4JFPqGCj414FYbmJqU+Fz8+ZQ==
X-Received: by 2002:a17:906:3116:b0:9a9:e4ba:2da7 with SMTP id 22-20020a170906311600b009a9e4ba2da7mr2041390ejx.49.1696427266903;
        Wed, 04 Oct 2023 06:47:46 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id kf1-20020a17090776c100b00992f2befcbcsm2805593ejc.180.2023.10.04.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:47:46 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 04 Oct 2023 15:47:42 +0200
Subject: [PATCH 2/3] selftests/tdx: add gitignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-topic-selftest_gitignore-v1-2-40689bcd23e2@gmail.com>
References: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
In-Reply-To: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696427264; l=476;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=5GsJYglli3t5TFFxYav+wxApE8MK0YTOQ09GMZ/uXh4=;
 b=FVel1WESuc+BXNiwh3M5qqYHO9Y5IBdTHdVwLIH7lRViGJnXAV3ELPiIF5tNP4EoPWOTIJ08U
 RUDdALzQVnkDK8ex2WGHRdTxMyl05BNu9EwTWLMUR+vZsBKPdsC+1nC
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

tdx builds a tdx_guest_test binary that can be ignored by git.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/tdx/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tdx/.gitignore b/tools/testing/selftests/tdx/.gitignore
new file mode 100644
index 000000000000..5db4d15cc673
--- /dev/null
+++ b/tools/testing/selftests/tdx/.gitignore
@@ -0,0 +1 @@
+tdx_guest_test

-- 
2.39.2

