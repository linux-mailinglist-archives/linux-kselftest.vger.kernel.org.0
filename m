Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8FA3BD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH3QUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:20:31 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:25716 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfH3QUb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:20:31 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 12:20:31 EDT
IronPort-SDR: cHjVgI0QyooCwYB5KJ1APtXRNu1Ir5WOXWAt9gcoqUINcoFw3p6FxUuAabd4MS5R7lfm5LiWGU
 braCoCjxiqtx/rh3RVQ9be8HjLZ0C+Laaxbvi+bOsD6RQ1bXUB00nV10XOTI1KQu5IyhmZecO2
 6u6BcIHEDF1eybP078YwgKmLPEEXtq0cSuL9QB+lVd5NjZ0iGuIhUZsV/5jAb0gpuzvuxhbrIS
 kLYM7xAlJyCO0Q1jrMTyBnJIzTnMBEqDfPPLKzZpdlQ30X2e4xbcZamZaQmaSJiWTfy0f7whDi
 4dU=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="40882803"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 30 Aug 2019 08:13:24 -0800
IronPort-SDR: NMaigheT+ZAXgM5xBCfKSjuRw7y04QYA2bkJ3XiuSk55YZxmfEnlSR5oowaVF6c6Kgn+RV3/v9
 naQdJCplLVl78XUf4xyryknIXUVYn2j/mMOhdKZ6gmyb07Xa2CGp3Pj1Z916ieML2P+eVlea6i
 3vsSXqYES94hp7zglJTxtVgR8gDtaughroY+TIvhMLccTEviGqTMyKfJ9uljoCRqs0C0vniuRd
 Hb/kPzf0n/VJnmtW58vQNs6YbbnutCFGfKYxNfqr9itDtzVIIrJIfCx5+/TDx+19CtrBvnukt1
 TYI=
Date:   Fri, 30 Aug 2019 12:13:21 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     shuah <shuah@kernel.org>
CC:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
Message-ID: <20190830161320.GD23419@mam-gdavis-lt>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
 <197ee603-6ea7-a3c8-6b62-e3ba95433053@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <197ee603-6ea7-a3c8-6b62-e3ba95433053@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 09:12:10AM -0600, shuah wrote:
> On 8/30/19 6:53 AM, George G. Davis wrote:
> >diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> >@@ -69,6 +70,7 @@ static void term(int sig)
> >  static void usage(char *progname)
> >  {
> >  	printf("Usage: %s [options]\n", progname);
> >+	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");
> 
> Can you split this line into two printf's. Checkpatch doesn't like
> it.
> 
> printf(" -f, --file          Open watchdog device file\n");
> A second one below for default.

Sure, I'll add the following interdiff in v3:

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 9f17cae61007..6a68b486dd61 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -70,7 +70,8 @@ static void term(int sig)
 static void usage(char *progname)
 {
 	printf("Usage: %s [options]\n", progname);
-	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");
+	printf(" -f, --file          Open watchdog device file\n");
+	printf("                     Default is /dev/watchdog\n");
 	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable       Turn off the watchdog timer\n");
 	printf(" -e, --enable        Turn on the watchdog timer\n");

> On a separate note, I wish this usage block uses \t instead of spacing
> things out.

I noticed that most of those lines are hard spaced with only one using tabs.
To remain consistent with existing CodingStyle, I used hard spaces.

Thanks!

-- 
Regards,
George
