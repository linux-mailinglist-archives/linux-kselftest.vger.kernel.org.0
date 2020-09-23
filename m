Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F027635E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 23:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWVxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 17:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWVxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 17:53:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09956C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 14:53:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g96so1173709otb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOb33T+YNOHc4vIBVgqzuq7U+UoXOh9A3nK6B7gM0do=;
        b=UIrV3HdF2956LQEYJdqcgj3NASCJwUzME0jGDZrc8T8x/GnbaKUwPdLcnQ5Ze1tOBG
         DPPFL7J30nCzElb6Ryo9LWY6A/qtpfhiqM4yVuQ2KiZM/Unn46Jh+DjAkWNG3wsj1pHH
         7eso/9lJqZ7RjsxGYz/cF9AlxtY5DUyvosIuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOb33T+YNOHc4vIBVgqzuq7U+UoXOh9A3nK6B7gM0do=;
        b=hExP8vtZdK/6VPuVlloBkEqr0oM4rJXhkp1v+JA7FRgqPHbI2A00Ti8zAFa0jbuHC4
         Po3MDWF+h4rdbTS+Asbq/kEtEdHrTEVa9IfjWz6iXU85NkPxfqobz2fv1JyRnparpl1T
         rQlz7e1tANbsfN+lME4u/HFOblOojMzd3JEdLR7r7NS5C0+GoN3jia3UVjJHRphG9/OC
         EpyqD6V9PksvUaAzb6pUnHULrLoPH8KLkJJV8YWTjEZUmaPr4R/0HRsmWc329vbFSjEH
         1VcsHCXoObPbl6AlTvH5qV6D+X0aq8yrmLKsgh+Lmkzue+vp6j85FSLGvS33uqHBJPWa
         W7RQ==
X-Gm-Message-State: AOAM530AfIja1OwzFlKtjo4LqNS2fqSZB+VaHXJp7HOChECoPpbC6MFs
        IUHjp8iCNxhxf66QJlZrpdZBWw==
X-Google-Smtp-Source: ABdhPJxExq4JHuVzVZKU9uaUiYXh3uICLg9b4TOBOOJQi7zlKYp3+50qVXQgomQIypWjMNM9eK2RIw==
X-Received: by 2002:a05:6830:1191:: with SMTP id u17mr1099399otq.335.1600898020691;
        Wed, 23 Sep 2020 14:53:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e19sm323206ote.37.2020.09.23.14.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 14:53:40 -0700 (PDT)
Subject: Re: [PATCH v1] kunit: tool: fix --alltests flag
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200923211938.3727976-1-brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fbc056e-6baa-a457-cc5f-058606903fe3@linuxfoundation.org>
Date:   Wed, 23 Sep 2020 15:53:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923211938.3727976-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/20 3:19 PM, Brendan Higgins wrote:
> Alltests flag evidently stopped working when run from outside of the
> root of the source tree, so fix that. Also add an additional broken
> config to the broken_on_uml config.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   tools/testing/kunit/configs/broken_on_uml.config |  1 +
>   tools/testing/kunit/kunit_kernel.py              | 15 ++++++++++-----
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
> index 239b9f03da2c..a7f0603d33f6 100644
> --- a/tools/testing/kunit/configs/broken_on_uml.config
> +++ b/tools/testing/kunit/configs/broken_on_uml.config
> @@ -39,3 +39,4 @@
>   # CONFIG_QCOM_CPR is not set
>   # CONFIG_RESET_BRCMSTB_RESCAL is not set
>   # CONFIG_RESET_INTEL_GW is not set
> +# CONFIG_ADI_AXI_ADC is not set
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e20e2056cb38..1b1826500f61 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -53,18 +53,23 @@ class LinuxSourceTreeOperations(object):
>   		except subprocess.CalledProcessError as e:
>   			raise ConfigError(e.output)
>   
> -	def make_allyesconfig(self):
> +	def make_allyesconfig(self, build_dir, make_options):
>   		kunit_parser.print_with_timestamp(
>   			'Enabling all CONFIGs for UML...')
> +		command = ['make', 'ARCH=um', 'allyesconfig']
> +		if make_options:
> +			command.extend(make_options)
> +		if build_dir:
> +			command += ['O=' + build_dir]
>   		process = subprocess.Popen(
> -			['make', 'ARCH=um', 'allyesconfig'],
> +			command,
>   			stdout=subprocess.DEVNULL,
>   			stderr=subprocess.STDOUT)
>   		process.wait()
>   		kunit_parser.print_with_timestamp(
>   			'Disabling broken configs to run KUnit tests...')
>   		with ExitStack() as es:
> -			config = open(KCONFIG_PATH, 'a')
> +			config = open(get_kconfig_path(build_dir), 'a')
>   			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
>   			config.write(disable)
>   		kunit_parser.print_with_timestamp(
> @@ -161,9 +166,9 @@ class LinuxSourceTree(object):
>   			return self.build_config(build_dir, make_options)
>   
>   	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
> -		if alltests:
> -			self._ops.make_allyesconfig()
>   		try:
> +			if alltests:
> +				self._ops.make_allyesconfig(build_dir, make_options)
>   			self._ops.make_olddefconfig(build_dir, make_options)
>   			self._ops.make(jobs, build_dir, make_options)
>   		except (ConfigError, BuildError) as e:
> 
> base-commit: 92a2b470086f68bf35eb9f94b6cb5ebdfac41b25
> 


Thanks. Applied to linux-kselftest kunit-fiex for 5.10-rc1

thanks,
-- Shuah
