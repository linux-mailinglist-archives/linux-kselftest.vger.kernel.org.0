Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8869E29CACB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 21:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373441AbgJ0U4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 16:56:54 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45578 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373434AbgJ0U4y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 16:56:54 -0400
Received: by mail-il1-f194.google.com with SMTP id g7so2758822ilr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 13:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GVN1lj+hI+FAZzFZbIZ9juB2x8dpAvsvHkDsUzwa/7Y=;
        b=L94FUgVn6iBO2xMDfBxztypNluIqPA50kKKvelC4df66ptg2+SC1MYbpFEeL1FRsJB
         QIvMIui33nYqCUMbQcQuYUANB7n4kEEzcZqfyW0MwMoOTii0OaA5LS9MCdiEgKrP0uDq
         XNnHVtG4STE77LXd4aYAkW6FuVfBXMckptgoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GVN1lj+hI+FAZzFZbIZ9juB2x8dpAvsvHkDsUzwa/7Y=;
        b=DHirTuG32v1rMKxYLdolVkPr8vg3MUjxB+CNphLg9iP+Xvg9g4s779XrkNtV8hgDVx
         MxZqsNZ90ogZMsRwLNvJ3A58Un3vwWJDjRejxLMmUwFFF+V7RlOVOpuaqxpMbhaCMO0I
         yWo8wtL6whkyHm1q7T6Jy/Wpqo2ihETqqoF1SPoBZzlU1Xae2+WSYYxaTibEGn3Ye6g2
         m4JoYvR8WT4hKRQwCcgUcA2DFU0TfJcWrHL7v1Ha9YAp+YpN3l0TfT7g3chMM4skuSGM
         XG8nX4tAoXu30Mlc0GVTM1WLR8+WvGdyb/t7b7WJl4EeWfU1cqLri8TILENTXCPsb0JQ
         o3zQ==
X-Gm-Message-State: AOAM531Tamnd8TKSCiY8c1cIjMxLCjaiCo+M+9f67DVzYpYFV+M8QsUt
        cXBBX8GNoScp68F8N756hERCVA==
X-Google-Smtp-Source: ABdhPJwpUyiduNOqVkumnC4/8YpHfmYYxrB4ELvD+HGmX+L95WMxEsT4oSP05Yyv7jADALMDQjCvPg==
X-Received: by 2002:a92:dac1:: with SMTP id o1mr3159909ilq.191.1603832213035;
        Tue, 27 Oct 2020 13:56:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u8sm1459675ilm.36.2020.10.27.13.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:56:52 -0700 (PDT)
Subject: Re: [PATCH v3 02/21] selftests/resctrl: Fix typo
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
 <20201020235126.1871815-3-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5c8ecfd2-6ade-9733-b56f-5fce535462f2@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 14:56:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020235126.1871815-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/20 5:51 PM, Fenghua Yu wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> The format "%sok" is used to print results of a test. If the test passes,
> the empty string is printed and if the test fails "not " is printed. This
> results in output of "ok" when test passes and "not ok"
> when test fails.
> 
> Fix one instance where "not" (without a space) is printed on test
> failure resulting in output of "notok" on test failure.
> 

The commit summary is misleading. It isn't typo. You are adding
a space to make the message correct?

> Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/cmt_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 13b01e010238..6ffb56c6a1e2 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -58,7 +58,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
>   	else
>   		res = false;
>   
> -	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
> +	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not ",
>   	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
>   
>   	printf("# diff: %ld\n", avg_diff);
> 

thanks,
-- Shuah
