Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974E8B3BF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbfIPN6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 09:58:09 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37294 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPN6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 09:58:09 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0BFA83C0579;
        Mon, 16 Sep 2019 15:58:06 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IWPcCamjG3-f; Mon, 16 Sep 2019 15:57:59 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 6B0E33C00C4;
        Mon, 16 Sep 2019 15:57:59 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 16 Sep
 2019 15:57:58 +0200
Date:   Mon, 16 Sep 2019 15:57:56 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
Message-ID: <20190916135756.GA24319@vmlxhi-102.adit-jv.com>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
 <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,
CC George

On Mon, Sep 16, 2019 at 07:26:41AM -0600, shuah wrote:
[..]
> >   		case 'f':
> >   			/* Handled above */
> >   			break;
> > +		case 'i':
> > +			/*
> > +			 * watchdog_info was obtained as part of file open
> > +			 * validation. So we just show it here.
> > +			 */
> > +			oneshot = 1;
> > +			printf("watchdog_info:\n");
> > +			printf(" identity:\t\t%s\n", info.identity);
> > +			printf(" firmware_version:\t%u\n",
> > +			       info.firmware_version);
> > +			printf(" options:\t\t%08x\n", info.options);
> > +			break;
> >   		default:
> >   			usage(argv[0]);
> > 
> 
> I would like to see these combined. Please don't add another argument.
> Combine patch and 1&2.

With all my appreciation for your comment, why do you think it is better
to get rid of the new argument? I don't think it is user-friendly to
always report the watchdog_info to the user. Just look at outputs [1-2]
and imagine that the watchdog_info part would pop up unconditionally.
It looks too busy to me.

[1] watchdog-test -b -i
Last boot is caused by: Power-On-Reset.
watchdog_info:
 identity:              Renesas WDT Watchdog
 firmware_version:      0
 options:               000081a0

[2] watchdog-test -i --help    
watchdog_info:
 identity:              Renesas WDT Watchdog
 firmware_version:      0
 options:               000081a0
Usage: ./watchdog-test [options]
 -f, --file             Open watchdog device file
                        Default is /dev/watchdog
 -i, --info             Show watchdog_info
 -b, --bootstatus       Get last boot status (Watchdog/POR)
 -d, --disable          Turn off the watchdog timer
 -e, --enable           Turn on the watchdog timer
 -h, --help             Print the help message
 -p, --pingrate=P       Set ping rate to P seconds (default 1)
 -t, --timeout=T        Set timeout to T seconds
 -T, --gettimeout       Get the timeout
 -n, --pretimeout=T     Set the pretimeout to T seconds
 -N, --getpretimeout    Get the pretimeout
 -L, --gettimeleft      Get the time left until timer expires

Parameters are parsed left-to-right in real-time.
Example: ./watchdog-test -d -t 10 -p 5 -e
Example: ./watchdog-test -t 12 -T -n 7 -N

-- 
Best Regards,
Eugeniu.
