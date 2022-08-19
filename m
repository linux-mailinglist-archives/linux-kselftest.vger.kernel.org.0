Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0D5994BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiHSFdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbiHSFc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:32:58 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D3E0FD2;
        Thu, 18 Aug 2022 22:32:57 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id t64so1771373vkb.12;
        Thu, 18 Aug 2022 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HYJuoBtqbtYCDoZ9mu7excmJEKH0WKQTkj4W1pw3rZQ=;
        b=TMvm8qnWVRNZf3RB/f+J1eNUyxjRaN/nc5YeTG+YiPGZskknKk1YyKn97ySC5H4+8q
         j4GwQx1TZ2C0mFAoRSsWo+Y9f/HNxw8SthWPXTd1w8NmPGEM4JeCvEXj6XL1q0HKkcTM
         8diW8q+8U6ArpmGu3hKm60qMZPol0bZxcGwAY29SAg4mJM3HiQlsoUDBP1wxV0CgFMQo
         gppZRjZDkW4FSchX7DHqJ3YCoxZcu87Beyy844+i6TEFkiaCk2RnA8GYh6NP02GbQnAe
         H46VpqHpfP1lLpC5Yh6Lc2TEshq2SuhWJVEyLJs75VFjEIlXLE5w92+ELdgDR8M5P2J2
         Bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HYJuoBtqbtYCDoZ9mu7excmJEKH0WKQTkj4W1pw3rZQ=;
        b=OTyJM9EXNbrCd9NzBjssOb+LsQMX96VrVgbmdEUfZ+zASzuTDWrbZFb5GLe0+dQQBE
         IWKOO0OkaVuU2t68j8bMh5xn80yOSe/mDBG0NtcAnK90XZO34RIUn80CVlSeb0woeMZH
         t0IHIGS4HAQ+v00fFO+Z/gEmCbVSYQ/oJEEAzxrR++6N7GSXTqTPcXcZCOCbD+Wob8Gg
         5iF0f8jrgMRDByLdN+3JkUk2Kq7rr2//r21VzjmliPlcydblT8mQBofVWMzrkqki2GUy
         YKEMmpgSXTfG1EQfmFdoAHxvZcQuXze8B/zpLksQaHKpxsYgwV9bHUIMBdAkv2hFSlq5
         QDyQ==
X-Gm-Message-State: ACgBeo2OmO7N2ug51GeEiVCOeEpMUjwTWK+UUls9TdATLoU3ikPh3dFo
        JZJ9Q/xbZgAXXmum1kQ2DlU=
X-Google-Smtp-Source: AA6agR5YfXjFl6TVihi8hb1HfvVsmJcFHKMlQW/8+DoxT7LQhE78EAfxq39oJIjPuzHgNOQgplURSg==
X-Received: by 2002:ac5:c18d:0:b0:385:9b32:9356 with SMTP id z13-20020ac5c18d000000b003859b329356mr1785299vkb.27.1660887176880;
        Thu, 18 Aug 2022 22:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:32:56 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 3/8] Documentation: KUnit: restore note about mrproper in start.rst
Date:   Fri, 19 Aug 2022 02:32:29 -0300
Message-Id: <20220819053234.241501-4-tales.aparecida@gmail.com>
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

The "Getting Started" guide should be beginner-friendly, therefore
add a note about the requirement of a clean source tree when running
kunit_tool for the first time, and its related error.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 165d7964aa13..e4b73adde6d0 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -19,6 +19,22 @@ can run kunit_tool:
 
 	./tools/testing/kunit/kunit.py run
 
+.. note ::
+	You might see the error:
+	"The source tree is not clean, please run 'make ARCH=um mrproper'"
+
+	That happens because internally kunit.py specifies the build directory in
+	the command ``make O=output/dir`` through the argument ``--build_dir``,
+	which is ``.kunit`` by default, and before starting out-of-tree build,
+	the source tree must be clean.
+
+	There's also the same caveats mentioned in the "Build directory for the kernel"
+	section of the :doc:`admin-guide </admin-guide/README>`, that is,
+	after it's used it must be used for all invocations of ``make``.
+	The good news is that it can indeed be solved by running
+	``make ARCH=um mrproper``, just be aware that this will delete the
+	current configuration and all generated files.
+
 If everything worked correctly, you should see the following:
 
 .. code-block::
-- 
2.37.1

