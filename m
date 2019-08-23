Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDC9B797
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2019 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfHWUQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 16:16:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404703AbfHWUQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 16:16:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so6337422pgb.9
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2019 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xmWOYmfNGYI3Y1y41HZf19hpjDC3mz85j0cRHycsQJY=;
        b=KdZC4mJ5+cGdoGruFg9hqsRn59QcD2SeuJ+1lIXAwWs69lgjW6ADqySlbr7ShGc/Nt
         dtZRGXa77ikJKSrz10p0MRcD1pVdMjdbTEywHVTp4owLAEpq5gmEhxcIK7QL+V7vYSuv
         5ozvqvwv0gPSyz+voLomLhz8cSV1Y6eSLt2fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xmWOYmfNGYI3Y1y41HZf19hpjDC3mz85j0cRHycsQJY=;
        b=a87CFJcZf+cCZg+jnvs/KU3tz7QxUOg1YeKsQRcJNnV2DHb/seC2F+/mBgscM+wbCW
         83Ff2havA/H8sbvHq3ByfGp+JuD14KRduhJ0IlsmsapDwoZD9pwgOx3nIgCJ1Del32cO
         W11j9c3l7t5Py2/9hZ1R70G+HYlS4Ylv1YQnaAOuqveilzZAnnp3xwPJqvg/1LFoDx91
         z+GwzeuNFir8osU6kLuXDYN8HbHweiV/vfMrIZtboOBQibuFGhCN13+ahI4pp0DZjYDQ
         ZVnR3EWhszSEfXjfq1ooMj7vLJnS7hHTdJNkjfxb3gywtE96hVNZUUvlel97RqkxuzJ9
         xqKw==
X-Gm-Message-State: APjAAAUsVsNPAT1zU8kOnKuaB4AZ4rKkK7uoeRqsIa9QdA8elMxlu/Ay
        dGrSN4hY5+2oimtFoUJF+5wNvIGmEog2tSlxGR508DfSqjy3e0fQy6LVKHyirZPeFB4Tp3I2r9S
        CMwvcaBz54dduP0vdDRzwjnPGrAzfZ+88otS3C4vD3NynodHPEIb3nZzDHlQU/SgWA9GWUAs1zc
        bgG+Xi1UfmEg==
X-Google-Smtp-Source: APXvYqwri9AQsAvZYFl15cTKqo0LzTCKgYiJV2w4DIRUnb1xQL31Z3EKC0Q8EroeKhuTNqGmY5fliw==
X-Received: by 2002:a17:90a:234e:: with SMTP id f72mr7096380pje.121.1566591395745;
        Fri, 23 Aug 2019 13:16:35 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f63sm4091921pfa.144.2019.08.23.13.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 13:16:35 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
 <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
 <20190822211220.GR16384@42.do-not-panic.com>
 <009295ce-bdc5-61d8-b450-5fcdae041922@broadcom.com>
 <20190823154721.GV16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <335278f4-bbaf-1f01-53e6-c01720b4c84f@broadcom.com>
Date:   Fri, 23 Aug 2019 13:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823154721.GV16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Luis,

Thanks for helping on this.

Enjoy your time off an we can work on it when you're back.

comments below.


On 2019-08-23 8:47 a.m., Luis Chamberlain wrote:
> On Thu, Aug 22, 2019 at 04:30:37PM -0700, Scott Branden wrote:
>> On 2019-08-22 2:12 p.m., Luis Chamberlain wrote:
>>> On Thu, Aug 22, 2019 at 01:07:41PM -0700, Scott Branden wrote:
>>>> On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
>>>>> This implies you having to change the other callers, and while currently
>>>>> our list of drivers is small,
>>>> Yes, the list is small, very small.
>>>>
>>>> There is a single driver making a call to the existing API.
>>>>
>>>> And, the maintainer of that driver wanted
>>>> to start utilizing my enhanced API instead of the current API.
>>> You mean in the near term future? Your change makes it use the full file.
>>> Just checking.
>> The change in the patch keeps the existing functionality in the
>>
> BTW for some reason your mailer keeps adding new lines per each line. I
> trim them below. Also for future emails please Cc:
>
>    Mimi Zohar <zohar@linux.ibm.com>
>
> As she'll be interested in some of this from the IMA security perspective.
>
>> qcom mdt_loader by reading the full file using the enhanced api.
>> I don't know when Bjorn will switch to use the partial firmware load:
>>
>> https://lkml.org/lkml/2019/5/27/9
> OK I see he did he liked the approach. OK thanks! This will make
> evolutions much easier.
>
>>>> As such I think it is very reasonable to update the API right now.
>>> I'd prefer to see it separate, and we fix the race *before* we introduce
>>> the new functionality. I'll be poking at that shortly but I should note
>>> that I leave on vacation this weekend and won't be back for a good while.
>>> I already have an idea of how to approach this.
>>>
>>> When the current user want to use the new API it can do so, and then we
>>> just kill the older caller.
>> We can kill the older api right now as my patch in qcom mdt_loader
>> calls the new API which allows reading of full or partial files?
> Yes its possible, but more on this below.
>
>>>>> following the history of the firmware API
>>>>> and the long history of debate of *how* we should evolve its API, its
>>>>> preferred we add yet another new caller for this functionality. So
>>>>> please add a new caller, and use EXPORT_SYMBOL_GPL().
>>>>>
>>>>> And while at it, pleaase use firmware_request_*() as the prefix, as we
>>>>> have want to use that as the instilled prefix. We have yet to complete
>>>>> the rename of the others older callers but its just a matter of time.
>>>>>
>>>>> So something like: firmware_request_into_buf_offset()
>>>> I would prefer to rename the API at this time given there is only a single
>>>> user.
>>>>
>>>> Otherwise I would need to duplicate quite a bit in the test code to support
>>>> testing the single user of the old api and then enhanced API.
>>>> Or, I can leave existing API in place and change the test case to
>>>> just test the enhanced API to keep things simpler in the test code?
>>> If the new user is going to move to the API once available I will be
>>> happy to then leave out testing for the older API. That would make
>>> sense.
>> I have switched the single user of the existing api to the new
>> API in the patch already?
> Right, but in the new approach you'd use a newer function name with
> the new feature.

