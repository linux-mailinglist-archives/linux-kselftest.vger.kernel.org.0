Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68647087D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjERSbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjERSbi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 14:31:38 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F61B7;
        Thu, 18 May 2023 11:31:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B0DA26018D;
        Thu, 18 May 2023 20:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684434686; bh=0oJ4YCO88gzA0yTmzaP8u075b2EyxCkSEeLLi9AmBa4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HZvFuPVCt4qtBFdIAt8SUI7JJQLU1YOH5j+fJEv4z7Tx9m704WZU26Jg+y8r3q/UN
         MCmegXojGsTUrU+vUMjYtYp2r/iA5AniqD296rLqQuiJbpSLlR+VWzP5nNMqfZzQV7
         9cKq1pTTPFKxi6eWymnX8Z3nBp7IAoJ/pdakdtcrvUME3FKWQJJkCXXa4f11h4ej98
         xDL+2redqTx4VktRi4fsFHJ/7ZqiCa/uV1FaTo5x/OVU4RwePghHoeSv8z6HxZKVMZ
         l47J5jMjo0IL3Mvnb2GK1CEHznbOnZdNBoA/ePO21U86aQAc82hKpvBNjTrBtzR/Fy
         3lVtI/xHElymQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YMIZ_9KlD99u; Thu, 18 May 2023 20:31:24 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 1610760189;
        Thu, 18 May 2023 20:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684434684; bh=0oJ4YCO88gzA0yTmzaP8u075b2EyxCkSEeLLi9AmBa4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ToeVBV+tOvfUV2HezSMYX9n0OYRLpndKIOe3XEF3V9zb3chYoJGfIKc0SuHYE1e59
         3AgIGK2im0b/oZ6iHPaJOl3zjhBjnkk0MWwWkI/aD4oHgsTCLYrUjRXOprASwx37Cu
         e9lkB0zaui9+nxA5LE+t/8Wnl1ojPuKVh6LIqb6yVzujcurwRWEn1f10vFZsJH60pY
         8gTLv0xYFcKkAWYL9JicUXTUmVENayGUR5yL7ZQWKtduVoK9/GGjZTyP2P81vsYGzp
         SIbrzfbIj8+kxT8SiJ1qvYLDEjkU+MvWUI1ab72V8ayJJ8w7PkUjMJQfowj3w4KkxJ
         VrVt+0neVdZog==
Message-ID: <f8f3b769-9819-852e-682e-54cbddfdd1fd@alu.unizg.hr>
Date:   Thu, 18 May 2023 20:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
 <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
 <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
 <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
 <72257758-a0e6-1118-f397-431ac9ec3059@alu.unizg.hr>
 <828b1d4c-dac8-4a64-9f1d-452762dc07bd@kili.mountain>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <828b1d4c-dac8-4a64-9f1d-452762dc07bd@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/23 17:20, Dan Carpenter wrote:
> On Fri, May 12, 2023 at 08:58:58PM +0200, Mirsad Goran Todorovac wrote:
>> On 12. 05. 2023. 15:09, Dan Carpenter wrote:
>>> On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
>>>>> @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
>>>>>     	mutex_lock(&test_fw_mutex);
>>>>> +	if (test_fw_config->reqs) {
>>>>> +		rc = -EBUSY;
>>>>> +		goto out_bail;
>>>>> +	}
>>>>> +
>>>>>     	test_fw_config->reqs =
>>>>>     		vzalloc(array3_size(sizeof(struct test_batched_req),
>>>>>     				    test_fw_config->num_requests, 2));
>>>>
>>>> I was just thinking, since returning -EBUSY for the case of already allocated
>>>> test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
>>>> to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
>>>> understood well, the CoC requires that I am explicitly approved of those?
>>>>
>>>
>>> If everyone else is okay, let's just apply this as-is.  You did all the
>>> hard bits.
>>>
>>> regards,
>>> dan carpenter
>>
>> If it is OK with you, then I hope I have your Reviewed-by:
>>
> 
> Wow.  Sorry for all the delay on this.

No, not at all. I don't want to be a nag and overwhelm developers. :-)

> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you.

I suppose this is for 2/3.

Did you consider reviewing the other two patches?

>> I'm kinda still uncertain about the proper procedure.
>> This certainly isn't "the perfect patch" :-)
> 
> Heh.
> 
> regards,
> dan carpenter

Well, I have about come to the limits of CONFIG_DEBUG_KMEMLEAK setting,
with a happy catch of about a dozen bugs, but this is still less than 
0.1% of the expected 11,000 bugs for a codebase sized 10.9 million line.

So I am considering the use of a static analysis tool. Like Smatch.

Thank Heavens, most of the code is modular, and about 90% of the
functions are static and thereof, of course, having the scope limited
to their module.

I am still only catching bugs like memleaks and lockups when they
manifest, proactive search for bugs is a new level I suppose.

Best regards,
Mirsad
