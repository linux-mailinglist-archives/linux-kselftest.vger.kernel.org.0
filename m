Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD14B3BEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfIPNz6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 09:55:58 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:3796 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbfIPNz6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 09:55:58 -0400
IronPort-SDR: 4I8apyNuXh3AqGh354En5LTjGW9EL/qvnrCao5fLDAmQO54hrnJGAdPSqNWkpBvW/EVK6f/8WE
 6c8xCHsF9Koh2Alc3Yp7xOTSq2+1oxJa5DWgJkTbHqTqgt4/v6x8eHgp47GK2qPDCrpQ3dLu5i
 d6zdKewJkrj7zvhOn4z8z9OoDP2eH/FFP/cGeXsIg+A3E3xefE+fB/ke+Uqe+yfcYLrnrvjgCS
 CkrXquqgOQThZQAdE7nvJnpLZyARkYQFq3R5tkWRyk5kplwfKC6cqcOwbYUFzMF9KAN8BwV2c1
 uJE=
X-IronPort-AV: E=Sophos;i="5.64,512,1559548800"; 
   d="scan'208";a="41379300"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 16 Sep 2019 05:55:57 -0800
IronPort-SDR: wlO2LzgkeJ8oH18yZpIOlZaWjERCDQACrOKK5QemycTs5lkqAzE8kVqHYFJNTrCJU1oXRt14ld
 4s06f73GPZLzoIWmn1dik2bnAgUcUvZjXQsDRDw3oeDcr52fMBK4F+eZAhZBOsISK8a3I2PW+Z
 6XuiZN5/yVGtdyNOx18sC2bcZmEGYEOrF369Zn6b7DSRJ3EL7Ob4t+1cY4EZcRPcwBhmzSPvaK
 maubildXZd5e2muyO6w5y4SoRfMPcynPJk2mSssn1vH8JCKq+pUzWAhIGSuqtfMx/PO97+Fifl
 h3U=
Date:   Mon, 16 Sep 2019 09:55:54 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
Message-ID: <20190916135553.GA19227@mam-gdavis-lt>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
 <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Mon, Sep 16, 2019 at 07:26:41AM -0600, shuah wrote:
> On 9/7/19 2:58 AM, Eugeniu Rosca wrote:
> >diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> >index 6ed822dc2222..f45e510500c0 100644
> >--- a/tools/testing/selftests/watchdog/watchdog-test.c
> >+++ b/tools/testing/selftests/watchdog/watchdog-test.c
> >@@ -19,7 +19,7 @@
> >  int fd;
> >  const char v = 'V';
> >-static const char sopts[] = "bdehp:t:Tn:NLf:";
> >+static const char sopts[] = "bdehp:t:Tn:NLf:i";
> >  static const struct option lopts[] = {
> >  	{"bootstatus",          no_argument, NULL, 'b'},
> >  	{"disable",             no_argument, NULL, 'd'},
> >@@ -32,6 +32,7 @@ static const struct option lopts[] = {
> >  	{"getpretimeout",       no_argument, NULL, 'N'},
> >  	{"gettimeleft",		no_argument, NULL, 'L'},
> >  	{"file",          required_argument, NULL, 'f'},
> >+	{"info",		no_argument, NULL, 'i'},
> >  	{NULL,                  no_argument, NULL, 0x0}
> >  };
> >@@ -72,6 +73,7 @@ static void usage(char *progname)
> >  	printf("Usage: %s [options]\n", progname);
> >  	printf(" -f, --file\t\tOpen watchdog device file\n");
> >  	printf("\t\t\tDefault is /dev/watchdog\n");
> >+	printf(" -i, --info\t\tShow watchdog_info\n");
> >  	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
> >  	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
> >  	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
> >@@ -216,6 +218,18 @@ int main(int argc, char *argv[])
> >  		case 'f':
> >  			/* Handled above */
> >  			break;
> >+		case 'i':
> >+			/*
> >+			 * watchdog_info was obtained as part of file open
> >+			 * validation. So we just show it here.
> >+			 */
> >+			oneshot = 1;
> >+			printf("watchdog_info:\n");
> >+			printf(" identity:\t\t%s\n", info.identity);
> >+			printf(" firmware_version:\t%u\n",
> >+			       info.firmware_version);
> >+			printf(" options:\t\t%08x\n", info.options);
> >+			break;
> >  		default:
> >  			usage(argv[0]);
> >
> 
> I would like to see these combined.

Ok.

> Please don't add another argument.

I'm not clear on your request here. Do you want to drop the addition
of optional --info|-i command line option and always display the
watchdog_info?

If yes, perhaps Eugeniu may mention what he has already mentioned to me earlier
that "it's very useful to see the watchdog identity" but "some users might
perceive the console output a bit busy if the Watchdog identity: <WDT name>
message is always on" so perhaps it is "more user-friendly to still call the
WDIOC_GETSUPPORT ioctl to sanitize the device file, but to only print the
Watchdog identity: message when the user passes e.g. a new -i, --identity
parameter".


> Combine patch and 1&2.

I'll do that but I'm not entirely clear on your "Please don't add another
argument" request.

> 
> thanks,
> -- Shuah

-- 
Regards,
George
