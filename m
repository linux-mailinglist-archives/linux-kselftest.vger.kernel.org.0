Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAD29CB60
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 22:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374230AbgJ0Vkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 17:40:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39937 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506372AbgJ0Vky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 17:40:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id h140so2732165qke.7
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbV13dQpmTzExWsfaHqMxXa/LCrpQNykUloI1j/cNyY=;
        b=SZ4eOGm4BsvC9ji8PGjcebSa+LMmczTgeAElhnetuu//7iKmjjMibbd8g5iI/wLhyD
         wXewNVyvv1y9VdFOjewo7ATYit5ETGO5efJZEdo2IpY6tZk93CEalI+3YoQaTgSrelkE
         ZwKv01YoXxXcdxor/LUQg7iKsQG6AS9fEA90c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbV13dQpmTzExWsfaHqMxXa/LCrpQNykUloI1j/cNyY=;
        b=MHgMisuFymSBeuANFw10XOpiMTamczYjYY8nxcuvxYImKBZOBIUd0VrFK6Zvoywwfp
         CIhrqxLZLslE66uEktt8uWk1Bk7zM6SLNInc6fkh+LmkZLpwBjIT/+mhM2NqjdmXSPx/
         obdfLjSeJytbGxqe+RImruqBqbZDl7VWePo67cj+MJo8hOwDaro0vn2s/ghk7yI2mbNp
         JKtPZ/ROJmFSktlAFCrW/FwpveU4A3QzauKS+DTa6uW4jJv83cpsjVyIcFApiecMb5rs
         uTIWmYMGTlN4dsBKlYIUHNYkdEVPL/VMRFt9NZ1JbHBQCsZloYtHjDMWelZIelO37KEk
         LdAg==
X-Gm-Message-State: AOAM530xgHYM/n0JX98PwYlhLCxrQBx07zts8+Tz8UIuAx+QgfsQh/Pe
        V5WqdX8XA5Jfq75GPM7zfX4LdUcYa/in1g==
X-Google-Smtp-Source: ABdhPJwURr5tW++4/oS77FQCPV4gJ30krmxDqjH5wY2UKUo4WHDfdpLjTqGOKt9aN+7NY3XQnYmiZg==
X-Received: by 2002:a05:6638:a11:: with SMTP id 17mr4316056jan.59.1603834460050;
        Tue, 27 Oct 2020 14:34:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 186sm1611593ile.4.2020.10.27.14.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:34:19 -0700 (PDT)
Subject: Re: [PATCH v3 05/21] selftests/resctrl: Return if resctrl file system
 is not supported
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
 <20201020235126.1871815-6-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aec728b0-6262-58ef-c408-93f19c281ad8@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 15:34:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020235126.1871815-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/20 5:51 PM, Fenghua Yu wrote:
> check_resctrlfs_support() checks if the platform supports resctrl file
> system or not by looking for resctrl in /proc/filesystems and returns a
> boolean value. The main function of resctrl test suite calls
> check_resctrlfs_support() but forgets to check for it's return value. This
> means that resctrl test suite will attempt to run resctrl tests (like CMT,
> CAT, MBM and MBA) even if the platform doesn't support resctrl file system.
> 
> Fix this by checking for the return value of check_resctrlfs_support() in
> the main function. If resctrl file system isn't supported on the platform
> then exit the test suite gracefully without attempting to run any of
> resctrl unit tests.
> 
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index b2a560c0c5dc..d24de546d4ef 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -155,7 +155,11 @@ int main(int argc, char **argv)
>   	sprintf(bw_report, "reads");
>   	sprintf(bm_type, "fill_buf");
>   
> -	check_resctrlfs_support();
> +	if (!check_resctrlfs_support()) {
> +		printf("Bail out! resctrl FS does not exist\n");
> +		goto out;
> +	}
> +

Adding config file makes sense to specify dependencies.

>   	filter_dmesg();
>   
>   	if (!is_amd && mbm_test) {
> @@ -196,6 +200,7 @@ int main(int argc, char **argv)
>   		cat_test_cleanup();
>   	}
>   
> +out:
>   	printf("1..%d\n", tests_run);
>   
>   	return 0;
> 

thanks,
-- Shuah
