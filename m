Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5994A8B6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353288AbiBCSTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 13:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiBCSTl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 13:19:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C9C061714;
        Thu,  3 Feb 2022 10:19:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id A412F1F4619E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643912378;
        bh=rziURq+uk/vVU8nLbnp3kXFJ0oB9uz8C5wxJ2k5a5f0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gri2YmDQoBLPbDu6KewMpdgXSRbwLtguVfi0q+hIA899Qh7BaltOfz2MpCf4KDJXW
         jWDsmeMcOw1gJ3GITsab/va6X44QY4UXizhEzQgxqVUI3cEgegQL9KOxIrVWq0+SXZ
         7f+THiLnzYSBY6D36pXD0BTGSIZlzHCzmSgu4p392JROSujitZYntL8QcL2ty5bPka
         LBFq1ug/f021QweV1oQvsgtjjyLeI+eXL+/dxNQuQ6LZmco5B7kP+ZNfPjh9Ux58VD
         O8o+nTBwezlCay0Z+EgDs1lMlysL7h5axMMpPT91Dn8B4amuTTtDM5H4w5uoOpNeD+
         u7BRRvFbYG4yA==
Message-ID: <bc705b2c-b2d7-c80f-7020-ee52a2aeb061@collabora.com>
Date:   Thu, 3 Feb 2022 18:19:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: kselftest tree on kernelci.org
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <5fd1a35c-f84e-1c6a-4a3a-be76dda97ca3@collabora.com>
 <ece6ea91-c44b-0bea-c4a2-ec099fa94881@linuxfoundation.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <ece6ea91-c44b-0bea-c4a2-ec099fa94881@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/02/2022 15:23, Shuah Khan wrote:
> Hi Guillaume,
> 
> On 2/2/22 6:32 AM, Guillaume Tucker wrote:
>> Hi Shuah,
>>
>> I've made this PR to start monitoring the "fixes" branch from the
>> kselftest tree on kernelci.org:
>>
>>    https://github.com/kernelci/kernelci-core/pull/998
>>
> 
> Thank you.

You're welcome.

>> While kselftest changes eventually land in linux-next, monitoring
>> your tree directly means we can test it earlier and potentially
>> enable more build variants or experimental tests.  Since
>> kernelci.org also builds and runs some kselftests we're regularly
>> finding issues and people are sending fixes for them.  See this
>> recent story for example:
>>
>>    https://twitter.com/kernelci/status/1488831497259921409
>>
>> Keeping an eye on kselftest patches with kernelci.org means we
>> can verify that fixes do what they're supposed to do with a much
>> larger test coverage than what individual developers can do.
>> We've been applying kselftest fixes on a branch managed by
>> kernelci.org to verify them in the past, but having the actual
>> kselftest tree part of the workflow would seem much better.
>>
> 
> Absolutely.
> 
>> There are several branches in your tree, while "fixes" seemed
>> like the most useful one to pick I see there is also a "kernelci"
>> branch too but it hasn't been updated for a while, reviving it
>> could give you the possibility to test patches through
>> kernelci.org before applying them on other branches that get
>> pulled into linux-next and mainline.
>>
> 
> This branch was a topic branch specific for changes I made for
> kernelci runs to be cleaner - I should delete this.
> 
> If you are looking for other branches to monitor in addition to
> "fixes" branch, the following are the ones to add:
> 
> next (for the merge window), kunit (kunit changes slated for merge window),
> kunit-fixes

I see these 4 branches (fixes, next, kunit, kunit-fixes) are all
merged into linux-next.  So it seems like the best thing to do
would be to cover them with a very lightweight number of builds and
tests focused on what they are about: only run kselftest on the
fixes and next branches, and only KUnit on kunit and kunit-fixes.
At the moment, KUnit is not run by kernelci.org (coming soon) so I
think we could just add the next branch for kselftest.  Then
linux-next will be tested with maximum coverage anyway so if
something subtle gets missed with the early tests it should get
caught the following day at the latest with linux-next.

>> Many things could potentially be done with arbitrary builds and
>> tests etc.  These are some initial suggestions.  How does this
>> sound?
> 
> Sounds great to me. Since selftest patches flow through various
> subsystem trees, having kernelci keep an eye is great. This would
> be another pair of eyes in addition to occasional tests I run and
> Linaro (LKTP) monitoring next.
> 
> How often do you send reports - I will watch out for them. Thanks
> again for taking the initiative to add kselftest to kernelci.

Builds and tests are run every time a new revision is detected on
the branches being monitored.  Then when they complete, a report
is sent.  It can take a while, but with a small number of builds
you could get results within an hour.  We could get the reports
sent to the linux-kselftest mailing list and your own address if
you want.

Also this configuration is all under source control on GitHub so
feel free to make changes to it in the future as you see fit.

Best wishes,
Guillaume
