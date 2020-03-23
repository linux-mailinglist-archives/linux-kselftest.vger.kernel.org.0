Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6070118F842
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWPJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgCWPJc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:09:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CADF206F8;
        Mon, 23 Mar 2020 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584976172;
        bh=e1uLIoKd9nU0TUs8bH6w5SBR5lZePgQittM/BJ+/UEo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C7yGcjhXo9lKrTEOH/ZnJ/6Djb1/1+IJfe225w7DgazgeEfzuM2wLlxPw8j1Kd6gx
         vW/bDWA8QdV9OVi+aIP9sCwvnDG4qtL1qsMhUGj1dzzmZNqaid60AB6Tw5xg9XljFY
         ClrUEEwBjSnP8mLRL9ZmBzUJj/v2GLFTEPUXhjKw=
Subject: Re: [PATCH] kunit: add --make_options
To:     Greg Thelen <gthelen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        shuah <shuah@kernel.org>
References: <20200227063134.261636-1-gthelen@google.com>
 <20200229015350.GA26612@ubuntu-m2-xlarge-x86>
 <4bb8eeef-54ac-86a7-4bc4-8e16fc149c1a@kernel.org>
 <xr93y2s34fp7.fsf@gthelen.svl.corp.google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a4a1e84a-9cfd-312d-1048-04a5e525332b@kernel.org>
Date:   Mon, 23 Mar 2020 09:09:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <xr93y2s34fp7.fsf@gthelen.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/14/20 12:24 AM, Greg Thelen wrote:
> shuah <shuah@kernel.org> wrote:
> 
>> On 2/28/20 6:53 PM, Nathan Chancellor wrote:
>>> On Wed, Feb 26, 2020 at 10:31:34PM -0800, 'Greg Thelen' via Clang Built Linux wrote:
>>>> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
>>>> optional --make_options flag to kunit.py allowing for the operator to
>>>> specify extra build options.
>>>>
>>>> This allows use of the clang compiler for kunit:
>>>>     tools/testing/kunit/kunit.py run --defconfig \
>>>>       --make_options CC=clang --make_options HOSTCC=clang
>>>>
>>>> Signed-off-by: Greg Thelen <gthelen@google.com>
>>>
>>> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>>>
>>
>> Please rebase on Linux 5.6-rc5 and resend. I tried applying
>> on Linux 5.6-rc1 as well as 5.6-rc5 and both fail.
>>
>> thanks,
>> -- Shuah
> 
> Rebased onto v5.6-rc5 below:
> 
>>From 0517b2c8b481535fb52bd86e94be1fec9aaeead7 Mon Sep 17 00:00:00 2001
> From: Greg Thelen <gthelen@google.com>
> Date: Wed, 26 Feb 2020 22:31:34 -0800
> Subject: [PATCH v2] kunit: add --make_options
> 
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
> 
> This allows use of the clang compiler for kunit:
>    tools/testing/kunit/kunit.py run --defconfig \
>      --make_options CC=clang --make_options HOSTCC=clang
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>

I can't apply this one.

Please send a proper patch with either REBASE tag or v2.

thanks,
-- Shuah
