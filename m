Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5175CE2F62
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbfJXKtR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 06:49:17 -0400
Received: from foss.arm.com ([217.140.110.172]:47030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436903AbfJXKtQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 06:49:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17B7F497;
        Thu, 24 Oct 2019 03:49:01 -0700 (PDT)
Received: from [10.1.197.50] (unknown [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 122113F71A;
        Thu, 24 Oct 2019 03:48:59 -0700 (PDT)
Subject: Re: next-20191024 kselftest results
To:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        dan.rue@linaro.org, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <312839085.10341.1571900438441.JavaMail.javamailuser@localhost>
Cc:     Prabhakar Kushwaha <pkushwaha@marvell.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <cb6b01a2-11a6-b33d-98cc-dea60933aff0@arm.com>
Date:   Thu, 24 Oct 2019 11:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <312839085.10341.1571900438441.JavaMail.javamailuser@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 24/10/2019 08:00, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc4
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: 12d61c6996999e6562cbbed5f270d572248a11c5
> git describe: next-20191024
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191024
> 
> Regressions (compared to build next-20191023)
> ------------------------------------------------------------------------
> No regressions                                                                                                          
>                                                                                                                        
> Fixes (compared to build next-20191023)                                                                   
> ------------------------------------------------------------------------                                               
> No fixes
> 
> In total:
> ------------------------------------------------------------------------
> Ran 0 total tests in the following environments and test suites.
> pass 0
> fail 0
> xfail 0
> skip 0
> 

It seems that my previous patch meant to ease kselftest in CI:

[PATCH v2 2/2] kselftest: exclude failed TARGETS from runlist
https://lore.kernel.org/linux-kselftest/20190926175219.29805-3-cristian.marussi@arm.com/

contained a subtle bug that killed it worldwide indeed :<

it should have been fixed already by Prabhakar Kushwaha in:

[PATCH][v3] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
https://lore.kernel.org/linux-kselftest/1571750829-28944-1-git-send-email-pkushwaha@marvell.com/T/#u

Thanks for the patience...

Cristian


> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> 
> 
> Failures
> ------------------------------------------------------------------------
> 
> i386:
> 
> x86:
> 
> x15:
> 
> juno-r2:
> 
> dragonboard-410c:
> 
> hi6220-hikey:
> 
> 
> Skips
> ------------------------------------------------------------------------
> No skips
> 
> 

