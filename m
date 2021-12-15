Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283D54755AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 10:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbhLOJ7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 04:59:22 -0500
Received: from foss.arm.com ([217.140.110.172]:47112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236424AbhLOJ7W (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 04:59:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9660A6D;
        Wed, 15 Dec 2021 01:59:21 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7E573F5A1;
        Wed, 15 Dec 2021 01:59:19 -0800 (PST)
Date:   Wed, 15 Dec 2021 09:59:11 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, linux-kselftest@vger.kernel.org,
        sjpark@amazon.de, keescook@chromium.org, shuah@kernel.org
Subject: Re: [selftests/kselftest/runner.sh]  3226b4a464:
 kernel-selftests.cpu-hotplug.cpu-on-off-test.sh.fail
Message-ID: <20211215095911.GK6207@e120937-lin>
References: <20211202142056.17386-1-cristian.marussi@arm.com>
 <20211213052044.GA1334@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213052044.GA1334@xsang-OptiPlex-9020>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 13, 2021 at 01:20:44PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 

Hi,

> commit: 3226b4a4648c6562c642947cee8b90335df911f5 ("[PATCH] selftests/kselftest/runner.sh: Add optional command parameters in settings")
> url: https://github.com/0day-ci/linux/commits/Cristian-Marussi/selftests-kselftest-runner-sh-Add-optional-command-parameters-in-settings/20211202-222205
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> patch link: https://lore.kernel.org/linux-kselftest/20211202142056.17386-1-cristian.marussi@arm.com
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-99d09ee9-1_20211206
> with following parameters:
> 
> 	group: group-01
> 	ucode: 0xde
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 

This commit was under discussion/not acked nor fully reviewed, not ready
for upstream queuing really.

Indeed I posted today a V2 that take a different approach:

https://lore.kernel.org/linux-kselftest/20211215095340.50717-1-cristian.marussi@arm.com/T/#u

and should solve also the issue mentioned in this report.

Thanks,
Cristian

