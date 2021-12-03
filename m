Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF046778F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380870AbhLCMoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 07:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352150AbhLCMoY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 07:44:24 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF1C06173E
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 04:41:00 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a2so3026367qtx.11
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 04:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YzETAAhL/NPrMqOB8Dhv3Q+lcOA75NqIJ8aqwt7MBQo=;
        b=Gr9vZEUCKtBa0P4z+lEvbS31k8YUTbRH8BuO+TFYQy22R2zi+R39oJ9TsOCM65TPSY
         cmJZXkb1M8m9fSQ0v6MtaTX5//U5q3jyMrF45c/K4/QfplpQjbhdHv0EGvgv6/CctqhV
         tTw3yiMC0GXvfkjqippNsQiwFAXR4GRuKqTcou6/T/pXUxgUaS8S7LKFvY3JZaMtwZeT
         tUT3EmM1+eQZ7xguS5xPmiiOrEgeN9yausc8RH8BOMN6Rwzr/c3HQ5dN37TtRfw2QhE5
         REyCkAzWNPYKMBjCHIzIjQCsHcVYnyO5NYeMipEx92/U6JBnDzL7AWxKRKhLMBjrM0L8
         Xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YzETAAhL/NPrMqOB8Dhv3Q+lcOA75NqIJ8aqwt7MBQo=;
        b=KUvSUcqDF0bJ5nd4BmIaRbVW+WKpjoLSDBChSTsIaLtKE28qBr7PDE8FtBQPm3mjhf
         x+IzH71/c9HImLEsPeaZcv0FOhpLeleZHdgsFJER1fWH60LNwxOS+oOPLfW2jBuxxMAl
         tkwdVMxFuV/XXkDTlsCvtdS3NQVALSa6jSFMeF06uJ28vI1h24T4gih0cU0vT+S9gELY
         3L54JKZo1sh2kzqxsF8iutFwY6va0U5sNornn3XqcBj/DYZn6QnOj9FZ2M7yl2WeLZup
         5xaSp25XNbyD5YDCKR05BmkzTb8thCayc7G6JkMNeMz12cMP0TpU/hQ+JehAxpVTA7be
         vdtQ==
X-Gm-Message-State: AOAM531UQGUOW+MNPkLckgg2JMTCuOY7BmlRjxGtU+Tyjv9nFq2T1Q0M
        7+Cyn/SqyVr9VnuUO8pmwnVgZg==
X-Google-Smtp-Source: ABdhPJwvWAMl4t4Ouer40afEMNCjblBSRcn9wt9/hC0MeqFtyK8US1JNgs+NvMPYbm7aZp/3NdtxXA==
X-Received: by 2002:a05:622a:1a83:: with SMTP id s3mr20385748qtc.497.1638535260098;
        Fri, 03 Dec 2021 04:41:00 -0800 (PST)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id u18sm2071638qki.69.2021.12.03.04.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 04:40:59 -0800 (PST)
Message-ID: <472b2dd9-3596-5d5b-2fc2-20a7bbf05dbf@mojatatu.com>
Date:   Fri, 3 Dec 2021 07:40:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/3] selftests/tc-testing: add exit code
Content-Language: en-US
To:     Li Zhijian <zhijianx.li@intel.com>, kuba@kernel.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Davide Caratti <dcaratti@redhat.com>
References: <20211203025323.6052-1-zhijianx.li@intel.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <20211203025323.6052-1-zhijianx.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All LGTM - but shouldnt these patches be independent of each other?
i.e submit 3 patches each with 1/1

cheers,
jamal

On 2021-12-02 21:53, Li Zhijian wrote:
> Mark the summary result as FAIL to prevent from confusing the selftest
> framework if some of them are failed.
> 
> Previously, the selftest framework always treats it as *ok* even though
> some of them are failed actually. That's because the script tdc.sh always
> return 0.
> 
>   # All test results:
>   #
>   # 1..97
>   # ok 1 83be - Create FQ-PIE with invalid number of flows
>   # ok 2 8b6e - Create RED with no flags
> [...snip]
>   # ok 6 5f15 - Create RED with flags ECN, harddrop
>   # ok 7 53e8 - Create RED with flags ECN, nodrop
>   # ok 8 d091 - Fail to create RED with only nodrop flag
>   # ok 9 af8e - Create RED with flags ECN, nodrop, harddrop
>   # not ok 10 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>   #       Could not match regex pattern. Verify command output:
>   # qdisc mq 1: root
>   # qdisc fq_codel 0: parent 1:4 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>   # qdisc fq_codel 0: parent 1:3 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
> [...snip]
>   # ok 96 6979 - Change quantum of a strict ETS band
>   # ok 97 9a7d - Change ETS strict band without quantum
>   #
>   #
>   #
>   #
>   ok 1 selftests: tc-testing: tdc.sh <<< summary result
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
> Acked-by: Davide Caratti <dcaratti@redhat.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> V3: repost to netdev
> V2: Fix missing ':'
> ---
>   tools/testing/selftests/tc-testing/tdc.py | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
> index a3e43189d940..ee22e3447ec7 100755
> --- a/tools/testing/selftests/tc-testing/tdc.py
> +++ b/tools/testing/selftests/tc-testing/tdc.py
> @@ -716,6 +716,7 @@ def set_operation_mode(pm, parser, args, remaining):
>           list_test_cases(alltests)
>           exit(0)
>   
> +    exit_code = 0 # KSFT_PASS
>       if len(alltests):
>           req_plugins = pm.get_required_plugins(alltests)
>           try:
> @@ -724,6 +725,8 @@ def set_operation_mode(pm, parser, args, remaining):
>               print('The following plugins were not found:')
>               print('{}'.format(pde.missing_pg))
>           catresults = test_runner(pm, args, alltests)
> +        if catresults.count_failures() != 0:
> +            exit_code = 1 # KSFT_FAIL
>           if args.format == 'none':
>               print('Test results output suppression requested\n')
>           else:
> @@ -748,6 +751,8 @@ def set_operation_mode(pm, parser, args, remaining):
>                           gid=int(os.getenv('SUDO_GID')))
>       else:
>           print('No tests found\n')
> +        exit_code = 4 # KSFT_SKIP
> +    exit(exit_code)
>   
>   def main():
>       """
> @@ -767,8 +772,5 @@ def main():
>   
>       set_operation_mode(pm, parser, args, remaining)
>   
> -    exit(0)
> -
> -
>   if __name__ == "__main__":
>       main()
> 

