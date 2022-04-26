Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3346E5101CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbiDZPZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352334AbiDZPZd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 11:25:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC20BE13
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 08:22:21 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z26so2091264iot.8
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cuUc2xoUdcusYuxjPdEemxe0UNLqKWIyVIlb0000qns=;
        b=QGqDycSpps1eWGDw6i+/PLvWV/1ssbWDef/meMng+TM1+EOjoXaBjNS1UhqPSVghFJ
         CLQ3GitILHh8j/g+1ZW9jFPosj4H0B2uxSxNBBjZlrPSGvcejiCi+IVzMINRgjErRQ3A
         vzaux1hFD+39PDEb336qsqQzmhLlxQfFeL7nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuUc2xoUdcusYuxjPdEemxe0UNLqKWIyVIlb0000qns=;
        b=B8bKKUf08MS3JOLCyzyrrMUX2CyEpMnLyp5rf801m4pC6wi4jwyOpYK/l/N8FNuPf6
         gmzTtDEsnNLR1Of76chpWGJejTq0jqqFaov3O/BDmQ1ABQmsaYx3bxeKaPsGSWr1svQz
         9HcDLvKJ6hun/JOdtktrR11u7jlIHjWfw9Inh7f5kpLDCnR6tMz+wiLK8Rihk5lg/Bhc
         qTf3fuGQhC2y9XnS+qp18rqECwj1zl9Mn/Udqv+wBjZiCytaZBmPIcP3Hioy8K/bBTQP
         5xg1mx9AdQmMbp74EQCV0C0GpLDG9cwTuSXI2/rxQ4XrBfjrrjSaMLhJEZGJCS/stBoX
         vgSg==
X-Gm-Message-State: AOAM533SYOcBjjWORl/i9CblBwQ8+rC6mLSD2zfxdf5GuHBAhUhBYz7Y
        ZSuRXq7NeqLK/SjMnx/lby9TJA==
X-Google-Smtp-Source: ABdhPJw6/39kt+AkHmRqI0UfjPCWfFn4VCLbOGq0QHMTSobHN6hPb0rHONYxdmyZLKkU6FSTEZWcBw==
X-Received: by 2002:a05:6638:25c3:b0:323:9914:c34f with SMTP id u3-20020a05663825c300b003239914c34fmr10887023jat.130.1650986541169;
        Tue, 26 Apr 2022 08:22:21 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s10-20020a92d90a000000b002cd7294db60sm8247970iln.20.2022.04.26.08.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:22:20 -0700 (PDT)
Subject: Re: [PATCH][V2] selftests/resctrl: Fix null pointer dereference on
 open failed
To:     Colin Ian King <colin.i.king@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220426122531.1506634-1-colin.i.king@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1d0b168a-8fe3-0b44-5e72-77e90d1f9ebb@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 09:21:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220426122531.1506634-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/26/22 6:25 AM, Colin Ian King wrote:
> Currently if opening /dev/null fails to open then file pointer fp
> is null and further access to fp via fprintf will cause a null
> pointer dereference. Fix this by returning a negative error value
> when a null fp is detected.
> 
> Detected using cppcheck static analysis:
> tools/testing/selftests/resctrl/fill_buf.c:124:6: note: Assuming
> that condition '!fp' is not redundant
>   if (!fp)
>       ^
> tools/testing/selftests/resctrl/fill_buf.c:126:10: note: Null
> pointer dereference
>   fprintf(fp, "Sum: %d ", ret);
> 
> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> V2: Add cppcheck analysis information
> 
> ---
>   tools/testing/selftests/resctrl/fill_buf.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 51e5cf22632f..56ccbeae0638 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -121,8 +121,10 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
>   
>   	/* Consume read result so that reading memory is not optimized out. */
>   	fp = fopen("/dev/null", "w");
> -	if (!fp)
> +	if (!fp) {
>   		perror("Unable to write to /dev/null");
> +		return -1;
> +	}
>   	fprintf(fp, "Sum: %d ", ret);
>   	fclose(fp);
>   
> 

Thank you. Applied to linux-kselftest next for Linux 5.19-rc1

thanks,
-- Shuah
