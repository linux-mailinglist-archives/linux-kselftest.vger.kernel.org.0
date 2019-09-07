Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB0AC56C
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394572AbfIGI7y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Sep 2019 04:59:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbfIGI7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Sep 2019 04:59:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id 30so8812963wrk.11;
        Sat, 07 Sep 2019 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnxWO73QUUHi2cXeJhawoF5m1VJA2QTLwFF/szRZaoM=;
        b=OkFbFciKRCN/o51L7Ja+aVWvv5cVplr5L+O1Gc7XKpINzLW4s88UIBL9Rv9Lj8d4cs
         DnyYR6wR2tafOe/sjYd+slKkxcD+u1s8VwmV0feDCQ2Ll3q7Vx4U2IjUuvykRTz/EiyT
         XkAANFLBDomxrpMPmdi0fYH/5LUNe51acTaTXuDZZUe9Fxgbc74lPc30CQqz2wPijbXI
         yWZmKocUpoSXvpzxv2fhPyiVbD7pSP2EqmIFVOEEN9CzPBCIiZKo/VrED/Co8KGdKH6f
         bF1JC8kaW+JH+CvSkgU/XkuI9I2OSb9cEP4oYj97XbDE6e1+w4t/Ccr6ZxL9aDHcb+To
         1aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnxWO73QUUHi2cXeJhawoF5m1VJA2QTLwFF/szRZaoM=;
        b=fjD1nICOtzkGCOtK/FH67mp1I5ZLrV0Qdke0wyFIlleFfpXX/QMfP09QYVqrbbXA55
         /qLiwThdU1SgAOg1PlR4UvuEiDWmVbqfvwU0JWhLrNyh1AnMMUke6DTk2lDRQdFtwt59
         ck+ADMiAD/xQNDOPPXecknLpR2Om6dGJ2+rPymqrW2EyXvmnWrZXU/R+Ba404KClFRZm
         V4PAPqXagZKmi1UA5CIP0YcDMwkKSR9/QiYqAtiQE++RheMjSyfzDnfy67r3YoQcDByc
         VMz6yCjrXPtC2+TrFnA/lOVfTwjkOb5CA3J39zYNjvoyDMu8Pm6bl4CL/Wmzt7n9Nnb1
         mLqA==
X-Gm-Message-State: APjAAAXwU/A5IVQLcTH8ep4FiUcuhzXsiW4MS0VCi1tnACeQeSCgrbgU
        OWEGyqBYldteAPrNSFy/CrA=
X-Google-Smtp-Source: APXvYqzD3ub+prw5PrfqRmLe7Pfax+rBD62eVo3vcu7HUWAQNq01XEEVrUBEqZ5okdtqSUrlDgEYvg==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr11362546wrc.331.1567846791511;
        Sat, 07 Sep 2019 01:59:51 -0700 (PDT)
Received: from localhost.localdomain (ipb218f54c.dynamic.kabel-deutschland.de. [178.24.245.76])
        by smtp.gmail.com with ESMTPSA id o22sm14080838wra.96.2019.09.07.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 01:59:51 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH 2/2] selftests: watchdog: Add command line option to show watchdog_info
Date:   Sat,  7 Sep 2019 10:58:33 +0200
Message-Id: <20190907085833.21167-2-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190907085833.21167-1-erosca@de.adit-jv.com>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>

A side of affect of commit "selftests: watchdog: Add optional file
argument" is that arbitrary files may be opened for watchdog testing, e.g.
/dev/null. To prevent watchdog-test from operating on non-watchdog device
files, commit "selftests: watchdog: Validate optional file argument" was
added to validate that a file is indeed a watchdog device via an
ioctl(WDIOC_GETSUPPORT) call. Since the watchdog_info is available as a
result of the ioctl(WDIOC_GETSUPPORT) call, add a command line option to
show the watchdog_info.

Suggested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of 
    https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

 tools/testing/selftests/watchdog/watchdog-test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 6ed822dc2222..f45e510500c0 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NLf:";
+static const char sopts[] = "bdehp:t:Tn:NLf:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -32,6 +32,7 @@ static const struct option lopts[] = {
 	{"getpretimeout",       no_argument, NULL, 'N'},
 	{"gettimeleft",		no_argument, NULL, 'L'},
 	{"file",          required_argument, NULL, 'f'},
+	{"info",		no_argument, NULL, 'i'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -72,6 +73,7 @@ static void usage(char *progname)
 	printf("Usage: %s [options]\n", progname);
 	printf(" -f, --file\t\tOpen watchdog device file\n");
 	printf("\t\t\tDefault is /dev/watchdog\n");
+	printf(" -i, --info\t\tShow watchdog_info\n");
 	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
 	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
@@ -216,6 +218,18 @@ int main(int argc, char *argv[])
 		case 'f':
 			/* Handled above */
 			break;
+		case 'i':
+			/*
+			 * watchdog_info was obtained as part of file open
+			 * validation. So we just show it here.
+			 */
+			oneshot = 1;
+			printf("watchdog_info:\n");
+			printf(" identity:\t\t%s\n", info.identity);
+			printf(" firmware_version:\t%u\n",
+			       info.firmware_version);
+			printf(" options:\t\t%08x\n", info.options);
+			break;
 
 		default:
 			usage(argv[0]);
-- 
2.23.0

