Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314E29CAD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 21:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373490AbgJ0U63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 16:58:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44420 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373486AbgJ0U63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 16:58:29 -0400
Received: by mail-il1-f195.google.com with SMTP id z2so2767263ilh.11
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mCBo/dw5+eCxlwInuX3ibBdG6i4KroGcWXBgc9MM9yk=;
        b=E6btr2a3h9jsRHGQAlpxQPGwcSUp/ZTRSB+1EQ+uSsE1eSxQks6bnsMcVHZDIBgtLu
         6iE3V6yfWRGc3dDB+Vfw2osZrSe3oBhoahVZNYjWvUNgIYfxyjlw6Frz39/kQRp8VGQ4
         QTB7DLORAkPmjopVOXTh6JhRblGV9O1zz0rqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCBo/dw5+eCxlwInuX3ibBdG6i4KroGcWXBgc9MM9yk=;
        b=V032JCnOrdNa69n8LbNh14TrSMDA5Yj+j1p0nUu8U0FQdyKuRcWJchi3KJ8ms11ybW
         zEX4YNWXJGJV+qVbpOxBZcxWI490zu960j1x+0Eqvr2LR565THuWIGzXVgDD7ExyP6Ky
         picBBJj6IO7+sKZrwnorEI9ExB9Qp1lB8vRbhFbYIa2XgmrFr+2rz0QAi9hlzfGVFRnr
         1QJJBVgJ3CJWnLrXVYPi7hiShOibhLi+/pcmx47cXXgFk399A50/cekOwfjvj1Tca5sH
         SVt1E92M2qRuZymNyul8o9/o5SZe1rPDOuhLMNW7kvWUV+XxkFiOE8xNBYM6DIgsS23f
         Hw6w==
X-Gm-Message-State: AOAM533QvP8VOrC5MTWR2Ul6yHEGUe82DS+9MzPpzZ3Nq9eZNNb6qGAj
        B10ZuTnojdeRljmtCInOQ7U1+Q==
X-Google-Smtp-Source: ABdhPJweLgguNJyriq0XoknCDhp82gHA7tUeIicg3wQa9XK+nHNdeoRTCw8tWWL9lpvo9AuJmWf8Eg==
X-Received: by 2002:a92:844b:: with SMTP id l72mr3178687ild.244.1603832307794;
        Tue, 27 Oct 2020 13:58:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f85sm1512866ill.39.2020.10.27.13.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:58:27 -0700 (PDT)
Subject: Re: [PATCH v3 03/21] selftests/resctrl: Fix typo in help text
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
 <20201020235126.1871815-4-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9f1eaeb-790c-2e32-ef8c-0dc88e3395c8@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 14:58:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020235126.1871815-4-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/20 5:51 PM, Fenghua Yu wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> Add a missing newline to the help text printed and fixup the next line
> to line it up to previous line for improved readability.
> 
> Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 35a91cab1b88..b2a560c0c5dc 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -37,8 +37,8 @@ void detect_amd(void)
>   static void cmd_help(void)
>   {
>   	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> -	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
> -	printf("\t default benchmark is builtin fill_buf\n");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
> +	printf("\t   default benchmark is builtin fill_buf\n");
>   	printf("\t-t test list: run tests specified in the test list, ");
>   	printf("e.g. -t mbm, mba, cmt, cat\n");
>   	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
> 

The commit summary is misleading. It isn't typo. You are adding
a space to make the message correct?

thanks,
-- Shuah
