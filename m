Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A7159949E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbiHSFdJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiHSFdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:33:06 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E5E0FD5;
        Thu, 18 Aug 2022 22:33:05 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id h19so1425017uan.9;
        Thu, 18 Aug 2022 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=c+0oqG7L/KIFE0prA1/0TP0LiidqFUxPZvUVbudAB6o=;
        b=KyiJHGoFLDiCyge0d+nP+PeH20Y+YBaro67sEpRGS1ubF2TUGhjVGteLDsPmlu27tp
         vgyBQvlW4hSiasIFZvJtALwzQm/e7cvGdBHJ/mMuohOZ+KkgTAgKMDy46PVndGPSuVow
         sFsoAlKefDdfdQFaYrdoUYshb/ntZB2HKpbILP+Ohv1GX7Ydgep6lI8go+KzQZy5u8DK
         hXlvNAJvBQnQJbemsAiaQzhOSPc1bkfAr1CaHJ1LSWEvIsHfQw19zTG0xk6A3kJbf8cU
         kkVQdhZDGXFHnNeziLzlIKf/xwfzOzLbpLMzNd30Rld/6cR4/JEk2gP1lbwb8y+SN50L
         jI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=c+0oqG7L/KIFE0prA1/0TP0LiidqFUxPZvUVbudAB6o=;
        b=viK6rbBsmK1dQPH56IuIDlODVw6uD+aE+2fpY4o7DEE83q4t4f019RotOgGtcQkYQ2
         9oML8q+0lmvRVUHFSyJQ51k7Z6BE49mlQStuuQYW4h2xFoo3ZxxexgY4IJfZ5HsYwjl8
         pbxndOJtfJAvQlFtlc5p9lZcuxNxhzV7FDm0j0nTfqS5NuqejZfKmeAjLXOFsf9BKAEB
         /94mvUTsNIgzB3POrzvCFnHXV7w4VBn5ZLJwExGKClJmcZktv4obsz9g27EUWUxFfIMd
         TFaljW7ZDfN+VpVIWQcBuqSVnFWOvK/5CzKGVuk6GHXCq8Z5kDB8lCmQ3n1dajFz36tA
         4laA==
X-Gm-Message-State: ACgBeo349pe8qggw3theJA05Hpsy692ARq2GM8OU/nr0n1XM41LBZ3Kw
        ZEWEkzzlC1N2Q3FurEyFVgw=
X-Google-Smtp-Source: AA6agR52hbuiJy6puaqgio3XZXfoNrUNPnBn8gyEQefMEnT7Or3s53EL8fi6sPOayObcQmaNW08RFg==
X-Received: by 2002:ab0:3b0b:0:b0:397:d412:8575 with SMTP id n11-20020ab03b0b000000b00397d4128575mr2338572uaw.105.1660887184393;
        Thu, 18 Aug 2022 22:33:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:33:04 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 5/8] Documentation: KUnit: add intro to the getting-started page
Date:   Fri, 19 Aug 2022 02:32:31 -0300
Message-Id: <20220819053234.241501-6-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819053234.241501-1-tales.aparecida@gmail.com>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
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
---
 Documentation/dev-tools/kunit/start.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index f0ec64207bd3..3855402a5b3e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -4,6 +4,11 @@
 Getting Started
 ===============
 
+This page contains an overview about the kunit_tool and Kunit framework,
+teaching how to run existent tests and then how to write a simple test-case,
+and covering common problems users face when using Kunit for the first time.
+It is recommended that the reader had compiled the Kernel at least once before.
+
 Installing Dependencies
 =======================
 KUnit has the same dependencies as the Linux kernel. As long as you can
-- 
2.37.1

