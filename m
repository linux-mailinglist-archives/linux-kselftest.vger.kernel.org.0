Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53630712D27
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEZTVp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZTVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 15:21:44 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509E13A;
        Fri, 26 May 2023 12:21:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6D0D860204;
        Fri, 26 May 2023 21:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685128900; bh=gdnV35r+qZer6ioSJSPnjms1VtPejxd0IlIT7RFCCbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IQ/qNCriuge2j3d/O+15dL1nZPwlXbH+pDg9rJjS16liWnpzqTXbR7RVINDaCWIjF
         jmqP1qNdOImAt6lNiPow4lUeUIP+IPnTsYv0OSUTObsWiXQBdf76Q1BPZKSmxi726f
         qmKBGTborb3ZPnQzRsDeX5ofYhGkevMRh7+UNE/HyMywPZI0xbNmdNA1I4HhlfwHF1
         VB6nX75KaEXWShSXkIqZZIWkCVDlCXWBKVt92xyXFlq/GeFzcJ1Ajw1XJTl5tNEEd7
         0dkZw8XQvEeNbzBC33JLKVPyXoLj4/abakkFtIoX9FwI+qGofhSI6uXOhvKg4ljcPn
         G8BaBKky+fevw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EjSdx_xuliag; Fri, 26 May 2023 21:21:38 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id EE76A60203;
        Fri, 26 May 2023 21:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685128898; bh=gdnV35r+qZer6ioSJSPnjms1VtPejxd0IlIT7RFCCbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W9FRbhl898RDurbIWAG9elsTFrdcuRfZcsxKAIHKgpgJqhBCwFuf1NlyfZnpB6ojj
         PY0aBzU9IVi0yfT2ZO78/7KNaqzOvmsTuzoI4SgEDU2ZZQvxsxpFEoi882VNIG6GuP
         Jc+D6Tv4ca2y0hwq7l/HMaoIATrcAswvWxt0yGSlK6NSw1EF4szHWzZjwVo927hBJi
         2zSiAxrDTqvNYIOYnx1jVHgr9+gXrLxbqMnLq4efex86sixX8cTZdXX8D1iP04BkZV
         MKjNbKNyGn/hDL+WgFF9J5KoH9i5G649CVKQ5ru7rlX2JHY6ow/PkacpRId2n/esWO
         p/wjtDeu1AIOA==
Message-ID: <8412fb0f-4b7c-b305-0947-ae68701bad20@alu.unizg.hr>
Date:   Fri, 26 May 2023 21:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
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
 <ZG2h34KzhQWONNec@bombadil.infradead.org>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZG2h34KzhQWONNec@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/23 07:34, Luis Chamberlain wrote:
> On Thu, May 18, 2023 at 06:20:37PM +0300, Dan Carpenter wrote:
>> On Fri, May 12, 2023 at 08:58:58PM +0200, Mirsad Goran Todorovac wrote:
>>> On 12. 05. 2023. 15:09, Dan Carpenter wrote:
>>>> On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
>>>>>> @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
>>>>>>     	mutex_lock(&test_fw_mutex);
>>>>>> +	if (test_fw_config->reqs) {
>>>>>> +		rc = -EBUSY;
>>>>>> +		goto out_bail;
>>>>>> +	}
>>>>>> +
>>>>>>     	test_fw_config->reqs =
>>>>>>     		vzalloc(array3_size(sizeof(struct test_batched_req),
>>>>>>     				    test_fw_config->num_requests, 2));
>>>>>
>>>>> I was just thinking, since returning -EBUSY for the case of already allocated
>>>>> test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
>>>>> to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
>>>>> understood well, the CoC requires that I am explicitly approved of those?
>>>>>
>>>>
>>>> If everyone else is okay, let's just apply this as-is.  You did all the
>>>> hard bits.
>>>>
>>>> regards,
>>>> dan carpenter
>>>
>>> If it is OK with you, then I hope I have your Reviewed-by:
>>>
>>
>> Wow.  Sorry for all the delay on this.
>>
>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>>
> 
> Thanks for doing this work! It looks much better now split up!

No problem. It's a great exercise for the little grey cells :-)

> For all 3 patches:
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks,
Mirsad

> Greg, can you pick these up?
> 
>    Luis
