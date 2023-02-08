Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204168E549
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 02:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBHBNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 20:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHBNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 20:13:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF24109A
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 17:13:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k13so17629375plg.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Feb 2023 17:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zW+dGDrJ/7CKPYl1S1HdzF90Gp3qx38oCHVTCV5NvVI=;
        b=iCgdw3e57QA5XdqNJxCjZ3s1kTMK0uLlewm9c4uEjjdy0lRn+EPviIU1Nl+G5Sqwc4
         ++IlFJsNhuVxUoJsMsjEAlR3kmlwUJPW3Z/4GygyYoYT6SQjPl7XeKz81APbrE4wylMO
         P9JtqCSdJVEOECNqBkSZUQFfkHqjUGZV3SnRHFzJ34mTgpUv52lR+T3Acy1Q1W8dbDJM
         HYt+HU7I1ju39g6t0zyOL1cefKKcBWG2BAOzV0I+TI55KoTZRk2nlXFRkZdkWbmo6ABi
         OwXjBngd+Nwy7R702n+dkgWuOMlUGja2f2djsbijn+hkKgOt9/kC2C1oPXGK1lhFw1MB
         vMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW+dGDrJ/7CKPYl1S1HdzF90Gp3qx38oCHVTCV5NvVI=;
        b=GW29W6isfwxngvUVsSxnkMqN1XYVNkbTxi17qYU1+AJ4rHYcruMIUfkPeEfJpuNB5S
         ffppeNsodwPURKveuYFJMCOi0lNoLa0L0aHJy2wq5741TiXJLmV7pB9kJphXcvvh2BwO
         +U38mzF/WmM9yJCfrUvE63uu34yKqrt9fRmUwblauAQjECVmB9GRq97smekTdkcKN6VL
         xWTlFoH14Mr16PnozyRiJLEav3VPLcE8P1Dt0Ulytq9wY7SaCOPf36hGYrpWAEsiz7lH
         itH6SP/S4eovdutaX7TuUZ9UpkiDrpjE6GSD9Obr2xJWWILenR8DNp29l4pjW3lDP1Fz
         gbQg==
X-Gm-Message-State: AO0yUKVena6t9xI0d19kR5Zmrl73H+fFy7LAdZ8VOEQmNQ5Xs/66Ako4
        lRvx+VJGIgc/3XTEOrikHoVbpQ==
X-Google-Smtp-Source: AK7set/y0aqSCXYGJ/s0hrVM+IdBy+QaRtdcwPTgIj70PWILXLf0XNoSZUMXZZvDEn5mEBUrEjoQWA==
X-Received: by 2002:a17:902:788b:b0:194:6d3c:38a5 with SMTP id q11-20020a170902788b00b001946d3c38a5mr58776pll.1.1675818786649;
        Tue, 07 Feb 2023 17:13:06 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm9885442pfd.106.2023.02.07.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:13:06 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:13:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 1/4] KVM: selftests: x86: Fix an error in comment of
 amx_test
Message-ID: <Y+L3HlFDRy+UiUSU@google.com>
References: <20230110185823.1856951-1-mizhang@google.com>
 <20230110185823.1856951-2-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185823.1856951-2-mizhang@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> After the execution of __tilerelease(), AMX component will be in INIT
> state. Therefore, execution of xsavec saving the AMX state into memory will

s/xsavec/XSAVEC

> cause the XSTATE_BV[18] cleared in xheader. However, the XCOMP_BV[18] will
> remain set. Fix the error in comment.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Venkatesh Srinivas <venkateshs@google.com>
> Cc: Aaron Lewis <aaronlewis@google.com>
> 

No need for a blank line.

> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index bd72c6eb3b67..16533949a189 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -204,7 +204,7 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
>  	GUEST_SYNC(4);
>  	__tilerelease();
>  	GUEST_SYNC(5);
> -	/* bit 18 not in the XCOMP_BV after xsavec() */
> +	/* bit 18 not in the XSTATE_BV after xsavec() */

I would rather overhaul the entire comment, e.g.

	/* Verify XTILEDATA is not set in XSTATE_BV after XSAVEC */

I had to look at the definition of XFEATURE_XTILEDATA to verify that yes, indeed,
bit 18 is XTILEDATA.

As for xsavec() vs. XSAVE, IIUC the clearing of XCOMP_BV[18] is a side effect of
XSAVEC the instruction, not something extra done by xsavec() the function.

>  	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
>  	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
>  	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
