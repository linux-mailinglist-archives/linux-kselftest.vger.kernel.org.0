Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930C634AD1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 18:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZRKI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCZRJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 13:09:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF84C0613AA
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Mar 2021 10:09:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n21so6118488ioa.7
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Mar 2021 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNOz2Cmqybk4+0BfIqPEtpDuAPTX+jzz1pIERqoYAdQ=;
        b=LGAJhtI94SvuljRJjoRIjR2B2dUfHi4Xt00SMpcV2+4PaRPivDJ4zrF8BSrX7m1k40
         OmoIoZ+w6F1xIVWzGcrLjMyVM3eaKE9i2lASWcZc3T6OzqvYDwmoZftSV7Hlx7vplFSc
         omXOBWJ/0TztzRA1lbJSdHGKfUSvCzxvlRjcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNOz2Cmqybk4+0BfIqPEtpDuAPTX+jzz1pIERqoYAdQ=;
        b=lv/6XPQvI0H+Vl/LZMU5vuW9CpYp3eai++VhXowOr+xPnckqvftx9lrE8mmoO//gAT
         EvT2tNC7PYG8hmnojSDzyUZYC/3ehFPqy+u4yqe67qRfnYhJ0cIseF2Kq0FTDtpnkLIn
         xV87ytl3SiVcYWbyRBmrqleY5nChdfKG1bLVDSA9+I+23ZLI+YTHo/fRGZjGKkV/n+gM
         9CP9jROZC4HQN8WjvBzZIp+NtZKOBNoFZi9FzlNtUNVr1GSZAqZWMvExxZ5e68w39NOA
         sRTi8EiWo0nAGZC9bUBwXZDtFXdHO/m6COsup0pza8sZCpX2GAKzkhPmeHUgbt/Dydqc
         Vlfw==
X-Gm-Message-State: AOAM532yZWmDAmdudxnLAXJQ+NbKEAL3cx4JfcqUysa1cZEfzdTKjgEG
        1zNn8Fha3WojOFE1YtzLsU767g==
X-Google-Smtp-Source: ABdhPJz8PkC2lNUKj97EzNEvcSlhOYV03Kvtlzr7cyDyh0en5mqouyUoykbRltO2nsKvRM6oqOZ/QA==
X-Received: by 2002:a05:6602:2287:: with SMTP id d7mr11071568iod.42.1616778595854;
        Fri, 26 Mar 2021 10:09:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o19sm4652640ioh.47.2021.03.26.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:09:55 -0700 (PDT)
Subject: Re: [PATCH v5] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
To:     Ilya Leoshkevich <iii@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210303004420.138360-1-iii@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e737460d-f042-064e-1ae4-e64300dfd446@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 11:09:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303004420.138360-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/2/21 5:44 PM, Ilya Leoshkevich wrote:
> Currently the following command produces an error message:
> 
>      linux# make kselftest TARGETS=bpf O=/mnt/linux-build
>      # selftests: bpf: test_libbpf.sh
>      # ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
>      # test_libbpf: failed at file test_l4lb.o
>      # selftests: test_libbpf [FAILED]
> 
> The error message might not affect the return code of make, therefore
> one needs to grep make output in order to detect it.
> 
> This is not the only instance of the same underlying problem; any test
> with more than one element in $(TEST_PROGS) fails the same way. Another
> example:
> 
>      linux# make O=/mnt/linux-build TARGETS=splice kselftest
>      [...]
>      # ./short_splice_read.sh: 15: ./splice_read: not found
>      # FAIL: /sys/module/test_module/sections/.init.text 2
>      not ok 2 selftests: splice: short_splice_read.sh # exit=1
> 
> The current logic prepends $(OUTPUT) only to the first member of
> $(TEST_PROGS). After that, run_one() does
> 
>     cd `dirname $TEST`
> 
> For all tests except the first one, `dirname $TEST` is ., which means
> they cannot access the files generated in $(OUTPUT).
> 
> Fix by using $(addprefix) to prepend $(OUTPUT)/ to each member of
> $(TEST_PROGS).
> 
> Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1->v2:
> - Append / to $(OUTPUT).
> - Use $(addprefix) instead of $(foreach).
> 
> v2->v3:
> - Split the patch in two.
> - Improve the commit message.
> 
> v3: https://lore.kernel.org/linux-kselftest/20191024121347.22189-1-iii@linux.ibm.com/
> v3->v4:
> - Drop the first patch.
> - Add a note regarding make return code to the commit message.
> 
> v4: https://lore.kernel.org/linux-kselftest/20191115150428.61131-1-iii@linux.ibm.com/
> v4->v5:
> - Add another reproducer to the commit message.
> 
>   tools/testing/selftests/lib.mk | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index a5ce26d548e4..be17462fe146 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -74,7 +74,8 @@ ifdef building_out_of_srctree
>   		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
>   	fi
>   	@if [ "X$(TEST_PROGS)" != "X" ]; then \
> -		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
> +		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
> +				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
>   	else \
>   		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
>   	fi
> 

Thank you. Will apply it for 5.13-rc1

thanks,
-- Shuah
