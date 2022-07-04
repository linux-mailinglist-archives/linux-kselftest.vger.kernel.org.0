Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D271A564FC9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiGDIep (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiGDIen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 04:34:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517B5F8A;
        Mon,  4 Jul 2022 01:34:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.53.41.168])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E2CD6601638;
        Mon,  4 Jul 2022 09:34:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656923681;
        bh=SeURJBNtzhwCV0tVGs7sh8U9S4mht0PBp1oWTSOLU/4=;
        h=From:To:Cc:Subject:Date:From;
        b=PQDdatC4C8GBKrjcAPRgfJUvT35DlZ1iPtXE/jyqwz6A5q5YThoqg5Zpf2Ecqbbl4
         UFCe2ZQ3mH3vVJDumktUobxns/HFaDSmLc0FkPamSyygtsns+0NKvO+06yUBR5gCbI
         iUgPSb4tjgE3nqr5SwNkUuLUwgK2lSG2fVToZyfhTNQWTUF7/ZQgAArbgAR5or0LPo
         yneZJrfpQAmJsT5i8SpgXv9ui9/B0np8B/6fMKvdCW2Sfk18exGxOQ0GLmRPHnvP6w
         uzjeHlvBigRzMdp4PE3/3gdaeWryb5pkGjYU3gbeWbWbN01kGJnDmZERDbTvu5uiBa
         NggP244iCYIkw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/kselftest: Fix build commands in guidelines
Date:   Mon,  4 Jul 2022 13:34:25 +0500
Message-Id: <20220704083426.1867401-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build commands start with "make". It is missing. Add "make" to the start
of the build command.

Fixes: 820636106342 ("docs/kselftest: add more guidelines for adding new tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 Documentation/dev-tools/kselftest.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ee6467ca8293..9dd94c334f05 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -255,9 +255,9 @@ Contributing new tests (details)
 
  * All changes should pass::
 
-    kselftest-{all,install,clean,gen_tar}
-    kselftest-{all,install,clean,gen_tar} O=abo_path
-    kselftest-{all,install,clean,gen_tar} O=rel_path
+    make kselftest-{all,install,clean,gen_tar}
+    make kselftest-{all,install,clean,gen_tar} O=abs_path
+    make kselftest-{all,install,clean,gen_tar} O=rel_path
     make -C tools/testing/selftests {all,install,clean,gen_tar}
     make -C tools/testing/selftests {all,install,clean,gen_tar} O=abs_path
     make -C tools/testing/selftests {all,install,clean,gen_tar} O=rel_path
-- 
2.30.2

