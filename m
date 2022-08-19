Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1B5992F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiHSCI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 22:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHSCI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 22:08:26 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983A52DDF;
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id p6so2857841vsr.9;
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LUWdT3rWXowd2tAqN9voXlgd0i9mK0bhvny4YxtRrog=;
        b=oeaINDlitH/VkyumqwSp0jpH1rbCvnqfOcL4nC538YFfFPIoOMo24PuceZEZ/19wql
         fT3fW7SRGbAKERBpZrmD7E92+3K4U+WU/cXduaTYJP6QJsN0LjsfCLXy7rshAqcNzxrA
         yAAlXc0CqHK85wjk3JmWBopzWgpkVfczFa8vIVm/JFRo56el7Np+/Ybftl512MORyDjl
         MEmKjlieSKGSvs6Jbr9lPw6ngm3PUPEVSC9sIsi2wIDcHsQSjF+i0RwQ3LYDMFOd+L0H
         aLPUzsJIpLY6AXcIo0QooTL3KoEJ30yEeaTW+cwUUKicp+Itfu1X+klP0pDMFmECUMXD
         Z2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LUWdT3rWXowd2tAqN9voXlgd0i9mK0bhvny4YxtRrog=;
        b=5oYz3XKvtG/Tbk90OnpKKfX6oWMbyAc3BSZXDfL57Ccm1ISTU5KV5I07MC6+VHT57Q
         sNo4FJYtcpB789DRBUw8n9snYf2wA2e6FFYD38Kuc80dx2oXTIqyF4gwPhD9gtKZlDQ4
         oz+FYs7TzTWXwZSxBOsh/YmBNIV9J3bWL6vP3uhc4kSbc2IpY+4LZao1T8pYip6TowD8
         KkHTp2qGB2K4i+LwK3pe5vXPdJxFEZk4GcCHkn7pbfGAqGqO7M8iIfE5MpKnFzAJ/0pb
         3kCwtK0GEWwYl5AOoCJmHEsDd70jTSOiqNMBAhBockldAQQDCC1cp7cnFFGeXI7J2TJY
         6lAA==
X-Gm-Message-State: ACgBeo27XrIACUzZGjyLK0PCuaBLOMqwz6g0fgo+ZJEbD+cZ9A8Pma6f
        z/0ehRLADpYQRCwfzV/f1/o=
X-Google-Smtp-Source: AA6agR5zbwlQKGOLOiTmbWRKZy2b23MVDpGAiUHOx4R3SCdJReWWUh7pIGvBZ+bGLMPWn8UOfX4pgQ==
X-Received: by 2002:a67:ba03:0:b0:385:b608:300d with SMTP id l3-20020a67ba03000000b00385b608300dmr2173862vsn.33.1660874903321;
        Thu, 18 Aug 2022 19:08:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id ba6-20020a056102282600b0038855ac0416sm1706595vsb.7.2022.08.18.19.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:08:22 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com
Cc:     siqueirajordao@riseup.net, mwen@igalia.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: tool: fix --qemu_config help text
Date:   Thu, 18 Aug 2022 23:08:15 -0300
Message-Id: <20220819020815.183766-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Remove duplicated wording from the help text for the kunit_tool
argument "qemu_config":
"Takes a path to a path to a file containing a QemuArchParams object."
         ~~~~~~~~~

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 tools/testing/kunit/kunit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e132b0654029..ae193c9820c5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -322,7 +322,7 @@ def add_common_opts(parser) -> None:
 			    metavar='PREFIX')
 
 	parser.add_argument('--qemu_config',
-			    help=('Takes a path to a path to a file containing '
+			    help=('Takes a path to a file containing '
 				  'a QemuArchParams object.'),
 			    type=str, metavar='FILE')
 
-- 
2.37.1

