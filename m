Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492D59B79F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiHVCaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHVCac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:32 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186021830;
        Sun, 21 Aug 2022 19:30:31 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c3so9787409vsc.6;
        Sun, 21 Aug 2022 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x027gD9Q590MYEegm4t4IJAQG82OSt6Oxw8CWkrsRdY=;
        b=fdMojUkEIMj6VvFshDtCCFB/Q+etuu3zE2OKrxEgHerfajDL6wZ1xY2gjG7doX4ELi
         WyWuFqKfE6Kyg4785ZrkGVcPmzuL918+fo0r/A1UXX3f6tVuSwsnxEATIXm12WaMUNBE
         J9QD0QMutCnYz9zmjwb0ahp3A849EyR2sydEFnbauVbKwQIyBrFAOuupxiNPAV5SsmJj
         1+iu4C2GopNy81d2DOLpGgy5RIfoPME0Xmyl2Y2SPp8W9uI2mp8sVPqCC8ZZBrlY34rz
         u8K7FKbIcJozS2zaMryf0YaiHloBTGnQinNsjyIKfYyTz8bkyb/3oemy6Rucc5EgyLdm
         IXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x027gD9Q590MYEegm4t4IJAQG82OSt6Oxw8CWkrsRdY=;
        b=qIPo6/xiDa6EQ1rTxc12pM1yzJJkEjc4txafx0r5MR5J90HwiK7W4WoQk5Hg62oPhd
         WcTiVTMQTYwEhTTm83CmAO8Y+vWPy3QMOq685lILqlJLKhaWp4nXtAky/RqXwT5RbDdd
         3ydz38zgOkuPjPTZSvAy73l66i3qi9ypvYIhpgqJleGKmDxqEBoQJjPogvf5zTRBilz1
         OKOTxpxl+VMKpVFjB6N/hjQLYHBiKPBao4idfWunSriSIVEhelsV+0Dsdym+WvZygCOW
         eBByfCiDaCbVBBfQ9xmlcFaEUelHrm+vKNHDZ7lFxAkxPjQMPZZpEUQR5m9X1S39JCrD
         NXeQ==
X-Gm-Message-State: ACgBeo3zEuZaRYudR6lGRHCkvL73oj+GbZ8ITVjgqEdnnE91+sj63XQg
        O2BhTGYUn2KNHzfOa6ICclk=
X-Google-Smtp-Source: AA6agR4O6gKYfi05v0t+dgGWyKTuTWLoTgs6S6tdxiHyTufbJpPFYG6Sw/hmpbM3FfDDap+bgXdz8w==
X-Received: by 2002:a05:6102:3a0c:b0:390:3a5b:dbcc with SMTP id b12-20020a0561023a0c00b003903a5bdbccmr3603654vsu.23.1661135430926;
        Sun, 21 Aug 2022 19:30:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:30 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 3/8] Documentation: KUnit: add note about mrproper in start.rst
Date:   Sun, 21 Aug 2022 23:26:41 -0300
Message-Id: <20220822022646.98581-4-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822022646.98581-1-tales.aparecida@gmail.com>
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
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

The "Getting Started" guide should be beginner-friendly, therefore
add a note about the requirement of a clean source tree when running
kunit_tool for the first time, and its related error.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

---
Notes:
    Edit note following suggestions (Sadiya Kazi)
---
 Documentation/dev-tools/kunit/start.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 2e31350a85e1..9beec7d6ac4b 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -19,6 +19,22 @@ can run kunit_tool:
 
 	./tools/testing/kunit/kunit.py run
 
+.. note ::
+	You may see the following error:
+	"The source tree is not clean, please run 'make ARCH=um mrproper'"
+
+	This happens because internally kunit.py specifies ``.kunit``
+	(default option) as the build directory in the command ``make O=output/dir``
+	through the argument ``--build_dir``.  Hence, before starting an
+	out-of-tree build, the source tree must be clean.
+
+	There is also the same caveat mentioned in the "Build directory for
+	the kernel" section of the :doc:`admin-guide </admin-guide/README>`,
+	that is, its use, it must be used for all invocations of ``make``.
+	The good news is that it can indeed be solved by running
+	``make ARCH=um mrproper``, just be aware that this will delete the
+	current configuration and all generated files.
+
 If everything worked correctly, you should see the following:
 
 .. code-block::
-- 
2.37.2

