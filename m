Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED72583B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgHaVlz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 17:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHaVly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 17:41:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCE0C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:41:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so2488193ilo.13
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cHr43YW5+iuDSdOUC12gPmWiPSezUttSApUwF+cX1IU=;
        b=BPxJwCD7kcNv/87qq8Ed4NTQiQ8rH4eYBBTgEhfwAEywW/yl08Knnr7Dg43wiEKCTC
         gOneUWSA0tkw21myD+rGkiVVk+avwQVJn31zchc/ZRu0K0X3DbygFrc3D3jbSsNfmGoB
         zCMUEqzpG/MMq2jBpndcF0y8aO6/QEBGjRCi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHr43YW5+iuDSdOUC12gPmWiPSezUttSApUwF+cX1IU=;
        b=rAlZXM+Z4PdFHiW7QvlH3ow3EthL3QZnzY0SYjwk5+jJBeENfwNKDcpKpSf8Wy6nwM
         ZGw60ioWFPAPCmMpy9sA5dqRfTEGnp9yfJcUfCBlk+DMQFPD7g4mQ4uQPkgZZxA4XyWY
         6viuJEFkPFE77HhkfCkAITEtKH/4/uqIPmfxPob9abUIgWT+Msywj2B7znD1fuiZvxFm
         r1snej8UAFsiIRkHCLu+oF7i/3jIT8tNnP2O7GAZHTaanQEbRB0h0lXUET0Ec/NGzGvr
         eF3gUVLlWu5J7/IwTX6pnQXH7gttPk1SGhyG4vPDS4qgFpqBwYXfSRH1NGOwscmCx+hF
         xriw==
X-Gm-Message-State: AOAM530S83W+C2ZqJvx5UbDeOA4HN0Ymab7ou6DW4yzVurap8EF+ZPZP
        N+OoGnq+d4yG8pIRjRR4KT8KaQ==
X-Google-Smtp-Source: ABdhPJxm6kdMsYQeFuxNFnd52GSbvYpPf3wn08xmFREmWsPNSBi6H/ns5n2GuEAgF7WAxi9omLSJkA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr2876415ilz.149.1598910113451;
        Mon, 31 Aug 2020 14:41:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y19sm3139539ili.47.2020.08.31.14.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 14:41:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20200811212756.3328740-1-brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d073fd4d-93e6-4c43-a814-c13719ac2259@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 15:41:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811212756.3328740-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/11/20 3:27 PM, Brendan Higgins wrote:
> Currently kunit_tool does not work correctly when executed from a path
> outside of the kernel tree, so make sure that the current working
> directory is correct and the kunit_dir is properly initialized before
> running.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   tools/testing/kunit/kunit.py | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 425ef40067e7e..e2caf4e24ecb2 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -237,9 +237,13 @@ def main(argv, linux=None):
>   
>   	cli_args = parser.parse_args(argv)
>   
> +	if get_kernel_root_path():
> +		os.chdir(get_kernel_root_path())
> +
>   	if cli_args.subcommand == 'run':
>   		if not os.path.exists(cli_args.build_dir):
>   			os.mkdir(cli_args.build_dir)
> +			create_default_kunitconfig()
>   
>   		if not linux:
>   			linux = kunit_kernel.LinuxSourceTree()
> @@ -257,6 +261,7 @@ def main(argv, linux=None):
>   		if cli_args.build_dir:
>   			if not os.path.exists(cli_args.build_dir):
>   				os.mkdir(cli_args.build_dir)
> +				create_default_kunitconfig()
>   
>   		if not linux:
>   			linux = kunit_kernel.LinuxSourceTree()
> @@ -270,10 +275,6 @@ def main(argv, linux=None):
>   		if result.status != KunitStatus.SUCCESS:
>   			sys.exit(1)
>   	elif cli_args.subcommand == 'build':
> -		if cli_args.build_dir:
> -			if not os.path.exists(cli_args.build_dir):
> -				os.mkdir(cli_args.build_dir)
> -
>   		if not linux:
>   			linux = kunit_kernel.LinuxSourceTree()
>   
> @@ -288,10 +289,6 @@ def main(argv, linux=None):
>   		if result.status != KunitStatus.SUCCESS:
>   			sys.exit(1)
>   	elif cli_args.subcommand == 'exec':
> -		if cli_args.build_dir:
> -			if not os.path.exists(cli_args.build_dir):
> -				os.mkdir(cli_args.build_dir)
> -
>   		if not linux:
>   			linux = kunit_kernel.LinuxSourceTree()
>   
> 
> base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> 


Applied the two patches in this seeries to linux-kselftest kunit-fixes
for the next 5.9-rc fixes

thanks,
-- Shuah
