Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A04CACCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiCBSCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 13:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiCBSC2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 13:02:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50740D5DF4;
        Wed,  2 Mar 2022 10:01:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 126331F44030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646244104;
        bh=TO/lYfvWn3GKhSIAvogB1BYYjqYiSleaZUgz1mJKfr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7yPZRKb/I87/D6naI6Vr5lJbqeRuW0dd1UrIv4pgIu2TOhRAFrZHRfJbxF+/rjD2
         9LqRT5d+oY6d9pjb+Q7kz0bJAgpZlBC8kAUXTTBUN9ek83n1gQ8ZPb64b45hkbUeGi
         OvV8r9Ce3rW5BmOGgyG+3DAy5oeWBHxu63EXSBZnyfAuS0z1h9olBTKO/Ev4/KIWHc
         Yr2XXXAaGLuHmvi2ZHNt58h6IsSVXZim9WI7rMubTD6ue3qWGOC9Ge6cLVfXTElftj
         WaFw3iHMKodtBkJ9WfUcdeovaGcJDWi2sFvoAEZ7a2N5wBhTxPu28fqSfKSyy6Un+L
         qjS9WZ/3/VNmw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] selftests/exec: add generated files to .gitignore
Date:   Wed,  2 Mar 2022 23:01:19 +0500
Message-Id: <20220302180121.1717581-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302180121.1717581-1-usama.anjum@collabora.com>
References: <20220302180121.1717581-1-usama.anjum@collabora.com>
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

Add generated files non-regular and null-argv to .gitignore file.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 9e2f00343f15..90c238ba6a4b 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -7,6 +7,8 @@ execveat.moved
 execveat.path.ephemeral
 execveat.ephemeral
 execveat.denatured
+non-regular
+null-argv
 /load_address_*
 /recursion-depth
 xxxxxxxx*
-- 
2.30.2

