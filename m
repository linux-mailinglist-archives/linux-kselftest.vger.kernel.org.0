Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E959B7A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiHVCaz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiHVCak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:40 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EA220BD4;
        Sun, 21 Aug 2022 19:30:39 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so4903386vkf.1;
        Sun, 21 Aug 2022 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=z1ZsU5x1IoYopHd5y3D5llLxgCc0eEbrcLWwHGDNGNI=;
        b=TRsp8CRTrrydzxQGGmIKRs7POSJ8s7mV7gUqN9lZ2qgBNPqimjMOZHXft087WPLDe+
         q0Rx3issWmxkzjSDswOblXXErorlP40dak8DlsOeKZ6hJGxIE8+CJlrEe2NaSicFukJp
         cqEzZZcRp35fX4QNKrx0m5mbtfGZCiZz+SGumBqzyuKvxTBt+yk6QIn/nPNXUHDvFHS5
         ExLPIlV/xcXEmOFNvenLU8qdbY9vTSVRza53oVNseECxR1mfdOtnunTdMxYSQ0vB4C2a
         Vvh3cxCXcmUWM6d8AZBQpUTtvfs7rqW7zFMQ7Dp7M4uTLErO1piZMeNkx2dXuk+bPHXq
         ozjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=z1ZsU5x1IoYopHd5y3D5llLxgCc0eEbrcLWwHGDNGNI=;
        b=0K750q+ytt9CwQfwGg//DoYMK6jNipX/izRJ7sNzzjSM2GGTKilPL6I4vuCzhGvWbb
         f31OlwzOdrkbMlTCZqWFLX5bfBiIhY6WWOTfubSyW3T+WqI12SBRpGMN3fep5jnZxRiw
         6z9tQFplOn8fyR4vnDrlPiR+/8Sit7dF32Yc77UOeFVVCtRIyPABUjTIQtbMrrN1wLdo
         5w4SckSjuZ0gOlKrsV3Ppj3DAlrkZ52rbS1mHxic74Tzl2iEKjupfrGMKjpNii0g/0rw
         IGDasFvb3Jt4/A6WcejF1xFs+OuwnPl2huosxo+1hSnlxbmujJMSbPTJfAuKKn/t68PV
         k6Zg==
X-Gm-Message-State: ACgBeo0RYeG53EC4lNXix7tsl1I5WlyiuqFyId08AVGHiIfLgI/H55Y/
        3JWUy0A1xVwACNfRSFEojH0=
X-Google-Smtp-Source: AA6agR4s/yrI1OKO/Z2JygmH+fmfnN/6uaXsOb2Z07rMUkHo+4/MAhfnXo4oJPX1vb6Ncvuwnv+tgQ==
X-Received: by 2002:a1f:2196:0:b0:383:cc4f:4233 with SMTP id h144-20020a1f2196000000b00383cc4f4233mr6447416vkh.16.1661135438500;
        Sun, 21 Aug 2022 19:30:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:38 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, Tim.Bird@sony.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 5/8] Documentation: KUnit: add intro to the getting-started page
Date:   Sun, 21 Aug 2022 23:26:43 -0300
Message-Id: <20220822022646.98581-6-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822022646.98581-1-tales.aparecida@gmail.com>
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe the objective of the Getting Started page, which should be a
brief and beginner-friendly walkthrough for running and writing tests,
showing the reader where to find detailed instructions in other pages.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>

---
Notes:
    Remove recommendation about having compiled the kernel before using
    kunit_tool. I changed my mind about it after Tim Bird's highlight.
---
 Documentation/dev-tools/kunit/start.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index adf782507999..75fd05286396 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -4,6 +4,10 @@
 Getting Started
 ===============
 
+This page contains an overview of the kunit_tool and KUnit framework,
+teaching how to run existing tests and then how to write a simple test case,
+and covers common problems users face when using KUnit for the first time.
+
 Installing Dependencies
 =======================
 KUnit has the same dependencies as the Linux kernel. As long as you can
-- 
2.37.2

