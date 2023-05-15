Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FB70240D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjEOGG0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 02:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEOGFq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 02:05:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9349F2;
        Sun, 14 May 2023 22:58:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f4c8eso311236766b.0;
        Sun, 14 May 2023 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684130300; x=1686722300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPQtZOXsXDtCauwTHNXvzScss6wN7/6B+b24lKETaGY=;
        b=VK/SJmfFZupbAd5/+2FwqSOo5GZXg1tMePpH0B9ihJg7i9s70UKRXN7pjr/rJ+Ccti
         vDMxqrkXkt2ev2XIK4l2mpLHAHjNmU9K7T/uZxBGLj3v5x2XFtIGmbNf7p8ROYWbB70E
         7bHRbQmqKhYQAAILyh20N/DkDwZBvCBmPJHG2xYwKzFmZEkrVWZm1jy8VlCvRafH6wEA
         UUqUCKsFqg7uO5fHNlVnznb9KkCr54n0Yijsf0i+1SiIzMzy4Vmh/jl67rkwWBQLpiYk
         Xu3s9GH1cMXUwp6himyLZGzdYFCgJ4839KyyRUI4p81baVKpY8KqzejeZkN+wCbhkKrx
         AC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684130300; x=1686722300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPQtZOXsXDtCauwTHNXvzScss6wN7/6B+b24lKETaGY=;
        b=eB0EsS5kDmGT9gw7rZredhyBE2IS2Dlx4sdQt7okdGX6D6ff/aMrL4ShCjfImqmZ4t
         vAKhAnh6WEc5pkr5JmC9j6diATZXWknQIdEbOmO9n8YJZr32sEXrmPDKO5osEPxfui6g
         K8IbW11ScMovktn2UEDMbNXQFHjg6SaL1Q9BqC+0SOHzsXs9JwhG2WMb6CapV/L6r5MC
         9wdT2hDSTTBFsb564Z/DV+gQX4ewdOgilJaPAx16+UTdljqkMV83x/AepnLeYuFvTSs2
         Lmh9lq1+khBVV8t/1Fh25QfI2otbaqznJsKJdXWZvCQTbfe1x9PA0h+yWXPFk2to0Mks
         qF2g==
X-Gm-Message-State: AC+VfDxQQJSx2uHGzgYXwFkunyLRxaLUpxbtRLs5xPxikCi5E9goK/1C
        DMRwKwuV2OpRXqY60sq9A74=
X-Google-Smtp-Source: ACHHUZ6nMW9a0P1Ql/uFkqv12DRTC4hSCe3KL6gtMdm1+0pa5miAPoRV2RKERnYzaZnI/EEomTYr/g==
X-Received: by 2002:a17:906:1051:b0:966:1f60:fd32 with SMTP id j17-20020a170906105100b009661f60fd32mr5945505ejj.6.1684130300277;
        Sun, 14 May 2023 22:58:20 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id de47-20020a1709069bef00b0096b20c968afsm1464579ejc.124.2023.05.14.22.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 22:58:20 -0700 (PDT)
Message-ID: <9a76e550-fd1e-851c-e322-4bf51ab11e97@gmail.com>
Date:   Mon, 15 May 2023 09:58:18 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] selftests: ALSA: Add test for the 'valsa' driver
To:     Mark Brown <broonie@kernel.org>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
 <20230513202037.158777-3-ivan.orlov0322@gmail.com>
 <ZGGKwA10shGGUr87@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <ZGGKwA10shGGUr87@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 05:28, Mark Brown wrote:
> On Sun, May 14, 2023 at 12:20:37AM +0400, Ivan Orlov wrote:
> 
>> +uid=$(id -u)
>> +if [ $uid -ne 0 ]; then
>> +	echo "$0: Must be run as root"
>> +	exit 1
>> +fi
> 
> It is not an error to run the selftest as a non-root user, the test
> should be skipped.

Alright, thanks!
>> +modprobe snd-valsa
> 
> We don't check if the module was already loaded.
> 
>> +if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
>> +	mount -t debugfs none /sys/kernel/debug
>> +
>> +	if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
>> +		echo "$0: Error mounting debugfs"
>> +		exit 4
>> +	fi
>> +fi
> 
> This will unconditionally attempt to mount debugfs in a standard
> location and won't clean up after itself, if the system didn't have
> debugfs mounted for some reason then this will leave it sitting there.

Yes, I agree... I'll remove this in the future versions, I think the 
approach with skipping in case of missing debugfs would be better.

By the way, I used the 'fpa' test as an example, and it looks like it 
should be fixed as well...

> Would it not be better to have a C program that actually calls the ioctl
> rather than a custom debugfs thing that may or may not be wired up to do
> the same thing as an ioctl would?  It seems like other than whatever
> this ioctl test actually does this is all just a simplified version of
> the existing pcm-test.

Well, the idea was to test the playback buffer consistency - the driver 
has the functionality of testing the playback buffer for containing the 
looped pattern (and if the buffer doesn't contain the looped pattern the 
test fails). So, firstly we get the capture buffer with this pattern 
(via arecord), and then send it to the driver for the test (via aplay).

The pcm-test (as I understand) performs only time checks, not the checks 
of the data played/captured, and I think it is pointless to test the 
time again. But I agree, that C test implementation would be better - 
using this approach I can perform additional buffer checks and cover 
more functionality of the driver.

Thank you very much for the review!

Kind regards,
Ivan Orlov.
