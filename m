Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78444616019
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKBJl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKBJly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 05:41:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF122BC4
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 02:41:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 4so16079841pli.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZjjsfhVpVmcKXTEAXNtkm7mljVLUHPV6/kXC2ILvLk=;
        b=adDXi8Yok5j/QS1Hd0PWyyALEH6R9tJTsIbSAWlQ/AXtawOjzK452sQCf1g9NHbd0t
         X93cZ4qPH//xgANbOAwuONnYWtpVmnhQJ2cAGZy0NpekfVrFZpOLpdsmzbX/It4MCQ3f
         bsWrjcjWIHmzlMmOeRWYWhBzs/1dZCD3V+xs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZjjsfhVpVmcKXTEAXNtkm7mljVLUHPV6/kXC2ILvLk=;
        b=AYNduZ/djnJPt1cweJmqqrMSp7qIdq7h2Ngz5xwOJTuZyXQYVPvwJL9+8vmYMvlyab
         DHd8PdJG93JHDUzapspuYWx3DV4eWGSvZ76k7UuTVYhjyoRTwfcvOmplvSTrHg2ryTYm
         sy62g4aclclFkAbnFBC9VL68cv1mEchAOSwP2ixNey43bAQ98r65FIl/Hk5LDUrWsjUq
         9ohSNOJApq3+eNAhKXRijZugkcPIjXDE1wJM0z7AW70q0iTAeoyoLRHde/TiMKqZ2u5L
         ciswPsmzNB1C2K4uhymZu2h6SnQHFbANfldg6Dyn20Cg8cv9IU6I6MF9029TyKqDppId
         MTWw==
X-Gm-Message-State: ACrzQf1+d+/6vg04d9HPD7tvg396+9HlEfTHlID2GufudusHJBuaXSd2
        T0212X7JsQLO2wXk2OFzRcPu2g==
X-Google-Smtp-Source: AMsMyM52YklWkHCnOHxtQRQyhs05T/jj5R+sIap/eItkZFEUIuRECDv4bxs6he5KZD3NLJVtrqKUPA==
X-Received: by 2002:a17:90a:e545:b0:213:9c27:cded with SMTP id ei5-20020a17090ae54500b002139c27cdedmr7680602pjb.208.1667382111831;
        Wed, 02 Nov 2022 02:41:51 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id 3-20020a620403000000b0056da2bf607csm4326244pfe.214.2022.11.02.02.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:41:51 -0700 (PDT)
Message-ID: <39586b57-aad2-d9ca-df12-67f1dfe60258@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:41:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 03:43, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if there is
> an error occurs or such as a SIGINT signal is received, the parent
> process will be terminated immediately, but the child process will not
> be killed and also umount_resctrlfs() will not be called.
> 
> Add a signal handler like other tests to kill child process, umount
> resctrlfs, cleanup result files, etc. when an error occurs.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>   tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++++-------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..5f81817f4366 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -98,12 +98,21 @@ void cat_test_cleanup(void)
>   	remove(RESULT_FILE_NAME2);
>   }
>   
> +static void ctrl_handler(int signo)
> +{
> +	kill(bm_pid, SIGKILL);
> +	umount_resctrlfs();
> +	tests_cleanup();
> +	ksft_print_msg("Ending\n\n");

Is there a reason to print this message? Remove it unless it serves
a purpose.

> +
> +	exit(EXIT_SUCCESS);
> +}
> +
>   int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   {
>   	unsigned long l_mask, l_mask_1;
>   	int ret, pipefd[2], sibling_cpu_no;
>   	char pipe_message;
> -	pid_t bm_pid;

Odd. bm_pid is used below - why remove it here?

>   
>   	cache_size = 0;
>   
> @@ -181,17 +190,19 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   		strcpy(param.filename, RESULT_FILE_NAME1);
>   		param.num_of_runs = 0;
>   		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		/* set up ctrl-c handler */
> +		if (signal(SIGINT, ctrl_handler) == SIG_ERR ||
> +		    signal(SIGHUP, ctrl_handler) == SIG_ERR ||
> +		    signal(SIGTERM, ctrl_handler) == SIG_ERR)
> +			printf("Failed to catch SIGNAL!\n");

Is perror() more appropriate here?

>   	}
>   
>   	remove(param.filename);
>   
>   	ret = cat_val(&param);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_results(&param);
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		ret = check_results(&param);

Why not use a goto in error case to do umount_resctrlfs() instead of changing
the conditionals?

>   
>   	if (bm_pid == 0) {
>   		/* Tell parent that child is ready */
> @@ -201,7 +212,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   		    sizeof(pipe_message)) {
>   			close(pipefd[1]);
>   			perror("# failed signaling parent process");
> -			return errno;
>   		}
>   
>   		close(pipefd[1]);
> @@ -226,5 +236,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   	if (bm_pid)
>   		umount_resctrlfs();
>   
> -	return 0;
> +	return ret;
>   }


With these changes made:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
