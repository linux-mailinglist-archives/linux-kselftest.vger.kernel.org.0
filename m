Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12A7AED43
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjIZMyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjIZMym (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 08:54:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C27C9;
        Tue, 26 Sep 2023 05:54:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c02e232c48so147836521fa.1;
        Tue, 26 Sep 2023 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732874; x=1696337674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSSA76tbtMgsClZO2PhtmBjLBmv/PWyp0ZgUSY7GNBs=;
        b=P/GXb1y5F1+m/mcwe/HJu7pVCUrv4gWMSdvaFPYsCyoEJgHlRfnogLZJg8v2R3uE+b
         MtkRiYL1oDaxK9cu/vfjMClo/b8KAz64nxvQfxWnkwOSFmIrLr44w/D9Adez0XpFmFP/
         5WaD8opLfXOybOSnllonoZek2QsDhz42wzgHOUCf4oEYIpG26lJkREowVdZuTKQgugK/
         cK8YXmVyVOH5oephSY9i1TFI/kXzrVJ0BTNEi6HFLoWNxfTJCpES0Lt+y9dyoPufHRGW
         tC8novXp1zL9wSLxcOg/Y+JRdt0c1COgK+bVbsg7o7ZImXe4vK56zD3cw4zuGhu7aWSE
         MAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732874; x=1696337674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSSA76tbtMgsClZO2PhtmBjLBmv/PWyp0ZgUSY7GNBs=;
        b=J35l5WgTBIkRFGnyYFEcUEdU0XaHsIrTn/QLz1d963R/CKMf2Ry5RJ1XfeSopn5/od
         3DkGj1eWHCNQiopwkwG3HiDkTuA/XmXD3KkwZ6ufZD72B+vj+9uFM09MMqXlW8TnIabW
         nozUP/ivFwZoLzIWinrUTE0i0erCwTY6uu1/GGvACQ0BT4HQm/Eu02umFohRkXQ+/S8y
         +PgF1/z7b5ha3gZzozqPWQ8IAakE4sJjWbFHRKHp2ZqhsM5e5NxSSrlY0hC2MgXEbCDW
         36cnOQwd/A/pNh8T9qoNQJdVAgSAyr2svBKp/IsIkfRXufedjObLgSUhRs73+qg7fl/M
         9TqA==
X-Gm-Message-State: AOJu0Yzf1m/QxaGes4NhklJZiA0ipXnXdFj/l6Rvw4fjHoD8OCy5/pgR
        GL/HAlP49JzoMa8wOGda5ko=
X-Google-Smtp-Source: AGHT+IEPvklHw0p3Crq2PTux3ivV5HO1SBeCs+IvL0I3tYCNQrjzF4d3c3KB2oyW1xw3xIZcHQ3l9g==
X-Received: by 2002:a2e:88c6:0:b0:2c0:1673:53af with SMTP id a6-20020a2e88c6000000b002c0167353afmr7995991ljk.14.1695732873666;
        Tue, 26 Sep 2023 05:54:33 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lg15-20020a170906f88f00b0099d0a8ccb5fsm7641329ejb.152.2023.09.26.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:54:33 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Sep 2023 14:54:31 +0200
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v1] bpf/selftests: improve arg parsing in
 test_verifier
Message-ID: <ZRLUhxycLfWgefhC@krava>
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

SNIP

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

this looks like unnecessary loop, the code before is easy to understand,
could we just do the args check on isdigit and valid index value in there?

jirka

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
