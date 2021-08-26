Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403043F8711
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbhHZMPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 08:15:34 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54288
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242446AbhHZMPe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 08:15:34 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 21CF93F365;
        Thu, 26 Aug 2021 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629980086;
        bh=/dJmievy+1/SfYgUqjAoPZYohmD9QSxsCNc6tg+k6gw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=F5KJEkOYs1j0nVBSQVF9qNBSrqNZdNDwVf7Efjf7SDZNntz+QpS+S8DjF8pFDgQ3T
         sfpwbawKS6tkrkd0o1BzHtXcLvXYKUZgpzPln12bLlu98gwgSCj5ilia/W5R8D2nCB
         LT/tb/sxF4Ob4kl2gHVHO+0azRuJdIgG4HoF/sZLTGug2WUVYFl59za1Kz3oXqtw6Q
         HhVOqDMnRtmmNu7z5U7ijnMj/pAj7QtL/TEH0oelSNdjPr9Kflhr/kqBQxSjCtxROm
         ruTu0izi/7TkJSqxF44vGKPZ9XttBipkMqLxWGF9XihNshHtg8fOO9a5oNDhmoafGT
         HZzOWnMP93k4Q==
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: safesetid: Fix spelling mistake "cant" -> "can't"
Date:   Thu, 26 Aug 2021 13:14:45 +0100
Message-Id: <20210826121445.13062-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/safesetid/safesetid-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 0c4d50644c13..4b809c93ba36 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -152,7 +152,7 @@ static void write_policies(void)
 
 	fd = open(add_whitelist_policy_file, O_WRONLY);
 	if (fd < 0)
-		die("cant open add_whitelist_policy file\n");
+		die("can't open add_whitelist_policy file\n");
 	written = write(fd, policy_str, strlen(policy_str));
 	if (written != strlen(policy_str)) {
 		if (written >= 0) {
-- 
2.32.0

