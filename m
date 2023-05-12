Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99D700827
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjELMfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbjELMfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 08:35:42 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D059E4;
        Fri, 12 May 2023 05:35:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 64B9A6016E;
        Fri, 12 May 2023 14:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683894872; bh=fzfxdz/vBCcOKARd0lBFdTTZ1RYjN1i3Sj9A9J+SMM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SN6hpz0KM0CLVgV8LHgROGgKcmmapOI9iQYNMHOopBHm08Z9d9pfWens/mcuwSWgf
         pZoOmDyu/JbGXLLUnUuXqe5SpOmHYYsOLHYQi1fECGcLM6uV5aGV0O62zQJEDhN3gC
         Fj/UMpJ7XADpjS/oNrV6/Piu39ey6Umrtg29nSMNG1U1aduv+wq0q27qvGmoRjNuXY
         7hdpNfLvhSGey7e4rVX7vR+ZCUDzgPFQ4mhuhT8XPeoiii7/3PTNp+qYvIz5+Pq757
         aBZXdzjlQaZe9+nbZtGbMrPU7rrnEjebwQ0C2c+ebSYErU2z4L4hToSx0Jqz13YLat
         +ecLBiUCRJi5w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zB8X5WPY8Rvp; Fri, 12 May 2023 14:34:30 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 957A66015F;
        Fri, 12 May 2023 14:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683894870; bh=fzfxdz/vBCcOKARd0lBFdTTZ1RYjN1i3Sj9A9J+SMM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BlPmARJNufsb4Q2WPtjEkK5RMDeMBg6/erj9qiLfQp1GZ0cis9SP5bnrFivbhIvRS
         TKWDSZIUwoaoULUJeI+D/z0VbCn/3rkdE56v1qunFQ0wUkNhVW+XrnJw+NznRTB6qH
         blTyJflSVjR32V2qgzS5BgB0QRpjoOyvCJ9KADqs7ZkrzUUkDB6sXOoQk369IerjEs
         kKbTKqv6MJfcYScQ60798rt59fIf1qdtFqiOmma/yhq+QDsdXcm1ZTUj08iYGsGx5C
         1JJodtWAng7HMNc3PBVMdtSY00NMGKZlirI6ACPhYtuEVC3+Zx5M7WsJOScrKMEmDV
         DlvYMFloFwa1Q==
Message-ID: <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
Date:   Fri, 12 May 2023 14:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
Content-Language: en-US, hr
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan,

On 5/9/23 10:47, Mirsad Goran Todorovac wrote:
> Dan Carpenter spotted that test_fw_config->reqs will be leaked if
> trigger_batched_requests_store() is called two or more times.
> The same appears with trigger_batched_requests_async_store().
> 
> This bug wasn't trigger by the tests, but observed by Dan's visual
> inspection of the code.
> 
> The recommended workaround was to return -EBUSY if test_fw_config->reqs
> is already allocated.
> 
> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: stable@vger.kernel.org # v5.4
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>   lib/test_firmware.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 35417e0af3f4..91b232ed3161 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -913,6 +913,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
>   
>   	mutex_lock(&test_fw_mutex);
>   
> +	if (test_fw_config->reqs) {
> +		rc = -EBUSY;
> +		goto out_bail;
> +	}
> +
>   	test_fw_config->reqs =
>   		vzalloc(array3_size(sizeof(struct test_batched_req),
>   				    test_fw_config->num_requests, 2));
> @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
>   
>   	mutex_lock(&test_fw_mutex);
>   
> +	if (test_fw_config->reqs) {
> +		rc = -EBUSY;
> +		goto out_bail;
> +	}
> +
>   	test_fw_config->reqs =
>   		vzalloc(array3_size(sizeof(struct test_batched_req),
>   				    test_fw_config->num_requests, 2));

I was just thinking, since returning -EBUSY for the case of already allocated
test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
understood well, the CoC requires that I am explicitly approved of those?

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
