Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E7615FAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiKBJ2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKBJ1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 05:27:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187A2BE6
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 02:27:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id io19so16010127plb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tig2lIwdCA6JHTxsTU+TQaIXl+F0LsrnT5B9kKYjmGM=;
        b=UfmqGin2l/Z2euAUtGeMyjYjWDvj+JP3yxy184yGkC4BcGbQ00r38NO326fvy+4D4Q
         xExoTKA00rCLYzZ43hdcvBBAX6t5DiqdrJIVXrdpoXC8KuXHUBKpLfXnHRQVaQqK1keb
         dzDOghZmgHKeYwJGW7GjqjOsBPkXV38qFgE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tig2lIwdCA6JHTxsTU+TQaIXl+F0LsrnT5B9kKYjmGM=;
        b=bO0cazwJUXpAL7lUbsYz7Kv+hH82s4l2V/gYyGpaoqBnWMKuCewoag8DSHlpO1rcxT
         J3vjxtItjdsnXEW6GwvKscGCHmvm9t9z7pi56mwZlRKKCerWJ0BSKO7o/VflO9FWMtzZ
         6C40oA+3DYG9XyEAfRb+NxQGnKfvQgiB3/++iJKmgzXZNnHw0NKoD9nXH0IMDhs+JuGP
         M6gjamGImKvjjb6BNO1XYF+Q/7KyyCB17RcWYZKUJpIrvdE3Aye0iQAapLqWS0JdK+3f
         cdmfbV3COFLcohsb2vNBRH1vxqvA56gaRPKAmNG0IkM97hrkKJDFTcC925wncQHwWsUV
         CJ5w==
X-Gm-Message-State: ACrzQf0nLml2QzS/FYzN/plp+SK04nfXJwus0fSff9LnkcSNS+jZUbh2
        htasemCviHZHTStFZnURPM+wrw==
X-Google-Smtp-Source: AMsMyM6/+HMLV2bJylWsJLlfhWSxo5sVsqDjCrok+HHs+xbzWZtkQ3xcCh4Xb8pJk+IUUEygyTjHww==
X-Received: by 2002:a17:902:cccd:b0:187:733:35d1 with SMTP id z13-20020a170902cccd00b00187073335d1mr22002052ple.26.1667381253581;
        Wed, 02 Nov 2022 02:27:33 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id o68-20020a62cd47000000b0056283e2bdbdsm7964981pfg.138.2022.11.02.02.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:27:32 -0700 (PDT)
Message-ID: <71707e1f-8805-d6c7-6a35-c74a5655d6cd@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:27:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Return MBA check result and
 make it to output message
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-3-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101094341.3383073-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 03:43, Shaopeng Tan wrote:
> Since MBA check result is not returned, the MBA test result message
> is always output as "ok" regardless of whether the MBA check result is
> true or false.
> 
> Make output message to be "not ok" if MBA check result is failed.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/mba_test.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 1a1bdb6180cf..5d14802add4d 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -51,7 +51,7 @@ static int mba_setup(int num, ...)
>   	return 0;
>   }
>   
> -static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
> +static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   {
>   	int allocation, runs;
>   	bool failed = false;
> @@ -97,6 +97,8 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   		       failed ? "Fail:" : "Pass:");
>   	if (failed)
>   		ksft_print_msg("At least one test failed\n");
> +
> +	return failed;

Rename "failed" to "ret" - naming the variable "failed" is confusing.

>   }
>   
>   static int check_results(void)
> @@ -132,9 +134,7 @@ static int check_results(void)
>   
>   	fclose(fp);
>   
> -	show_mba_info(bw_imc, bw_resc);
> -
> -	return 0;
> +	return show_mba_info(bw_imc, bw_resc);
>   }
>   
>   void mba_test_cleanup(void)

With that change,

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
