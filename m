Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1077AED00
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjIZMlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjIZMlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 08:41:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27EEEB;
        Tue, 26 Sep 2023 05:40:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-534659061afso1271375a12.3;
        Tue, 26 Sep 2023 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732052; x=1696336852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/YRY9yQJk6mtkXHIe9rZvZZaiQwNs3B0gJlBYDdShz4=;
        b=Xi2XxTX3xArWBdetnfGWEnUDO/eXd4x1OaDIxhl499kqcPt79zew8Z1cwwPj78e1Pn
         3EKg1kgg3O3GcUgII0zhUM8euhQUk4hqpnXWmNRWGTabQPOpbevY3NzaMiQpBNzs6FCj
         h9XR3CI5/qW+AKUtaMkDk3TZcogGovRkFyYFBLOGkmb3qoT7PK0qjNEVYuamECXEuCxy
         +l4IRyBbbX68NisE35YLmAR3+nL+FdkQpdFfa8vlAlQ1sChLF0PAhke3xzEwa+1A9qrk
         hstIo8td561BQGCfogLMLTzimzzg4i45bpns3M0LO2GWjjwXEvLtHjx4hoPGpJKDZd2Y
         7Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732052; x=1696336852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YRY9yQJk6mtkXHIe9rZvZZaiQwNs3B0gJlBYDdShz4=;
        b=tONfrgijPhZIp84k0qx15aaE4lo98dFBBl8ELOLhG8EodeYb6XOqhpHUG+DvXjY9Pw
         /47e4rZf01OWflex/gNCza+VRjcTVCFH/DtDrxwPfHMQWjJeJPYxITv/BF1/l17I5GDX
         tururvYnbq0V8XMWueUKoXA3ImL6drOWjOpexac6ybXC9QsIvQYLeeo5Yni+m6NBGxeJ
         ajtPWpoLqBk8BaUMzI+XnZ49PHGBCRg3eCIpZNWVgCvIxGtkaxCwXBI9S0nKRoXjI/4r
         tIihc0uPLutQNUguNEINOWxCi2LBAULCmLXGL6JLflBbjBHE8+Ael+n0HlVUubIgSLdL
         e8+w==
X-Gm-Message-State: AOJu0YxkQE6nqq2tWBpiFPeRXgTXBEdZMpbCJtDdcHYCzeqVmXRHfXDI
        zIu8N0iq4g4NphYO77866E4=
X-Google-Smtp-Source: AGHT+IF8Bdu1wgi4OEbTgX8REMmOZ0IDM7txTkRoPoTX2SZd3bXWXkaQRg0+frzvdN8lSkDNuHq7Bg==
X-Received: by 2002:aa7:c755:0:b0:530:bbeb:571 with SMTP id c21-20020aa7c755000000b00530bbeb0571mr8885034eds.36.1695732051949;
        Tue, 26 Sep 2023 05:40:51 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402516700b0052f3471ccf6sm6768323ede.6.2023.09.26.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:40:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Sep 2023 14:40:49 +0200
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v1] bpf/selftests: improve arg parsing in
 test_verifier
Message-ID: <ZRLRUQEf7M4wa1HJ@krava>
References: <20230925233702.19466-1-Tony.Ambardar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925233702.19466-1-Tony.Ambardar@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 04:37:02PM -0700, Tony Ambardar wrote:
> Current test_verifier provides little feedback or argument validation,
> instead silently falling back to running all tests in case of user error
> or even expected use cases. Trying to do manual exploratory testing,
> switching between kernel versions (e.g. with varying tests), or working
> around problematic tests (e.g. kernel hangs/crashes) can be a frustrating
> experience.
> 
> Rework argument parsing to be more robust and strict, and provide basic
> help on errors. Clamp test ranges to valid values and add an option to
> list available built-in tests ("-l"). Default "test_verifier" behaviour
> (run all tests) is unchanged and backwards-compatible. Updated examples:
> 
>      $ test_verifier die die die     # previously ran all tests
>      Usage: test_verifier -l | [-v|-vv] [<tst_lo> [<tst_hi>]]
> 
>      $ test_verifier 700 9999        # runs test subset from 700 to end
> 
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 54 ++++++++++++---------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 98107e0452d3..3712b5363f60 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -10,9 +10,11 @@
>  #include <endian.h>
>  #include <asm/types.h>
>  #include <linux/types.h>
> +#include <linux/minmax.h>

this fails to compile

  BINARY   test_verifier
test_verifier.c:13:10: fatal error: linux/minmax.h: No such file or directory
   13 | #include <linux/minmax.h>
      |          ^~~~~~~~~~~~~~~~

looks like you could use perhaps <linux/kernel.h> instead?

jirka


>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <ctype.h>
>  #include <unistd.h>
>  #include <errno.h>
>  #include <string.h>
> @@ -1848,36 +1850,40 @@ int main(int argc, char **argv)
>  {
>  	unsigned int from = 0, to = ARRAY_SIZE(tests);
>  	bool unpriv = !is_admin();
> -	int arg = 1;
> -
> -	if (argc > 1 && strcmp(argv[1], "-v") == 0) {
> +	int i, arg = 1;
> +
> +	while (argc > 1 && *argv[arg] == '-') {
> +		if (strcmp(argv[arg], "-l") == 0) {
> +			for (i = from; i < to; i++)
> +				printf("#%d %s\n", i, tests[i].descr);
> +			return EXIT_SUCCESS;
> +		} else if (strcmp(argv[arg], "-v") == 0) {
> +			verbose = true;
> +			verif_log_level = 1;
> +		} else if (strcmp(argv[arg], "-vv") == 0) {
> +			verbose = true;
> +			verif_log_level = 2;
> +		} else
> +			goto out_help;
>  		arg++;
> -		verbose = true;
> -		verif_log_level = 1;
>  		argc--;
>  	}
> -	if (argc > 1 && strcmp(argv[1], "-vv") == 0) {
> -		arg++;
> -		verbose = true;
> -		verif_log_level = 2;
> -		argc--;
> -	}
> -
> -	if (argc == 3) {
> -		unsigned int l = atoi(argv[arg]);
> -		unsigned int u = atoi(argv[arg + 1]);
>  
> -		if (l < to && u < to) {
> -			from = l;
> -			to   = u + 1;
> -		}
> -	} else if (argc == 2) {
> -		unsigned int t = atoi(argv[arg]);
> +	for (i = 1; i <= 2 && argc > 1; i++, arg++, argc--) {
> +		unsigned int t = min(atoi(argv[arg]), ARRAY_SIZE(tests) - 1);
>  
> -		if (t < to) {
> +		if (!isdigit(*argv[arg]))
> +			goto out_help;
> +		if (i == 1)
>  			from = t;
> -			to   = t + 1;
> -		}
> +		to = t + 1;
> +	}
> +
> +	if (argc > 1) {
> +out_help:
> +		printf("Usage: %s -l | [-v|-vv] [<tst_lo> [<tst_hi>]]\n",
> +		       argv[0]);
> +		return EXIT_FAILURE;
>  	}
>  
>  	unpriv_disabled = get_unpriv_disabled();
> -- 
> 2.34.1
> 
> 
