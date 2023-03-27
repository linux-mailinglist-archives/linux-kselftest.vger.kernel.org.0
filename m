Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A829F6CA3EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjC0MWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjC0MWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 08:22:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB176A7;
        Mon, 27 Mar 2023 05:20:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x20so8771325ljq.9;
        Mon, 27 Mar 2023 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679919607;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWnunhEsuJEWbwQ8zih8owiESZ1bj98jfmJyeLipbGk=;
        b=AXp7pDNSgF/hf5SpY/lR8BFw972fobQ4ucdzAs4gZllepquz9kr8JIoNK4JIVDOnlL
         Gtb0k2fPEzzyoqAhFHDaWYCwcwMPbD1Uw172EIgKRQZ7hmK54jGQuOEIjuleTe3L7qbD
         iuBjx0ZuwpABuB8KYkFeNFLuwGzhzb1E9XKYN7BWzu8ost7ZA1XiX5AkKuUECv7jAxar
         B5MAbo1F3Df0kmbPyUBDUwjpqEHWotgx2fXER3NKdNVTBg0fIizc0vnj7d11UGQnCY3A
         EBL5aAU8jNK+TvCMtFIA3V2zK0jNiAGJe1EctsWvMwny3ZaVY+g7S/Ve2o1gafBoOUzt
         EuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919607;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWnunhEsuJEWbwQ8zih8owiESZ1bj98jfmJyeLipbGk=;
        b=4plT/w2UnEs7VLIsn2CowtdkLN0UUjsfAJCQlH0fNgSX/if2fGPyhmSHB1JekLrx8/
         yOU7KFd1pYo+TKDkPTSQ4LiXDJBeq52tHiWeJi78xEI//4HUOgmIQtozWGe9tAygDGEd
         8+wI21u/rkkWzW5/eAZC3vJIoGxLOZ+ySe/87xT7OoZK+WXr8o4OaUbGQSElYu/t9h8K
         8fm+3QrKk44/I+Fu1IKDir2LvValIPzY9bSvt8bLN4FmwpInLxzYlNoUAMK1TeG5PpAF
         ztYdYGJTl3Hu1Tbg4C1oKP2n+r6DSb6v1ocqREKJQC3oYpkMQmagySqLcsDdoiaJyYAO
         khxQ==
X-Gm-Message-State: AAQBX9dYX4i3EV7W2IVgEkm+K0LxQx583Pgd1FVV0tMb0cvcWq5baQBc
        Rku+FIG834ddTKaTJSKkJrc=
X-Google-Smtp-Source: AKy350aACm+hxMqa7cx0UuE3GRhQRJAiENJpqRKWCphlLXDPKfpyDpuDZxL6LFfl5DDpesy55tcQWw==
X-Received: by 2002:a2e:86d5:0:b0:29f:e144:6c6a with SMTP id n21-20020a2e86d5000000b0029fe1446c6amr3270748ljj.23.1679919607681;
        Mon, 27 Mar 2023 05:20:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002934d555783sm4597346lji.6.2023.03.27.05.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 05:20:07 -0700 (PDT)
Message-ID: <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
Date:   Mon, 27 Mar 2023 15:20:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device
 creation
In-Reply-To: <ZCGFgypeuJXqNwQt@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/23 15:01, Greg Kroah-Hartman wrote:
> On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
>> A few tests need to have a valid struct device. One such example is
>> tests which want to be testing devm-managed interfaces.
>>
>> Add kunit wrapper for root_device_[un]register(), which create a root
>> device and also add a kunit managed clean-up routine for the device
>> destruction upon test exit.
> 
> I really do not like this as a "root device" is a horrible hack and
> should only be used if you have to hang other devices off of it and you
> don't have a real device to tie those devices to.
> 
> Here you are abusing it and attempting to treat it as a real device,
> which it is not at all, because:
> 
>> Special note: In some cases the device reference-count does not reach
>> zero and devm-unwinding is not done if device is not sitting on a bus.
>> The root_device_[un]register() are dealing with such devices and thus
>> this interface may not be usable by all in its current form. More
>> information can be found from:
>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
> 
> See, not a real device, doesn't follow normal "struct device" rules and
> lifetimes, don't try to use it for a test as it will only cause problems
> and you will be forced to work around that in a test.

Ok. I understood using the root-device has been a work-around in some 
other tests. Thus continuing use it for tests where we don't need the 
bus until we have a proper alternative was suggested by David.

> Do the right thing here, create a fake bus and add devices to it.
> 
> Heck, I'll even write that code if you want it, what's the requirement,
> something like:
> 	struct device *kunit_device_create(struct kunit *test, const char *name);
> 	void kunit_device_destroy(struct device *dev);

Thanks for the offer Greg. This, however, is being already worked on by 
David. I don't want to step on his toes by writing the same thing, nor 
do I think I should be pushing him to rush on his work.

> Why do you want a "match" function?  You don't provide documentation
> here for it so I have no idea.
> 
> Anything else needed?
> 
>> The use of root-devices in the kunit helpers is intended to be an
>> intermediate solution to allow tests which do not require device to sit
>> on a bus avoid directly abusing the root_device_[un]register() while
>> proper kunit device solution is being worked on. Related discussion can be
>> found from:
>> https://lore.kernel.org/lkml/CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7FtA-dTQ@mail.gmail.com/
> 
> Again, no, please let's not get this wrong now and say "we will fix this
> later" as that's not how kernel development should work...

Ok. In that case I need to drop the tests from the series until we get 
the new APIs in place. It really sucks but I guess I understand the 
rationale for not wanting to "intermediate" solutions merged. Yes, I 
hoped it'd be Ok as David is already working on it - but I was still 
kind of expecting your response. This is why I made it very clear in the 
cover-letter and this commit message what is suggested here.

Jonathan, should I re-spin the series without patches 3/7 and 5/7 or can 
you please review this and I'll just drop those for the next version?

Thanks for the review Greg, I think this case is now "closed".

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

