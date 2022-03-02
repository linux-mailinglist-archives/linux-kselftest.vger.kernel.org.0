Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0044CACCB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiCBSC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiCBSC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 13:02:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B8D5DEB;
        Wed,  2 Mar 2022 10:01:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 12F1C1F43FAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646244101;
        bh=tB4dwZK0Et/2OMzDW/FvWoGbb4aD30Ljk6K8uOCkSoA=;
        h=From:To:Cc:Subject:Date:From;
        b=gyJyTqZgH0ONxkzxgJB/NKs1qGqLolWEAwH/Elnbu6w7HSfK7BZwDLQkMO4yyJBGw
         Wpqpfvr3MYokc9B/m6stGw4X4OtBE+QLxfr5pVJmddH0rFs4YTK+d0cJ097A1FF2mY
         zG3bDB6fSmWZ5VQHi6KRK7Dgtq5wbqwE4D+ayvedRtnws3XndluCtQxfCLCodd2JpW
         KYQPHVQ7F4+GgT+7Qw4v7QT2qkGKkstveq5U2e9H+j/H0N9mJZQF3WwClRkQ3hmtaJ
         6BPhJgsDXOePgY3KWeLMaSf5HZKr2uGQ3Z2AJ2K2LWNXVfFrAFUQLdwH5dvIdNhmAg
         VAbHoeJ+CSZRQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] selftests: add kselftest_install to .gitignore
Date:   Wed,  2 Mar 2022 23:01:18 +0500
Message-Id: <20220302180121.1717581-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kselftest_install directory to the .gitignore which is created while
creation of tar ball of objects:
make -C tools/testing/selftests gen_tar

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V2:
Break up the patch in individual test patches
Remove changes related to net selftest
---
 tools/testing/selftests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 055a5019b13c..cb24124ac5b9 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -3,6 +3,7 @@ gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
+kselftest_install/
 tpm2/SpaceTest.log
 
 # Python bytecode and cache
-- 
2.30.2

