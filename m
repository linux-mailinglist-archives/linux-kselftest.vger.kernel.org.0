Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5A3DD27A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhHBJAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 05:00:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhHBJAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 05:00:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2CDAD1F423FC
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
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: KernelCI Hackfest #2 - Sept 6-10 2021
Message-ID: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
Date:   Mon, 2 Aug 2021 10:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The first KernelCI hackfest[1] early June was successful in getting
a number of kernel developers to work alongside the core KernelCI
team.  Test coverage was increased in particular with kselftest,
LTP, KUnit and a new test suite for libcamera.  We're now improving
documentation and tooling to make it easier for anyone to get
started.  Find out more about KernelCI on https://kernelci.org.

The second hackfest is scheduled for the 6th-10th September.  It
should be a good opportunity to start discussing and working on
upstream kernel testing topics ahead of the Linux Plumbers
Conference[2].

Here's the project board where anyone can already add some ideas:

  https://github.com/orgs/kernelci/projects/5

There is no registration system, but please reply to this email or
send a message on IRC (#kernelci libera.chat) or kernelci.slack.com
if you would like to take part so you'll get email updates and
invitations to the meetings and open hours sessions online.  You
may just drop in and out at any point during the hackfest as you
see fit.

The hackfest features:

* Daily open hours online using Big Blue Button to discuss things
  and get support from the KernelCI team

* KernelCI team members available across most time zones to provide
  quick feedback

* A curated list of topics and a project board to help set
  objectives and coordinate efforts between all contributors


As always, KernelCI is at the service of the kernel community so
please share any feedback you may have to help shape this upcoming
hackfest in the best possible way.

Thanks,
Guillaume


[1] https://foundation.kernelci.org/blog/2021/06/24/the-first-ever-kernelci-hackfest/
[2] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-test