Yes, I will send a new version with a new function name.

firmware_request_into_buf() is more appropriate than 
firmware_request_into_buf_offset() though.

The function accepts both partial or full file requests with or without 
an offset into the file.

>
>> And both full and partial reads using the new API are tested with this
>> patch series.  If you really insist on keeping the old API for a
>> single user I can drop that change from the patch series and have the
>> old request_firmware_api call simply be a wrapper calling the new API.
> Yes please.
Sure, if you want me to remove the change to the existing qcom driver to 
keep using the old api as well I'll do so.
>
>>> But if you do want to keep testing for the old API, and allow an easy
>>> removal for it on the test driver, wouldn't a function pointer suffice
>>> for which API call to use based on a boolean?
>>>
>>> But yeah if we're going to abandon the old mechanism I'm happy to skip
>>> its testing.
>> We can skip right now then.  As enhanced API is a superset of old API.
>> If you want the old API left in place I can just add the wrapper
>> described and only test the newly named function and thus indirectly
>> test the old request_firmware_into_buf.
> Yes this makes sense. But I want to take a bit step back right now and
> think about this a bit more. I'm starting to wonder if this whole sysfs
> stuff should be replaced with a better scalable scheme. Consider all the
> fancy things you can do in userspace with a block device. Offsets are
> already supported, and so much more.

Yes, if normal file operations worked in kernel space all would be good.

> So I'm starting to think that the
> firmware fallback upload sysfs interface is much better suited as a
> really simple block device long term.
> I understand you want your solutions addressed upstream yesterday, but
> this is the *sort of review* on architecture that should have been
> done for the request_firmware_into_buf() long ago. But since you
> probably don't want to wait for a revamp of the interface, a middle
> ground might be in order for now, with the roadmap put in place to
> evaluate scalable alternatives.

Sounds very reasonable.

All I wish to do is request part of file into a pre-allocated memory 
location.

> Either way, we should consider the current bug you ran into for the
> solutions put forward, with the new functionality you are proposing.
>
> The core of the issue you ran into was the duplicate named kobjects,
> which are reflected also on the sysfs hierarchy. The directory name
> created for each firmware request, when duplicate entries exist for
> one device collide. Upon a secondary request for firmware using the
> fallback interface, the kobject/directory already exists.
>
> Its easier to understand this from a directory hierarchy perspective.
> For instance the test driver uses:
>
> /sys/devices/virtual/misc/test_firmware/
>
> The test script for the test_firmware driver uses:
>
> DIR=/sys/devices/virtual/misc/test_firmware/
>
> To load firmware we use a directory underneath this firmware name for
> the file name of the firmware requested, so to load firmware called
> $name on the test script we use:
>
> echo 1 >"$DIR"/"$name"/loading
> cat "$file" >"$DIR"/"$name"/data
> echo 0 >"$DIR"/"$name"/loading
>
> An issue no one has cared for, and also we have not hit yet is that,
> this implies no firmware names can be used which match other sysfs
> attributes exported by a driver. I'm not too concerned for this right
> now, but it is a worthy thing to consider long term under a new
> solution.
>
> So the issue is that the firmware loader will try to create two equally
> named entries underneath the firmware loader directory. Yes we can
> sledge hammer the API to act serially, but this is will just
> just move one problem to another, your secondary call would have to
> wait until the first one not only completes the call, but also
> release_firmware() is called.
>
> I'm looking at using a device name prefix if we do add a new API
> or functionality. This way userspace can expend and knows what
> extra tag to use other than the driver name.
>
>    Luis
