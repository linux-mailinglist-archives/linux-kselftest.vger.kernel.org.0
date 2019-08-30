Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E7A37E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3NiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 09:38:24 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:41455 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfH3NiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 09:38:24 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 42A593C0579;
        Fri, 30 Aug 2019 15:38:22 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xi7ekeR7DieB; Fri, 30 Aug 2019 15:38:16 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 89A243C04C0;
        Fri, 30 Aug 2019 15:38:16 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 30 Aug
 2019 15:38:16 +0200
Date:   Fri, 30 Aug 2019 15:38:13 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     "George G. Davis" <george_davis@mentor.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
Message-ID: <20190830133813.GA23613@vmlxhi-102.adit-jv.com>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi George,

On Fri, Aug 30, 2019 at 08:53:16AM -0400, George G. Davis wrote:
> Some systems have multiple watchdog devices where the first device
> registered is assigned to the /dev/watchdog device file. In order
> to test other watchdog devices, add an optional file argument for
> selecting non-default watchdog devices for testing.
> 
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
> v1:
> - https://lkml.org/lkml/2019/8/29/16
> v2:
> - Update printf for ENOENT case based on report from Eugeniu Rosca

Below interdiff [1] matches my expectations. Thanks!

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] interdiff <(git show patch_v1) <(git show patch_v2)  
diff -u b/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
--- b/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -107,7 +107,7 @@
 
 	if (fd == -1) {
 		if (errno == ENOENT)
-			printf("Watchdog device not enabled.\n");
+			printf("Watchdog device (%s) not found.\n", file);
 		else if (errno == EACCES)
 			printf("Run watchdog as root.\n");
 		else

-- 
Best Regards,
Eugeniu.
