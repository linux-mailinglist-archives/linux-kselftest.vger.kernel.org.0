Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCED14A8CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgA0RRA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 12:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgA0RQ7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 12:16:59 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D0721739;
        Mon, 27 Jan 2020 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580145418;
        bh=PglgpVemLWFSZcqxwzUkIG2G/5M7nzcxv89bJ6SA8d4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DYX5oPrLNctYSgyCCGsTdEc3PYUdnRmEOpzmidU2MUIlJcpvn33jqC357LcFSefd0
         mG7Y0FZh4EH3L2AS6dxWQ0Anp4uakN7zugQYPnXzL+1pIgwbl4lBDzxv/VlBQTnFxY
         7i9wEL8J/66nftUmnewCagRZYzCas5ei6tn2//X4=
Subject: Re: [PATCH] selftests: settings: tests can be in subsubdirs
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mptcp <mptcp@lists.01.org>, shuah <shuah@kernel.org>
References: <20191022171223.27934-1-matthieu.baerts@tessares.net>
 <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
 <201911211018.D6CD68AC5@keescook>
 <602ab319-dcb9-4ac7-b2b8-f7b6072ddc03@tessares.net>
From:   shuah <shuah@kernel.org>
Message-ID: <bcce12e4-f122-10ae-dbc7-cc199d9716b6@kernel.org>
Date:   Mon, 27 Jan 2020 10:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <602ab319-dcb9-4ac7-b2b8-f7b6072ddc03@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/20 9:05 AM, Matthieu Baerts wrote:
> Hi Shuah, Kees,
> 
> On 21/11/2019 19:52, Kees Cook wrote:
>> On Thu, Nov 21, 2019 at 05:32:42PM +0100, Matthieu Baerts wrote:
>>> Hi Shuah,
>>>
>>> First, thank you for maintaining the Kernel Selftest framework!
>>>
>>> On 22/10/2019 19:12, Matthieu Baerts wrote:
>>>> Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
>>>> timeout per test) adds support for a new per-test-directory "settings"
>>>> file. But this only works for tests not in a sub-subdirectories, e.g.
>>>>
>>>>    - tools/testing/selftests/rtc (rtc) is OK,
>>>>    - tools/testing/selftests/net/mptcp (net/mptcp) is not.
>>>>
>>>> We have to increase the timeout for net/mptcp tests which are not
>>>> upstreamed yet but this fix is valid for other tests if they need to 
>>>> add
>>>> a "settings" file, see the full list with:
>>>>
>>>>     tools/testing/selftests/*/*/**/Makefile
>>>>
>>>> Note that this patch changes the text header message printed at the end
>>>> of the execution but this text is modified only for the tests that are
>>>> in sub-subdirectories, e.g.
>>>>
>>>>     ok 1 selftests: net/mptcp: mptcp_connect.sh
>>>>
>>>> Before we had:
>>>>
>>>>     ok 1 selftests: mptcp: mptcp_connect.sh
>>>>
>>>> But showing the full target name is probably better, just in case a
>>>> subsubdir has the same name as another one in another subdirectory.
>>>>
>>>> Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second 
>>>> timeout per test)
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Sorry to bother you again with this but by chance, did you have a 
>>> look at
>>> the patch below? :)
>>>
>>> It doesn't only fix an issue with MPTCP, not in the kernel yet. But 
>>> it also
>>> fixes the issue of taking the right "settings" file (if available) 
>>> for any
>>> other tests in a sub-directory, e.g.:
>>>
>>>    drivers/dma-buf
>>>    filesystems/binderfs
>>>    net/forwarding
>>>    networking/timestamping
>>>
>>> But I guess all tests in powerpc/* dirs and others.
>>
>> Thanks for the ping! I missed this patch when you originally sent it.
>> Yes, this make sense to me:
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Kees, Thank you for this review!
> 
> Shuah, I am sorry to send you this new request. It is just to inform you 
> that the first selftests for MPTCP are now in "net-next" repo, ready for 
> the future Linux 5.6.
> We would then be very happy to see this patch here below for the 
> kselftest framework accepted to avoid timeouts. Locally we apply this 
> patch before running the selftests but we cannot ask everybody running 
> MPTCP' selftests to do the same :)
> 
>

I am sorry for the delay. My bad. Looks like I just missed it. I will
make sure it gets into 5.6-rc1

Thanks for your patience and ping.

thanks,
-- Shuah
