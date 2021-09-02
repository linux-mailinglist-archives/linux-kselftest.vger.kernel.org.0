Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E23FF4D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhIBUYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 16:24:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58630 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346339AbhIBUYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 16:24:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id F27671F44AE4
Subject: Re: KernelCI Hackfest #2 - Sept 6-10 2021
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     "kernelci@groups.io" <kernelci@groups.io>
Cc:     kernelci-members <kernelci-members@groups.io>,
        automated-testing@lists.yoctoproject.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Summer Wang <wangsummer@google.com>,
        linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
        kunit-dev@googlegroups.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
Reply-To: kernelci@groups.io, guillaume.tucker@collabora.com
References: <169771B791E5E075.25031@groups.io>
Message-ID: <259a2ea9-63da-b5df-3496-676c2b76700b@collabora.com>
Date:   Thu, 2 Sep 2021 21:22:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <169771B791E5E075.25031@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/08/2021 10:00, Guillaume Tucker wrote:
> The first KernelCI hackfest[1] early June was successful in getting
> a number of kernel developers to work alongside the core KernelCI
> team.  Test coverage was increased in particular with kselftest,
> LTP, KUnit and a new test suite for libcamera.  We're now improving
> documentation and tooling to make it easier for anyone to get
> started.  Find out more about KernelCI on https://kernelci.org.
> 
> The second hackfest is scheduled for the 6th-10th September.  It
> should be a good opportunity to start discussing and working on
> upstream kernel testing topics ahead of the Linux Plumbers
> Conference[2].

Please find below some extra information for the KernelCI
Hackfest which is taking place next week.  We're expecting at
least some contributors from the Civil Infrastructure Platform
project, the Google Chrome OS kernel team, Collabora kernel
developers and a few more from the wider Linux kernel community.

If you need any direct support, please reply to this email or ask
on kernelci.slack.com or IRC #kernelci (libera.chat).


> Here's the project board where anyone can already add some ideas:
> 
>   https://github.com/orgs/kernelci/projects/5

In order to add an issue to the workboard, please first create
one in a KernelCI GitHub repository such as kernelci-core:

  https://github.com/kernelci/kernelci-core/issues

Each contributor to the hackfest should be added to the
KernelCI "hackers" team, which has permission to edit the
workboard.  If you aren't part of this team yet, please ask and
you'll be invited.

Note: Having a GitHub account is not mandatory for taking part in
the hackfest.  It's mainly there to facilitate coordination, even
though it is required in order to contribute to the KernelCI
GitHub repositories.  Contributions as part of the hackfest may
also be in the kernel tree such as improvements to kselftest,
KUnit or bug fixes, or other test suites such as LTP etc.


> The hackfest features:
> 
> * Daily open hours online using Big Blue Button to discuss things
>   and get support from the KernelCI team
> 
> * KernelCI team members available across most time zones to provide
>   quick feedback
> 
> * A curated list of topics and a project board to help set
>   objectives and coordinate efforts between all contributors

Please see the table below with the proposed daily open hours to
accommodate most time zones:

Region        Zone    Time 1       Time 2
East Asia     GMT+10  17:00-19:00  03:00-05:00
Europe        GMT+2   09:00-11:00  19:00-21:00
              UTC     07:00-09:00  17:00-19:00
West America  GMT-7   00:00-02:00  10:00-12:00


They will be held as a Big Blue Button virtual conference with
the same URL as the last hackfest.  It's not being shared
publicly to avoid any potential abuse, so please ask if you don't
have it already.

On Monday, the focus should be put on getting started and
reviewing the backlog on the hackfest workboard to distribute
things among people or help new contributors find topics suitable
for them.  Open hours are otherwise opportunities to get more
direct support from the KernelCI team or discuss any topic.

See you there!

Best wishes,
Guillaume

> [1] https://foundation.kernelci.org/blog/2021/06/24/the-first-ever-kernelci-hackfest/
> [2] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-test
