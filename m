Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36073BBEE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404961AbfIWXUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 19:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404574AbfIWXUB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 19:20:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DC2207FD;
        Mon, 23 Sep 2019 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569280800;
        bh=TYN86YGqXrsNBL03jzhfsZPF5Z0IhGEVZrOQsXcIRxE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cJTZZ86R1cHXbjLg4vi8B0sHXXBy4k2H84qg0dtY3VbXbv2ywgMx52p+wy9o7WIhB
         jHVdvVYvxR4hDlHDqkiChGdbeIli92UKMjw4l7Ed+g5UkNy8OB94MhB9b8MY+xmxRq
         lMQepytSLlA15jkrhC6Ags0hjr5rAAvcyWKraxIY=
Subject: Re: kunit: what do we do with the 'kunit/alpha/master' branch?
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Chiang <davidchiang@google.com>,
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
 <2e2441c8-eba7-e5c5-ae18-8d9141c0de98@kernel.org>
 <CABVgOS=tgjQ5J6kaQRHHi=Fxr_cWRJ+-3BgEqx2QkyTFfoYArw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5785a414-b726-a2d6-b8a0-d5f4efaed22e@kernel.org>
Date:   Mon, 23 Sep 2019 17:19:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOS=tgjQ5J6kaQRHHi=Fxr_cWRJ+-3BgEqx2QkyTFfoYArw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/19 5:00 PM, David Gow wrote:
> On Mon, Sep 23, 2019 at 2:52 PM shuah <shuah@kernel.org> wrote:
>>
>> My concern with this approach is either one could outdated. is there a
>> reason continue in parallel mode. I would rathet see development happen
>> upstream so we don't have lot of code to be upstreamed sitting in an
>> experimental branch while upstream keeps moving. It is given that they
>> will diverge.
> 
> I definitely appreciate that, and the aim certainly is to have most
> changes go straight upstream without passing through the
> 'experimental' branch first.
> 
> The real purpose of the 'experimental' branch is to have somewhere to
> keep the mocking functionality before we're ready to upstream it.
> Given that there are already people using the current version of the
> mocking framework, we want to provide a smooth-ish path to upstream by
> providing this branch which is at least closer to upstream than when
> we are now (and that'll stay as close to upstream as possible through
> regular rebasing, rather than staying 'stuck' on the older versions).
> 

What I would like to see is a freeze on the experimental branch as soon
as KUnit goes into mainline (which is really at the end of this week)

Start draining the experimental branch with a goal to get all everything 
currently staged there mainlined.

Please define clear sunset date for the experimental branch. Without
that we are looking at a lot of pain in the future.

thanks,
-- Shuah


