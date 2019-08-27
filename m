Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7D9EFD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH0QMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 12:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfH0QMp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 12:12:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792622186A;
        Tue, 27 Aug 2019 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566922364;
        bh=TN7/7Rqdl/EiqP0v3ytPDvKZIVZ9HCC/Si2Qhz4gL4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AbbbpIEaVTjhsHc15DkggjkUbn224g5fFiQubXXAJ1RzbtYDwBdpHL27PTIcDs1OF
         pXRTnzD3wiBdPnGRkN75ATj9lybwBmeLagzLo7X4xLjuTOyXSBl7sUQKCNoOUy4mtG
         eGoTR8rxcs7a+2d90SUCxez6ZjAxzJXQfgbuzAvQ=
Subject: Re: linux-next: Tree for Aug 27 (kunit)
To:     Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190827190526.6f27e763@canb.auug.org.au>
 <c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org>
 <CAFd5g452baXuwL1hDyX+U53_p6XGppTf5p1qMwRsGK-wjzJ8Lg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0352fae9-564f-4a97-715a-fabe016259df@kernel.org>
Date:   Tue, 27 Aug 2019 10:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g452baXuwL1hDyX+U53_p6XGppTf5p1qMwRsGK-wjzJ8Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 10:09 AM, Brendan Higgins wrote:
> On Tue, Aug 27, 2019 at 8:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 8/27/19 2:05 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20190826:
>>>
>>
>> on i386:
>> # CONFIG_PRINTK is not set
>>
>>
>> ../kunit/test.c: In function ‘kunit_vprintk_emit’:
>> ../kunit/test.c:21:9: error: implicit declaration of function ‘vprintk_emit’; did you mean ‘vprintk’? [-Werror=implicit-function-declaration]
>>    return vprintk_emit(0, level, NULL, 0, fmt, args);
>>           ^~~~~~~~~~~~
>>           vprintk
> 

Thanks Randy for catching this.

> Ooops, it never occurred to me to test the situation where I wouldn't
> be able to see test results :-)
> 
> It seems to me that the right thing to do here is to do what
> dev_printk and friends do and to ifdef this out if CONFIG_PRINTK is
> unavailable. Does that seem reasonable?
>  > Also, do you want me to resend my patches with the fix or do you want
> me to send a new patch with this fix? (Sorry for the newbie question.)
> 

Brendan,

I would like to apply the fix on top of the series. I don't want to
revert.

thanks,
-- Shuah
