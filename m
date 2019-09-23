Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC3BBE26
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 23:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfIWVw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 17:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbfIWVw3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 17:52:29 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E4A2053B;
        Mon, 23 Sep 2019 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569275548;
        bh=aJD72tMRJbp8Cy8s3cyn4aiUUcujia8nJI4yjVY0Cpw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBLGLLauYl8gZW1YTtmbGLGlEz1wmzDqNIXJE4s+pfrWMQ8kj5IPYGCX4yD98hWyf
         ulQiJ40vfhwiAt6cf9ItWXsRAXcwQ/3jsvgADc7m94AOsQRrIuM/ZpN3ex6QVjaI1w
         0+oS82BZaDBAzaLaZ6sP5T6Py74/g/uod9b0I6A0=
Subject: Re: kunit: what do we do with the 'kunit/alpha/master' branch?
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     David Chiang <davidchiang@google.com>,
        David Siebert <David.Siebert@l3harris.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Pei Huang <peihuang@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sangsu Ha <sangsu.ha@samsung.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
 <CAFd5g4659KMmAtJshzs0n=rPZX5EGFBgYfNkH5RznZH=JnxeHQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2e2441c8-eba7-e5c5-ae18-8d9141c0de98@kernel.org>
Date:   Mon, 23 Sep 2019 15:52:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g4659KMmAtJshzs0n=rPZX5EGFBgYfNkH5RznZH=JnxeHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/19 3:41 PM, Brendan Higgins wrote:
> On Tue, Sep 17, 2019 at 11:41 AM David Gow <davidgow@google.com> wrote:
>>
>> TL;DR: We expect KUnit to be accepted upstream into Linus' branch in
>> the next week or two, and we now need to figure out what we are going
>> to do with our non-upstream 'kunit/alpha/master' branch.
> 
> Given that it has been about a week and we haven't heard any comments,
> complaints, or concerns about this. I assume that there are no strong
> opinions against this, and people will be generally okay with this
> strategy.
> 
> As mentioned previously, we are expecting to see KUnit make it into
> torvalds/master this merge window (the next week or so), so we will
> probably update/rename kunit/alpha/master shortly thereafter.
> 
> Cheers
> 
>> Hello everyone,
>>
>> We've put together a rough proposal of what we should do with our
>> not-upstream branch, known to most people using it as
>> 'kunit/alpha/master'[1], now that KUnit's acceptance into mainline
>> appears to be imminent (the KUnit MVP patchset is now in linux-next,
>> and the merge window just opened).
>>
>> ==========
>> Background
>> ==========
>>
>> KUnit development is currently split between two versions: the
>> 'kunit/alpha/master'[1] git branch, and the version being submitted to
>> the upstream Linux kernel. While there are some good reasons to
>> continue to have two separate versions of KUnit, at present there is
>> some uncertainty around the difference between these versions, and in
>> which circumstances each version is useful.
>>
>> At present, the 'kunit/alpha/master' branch serves a few different
>> purposes. It is a place for code not-yet-ready for upstream -- such as
>> the mocking framework -- while being developed, while also acting as a
>> stable version for customers who do not wish to follow along with the
>> changes made during the upstreaming process. Adding to the confusion,
>> the name 'kunit/alpha/master' refers to an early (alpha) version of
>> KUnit, and the version of KUnit being upstreamed has now diverged
>> significantly from this version, requiring significant differences in
>> documentation, and requiring a number of changes to tests when porting
>> from one version to the other. Finally, it is not clear how the
>> 'kunit/alpha/master' version should evolve as features it contains are
>> upstreamed.
>>
>> On the other hand, the version being upstreamed has its own
>> complications. It contains significantly fewer features (as features
>> such as the mocking frameworks will be upstreamed individually), and
>> so is less useful for the average customer. Until each feature is
>> upstreamed, it is iterated on rapidly to address comments from the
>> kernel community, so in-progress features are not stable enough to
>> reasonably build on. Finally, it exists only as a set of patches on
>> mailing lists, rather than as a maintained git repository (due to the
>> fact that the patches themselves are changing rapidly), making it
>> difficult for early adopters to incorporate into their own trees.
>>
>> Whilst we believe there to be enough (at times conflicting) goals
>> above to justify having multiple versions of KUnit, we want to ensure
>> that they are meeting their goals, and that we have a process to
>> ensure that code finds its way into the correct version, that we can
>> deprecate and remove failed experiments or superseded versions, and
>> that we can keep pace with upstream kernel releases.
>>
>> ============
>> The Proposal
>> ============
>>
>> We propose having two tracks of development: the upstream kernel
>> (comprising both code that has been upstreamed, and code which is in
>> the process of being upstreamed -- i.e. is being reviewed on the
>> mailing lists), and an 'experimental' branch, which contains features
>> which are yet to be submitted upstream.
>>

My concern with this approach is either one could outdated. is there a
reason continue in parallel mode. I would rathet see development happen
upstream so we don't have lot of code to be upstreamed sitting in an
experimental branch while upstream keeps moving. It is given that they
will diverge.

thanks,
-- Shuah
