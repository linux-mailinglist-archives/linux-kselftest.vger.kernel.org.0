Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3010CFF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1XdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Nov 2019 18:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfK1XdO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Nov 2019 18:33:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0AF217BA;
        Thu, 28 Nov 2019 23:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574983993;
        bh=DfDA5ASRd0FQviVSfponfqZ0qlyC6z7JYzzWvWBOlvM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MmYWw/dtu77AxYQj3dKdz8BtOF6siEtu4tyWsAtdiLbo0yr35HxKuY0MjrF5BIslh
         u2/kvR4rY9bbtU41mgB8qCcgrvehW1y9vAx8sbQAXliJMQ9dgJ1B9ZxNXzwpjB09rq
         AM3f3b4AuXGGXjMcNHcv3TSKmg57j6h4s2pupsKk=
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when
 KBUILD_OUTPUT is set
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Cristian Marussi <cristian.marussi@arm.com>, Tim.Bird@sony.com,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
 <8736ea2cty.fsf@mpe.ellerman.id.au>
 <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com>
 <8bd66a2d-e92f-6108-77d0-91d737df9b0d@kernel.org>
 <c0d01c8f-1a40-e491-28e8-e93f8f90c874@arm.com>
 <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org>
 <871rts1vjx.fsf@mpe.ellerman.id.au>
From:   shuah <shuah@kernel.org>
Message-ID: <8b453a07-68c1-2f6e-eb58-e25d437d28ff@kernel.org>
Date:   Thu, 28 Nov 2019 16:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <871rts1vjx.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/27/19 9:20 PM, Michael Ellerman wrote:
> shuah <shuah@kernel.org> writes:
>> On 11/27/19 9:23 AM, Cristian Marussi wrote:
>>> On 27/11/2019 16:04, shuah wrote:
>>>>> On 27/11/2019 03:54, Michael Ellerman wrote:
> ...
>>>>>>
>>>>>> It just hit my travis jobs when I merged up to master:
>>>>>>
>>>>>>      https://travis-ci.org/linuxppc/linux/jobs/617482001
>>>>>>
>>>>>> Shuah can we please get this reverted?
>>>>>>
>>>>
>>>> I will take care of this. Supporting all these use-cases has been
>>>> maintenance problem. Fixing one use-case breaks another. :(
> ...
>>
>> If all of the above works with kselftest-install target, I would rather
>> ask for CI's to change, so we can get rid of make -C usage for install.
>>
>> In which case, I would rather not revert this and request CIs to start
>> using kselftest-install target.
>>

Okay reverted now and pushed it to linux-kselftest fixes. Will send it
to Linus in a couple of days.

>> I would like to see CI's use kselftest-* targets from the main makefile
>> for build/run/install.
> 
> The problem is old kernels (stable branches & distro kernels) don't
> support that (or it doesn't work correctly).
> > So then the CIs have to invoke the selftest build differently depending
> on which kernel version they're building, which gets ugly for them.
> 

Let's move there slowly as stables get retired. I would like to see
using kselftest main Makefile files as the supported mode going forward.
This is necessary for us to make it easier to support and maintain the
use-cases.

thanks,
-- Shuah


