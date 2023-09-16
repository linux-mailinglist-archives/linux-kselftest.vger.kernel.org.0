Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C977A3153
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbjIPQMJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjIPQLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 12:11:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45300CC0;
        Sat, 16 Sep 2023 09:11:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so3782909a12.0;
        Sat, 16 Sep 2023 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694880693; x=1695485493; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2D29quburpZKmR88i6a3MAgQFNHJh6PxWDpmGkVgtps=;
        b=H8AHCEgDKJ+1KS90ga9snc7C8CeBqqxMRq1AuxDywSt7MWsLCzdPzd2iFROXiAxmXR
         WojYbQMQhSgzhhxi0W/l5rM9p1TMvP6gRthVn+GffgP9VBMqWIbx1T7GZjjHdWLBD5kG
         /9jTEifQfcXTQtFpvx1308kkMrUqwESSbxnrBr4Y6SOUhXqF9E6G+zTqMrCgLxQGNlRt
         90oIHYrmSD3fRarFqQISwWMFLF+4i49g/FKpmBUjTR4H2JXBPD1M2W45AhXbsxcQEbdn
         lNyrunE5cWlb1qZSaqmsvTLI8sZsX3eoG5fOn76lz+Ya6g+TMZr99Py1Q/cXcDFk86ew
         BgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694880693; x=1695485493;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D29quburpZKmR88i6a3MAgQFNHJh6PxWDpmGkVgtps=;
        b=hninRCwtcZTZFOQevQJmOim+lQF71OLYTpR8Puy5qVuMEsYxAmDMZjPap2x83mwx2X
         Qd8e6+ZGo62fj60n6LKqn2iuYhtQ4B5HvvbMOcZYGA1VtQ4vkGmH/8GytSTQl+CgwSOP
         nvyU3jt0Iu6ci7kHbGoLIBZaPD55txwegRMN0nTcu8UIX0VF45YXbegiPRvSJx7qUE5X
         dDRDas/inqd2mKBzEwP9PDBwt+8jCwkoBfVv6Mk2/pdyKyZ/iGcB7wT0knkXnpiw0tQC
         AtW2oX9AteHM8Hp3gV8qqSALU5IsI4DxUetSfCQDfA7Rit0NlAe7rHympHyBRSYDPCIK
         sbKw==
X-Gm-Message-State: AOJu0YyIbl28ZlTWhCEWWZRs6XBuQOzpXoPnNrV5xzyrV4uPlYT2CMLz
        UE484se0W3g113Rbv0pqAMw=
X-Google-Smtp-Source: AGHT+IEtqsFwHKCcW79YHmTi16x18Ywke6xmHVW2O7x1m8mDtbz6o33y1ZArqXail0vCaVgtpR36gg==
X-Received: by 2002:a17:907:75c4:b0:9a5:d657:47ee with SMTP id jl4-20020a17090775c400b009a5d65747eemr3939414ejc.58.1694880693556;
        Sat, 16 Sep 2023 09:11:33 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-82f4-11ae-0d42-6e00.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:82f4:11ae:d42:6e00])
        by smtp.gmail.com with ESMTPSA id xo23-20020a170907bb9700b0099290e2c163sm3861131ejc.204.2023.09.16.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 09:11:33 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sat, 16 Sep 2023 18:11:31 +0200
Subject: [PATCH] selftests: uevent filtering: fix return on error in
 uevent_listener
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-self_uevent_filtering-v1-1-26ede507d454@gmail.com>
X-B4-Tracking: v=1; b=H4sIALLTBWUC/x3NQQrCMBCF4auUWRtoUo3oVURKEiftQJiWTFqE0
 rs7uPzf4nsHCFZCgWd3QMWdhBbWsJcO0hx4QkMfbXC9G/qH9aYtKyUjWPK44Y7cxkylKcKTsfd
 4G5x3MV09qBCDoIk1cJrV4K0UHdeKmb7/y9f7PH9rZ3RaggAAAA==
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694880692; l=1362;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=S4RWDQgvO5XPexY8N6KFcYh6xsBydPzqOVbL1s6XVhU=;
 b=cAovhn9t4cDxBHwizFmibdCmD41kYpuZCsM9shSZIle8xzuK77Bbk4dqB4qR+hik+zhOlw6Mc
 2GP+/wu8iunDBc6XMyi5FHQ37WBPyj2Zo5tmFnEN4OClltYyD8Ha80T
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

Assign the error value to the real returned variable fret. The ret
variable is used to check function return values and assigning values to
it on error has no effect as it is an unused value.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/uevent_filtering.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index 5cebfb356345..e191b6d69f8c 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -158,7 +158,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 		r = recvmsg(sk_fd, &hdr, 0);
 		if (r <= 0) {
 			fprintf(stderr, "%s - Failed to receive uevent\n", strerror(errno));
-			ret = -1;
+			fret = -1;
 			break;
 		}
 
@@ -172,7 +172,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 
 		if (!expect_uevent) {
 			fprintf(stderr, "Received unexpected uevent:\n");
-			ret = -1;
+			fret = -1;
 		}
 
 		if (TH_LOG_ENABLED) {

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230916-topic-self_uevent_filtering-17b53262bc46

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

