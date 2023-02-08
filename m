Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047CD68E590
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 02:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBHBsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 20:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBHBsn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 20:48:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08357AAA
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 17:48:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so764572pjq.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Feb 2023 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaWmVwukI1ayQ/CHcE8yufMV7Id8NI5E9IHNugGw6TE=;
        b=boeq3f5yUhZov8hpw0E8yN/K7WkvFei34Oba03Q9i/pDEyKo/o9qITtDfoz6R3zeaJ
         ahHw9iSTuVAv4aLCpbOh0vwFO+EjpQFl0YItr/XLLGRgkG/KCxY8r1YUh7uBxHEOfeah
         8ag37wVrZoYsR+NuW3nA1zhNzJk/DhSzY4cUbqrCb2QBctLywku/lFYg2VeltvUNCRpQ
         3beMQDNfG6D8KFB2YqvhlBeNLcBAKFS30vJbQ1s+7Lvup0W4X8jj1PpD5kYpqm5p0d2/
         ln/QL9FqT0BTtryO06E7L9qnaf7eWqu09qY4lfdjTUpHv1js/g6XoRAnoEpXEiZTuMmk
         ZB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaWmVwukI1ayQ/CHcE8yufMV7Id8NI5E9IHNugGw6TE=;
        b=Tp/L5gZS5IvyVvVZM7ovcwIUre4ur72DnNg/Y8UonbzLDSKmoJy573aS58HXzOv0bE
         EkUR4p6M57BOK7S2XDGucEjg3zJxMRQg3VaoAJcz2mv6S25GXdCLJ0tth3/v0ygKsbmV
         0oSqthm3zk4aprPWqbRD+WC+ANc//ROyy+P0bhXVmdtKUnC/ihCvLN537LTCLIBOYx2g
         HHrK11rdMDrbt3VJ8ikei55p6MQhWkbK4WVSvy/Kwxj8iikULLJpD/sDowm/d8XXhjpK
         6SM6ET+LyVN/jozx23y6wJdI0hN1cKLTISz8z6FAhmB5fTQNLbjRgJlHHwDNBW8y2gcz
         E1UQ==
X-Gm-Message-State: AO0yUKV1iOekeBm3sLuEHawoXl72CHe8G6Ash55X6VzVIjIp+FZ4K6LD
        sf5+2ULPZs318wYLLczhPkO8OQ==
X-Google-Smtp-Source: AK7set/pP1FRr7jt6j9nqI06yKqTZM/V7+D23d9yLYh6Y7Vn/ookEMRRIWeJyV2n1HV21mzVW2fJhQ==
X-Received: by 2002:a17:902:c20d:b0:198:af50:e4e0 with SMTP id 13-20020a170902c20d00b00198af50e4e0mr115157pll.6.1675820921284;
        Tue, 07 Feb 2023 17:48:41 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001992fc0a8eesm2105493plb.174.2023.02.07.17.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:48:40 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:48:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 4/4] KVM: selftests: x86: Repeat the checking of xheader
 when IA32_XFD[18] is set in amx_test
Message-ID: <Y+L/deE3+Uywm4kE@google.com>
References: <20230110185823.1856951-1-mizhang@google.com>
 <20230110185823.1856951-5-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185823.1856951-5-mizhang@google.com>
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
> Repeat the checking of AMX component in xheader after xsavec when

s/xsavec/XSAVEC.  Not sure about xheader, though it seems like that should be
capitalized too.

> IA32_XFD[18] is set. This check calibrates the functionality scope of

s/18/XTILEDATA

> IA32_XFD: it does not intercept the XSAVE state management.

I didn't follow this.  Is this basically saying "Verify XTILEDATA is saved by
XSAVEC even when disabled via IA32_XFD"?

> Regardless of the values in IA32_XFD, AMX component state will still be
> managed by XSAVE* and XRSTOR* as long as XCR[18:17] are set.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index 18203e399e9d..9a80a59b64e6 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -235,6 +235,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
>  
>  	/* xfd=0x40000, disable amx tiledata */
>  	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
> +
> +	/*
> +	 * Bit 18 is cleared in XSTATE_BV but set in XCOMP_BV, this property

s/Bit 18/XTILEDATA

> +	 * remains the same even when IA32_XFD disables amx tiledata.

I would phrase this as "even when AMX tile data is disabled via IA32_XFD".
Software disables AMX, IA32_XFD is the mechanic by which that is done.

> +	 */
> +	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
> +	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
> +	GUEST_ASSERT((get_xcompbv(xsave_data) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);

Same feedback about using !(...) and unnecessary "== x".

> +
>  	GUEST_SYNC(6);
>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
>  	set_tilecfg(amx_cfg);
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
