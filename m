Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE76A1F8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfH2Ppy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 11:45:54 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:56739 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2Ppy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 11:45:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 11:45:52 EDT
IronPort-SDR: kiHa/Oosnu7Ea9b/XkJZXA6lua53A8G/iXOGUR8RPOeIHoH4f2xzkjkhQBNf2a8UkECndWTrPf
 j/1HklCgSgTnjollSqxpe6ziEwZpnNl5hB6w+/sVU3jkRKSp/ePJoguzPYL8xZLeU3EQa7/94A
 Qq1dRbaKjgQpIRjwIT2/2HWpN+63qvixb0D45fIiuknPqLonhA/7zR0NbUk8OMXJDoKhY/8oyb
 5srO6Q3i4qAD5xOEE7lDLBIwT32Jwqbz3HUYbAtqwoQ7a9YPBfIb88q8+7xaRBN/Ztcji8Eg9A
 Kjs=
X-IronPort-AV: E=Sophos;i="5.64,443,1559548800"; 
   d="scan'208";a="42686256"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 29 Aug 2019 07:38:46 -0800
IronPort-SDR: B8Uc1qwoyjI0XWDom6ANkzkGpdNxBQDqWna/CNLxvDgZZ7LWBK5OX0c0ykNKAb/N0YKQvwRcot
 ZS9yZpP1H9eRekSubrwti2SU3UtRl8u0czbKMLdIAz3+3ZyUQl26aNEq+SRRGsXqL5H3lLTSDM
 1+xBJqaIZ6/qxKjxnKcVNspjwZ3+CUP3GkGGwWkynmJbQwsLuHgI2lbI5MjYoEENwVKTDiixtt
 CYuP/wRW1pOi/ILV7+oly5imw87YbEQBlpRcleubhB9cvnfERH1IOl1V+HqDmrcybZpFvyOCoo
 /xU=
Date:   Thu, 29 Aug 2019 11:38:43 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] selftests: watchdog: Add optional file argument
Message-ID: <20190829153842.GC4028@mam-gdavis-lt>
References: <1567053566-18971-1-git-send-email-george_davis@mentor.com>
 <20190829143814.GA3424@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829143814.GA3424@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Eugeniu,

On Thu, Aug 29, 2019 at 04:38:14PM +0200, Eugeniu Rosca wrote:
> Hi George,
> 
> On Thu, Aug 29, 2019 at 12:39:25AM -0400, George G. Davis wrote:
> > Some systems have multiple watchdog devices where the first device
> > registered is assigned to the /dev/watchdog device file.
> 
> Confirmed on R-Car H3-Salvator-X:
> 
> root@rcar-gen3:~# ls -al /dev/watchdog*
> crw-------    1 root     root       10, 130 Aug 21 09:38 /dev/watchdog
> crw-------    1 root     root      247,   0 Aug 21 09:38 /dev/watchdog0

What you see there is the typical case where there is only one watchdog in
the system, /dev/watchdog0, which is registered as the default watchdog
via /dev/watchdog. If you have another watchdog enabled, e.g. softdog, you
will see:

root@h3ulcb:~# ls -l /dev/watchdog*
crw-------    1 root     root       10, 130 Mar 28 20:37 /dev/watchdog
crw-------    1 root     root      247,   0 Mar 28 20:37 /dev/watchdog0
crw-------    1 root     root      247,   1 Mar 28 20:37 /dev/watchdog1

In the above case, `watchdog0` is aliased to `watchdog` but you may prefer
to test the non-default `watchdog1` instead (rather than changing your
kernel config if one or more are built-in, preventing testing of the
non-default watchdog).

> [..]
> 
> > -	fd = open("/dev/watchdog", O_WRONLY);
> > +	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
> > +		if (c == 'f')
> > +			file = optarg;
> > +	}
> > +
> > +	fd = open(file, O_WRONLY);
> 
> Would it be possible to improve below not so helpful and slightly
> misleading printout:
> 
> $ ./watchdog-test -d -t 10 -p 5 -e -f /dev/watch
> Watchdog device not enabled.

Oops, right, thanks for that report.

I'll add the following in the next update:

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index ebeb684552b9..9f17cae61007 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 
 	if (fd == -1) {
 		if (errno == ENOENT)
-			printf("Watchdog device not enabled.\n");
+			printf("Watchdog device (%s) not found.\n", file);
 		else if (errno == EACCES)
 			printf("Run watchdog as root.\n");
 		else


Thanks!

-- 
Regards,
George
