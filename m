Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95D6A98D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 05:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfIEDS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 23:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEDS5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 23:18:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963AB20820;
        Thu,  5 Sep 2019 03:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567653536;
        bh=x103vjFro/56JQBTS72JFh+qVGn9mYNwiXusgES3/Ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=z7g+XVXGFVzVKOdOTR/4t3cLYVy3/uhimcM2gDMPpPkbT1yuGiocHpduud69XGEKV
         +jESzwIOgPB3TabMfxsqOTsT6/Glrxhz4beVZ/EhuI6qiI7VFLvvJX9EKombqy40sJ
         CBoZe7G0Esi5AGDGrTJVUbKbrlUAldry2UkBvnh4=
Subject: Re: next-20190903 kselftest results
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <943338456.3594.1567519226589.JavaMail.javamailuser@localhost>
 <34634351-ecff-4520-cbc0-8ab6a4412150@kernel.org>
 <CAEUSe78FOo26W+96v4o5mv3Dr5HvWdgssEXDaq4b_kJZhCY+TQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0bba3933-0aeb-4845-3d45-b3856f2245dd@kernel.org>
Date:   Wed, 4 Sep 2019 21:18:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEUSe78FOo26W+96v4o5mv3Dr5HvWdgssEXDaq4b_kJZhCY+TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/4/19 7:10 PM, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 4 Sep 2019 at 17:44, shuah <shuah@kernel.org> wrote:
>> On 9/3/19 8:00 AM, ci_notify@linaro.org wrote:
>>> Summary
>>> ------------------------------------------------------------------------
>>> kernel: 5.3.0-rc7
>>> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>> git branch: master
>>> git commit: 7dc4585e03786f84d6e9dc16caa3ba5b8b44d986
>>> git describe: next-20190903
>>> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190903 >>>
>>> Regressions (compared to build next-20190902)
>>
>> Looks like you are running kselftest from 5.2 on this linux-next.
>> You won't be able to find any kselftest test regressions this way.
>> You aren't testing the kselftest patches that are in linux-next
>> for Linux 5.4-rc1.
> 
> The way OE refers to versions can be confusing (it was for me, at
> least). The version is said to be "5.2+gitAUTOINC+7dc4585e03", which
> means that it's 5.2 (last known version) + some Git commits. In this
> case, 7dc4585e03 points to next-20190903.
> 
> 
>> It would be helpful if you match the kernel and kselftest for linux-next
>> and Linux mainline.
> 
> Indeed, we do that exactly:
> * linux-next is tested with the in-kernel version of kselftests
> * linux-mainline is tested with the in-kernel version of kselftests
> * linux-stable 5.2 is tested with the latest released kselftests
> (*should* be 5.2.11)
> * linux-stable 4.19 is tested with the latest released kselftests
> (*should* be 5.2.11)
> * and so on for 4.14, 4.9 and 4.4
> 

Yeah then why does the site show the following?


 >>> Test details: 
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190903
kselftest__version 5.2+gitAUTOINC+7dc4585e03
libhugetlbfs__version 2.21
make_kernelversion 5.3.0-rc7

This is why I asked the above question about revisions.

thanks,
-- Shuah
