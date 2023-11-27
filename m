Return-Path: <linux-kselftest+bounces-650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25B7FA300
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 15:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CE28183E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2D1E501;
	Mon, 27 Nov 2023 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP26FI7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB82721;
	Mon, 27 Nov 2023 06:37:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b34563987so24444055e9.1;
        Mon, 27 Nov 2023 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095823; x=1701700623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wkMZvkg5p67oPV5H2cjNwjUF/2UvASsIf9FQuVXTx4=;
        b=NP26FI7u4PzpK4OFVsdzVItPtQz0r7Jk6OmPtgrwTfUMI7ft3/UkgXgdbqO57qUuHg
         DCNsbZ/Fd0nIkleT81EvgmccVYnJfW2LHfguDxr3ThDtsX+J2oQReM7t4eGCSmVN0Ew/
         YWPP8PBg36IiP8eN/9MMDG8P/8KYJsF7dQhiXxzeAPXDQTzzbmqrSlttJBUto0taydMY
         jR0wMtsB7tkBWSWWE/v0gwAwwzOHD2qJCRZs8j+E8LKtjciJ3YhN0DK3l62VT+llWZWw
         YSC+C4qFq0v4AiH6bqnWTyoZQQxY81pCCiLPXLdZKReu05lbsRRHWSbxQ+FKXQ646tn7
         tzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095823; x=1701700623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wkMZvkg5p67oPV5H2cjNwjUF/2UvASsIf9FQuVXTx4=;
        b=OK3Eef15mTGPUqcpJZNB8sCsa1DCje2ss5YU70XUmZTVYeRDaGvHOr5/fv417froQe
         6IdFdBZbI1zZSPODXth7/o660xcKs/6V14q7kOXpsV9Otmv57imLmjzherE3O5eTh7cO
         ja15f3XLdMnh5WNm8zBeBuaM2SyHfZfyK45Uun89JAlV0/jiJU5FaIG0OqxFR5boR2ZF
         A1gzMYwRpZckg1+0GuCQS0ZQM++oDGqe1rTKifOgEayLd2kzyC+a6lepcZkGARWTrHud
         /8kICq7Ln1Cn15E1eNkldCaoOqz5SmIVII+YarYo/L3n6wyIgkbNT47KRQvCrYPR2+kx
         DjpA==
X-Gm-Message-State: AOJu0YyXrZ3Rtbuk8pEaXUr7JdL55h0974ip9hk9J9FMaHHbmUg8ZPRA
	DiuwlMpk/fbmPcDVeBkVmf8=
X-Google-Smtp-Source: AGHT+IENi/hD2FvN9ugjJRDtdV87yRNcDf8vKkEL7rPdiqWCPjKcGz+JFWwUJdB5JxWnXe0AL70Mpg==
X-Received: by 2002:a05:600c:1c8a:b0:408:369a:dad1 with SMTP id k10-20020a05600c1c8a00b00408369adad1mr9559454wms.4.1701095822569;
        Mon, 27 Nov 2023 06:37:02 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003143867d2ebsm12223239wrz.63.2023.11.27.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:37:02 -0800 (PST)
Message-ID: <f2e3a80b-ea3e-4bd7-bd38-1f36bcfc8b40@gmail.com>
Date: Mon, 27 Nov 2023 14:37:01 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] selftests/net: ipsec: fix constant out of range
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
 <20231124171645.1011043-2-willemdebruijn.kernel@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20231124171645.1011043-2-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/23 17:15, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Fix a small compiler warning.
> 
> nr_process must be a signed long: it is assigned a signed long by
> strtol() and is compared against LONG_MIN and LONG_MAX.
> 
> ipsec.c:2280:65:
>     error: result of comparison of constant -9223372036854775808
>     with expression of type 'unsigned int' is always false
>     [-Werror,-Wtautological-constant-out-of-range-compare]
> 
>   if ((errno == ERANGE && (nr_process == LONG_MAX || nr_process == LONG_MIN))
> 
> Fixes: bc2652b7ae1e ("selftest/net/xfrm: Add test for ipsec tunnel")
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

LGTM, thanks!
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
>  tools/testing/selftests/net/ipsec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
> index 9a8229abfa026..be4a30a0d02ae 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -2263,7 +2263,7 @@ static int check_results(void)
>  
>  int main(int argc, char **argv)
>  {
> -	unsigned int nr_process = 1;
> +	long nr_process = 1;
>  	int route_sock = -1, ret = KSFT_SKIP;
>  	int test_desc_fd[2];
>  	uint32_t route_seq;
> @@ -2284,7 +2284,7 @@ int main(int argc, char **argv)
>  			exit_usage(argv);
>  		}
>  
> -		if (nr_process > MAX_PROCESSES || !nr_process) {
> +		if (nr_process > MAX_PROCESSES || nr_process < 1) {
>  			printk("nr_process should be between [1; %u]",
>  					MAX_PROCESSES);
>  			exit_usage(argv);

-- 
Dmitry


