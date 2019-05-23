Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D728AB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfEWTpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 15:45:53 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58742 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388877AbfEWTPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 15:15:04 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A2A5E3A96BB;
        Thu, 23 May 2019 17:47:55 +0000 (UTC)
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 402AC240003;
        Thu, 23 May 2019 17:47:45 +0000 (UTC)
Date:   Thu, 23 May 2019 19:47:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: about selftests/rtc test related stuff
Message-ID: <20190523174739.GY3274@piout.net>
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/05/2019 22:29:36+0530, Jeffrin Thalakkottoor wrote:
> I get the following result when i run "rtctest"
> please see the following....
> -----------------x------------------------x-----------------
> $pwd
> /home/jeffrin/upstream/linux-kselftest/tools/testing/selftests/rtc
> $./rtctest
> [==========] Running 7 tests from 2 test cases.
> [ RUN      ] rtc.date_read
> rtctest.c:32:rtc.date_read:Expected -1 (18446744073709551615) !=
> self->fd (18446744073709551615)
> rtc.date_read: Test terminated by assertion

Your user probably doesn't have access to the rtc device file.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
