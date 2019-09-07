Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABAAC56A
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbfIGI7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Sep 2019 04:59:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46346 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbfIGI7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Sep 2019 04:59:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so8848931wrt.13;
        Sat, 07 Sep 2019 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsIMACDqxff3KGbVW1Gr6ExXEjisbsF9hjOYbr2Kxz4=;
        b=TjsrMFnxmWdH5YiIaWM5qEKaZsYQGusAfyc9ldPE640gb3MpAzZiocLXS9wzHpPvch
         2dLjczIzxmHZhSjvqe5JcTJmyFu7iIUggTAusLm1z4aHJeabURD5dD5w+1b4S4HMAY+u
         GYr03uoRqNShe9awBBgvMCWsuVvH9xJlktHEsx/T5DiabN5hqy/IH6FbWdvdbDBC44rv
         aQbBZEBncjhs7EtDhuTj7khKGSgbIXavHswNAmdm7AGcO1or0FgxwgTgBbI6YYiKS4Qt
         83wIqF+tgvtLi8CqeGFV7/+D/F7VwlO7WQSd+xaFTpCeEGRaAqVsUKB9/dEXr3Wlr4pS
         RUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsIMACDqxff3KGbVW1Gr6ExXEjisbsF9hjOYbr2Kxz4=;
        b=mNo9ripXRb4EED6yIaIdTAizYvon059blk7Qs8pZCj6Xa4lW8zKOHDDrDyw7c4GhIP
         zysQFaCSwaqYOJCOgjRIf333ojHTr6wZ0+akNlfkpuP/2rXC8aaMU515bwVsP91qZSf3
         TwqW3B/EwVy9gMgux5JncFj2dffzkplArJxd5j2FS/1p0tufLc2oo6PCBLCFCXxVHnA6
         O/zTmyFD4ivIKb6qP3uvnhZf/fy+ZQS3XN4v1uUmDGMWmbm/2C56PD/HLzXNhfbafI8P
         UFTAd4ncfW8C8C35AWC93M00sh5W4dABPqxFd8ye8JDXBORffbJPLRXXZ5B6sWSJokvr
         MBbw==
X-Gm-Message-State: APjAAAUHY8TH1+ArCcUSqNpKbvUYwDqD/uGV6pUewfqLhP9i++lwezD+
        cYzx3Po6TpsZQytofMzQcTo=
X-Google-Smtp-Source: APXvYqwvSB8r+8hieyWroNrOXH9BxkzHJD0PYInV24502TrcISVLC4cj1a1Wj5eNvq3mHWp8sx45DA==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr11061805wrr.343.1567846782624;
        Sat, 07 Sep 2019 01:59:42 -0700 (PDT)
Received: from localhost.localdomain (ipb218f54c.dynamic.kabel-deutschland.de. [178.24.245.76])
        by smtp.gmail.com with ESMTPSA id o22sm14080838wra.96.2019.09.07.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 01:59:41 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH 1/2] selftests: watchdog: Validate optional file argument
Date:   Sat,  7 Sep 2019 10:58:32 +0200
Message-Id: <20190907085833.21167-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>

As reported by Eugeniu Rosca, the newly added optional file
argument does not validate if the file is indeed a watchdog, e.g.:

./watchdog-test  -f /dev/zero
Watchdog Ticking Away!

Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
    https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

 tools/testing/selftests/watchdog/watchdog-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index afff120c7be6..6ed822dc2222 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -97,6 +97,7 @@ int main(int argc, char *argv[])
 	int c;
 	int oneshot = 0;
 	char *file = "/dev/watchdog";
+	struct watchdog_info info;
 
 	setbuf(stdout, NULL);
 
@@ -118,6 +119,16 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	/*
+	 * Validate that `file` is a watchdog device
+	 */
+	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
+	if (ret) {
+		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
+		close(fd);
+		exit(ret);
+	}
+
 	optind = 0;
 
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
-- 
2.23.0

