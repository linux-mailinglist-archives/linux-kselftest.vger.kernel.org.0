Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C2470C39
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 22:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhLJVJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhLJVJS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 16:09:18 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080DC061746;
        Fri, 10 Dec 2021 13:05:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 07F072CC;
        Fri, 10 Dec 2021 21:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 07F072CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639170342; bh=ah7X2p+x7eNXWfUxiAvcbLc+vL4B4rK2KSitJdGSWbg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Fai/J8PJVDqw32kJ4cgP/LATbXRW+UiaCL+9qJPIwrP5RmYT0b5ePsEipAPcCGQXk
         /7Hvl20oYYmuubX92kmN4qoTogIK3HXj98Xrosm/8LWjSa33MmPIO57YDW+97ajJAf
         FMnapIP5MoM+jCyoN+Kg3x9gmwnT6KCUX00L6zW0i20tnOMEUo29zEXNxGNQ+ji2pl
         2h3pTmjZH+aT98NjkfEsTMnbUOC/SScLW6VRoFTjIytBCmDTazm9OZr1qW0dyTP0d4
         W44NEIk/6oCFQKqOsiuFg5cZnhgfTNLarJN5+thlnWwi0kU3Fil2B895w719rBIGjP
         xhnwmNblr8gQA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
In-Reply-To: <8c06e715-a83e-e8c6-74c3-836831b85cdf@linuxfoundation.org>
References: <20211207190251.18426-1-davidgow@google.com>
 <202112071358.E8E6812D@keescook>
 <8c06e715-a83e-e8c6-74c3-836831b85cdf@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 14:05:41 -0700
Message-ID: <87mtl8qifu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 12/7/21 3:02 PM, Kees Cook wrote:
>> On Tue, Dec 07, 2021 at 11:02:51AM -0800, David Gow wrote:
>>> From: Rae Moar <rmoar@google.com>
>>>
>>> It does not make any significant additions or changes other than those
>>> already in use in the kernel: additional features can be added as they
>>> become necessary and used.
>>>
>>> [1]: https://testanything.org/tap-version-13-specification.html
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> Co-developed-by: David Gow <davidgow@google.com>
>>> Signed-off-by: David Gow <davidgow@google.com>
>> 
>> I like it! Thank you so much for suffering through my earlier reviews.
>> :)
>> 
>> The only concern I have is wonder what'll be needed to kselftest to
>> deal with indentation changes. As long as this can be implemented
>> without a subtest knowing it is a subtest, we're good.
>> 
>
> A lot of this TAP output is in the wrappers - hopefully it will be okay.
> Fingers crossed. :)
>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> 
>
> Looks good to me as well. Thanks for doing this work.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Would you like me to take this through the docs tree, or do you have
other plans for merging?

Thanks,

jon
