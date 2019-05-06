Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74514D0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfEFOrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 10:47:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50421 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfEFOrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 10:47:18 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so20710797itk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DpOTHTN61DNh0jzA3oEB6+Erb5rOcYNfwyvkegv2Kn0=;
        b=YHXOsoSNPP+91o/8xFKA+1I+O1WnTJI+Pr6esCtIaRNNgKIicPD2Gh0yARBvQhzH0Y
         BakP/wZbniH9i/FfRVNfXkbYa0M8K+BKP5yMHcKdDJoWja4VJaCdSZHiG1MuGKQCDZ64
         ph3u/3UFn0JyCX0VYhubw5krtx5184RP3j64o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DpOTHTN61DNh0jzA3oEB6+Erb5rOcYNfwyvkegv2Kn0=;
        b=b4JNCLbehuj8jUTTtydB60rb1pEZwBRmZUSkhcO6rw8nW+FQXD7440i14h5ULUbcBY
         GGGOyxYQDaxbk6j/+qU4pwvvhblyC2yyg4u1YU8NiFe3EXt1G0f4kC1lUx0LJNxTiSzU
         Fns+pJP7Q5erazWyl9pGVQdPQjpXzbe6hZ7fmzwbnLoqc2zdHVCFdsCJQMcn0N/Zs2Qm
         Vg+NcHiUth8NnRYMezLPwINC0hVGb0umFjEgCr6rCOfho+EzXyFQGYHkjIpYHDtwcJ60
         64+q4JCEJhfAIMpyRBSVBMisrk73JU4wCPt5yV6Z2lZSEzvKE+88j0k2hEfk/uscVAdu
         fJGA==
X-Gm-Message-State: APjAAAVCmdpVjju6z8Cr9QNStNoElmhDsD9zfpL9a8dzoqW+oC6SgA7Z
        C3uMEaLgyVlhdueQraaqQG/2HQ==
X-Google-Smtp-Source: APXvYqxKSTCiJxdwYirrcVpxqxAb++n6X86LP1uUdw7zskem8MIedd+9DqDZSsQjNfBe0xXVMemvsw==
X-Received: by 2002:a05:660c:799:: with SMTP id h25mr18380320itk.85.1557154037724;
        Mon, 06 May 2019 07:47:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q125sm3478606iod.88.2019.05.06.07.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 07:47:16 -0700 (PDT)
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
To:     Greg KH <greg@kroah.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
 <20190505091356.GB25646@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
Date:   Mon, 6 May 2019 08:47:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505091356.GB25646@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/5/19 3:13 AM, Greg KH wrote:
> On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
>> Add a sleep between detach and check for exportable devices to avoid
>> the following segfault from libc-2.27.so
>>
>> [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> index 128f0ab24307..beacf24a8df7 100755
>> --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
>>   src/usbip detach -p 100;
>>   echo "=============================================================="
>>   
>> +# let detach complete. Avoid segfaults from libc-2.27.so
>> +sleep 3;
> 
> That feels very "arbitrary", why do we "know" it will take at most 3
> seconds?  I guess there's not much else we can do here except maybe
> somehow watch sysfs until the device is really gone?
> 

Yeah. Number 3 is somewhat arbitrary. It helps the host process the
detach request from the client and update the sysfs. Detach returns
as soon as client side is done, and the test is running the next
command on the host side. If I were run these commands manually, it
gives enough settling time. I am looking for a quick way to allow
settling time in this automated test.


thanks,
-- Shuah
