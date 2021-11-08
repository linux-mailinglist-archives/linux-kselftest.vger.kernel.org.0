Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F4447844
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Nov 2021 02:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhKHBcE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Nov 2021 20:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhKHBcD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Nov 2021 20:32:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E475C061714;
        Sun,  7 Nov 2021 17:29:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so3347666pjj.0;
        Sun, 07 Nov 2021 17:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2eiSTCEhkv2QL1WcuadqsLjGZwmJNxv+T2Gs1korUk=;
        b=A6r4IiCMUR9X5EHkxzOU3Udir/aKoS5FQoclznj/pDJyjFkRccXYerbFQbawZIMSUD
         HeFHCdk4OYs85ddtqWY87XZCjBHiqD+/AXELmBqmyMqII0b5yZZkvQYFcY5+3UGwgqBE
         CGOkSOzrFsfDuNa+bcCgFfFKfkbkBEOrkjoParxBJB1G0guNwuY8eA702jLk2Pxfpy41
         6WZ30eRbP+ygwm1UZASITd3Rhm5uXasBUw7nrUirLHgucsNz2MrN54cRoMJFoppalpjk
         szfyWEQCt88sH4pkSiIIxwPHAXdVcoPH+wccBWP59GOG6e7sNyBtPfvt/V9FXQmFBvga
         3j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2eiSTCEhkv2QL1WcuadqsLjGZwmJNxv+T2Gs1korUk=;
        b=I7OCIK44RIVkw73ZoQymodMFctMgzqp39WyO2Cjs4NETtFUlth2IauZlBHmA0wRVx4
         DLsMxJh9DjjVePf6jnABDZNk81lBjE2Q/oSOCjr46hVE7LiFdjb6EQNITsXQBFcNXMbG
         mp0AISTVtBVAFdsn9SW7Kt/ME6EN9uAzsNY+0OlPB72dtsJMHm+CZqkRkUgrd+gPVmo3
         1rNHBMYIqS7ioIWx3ku4o9N8x3+WwaI8kyMGDi0KIlPOqc4qE60qTdtsITp4YmZH/o9v
         WuKKhawz32Z5ZmG5AN+2tYDHx8U4sUUtcHDHJERNced4MYXOrOhSsf8EongqqaJmnwld
         6JKg==
X-Gm-Message-State: AOAM530d664aXzJVviacidN+yd/7pMlifz+FLARdYicqK1uQvcIbJTIF
        fFBrB4Bkq+Wfo0bQ7+xPD4VqPVGsWd9+fg==
X-Google-Smtp-Source: ABdhPJzTC7IpmjZLd2gm/6K3047gJ3aJKHNiI1Y/2uveMTh3GiUZGrPoPgBjR6cpQk2CtlbuFRRrsw==
X-Received: by 2002:a17:90b:4d84:: with SMTP id oj4mr43652154pjb.90.1636334959261;
        Sun, 07 Nov 2021 17:29:19 -0800 (PST)
Received: from sol.lan (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id t4sm13800861pfj.166.2021.11.07.17.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 17:29:18 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com,
        lizhijian@cn.fujitsu.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/3] selftests: gpio: fix minor build issues
Date:   Mon,  8 Nov 2021 09:28:48 +0800
Message-Id: <20211108012851.7772-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a series of fixes for minor problems in the building of the GPIO
selftests introduced by my rework of those tests.

The first patch is from Li Zhijian and fixes a compiler error when
building the selftests in environments with stale system includes.
I have reworded the commit comment to make it more to the point in
describing the root cause of the problem and the fix, as suggested by
Shuah in his initial review of that patch.

The second patch fixes a warning when the tests are compiled with -Wall,
and the final patch restores the CFLAGS that should not have been removed
in the rework, including the -Wall.

Kent Gibson (2):
  selftests: gpio: fix uninitialised variable warning
  selftests: gpio: restore CFLAGS options

Li Zhijian (1):
  selftests: gpio: fix gpio compiling error

 tools/testing/selftests/gpio/Makefile           | 1 +
 tools/testing/selftests/gpio/gpio-mockup-cdev.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.33.1

