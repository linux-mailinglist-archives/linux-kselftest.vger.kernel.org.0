Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425DBB3EAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfIPQPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:15:47 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:8309 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389857AbfIPQPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:15:46 -0400
IronPort-SDR: mtj6ziQLOphqyJhpwGyrlc8UiJRYTuKxDJBBZXveCOK/HvnTzYu0nDrjc7L3muakEyacBPV9so
 IgCM7dw7323+MBZ8TptG6LRQaVH1BVQzCHx09PqtDogL8pvpZ0Nll0eKRqtKdBLaHOsqdwWJUT
 HcL52WqmSkvynwTaFdGfPExHXeG4USyikQdWyFp5MZTk23L+tlEDLvM/jyOBYly6B9W5r7cM/c
 8PbhDFb6/WhbY9cEHkQICqpkRXJLp773lCqJqmePlI+BprWCnQotNDcWz6xap1hRuUQ5OviEPR
 PWY=
X-IronPort-AV: E=Sophos;i="5.64,513,1559548800"; 
   d="scan'208";a="41349369"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 16 Sep 2019 08:15:45 -0800
IronPort-SDR: SUef5D1NBICP3TS7MwEABq9LpaU/dxuup5tbmQ8U2VieEcK4vLgt/Kddi6dFWJ5T5GwtisKkOs
 RfTE8TEzfHa/6lZljB/Fi8dZzRufScbJj8bFaesEPLbynO72UH/cdTbSHWYTiV44yQaaciwS9r
 9g6vfyAnMoO9b+RDsN9g0jOamH3EAkEc2IW5Rqczp3BAmgdrqUyuiP1oLJ0CF9LaFOh07sWwcV
 5pltXGchw4T+8zqBGoukFe69UQ+XyXyuE0CnQct88CfOUAKVqsF+vGCGkm+qiMqqcZ/wa40wd+
 Ems=
Date:   Mon, 16 Sep 2019 12:15:41 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
Message-ID: <20190916161541.GB19227@mam-gdavis-lt>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
 <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
 <20190916135756.GA24319@vmlxhi-102.adit-jv.com>
 <24cc0dde-6df3-3ea2-3e1d-0bc166bb48ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24cc0dde-6df3-3ea2-3e1d-0bc166bb48ac@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Shuah,

On Mon, Sep 16, 2019 at 10:05:17AM -0600, shuah wrote:
> On 9/16/19 7:57 AM, Eugeniu Rosca wrote:
> >Hi Shuah,
> >CC George
> >
> >On Mon, Sep 16, 2019 at 07:26:41AM -0600, shuah wrote:
> >[..]
> >>>   		case 'f':
> >>>   			/* Handled above */
> >>>   			break;
> >>>+		case 'i':
> >>>+			/*
> >>>+			 * watchdog_info was obtained as part of file open
> >>>+			 * validation. So we just show it here.
> >>>+			 */
> >>>+			oneshot = 1;
> >>>+			printf("watchdog_info:\n");
> >>>+			printf(" identity:\t\t%s\n", info.identity);
> >>>+			printf(" firmware_version:\t%u\n",
> >>>+			       info.firmware_version);
> >>>+			printf(" options:\t\t%08x\n", info.options);
> >>>+			break;
> >>>   		default:
> >>>   			usage(argv[0]);
> >>>
> >>
> >>I would like to see these combined. Please don't add another argument.
> >>Combine patch and 1&2.
> >
> >With all my appreciation for your comment, why do you think it is better
> >to get rid of the new argument? I don't think it is user-friendly to
> >always report the watchdog_info to the user. Just look at outputs [1-2]
> >and imagine that the watchdog_info part would pop up unconditionally.
> >It looks too busy to me.
> 
> Yes it does look busy. I am okay with adding a second options
> based on what you both said.
> 
> I don't like the commit log.

Agreed, I didn't like it either - it was rather a draft.

> 
> Unfortunately this thread no longer contains the commit log.
> 
> I would like to see the commit log without any references to side
> effects. It make it rather confusing.
> 
> "A side of affect of commit "selftests: watchdog: Add optional file
> argument" is that arbitrary files may be opened for watchdog testing, e.g.
> /dev/null. To prevent watchdog-test from operating on non-watchdog device
> files, commit "selftests: watchdog: Validate optional file argument" was
> added to validate that a file is indeed a watchdog device via an
> ioctl(WDIOC_GETSUPPORT) call. Since the watchdog_info is available as a
> result of the ioctl(WDIOC_GETSUPPORT) call, add a command line option to
> show the watchdog_info."
> 
> I would drop all references to that.

How about the following commit message for the squash commit for [1] and [2]?:

"
selftests: watchdog: Validate optional file argument

As reported by Eugeniu Rosca, a side of affect of commit c3f2490d6e92
("selftests: watchdog: Add optional file argument") is that arbitrary files
may be opened for watchdog testing, e.g.

./watchdog-test  -f /dev/zero
Watchdog Ticking Away!

To prevent watchdog-test from operating on non-watchdog device files,
validate that a file is indeed a watchdog device via an
ioctl(WDIOC_GETSUPPORT) call.

While we're at it, since the watchdog_info is available as a result of the
ioctl(WDIOC_GETSUPPORT) call, add a command line option to optionally show
the watchdog_info.
"

Thanks!


> 
> thanks,
> -- Shuah

-- 
Regards,
George
