Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5812F4387B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfFMPGK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732422AbfFMOKW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 10:10:22 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6256A2082C;
        Thu, 13 Jun 2019 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560435020;
        bh=7OQwG+702F83sAlyNtbM+xJYZmjcRDOB9gr9GLwbm/c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fy827eMPNUMVo1nmLnXJA6nqyasdum9lUWVDJRjDXrYqe7HHkDyvSp0qpAXeq9iGs
         qwXrr3QI4wouB6/NX8mAR6f8dLdDEwwYJ2Kww5cZLXNaW5kf3RcknFoqNYwELrplon
         ch0MUmzKkKOmEuUmSWfqdEl0z2XnxEGEz56vDWTM=
Subject: Re: kselftest build broken?
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
 <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
 <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
 <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org>
 <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
 <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org>
 <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f0f9f016-6c1f-447b-1713-7e582aedf74c@kernel.org>
Date:   Thu, 13 Jun 2019 08:10:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/19 3:12 PM, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 12 Jun 2019 at 14:32, shuah <shuah@kernel.org> wrote:
>> On 6/12/19 12:29 PM, Dmitry Vyukov wrote:
> [...]
>>> 1. You suggested to install a bunch of packages. That helped to some
>>> degree. Is there a way to figure out what packages one needs to
>>> install to build the tests other than asking you?
>>
>> I have to go through discovery at times when new tests get added. I
>> consider this a part of being a open source developer figuring out
>> dependencies for compiling and running. I don't have a magic answer
>> for you and there is no way to make sure all dependencies will be
>> documented.
> 
> This is something we, as users of Kselftests, would very much like to
> see improved. We also go by trial-and-error finding out what is
> missing, but keeping up with the new tests or subsystems is often
> difficult and tend to remain broken (in usage) for some time, until we
> have the resources to look into that and fix it. The config fragments
> is an excellent example of how the test developers and the framework
> complement each other to make things work. Even documenting
> dependencies would go a long way, as a starting point, but I do
> believe that the test writers should do that and not the users go
> figure out what all is needed to run their tests.
> 
> Maybe a precheck() on the tests in order to ensure that the needed
> binaries are around?
> 

Right. Take a look at x86 test Makefile - it handles that. Tests can
handle these in their Makefile - not at run-time.

I will be happy to take patches similar to the checks x86 does. These
shouldn't fail the kselftest build and print out dependencies.

This way users can go install them.

> For what it's worth, this is the list of run-time dependencies package
> for OpenEmbedded: bash bc ethtool fuse-utils iproute2 iproute2-tc
> iputils-ping iputils-ping6 ncurses perl sudo python3-argparse
> python3-datetime python3-json python3-pprint python3-subprocess
> util-linux-uuidgen cpupower glibc-utils. We are probably missing a
> few.
> 

Sure see above.

thanks,
-- Shuah
