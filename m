Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388574F8799
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 21:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiDGTDM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiDGTDL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 15:03:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09322C6E5
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 12:01:06 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q11so7971531iod.6
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=keVkYj4cWaI4gay87MdL0AahO7PaN4KeF2eJUm3V5FQ=;
        b=bJx6W9C91GXHZT9WZmR5uDci7uh5rihNKWqmcZX88RTvcFDWcennu7TEZgFHORE0o5
         Sih/OiecaC+yPBT1oUXlgYv4Thkp3gG2s1+O1pF9KogW+eHi2GYSo6vwUN0wYrwPG3Ls
         d0JJ9Qy1LuKY4eLK/uh5sCTBRurXSZkClGXzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=keVkYj4cWaI4gay87MdL0AahO7PaN4KeF2eJUm3V5FQ=;
        b=6eFob/vRatKTuk1kYULsLiaAU8Wnl0e08ZJV4gCJ9lJJguzdQlLZYTarR3A4Uz9ovX
         UQXA2md5xCH9VzGlO+DPsKLt7fJR2K3+J0BkvBi8r5c1IVyx5P/r4AUt1jBXOkX0F2y9
         UobtHI3ajDB4VcmTeKPfnwGTzmozHgM3Yyf9TBGLsHmrgVnCEJfDwascZzsVqjQb9RP0
         kxcoEMs4WFB8ZPXvKh8bw6IxOjnroJyXLHT9kS1yNK1l7tn60EXP8MSlcKQBtmKsUemB
         bohPOMdBZVTVpEBywiTqiuQylt3a9gZYH2Gj5mqwP8JnU40a/caIhEqBwmzLgAEdYYIN
         SM+Q==
X-Gm-Message-State: AOAM530+of6nEdCbX0nzorrVd+yrhEIubz6hT+rlhoK/lA1/FebmvFUh
        CgDR/VnYgQ6/iBqTioZyRKEAn4shK8KFTA==
X-Google-Smtp-Source: ABdhPJxGOZ2BJ+RHSzRcbdkCNemhvmf9CaBqWrCb2/N1joKqeDq2ON7aDkwhDmdeCC+ElIarNR2UwQ==
X-Received: by 2002:a05:6638:d87:b0:323:c006:3650 with SMTP id l7-20020a0566380d8700b00323c0063650mr7872341jaj.64.1649358065787;
        Thu, 07 Apr 2022 12:01:05 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k5-20020a6bf705000000b00649a2634725sm13146036iog.17.2022.04.07.12.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:01:05 -0700 (PDT)
Subject: Re: [PATCH V2] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220407184008.93879-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e9c8a8c7-9a0d-09be-343d-038b7f791b98@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 13:01:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220407184008.93879-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/7/22 12:40 PM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed.
> 
> Fix this issue by adding CPU_FREE in the "shutdown" function which
> is called in most of the error/exit path for the cleanup. Also add
> CPU_FREE in some of the error paths where shutdown is not called.
> 
> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>  From v1 -> v2:
>   Addressed review comment from Shuah Khan to add
>   CPU_FREE in other exit paths where it is needed
> 

Thank you. I have a couple of comments on making the error
paths simpler. Please see below.

>   tools/testing/selftests/mqueue/mq_perf_tests.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
> index b019e0b8221c..182434c7898d 100644
> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
> @@ -180,6 +180,9 @@ void shutdown(int exit_val, char *err_cause, int line_no)
>   	if (in_shutdown++)
>   		return;
>   
> +	/* Free the cpu_set allocated using CPU_ALLOC in main function */
> +	CPU_FREE(cpu_set);
> +
>   	for (i = 0; i < num_cpus_to_pin; i++)
>   		if (cpu_threads[i]) {
>   			pthread_kill(cpu_threads[i], SIGUSR1);
> @@ -589,6 +592,7 @@ int main(int argc, char *argv[])
>   						cpu_set)) {
>   					fprintf(stderr, "Any given CPU may "
>   						"only be given once.\n");
> +					CPU_FREE(cpu_set);

This could be done in a common error path handling.

>   					exit(1);
>   				} else
>   					CPU_SET_S(cpus_to_pin[cpu],
> @@ -607,6 +611,7 @@ int main(int argc, char *argv[])
>   				queue_path = malloc(strlen(option) + 2);
>   				if (!queue_path) {
>   					perror("malloc()");
> +					CPU_FREE(cpu_set);

This could be done in a common error path handling.

>   					exit(1);
>   				}
>   				queue_path[0] = '/';
> @@ -619,6 +624,7 @@ int main(int argc, char *argv[])
>   	}
>   
>   	if (continuous_mode && num_cpus_to_pin == 0) {
> +		CPU_FREE(cpu_set);

This could be done in a common error path handling.

>   		fprintf(stderr, "Must pass at least one CPU to continuous "
>   			"mode.\n");
>   		poptPrintUsage(popt_context, stderr, 0);
> @@ -628,10 +634,12 @@ int main(int argc, char *argv[])
>   		cpus_to_pin[0] = cpus_online - 1;
>   	}
>   
> -	if (getuid() != 0)
> +	if (getuid() != 0) {
> +		CPU_FREE(cpu_set);
>   		ksft_exit_skip("Not running as root, but almost all tests "
>   			"require root in order to modify\nsystem settings.  "
>   			"Exiting.\n");
> +	}
>   

Why not move this check before CPU_ALLOC and make this the very first
check in main()?

With this change the other places where CPU_FREE is added right before
exit(1). Something like this:

err_code:
	CPU_FREE(cpu_set);
	exit(code)

>   	max_msgs = fopen(MAX_MSGS, "r+");
>   	max_msgsize = fopen(MAX_MSGSIZE, "r+");
> 

thanks,
-- Shuah
