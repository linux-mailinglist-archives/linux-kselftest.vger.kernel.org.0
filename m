Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156525ADA15
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiIEUVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 16:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 16:21:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AFE12AD1
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Sep 2022 13:21:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e20so12588642wri.13
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Sep 2022 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HkuLS1fVbmOSdnVWEUBZxpoZwFJkI5ziv+kyTn1ya8A=;
        b=XnBxNSGxFzdOGOhK6lfK5VvAiuVTm0Z2TqgxrmLWe1FMSGslTh0D1Q9Zrwo9dhKGTZ
         Qgr2Bdm56yRHNuD+JvCNI46qTUr56YLA6Zj/OKvkjCqnyf9tSe0TXiOZzi+6YTxC8Fqf
         VGXCAxi1qBlgF7UbgxbMH9tw4YFfL1znx/gJ5VywL/2LLyY+fy8pi+tCQyXWJ43FEHXg
         SERj2mHuNhjVlGF/eo5KVuyk42Fq2RMtx34asHakz2IgD6Lg2+r5E38VRef5yU+7wuFb
         tQ7IRP7RK3Llj6jU4+TFATA7ijh1BTZf3vAa4upEnCHv+KFmR6+T0GoZW/MGE1BEES/n
         eQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HkuLS1fVbmOSdnVWEUBZxpoZwFJkI5ziv+kyTn1ya8A=;
        b=r1t4UcHQGu9VhjpzGtHHWHJd2UVg1RKaP39UumjYoecvltjKh6oBaISFpQIKWi2TFl
         hISa8ANGz3SUYV5k1U4P/FY2a/+uUekA0mmz9EaAJvKR+Vy0JCQ/C7EhMrAo8OlEsw4O
         0B6iplGFGDTd4zvT58fFBsfbe812rUGoRY9HWZQTbkPEWZh1Sdktb8x2Ht8UVgVfXB2q
         pmsUFE9VdyslO7wmKJhqdug7BV8xKZxkyDQm3XhUZ7G0t38FuVp/Bt2GhWMZ8KIIwFWA
         pcTIq/Gxiv0m4UKPEBppbKp1UcK7pWSXsTonknRONxDrUWkD5ng+Odyz0eEYInqncWq7
         HamQ==
X-Gm-Message-State: ACgBeo0XMseNMIDIa4WEDvJnGeQfnBAiWXwTee6N89p/rf71KYGsQ+pR
        2mO3lk9Q8hLZMSgtEqHkXl6V4Q==
X-Google-Smtp-Source: AA6agR4S1kbgPVba5pV/XjvMvNrRZp4UPoOlolPLPEvgADezZUSkZBNAYtPJy9ZXsCx2zioNwzei9Q==
X-Received: by 2002:a5d:62c8:0:b0:228:67d2:797b with SMTP id o8-20020a5d62c8000000b0022867d2797bmr4529340wrv.462.1662409275977;
        Mon, 05 Sep 2022 13:21:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm19841272wms.23.2022.09.05.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:21:15 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 0/3] selftests/Make: Recursively build TARGETS list
Date:   Mon,  5 Sep 2022 21:21:05 +0100
Message-Id: <20220905202108.89338-1-dima@arista.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From [1]:
> Please look into a wayto invoke all of them instead of adding individual
> net/* to the main Makefile. This list seems to be growing. :)

I might have misunderstood what was suggested... Here is an attempt to
let sub-selftests define their own $(TARGETS) directories.

[1]: https://lore.kernel.org/all/aa0143bc-b0d1-69fb-c117-1e7241f0ad89@linuxfoundation.org/T/#u

Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

Dmitry Safonov (3):
  selftests/Make: Recursively build TARGETS list
  selftests/.gitignore: Add vfork_exec
  selftests/.gitignore: Add io_uring_zerocopy_tx

 tools/testing/selftests/Makefile             | 71 ++++----------------
 tools/testing/selftests/drivers/Makefile     |  7 ++
 tools/testing/selftests/filesystems/Makefile |  4 ++
 tools/testing/selftests/lib.mk               | 59 +++++++++++++++-
 tools/testing/selftests/net/.gitignore       |  1 +
 tools/testing/selftests/net/Makefile         |  4 ++
 tools/testing/selftests/timens/.gitignore    |  1 +
 7 files changed, 87 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/Makefile


base-commit: 42e66b1cc3a070671001f8a1e933a80818a192bf
-- 
2.37.2

