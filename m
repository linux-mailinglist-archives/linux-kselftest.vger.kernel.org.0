Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1B3FF4DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 22:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbhIBUZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 16:25:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58644 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbhIBUZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 16:25:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id AC7421F44AE4
Subject: Re: KernelCI Hackfest #2 - Sept 6-10 2021
To:     Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        kernelci@groups.io
Cc:     kernelci-members <kernelci-members@groups.io>,
        automated-testing@lists.yoctoproject.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Summer Wang <wangsummer@google.com>,
        linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
        kunit-dev@googlegroups.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
 <CANgtXuPjD0rW-A=gMNUd7mdF1Bynz+QQmDHLy7vh9UODd8NtbA@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <01d483d0-6cee-f0dc-b65d-bd776c7d206f@collabora.com>
Date:   Thu, 2 Sep 2021 21:24:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CANgtXuPjD0rW-A=gMNUd7mdF1Bynz+QQmDHLy7vh9UODd8NtbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/08/2021 17:46, Alice Ferrazzi wrote:
> Hello,
> 
> On Mon, Aug 2, 2021 at 6:00 PM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> The first KernelCI hackfest[1] early June was successful in getting
>> a number of kernel developers to work alongside the core KernelCI
>> team.  Test coverage was increased in particular with kselftest,
>> LTP, KUnit and a new test suite for libcamera.  We're now improving
>> documentation and tooling to make it easier for anyone to get
>> started.  Find out more about KernelCI on https://kernelci.org.
>>
>> The second hackfest is scheduled for the 6th-10th September.  It
>> should be a good opportunity to start discussing and working on
>> upstream kernel testing topics ahead of the Linux Plumbers
>> Conference[2].
>>
>> Here's the project board where anyone can already add some ideas:
>>
>>   https://github.com/orgs/kernelci/projects/5
> 
> I cannot add topics to the project board.

Please see the email I just sent in reply to my original one,
with extra information about how to add issues.  You've been
invited to the "hackers" team so you should be able to edit the
workboard once you've accepted it.

Thanks,
Guillaume
