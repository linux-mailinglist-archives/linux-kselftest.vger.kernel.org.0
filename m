Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9578DAB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbjH3Sg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjH3Nc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 09:32:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220611F;
        Wed, 30 Aug 2023 06:32:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so84357581fa.2;
        Wed, 30 Aug 2023 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402374; x=1694007174; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnDE+pbhmyZZgibTtE5/3/lahQ2s3Jiv+g1RsGQj064=;
        b=h76hn8ZrFVEpRL2Lwcb15amvXHlKGuHq8jL+9WkscAnkUIK7L9rj5ImXDspGuFLbl4
         Ik7WwFY5KdSrBJpZHRp+em6LDvC1hGgJaDn7gJjBIvx5XUU3wfjabcDySjLLNlin68/2
         TvUhxqaVsNuzHzgduDwNTZvDuxFWOJYRkAJcUN34cE2MvzgDAsDdvGyYdX01a2Rf32Aq
         mOAzco+pD/FZyATDOR1lZYRWevezIQOlLhzpodkIHVsQo7JZU7zsaClNbZdpr4VaJKVS
         zHAIb24j9YSMRte/I7uU/YkwSXSGScQ+OGPNcBsHfKRvqCw8xHJElrcnXOYUw3Odyyls
         NktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402374; x=1694007174;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnDE+pbhmyZZgibTtE5/3/lahQ2s3Jiv+g1RsGQj064=;
        b=OVcM7CXCLITrn37YEbnIZB0jyoP0EWlt/2z0qjJ1DwtGbDGcbdPr8HIlqFjJrY+ais
         hm7jW8XHMWgWKnDkN69q9AOFlp0vJ7xsudvzTeyiBMJetgYsKlj8Mz1GOulp5OjGMyVm
         GEDX4zC1uKwlwcaxVWrmBaGUjgwf00T/UkN4RSX0qMb87dPIJ9wFuGQjdcV1J5G6xggQ
         5jUzVfxN9CmrpywRrJYAf33SSatcS6csWV/b4I69c4CpSwJV4wXT3eNALdTqOHPsApOx
         Wv7SNqvjbYBzr8blXRYPIk1QhArDGxCUUeR0xmU3RoJmtF7ENKIS1MiE4S60787ir5Iv
         G82g==
X-Gm-Message-State: AOJu0YxNSmdeGohVydObQwNhMCyIL/G/5EbYVUAwGqJuqzhdCjEPyW4Z
        vl7W0b+wh5JUyZFNDr45OiFvW54pGNKIExTB
X-Google-Smtp-Source: AGHT+IGi8ro0DR7fyFjZnSw3v3zPDry2Iuy00rD3+/FoIo1eybxV5kiHIB75fOisLiLy0+bcmuD+Lw==
X-Received: by 2002:a2e:9303:0:b0:2bd:1bca:ebee with SMTP id e3-20020a2e9303000000b002bd1bcaebeemr1784959ljh.19.1693402374285;
        Wed, 30 Aug 2023 06:32:54 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id lu9-20020a170906fac900b009a1e73f2b4bsm7160374ejb.48.2023.08.30.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:32:53 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 30 Aug 2023 15:32:39 +0200
Subject: [PATCH] selftests: static_keys: fix messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-feature-static_keys_selftest_messages-v1-1-49bb58c508a7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPZE72QC/x2NTQrCMBQGr1KyNhCbYtSriIT8fGkf1ljyUlFK7
 25wObOY2QSjEFhcu00UvInplRscD50Ik8sjJMXGole9VmetZIKra4Hk6ioF+8CXLWNOFVztE8x
 uBMs46Hgy0ZuLGURreceQvrgcplbL6zw3uRQk+vznt/u+/wDx0cSsjAAAAA==
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ivan.orlov0322@gmail.com,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693402373; l=2062;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=oWvFN7xOGkU7bcs3lDFa6vK7FIsOV5vZtf+uQm0sw9k=;
 b=Mc+Ml1gSrzo1GBG7gW7JleZmEtAVVegiL5pOr8qR3D4f8IYdevKiTpqTfPY9UBvtA1Erw0egw
 I6PMjjkZmu6CxmpMgck4XfOo8C4vo+z/eLJjqMMtOkf5BWFDw/X2qkF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use "static_keys" (name of the test itself) consistently instead of mixing
"static_key" and "static_keys" at the beginning of the messages in the
test_static_keys script.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This single-patch series fixes a minor inconsistency in the
'test_static_keys' script from the static_keys selftest. As a general
rule, the selftest name is provided at the beginning of every log
message.

Apply the selftest name for all log messages consequently.
---
 tools/testing/selftests/static_keys/test_static_keys.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/static_keys/test_static_keys.sh b/tools/testing/selftests/static_keys/test_static_keys.sh
index fc9f8cde7d42..3b0f17b81ac2 100755
--- a/tools/testing/selftests/static_keys/test_static_keys.sh
+++ b/tools/testing/selftests/static_keys/test_static_keys.sh
@@ -6,18 +6,18 @@
 ksft_skip=4
 
 if ! /sbin/modprobe -q -n test_static_key_base; then
-	echo "static_key: module test_static_key_base is not found [SKIP]"
+	echo "static_keys: module test_static_key_base is not found [SKIP]"
 	exit $ksft_skip
 fi
 
 if ! /sbin/modprobe -q -n test_static_keys; then
-	echo "static_key: module test_static_keys is not found [SKIP]"
+	echo "static_keys: module test_static_keys is not found [SKIP]"
 	exit $ksft_skip
 fi
 
 if /sbin/modprobe -q test_static_key_base; then
 	if /sbin/modprobe -q test_static_keys; then
-		echo "static_key: ok"
+		echo "static_keys: ok"
 		/sbin/modprobe -q -r test_static_keys
 		/sbin/modprobe -q -r test_static_key_base
 	else
@@ -25,6 +25,6 @@ if /sbin/modprobe -q test_static_key_base; then
 		/sbin/modprobe -q -r test_static_key_base
 	fi
 else
-	echo "static_key: [FAIL]"
+	echo "static_keys: [FAIL]"
 	exit 1
 fi

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230830-feature-static_keys_selftest_messages-d43d67db7974

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

