Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB414FE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEFPSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 11:18:03 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40712 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfEFPSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 11:18:03 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so5395839ita.5
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pQydGOg4OcYDbNXBsQRT4Lvzf+ksqu8jt9++8oyYp8=;
        b=AZ9OASulQopNJAz/g6esfXYRGTB3j58sn9wd3Ww8ryDcz06MhO9qArg58Dib9dxzuI
         JHYxRfgi3aSjdur/8P5G5FjZzIndaDKGaVe5QlWe93g8xCeIhxs+lJpwgDLlg57cZnor
         MknrBcs0iOB3+Dh38qnXZKsEm5zx8YDk7kow0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pQydGOg4OcYDbNXBsQRT4Lvzf+ksqu8jt9++8oyYp8=;
        b=KdNAoN+2BfvbxUQcwJ5bS+bqfpLufJ2TLiqkABbgL0Lhvdqe6KHprI9hLK1OcRk2we
         yAiLC3/MSQHqyVKKq2tzAXQkozYQcXZHZXyazumJ3SAj5jm4IG275pKBt+aiy1z7g3cj
         tP5HNKERhjiAraOw9KFi37HZ7GWAg47cZW+rd/lo2fa6Q3BBKikHgRqKxg8TYMYjioHt
         vHFadmhauOZi4QENn1rxWL1Qw8rpctf9kid+1i2hjsKIqp6PeCps5KVsaRghP2SlUCK5
         +E+RD0sAgeT3aavSVFS0CIQakkw/uIScoWJ6uxt7mX84jhlOJJJsh8VRyhDZBekUxmPD
         wqEw==
X-Gm-Message-State: APjAAAVkyhWhz/8jD73YyLr4ToLAmWtUxvhsZJ1L6Zr3YC7hu/h8lJ8W
        nR4bkqKFaf8CD8e5MHGozuQSlQ==
X-Google-Smtp-Source: APXvYqyPd66l+UgLY2N+cihkt4KtQKbB3decdpUkRANIYDmWD7+aar3uFt3aYwaCclD5MjkbHOTi1A==
X-Received: by 2002:a05:660c:111:: with SMTP id w17mr17449225itj.62.1557155882202;
        Mon, 06 May 2019 08:18:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i72sm8735324itc.11.2019.05.06.08.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:18:01 -0700 (PDT)
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
To:     Greg KH <greg@kroah.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
 <20190505091356.GB25646@kroah.com>
 <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
 <20190506151540.GA12755@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b1bf8113-75a1-40dc-daf9-4411c3e87cfe@linuxfoundation.org>
Date:   Mon, 6 May 2019 09:18:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506151540.GA12755@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/6/19 9:15 AM, Greg KH wrote:
> On Mon, May 06, 2019 at 08:47:15AM -0600, Shuah Khan wrote:
>> On 5/5/19 3:13 AM, Greg KH wrote:
>>> On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
>>>> Add a sleep between detach and check for exportable devices to avoid
>>>> the following segfault from libc-2.27.so
>>>>
>>>> [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> index 128f0ab24307..beacf24a8df7 100755
>>>> --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
>>>>    src/usbip detach -p 100;
>>>>    echo "=============================================================="
>>>> +# let detach complete. Avoid segfaults from libc-2.27.so
>>>> +sleep 3;
>>>
>>> That feels very "arbitrary", why do we "know" it will take at most 3
>>> seconds?  I guess there's not much else we can do here except maybe
>>> somehow watch sysfs until the device is really gone?
>>>
>>
>> Yeah. Number 3 is somewhat arbitrary. It helps the host process the
>> detach request from the client and update the sysfs. Detach returns
>> as soon as client side is done, and the test is running the next
>> command on the host side. If I were run these commands manually, it
>> gives enough settling time. I am looking for a quick way to allow
>> settling time in this automated test.
> 
> Ok, you might want to document that you know it's a random number :)
> 

Okay. Will do. I will send v2. :)

thanks,
-- Shuah
