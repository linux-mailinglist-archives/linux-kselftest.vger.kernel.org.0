Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09A7B4798
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Oct 2023 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjJANSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Oct 2023 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjJANSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Oct 2023 09:18:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F33100;
        Sun,  1 Oct 2023 06:18:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso276791a12.1;
        Sun, 01 Oct 2023 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696166294; x=1696771094; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kmrieUoEvolqVXvMCccXXIjVigvLDaCkvcg3JtU/Iw=;
        b=Z6SA2oxgwIEp88aIQPnhGlAH6BT93fzOgLNc6WEJobO2SjyX02CjoAaN9LVD6q31um
         7uIxJoYQLo2wNz5N8AkHEPxlSRx8H77TR80Vi8tTerkQuTzRrFp4tUcW1zYoDS3td2yi
         FJ5P0Ww/xCOaEVrtCAMLrvzCun8l1CO8mJ14IE9bTRM27/vMNlo1kSyjq+uwYDolSRyF
         QduAJC6QgTcKbwnwJKvygdgebW8KCjphxZKcPzycbZUJkm+Is1mfqLbHuwg78u1HrE09
         at/UHhE9Klb4IhEt/qqMxGbDQl94Fr4QU3jLTWK2PHZgRk8ItEDGvo4GWCepuUSlzNMB
         4DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166294; x=1696771094;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kmrieUoEvolqVXvMCccXXIjVigvLDaCkvcg3JtU/Iw=;
        b=FOpcom0BR07Ivn5tX5LZPbTHubn0B0q2nlpTHTfWtPPKW0gL7zvSbouKmjuZdOU9Nh
         RchBJrYgApc+vfT/HzV+u3TlIMJKPQdArZ21OFEDnY+d1b8+Jwu9H7Z/58VugRQyZdpi
         tUtqplx62wrecbqEReeelLH5ZfTjEyI1ye/HJkq+L/E0mkMBJCvlnWyKe3XehC6CTQRi
         t+97TeQ3OANHURkxh/3DyBAo9zDj2YiqmCavSd8QWOgKcfMUN3TKoDmo/Kxk08Oc3zTg
         P5eZ0RdGRYaD7zMktunbcmX7TkfJ4T8WTj5lPtm19YYWclZnwbHzPiq+dVluWQDPkBj2
         9+fA==
X-Gm-Message-State: AOJu0Yy3w6E8XbhRoYHbZjWk+KPjbF6fnXznADKiXjUv4CePMIvWQCvV
        0PhAtr7FM5gyqtE3b+/mIdtCArBN83fC8w==
X-Google-Smtp-Source: AGHT+IGevTZnyJQZflsEG6qrGGm9qgAssk/eAes2jv0cQkmvXveXNKBCZJKIMymOzxZz8oEzi9hphg==
X-Received: by 2002:a05:6402:14d2:b0:522:1f09:dde3 with SMTP id f18-20020a05640214d200b005221f09dde3mr8303172edx.3.1696166294412;
        Sun, 01 Oct 2023 06:18:14 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-4c68-6c03-863b-ad4e.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4c68:6c03:863b:ad4e])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7d311000000b00532bec5f768sm14036189edq.95.2023.10.01.06.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:18:13 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 01 Oct 2023 15:18:09 +0200
Subject: [PATCH] selftests: static_keys: fix test name in messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-topic-static_keys_selftest_messages-v1-1-da170a080427@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJBxGWUC/x2N0QqDMAwAf0XyvEJbB9L9yhgl7aKGzSpNkA3x3
 6d7PA7uNhCqTAK3ZoNKKwvP5QB3aSCPWAYy/DwYvPWts9YZnRfORhSVc3zRV6LQu1cSjROJ4EB
 ibAi+9fbapS7AUUooZFLFksezNaEo1VMslXr+/Pf3x77/ANA3ABqOAAAA
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696166292; l=1878;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=UnmF1DURZkDd0tpxiFqDNHzvObTRgMeQgOdg9+HX6H8=;
 b=fq22QaIRZ2IM0I0h9saBt3BujVkkKa49u50vh9ahqujpgz2c6yKSsyYmG4bqOHLV1xz1n3Asx
 bw3+buCUPUTDZ1D78eJzCkC7i2od9kuNx/iyJSrcNNHshc9igaPinyU
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

As a general rule, the name of the selftest is printed at the beginning
of every message.

Use "static_keys" (name of the test itself) consistently instead of mixing
"static_key" and "static_keys" at the beginning of the messages in the
test_static_keys script.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
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
base-commit: cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c
change-id: 20231001-topic-static_keys_selftest_messages-099232047b79

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

