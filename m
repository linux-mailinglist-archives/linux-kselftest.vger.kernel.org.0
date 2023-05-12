Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3720F700F1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjELS7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbjELS7b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 14:59:31 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD910F1;
        Fri, 12 May 2023 11:59:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2B3976016E;
        Fri, 12 May 2023 20:59:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683917966; bh=hCGxLmUFNgBLRFy5cKEjS0qJFgAEMpLY3ZFobzHgQzk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pHa2nKCJXE8rKIRkLbbUPjaMMGMp7nFmYiHF8Ea4FuaXAEsA7xvcCFENNf/k7frQY
         2HHEiRnDRpaxKFQtlhQexKjczH0ZQYPMsEdwyT3XUroZGUnBJZ07Yg+IpKAgr5qh82
         jzuDELzGnAgUSjmHaE97uiPmOumfecOYHy4yd4dFTa9KbMLc3zQMDPJmHlYmVPM67D
         r2jTCZybVlWZhBSFd2MZNajUsH3TjrE9aynCME2cQRi3uX5wMDEi53kSz/UbQUUwxI
         Iu48sDg3L0USN/VGvLqTuINvu9+55dX4CS7p9zNi+x4Y5KbC+gqRzyVaYnZZZW25/C
         CZW7IF+s/BNow==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SlCievW2rv7D; Fri, 12 May 2023 20:59:23 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 02A906015F;
        Fri, 12 May 2023 20:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683917963; bh=hCGxLmUFNgBLRFy5cKEjS0qJFgAEMpLY3ZFobzHgQzk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PmGyGbpovByG81R4WyAQ+UdFoqhvJywvMH3h/5iNm3J1k7UkB4Zu9K8ARFj5XjtzW
         xh5WJd+RPMw7Yz+5v97akb9ywS/2OSFbz1JyGdFArYzRtKbfNjSizDpUiC+5E1X33u
         5pDJoEIm2WQ8Sv3vwBWxlpNtjMoywMH1+hB6xz6uPLUzSRiVfoUZkD92W/Mw2zwUMs
         17T/jfjlsw64ME82Wo0Op8fTrCfTkAoilXjMCUimUL8hX4vc7cXlYtNKWhUOFHgc++
         I77VTa21FQ5U8wUaSjN7AW0boe6e66BVxG38fDBJfc6O6tZuIZ4ysHS+1eB2AwMHXx
         CFghmz4SRmIjw==
Message-ID: <72257758-a0e6-1118-f397-431ac9ec3059@alu.unizg.hr>
Date:   Fri, 12 May 2023 20:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
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
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12. 05. 2023. 15:09, Dan Carpenter wrote:
> On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
>>> @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
>>>    	mutex_lock(&test_fw_mutex);
>>> +	if (test_fw_config->reqs) {
>>> +		rc = -EBUSY;
>>> +		goto out_bail;
>>> +	}
>>> +
>>>    	test_fw_config->reqs =
>>>    		vzalloc(array3_size(sizeof(struct test_batched_req),
>>>    				    test_fw_config->num_requests, 2));
>>
>> I was just thinking, since returning -EBUSY for the case of already allocated
>> test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
>> to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
>> understood well, the CoC requires that I am explicitly approved of those?
>>
> 
> If everyone else is okay, let's just apply this as-is.  You did all the
> hard bits.
> 
> regards,
> dan carpenter

If it is OK with you, then I hope I have your Reviewed-by:

I'm kinda still uncertain about the proper procedure.
This certainly isn't "the perfect patch" :-)

Best regards,
Mirsad
