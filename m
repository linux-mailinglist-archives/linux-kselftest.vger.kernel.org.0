Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA511D8B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfLLVpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 16:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbfLLVpV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 16:45:21 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2E621556;
        Thu, 12 Dec 2019 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576187121;
        bh=HKha0l8Vk72dO87EAxfkpbMriBYIovoUg6JKYg1e2OM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Sk9+cf5uKQrIX5jeay43dItmSoYGDXTwsCNaL/pC/awWgGA/W8Di5oIT95lAI1b+t
         FZWagQKrsCI1ZgogKIz76cPNiZEWnGl+3Ek2C7Hj9FQgnLxjErpuLFdkP7OdsyRLTT
         jJcQFM681SCPOR6bB0seoRqygI1OlZL9CFeEoNxM=
Subject: Re: [PATCH v6 0/6] Fix nits in the kunit
To:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>, shuah <shuah@kernel.org>
References: <20191212022711.10062-1-sjpark@amazon.de>
 <CAFd5g46HjimaZB+_TJdy627p_jrBOrdav6+qDa4i_t4Kzmy8rQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f9c438ba-433c-6624-5eab-6acff72f55f6@kernel.org>
Date:   Thu, 12 Dec 2019 14:44:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFd5g46HjimaZB+_TJdy627p_jrBOrdav6+qDa4i_t4Kzmy8rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/12/19 2:31 PM, Brendan Higgins wrote:
> On Wed, Dec 11, 2019 at 6:27 PM SeongJae Park <sj38.park@gmail.com> wrote:
>>
>> This patchset contains trivial fixes for the kunit documentations and
>> the wrapper python scripts.
>>
>>
>> Baseline
>> --------
>>
>> This patchset is based on 'kselftest/fixes' branch of
>> linux-kselftest[1].  A complete tree is available at my repo:
>> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6
> 
> Everything looks good to me. Shuah, feel free to pick this up at your
> convenience.
> 
> SeongJae, Thanks for all your hard work on this. I really appreciate it!
> 

Yup. I will pull these in early next week.

thanks,
-- Shuah
