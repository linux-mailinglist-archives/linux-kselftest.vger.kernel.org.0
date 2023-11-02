Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385E7DF0F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjKBLOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLOr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 07:14:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6C132
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Nov 2023 04:14:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso9975391fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Nov 2023 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698923676; x=1699528476; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o58wFnf6szPGgzlryUFb1pArzVhpE+Bc8B/ye0mh1Ic=;
        b=U53jqP9VsUBak53Y5BfKYfegk3kaVH4KZAkUP0KAhHPKM/eAbu3Dhyy2tSC/G70F16
         pLEfg6e/NzHbe30i0hvgPA2D0qvph/Iza4vRoYLPLavuHyAUlz21bQsaWMWWffq31Y/u
         BLEEulyy+BSJz7zVF24Xj6Se21AQ9seOR9HcWAhMTrGE4tC6zAS1BN7rRb2XDSOze1MP
         Ggox8NcFXFQVfDLjqcbHTzinBsBtnaRybKmPymlBwQRt74BVx6uM/mwSMWFg5aCzr23Q
         L4yJLhnYyNYhwmgWa8c4VKYmMz+sT5S266ehiOmXNS09PIS+a+sOHgXWTOI3UMvwe4yK
         Fkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698923676; x=1699528476;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o58wFnf6szPGgzlryUFb1pArzVhpE+Bc8B/ye0mh1Ic=;
        b=MicEBGHQbJpQXn/F/sIwfhDXZU0ga3U9jKP8K+BSbRfjdCz80+b3U6qRRNU29RPtq5
         12I2xLIYWuJSYvhGrokzRk7Lq89HSl3gg37h12iw+zsQ386btXxUKIKLa1iBjDa2t8qA
         2OtP7GohzI7+hxFQJZNTWWJZKFig+Qg9Y+1x5g67d6wQK7YR4sVqe97/gHK66ge5W12x
         5ouYs0nD/2wWl8BWaCHfOlQAjPDcCVu3IjFBx4rlHDmmkvR7kXYCDYAJqLPnbr1vjovf
         TZsUXmxW5c8FX1SeOn6FWRx/fdPCHT6b/wlxeJGB2A/KMmgaWaJBIFanC2JVKvFocyrK
         CzJw==
X-Gm-Message-State: AOJu0Yxop4SO9GDRN5qKEGY0Q7p4zRckxuYTncw0qtlg83VBjlDqpCFU
        wRDjSseZVXaz7DTMc/f/d7zcQg==
X-Google-Smtp-Source: AGHT+IH9UK7cZnl9aI1aNQH4ht0Hk9DmI3/B0c72F9p/BRC6XUjOOYp1gCJA1VqoiNTczqzaa+kmgQ==
X-Received: by 2002:a2e:be10:0:b0:2c4:fdc9:c8a3 with SMTP id z16-20020a2ebe10000000b002c4fdc9c8a3mr16743697ljq.50.1698923676107;
        Thu, 02 Nov 2023 04:14:36 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id bd4-20020a05651c168400b002c6ee08c2casm215421ljb.105.2023.11.02.04.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:14:35 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:14:33 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix broken build where char is
 unsigned
Message-ID: <20231102111433.GA364395@mutt>
References: <20231102103537.247336-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102103537.247336-1-bjorn@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-02 11:35, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are architectures where char is not signed. If so, the following
> error is triggered:
> 
>   | xdp_hw_metadata.c:435:42: error: result of comparison of constant -1 \
>   |   with expression of type 'char' is always true \
>   |   [-Werror,-Wtautological-constant-out-of-range-compare]
>   |   435 |         while ((opt = getopt(argc, argv, "mh")) != -1) {
>   |       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
>   | 1 error generated.
> 
> Correct by changing the char to int.
> 
> Fixes: bb6a88885fde ("selftests/bpf: Add options and frags to xdp_hw_metadata")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Thank you for the patch.
I saw the same failure when I built selftests/bpf for arm64.

With this patch ontop of today's next-20231102, fixes that build issue.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 17c0f92ff160..c3ba40d0b9de 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -430,7 +430,7 @@ static void print_usage(void)
>  
>  static void read_args(int argc, char *argv[])
>  {
> -	char opt;
> +	int opt;
>  
>  	while ((opt = getopt(argc, argv, "mh")) != -1) {
>  		switch (opt) {
> 
> base-commit: cb3c6a58be50c65014296aa3455cae0fa1e82eac
> -- 
> 2.40.1
> 

