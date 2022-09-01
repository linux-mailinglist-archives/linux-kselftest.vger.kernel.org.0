Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CCF5A9BAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiIAPaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiIAPaC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 11:30:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489D1119
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 08:29:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2757781pjq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Sep 2022 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uEj+Y7Y/+YOHMSskQFWNi+2HHQDrIeW3yFZoL+MzmCA=;
        b=XnJ2wsCxF8tcfraG5sEl0nCNjGP9Bilt7of9qMjRKEcLdnCtKg/Y/70LxLSz5b/LQW
         HB7FwbLhalHN/C3kOLN1pB2v/LJyTHSucRh85pppfXgfAzvejP4gPJFlfiU8Q+KnCQmU
         yPdk/503lGXLXQ71TW81D1UxFpAE9siiVke4rKqb/jPQ2gGYMfU6ln/flqL9VNl+PH3C
         0Fv+RojMJYsoBEaBN7p0QfRr4O/7KG5Ylhr9ReSQf80+DUFAXTVV5+CiTRkMurXAdzAk
         lZRuywlOuVc01HdjcAYq125MKpHz8Zmk3KfemiIY9iKxSPCbb/hwFo07lNSf8jt/YxaF
         1i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uEj+Y7Y/+YOHMSskQFWNi+2HHQDrIeW3yFZoL+MzmCA=;
        b=vuLaBl/XEFCnqFILEdn4IezkOUh6HFILulsmQg0i+bumNzZc8Kzmg8altczQan+Qvy
         DLiCxHzYX/S5P43BbZ0eLu1psiqRE8H6lDCAVuFcev5WY9eejmTSy3Jax7DHjwIlu+YH
         /qvvoGgb6gYiuC1EKfM62jc4QjcWl8La5P23qOOjz6VsX3D7zkXvQl97KiIfd6D/OCAR
         O7/CaTgxaoc5dQnHyI033K4uAuo5wXnRfqVVqTSHhDV1eRsLLj93HzYbkhr/UIHDZrmj
         1JTJxhfwxzNpBLTWtpcVsemTx+FrT3WF1VD0odHrwFTuCqVl0/hICfxoGPa7I4YxWJNu
         pe4w==
X-Gm-Message-State: ACgBeo03Cu4WjdTTznGIDsDgw6u4AAoHQKIyysRtDSVy7SpLa8lMijOb
        ojAoEXUGVHWUCt6tea5AuSCFrQ==
X-Google-Smtp-Source: AA6agR6g/blRPHq0d3n7aMFn6OtHPk3vvVO7+7+iZmO5GTldkf85RNK960XEeC83SwKhjZRzxu+kdA==
X-Received: by 2002:a17:90b:1d0f:b0:1fe:4171:6e6f with SMTP id on15-20020a17090b1d0f00b001fe41716e6fmr5633707pjb.206.1662046191185;
        Thu, 01 Sep 2022 08:29:51 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001708c4ebbaesm13590277plg.309.2022.09.01.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:29:50 -0700 (PDT)
Date:   Thu, 1 Sep 2022 15:29:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>,
        Borislav Petkov <bp@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] x86/fpu: Allow PKRU to be (once again) written by
 ptrace.
Message-ID: <YxDP6jie4cwzZIHp@google.com>
References: <20220829194905.81713-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829194905.81713-1-khuey@kylehuey.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 29, 2022, Kyle Huey wrote:
> @@ -1246,6 +1246,21 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
>  		}
>  	}
>  
> +	/*
> +	 * Update the user protection key storage. Allow KVM to
> +	 * pass in a NULL pkru pointer if the mask bit is unset
> +	 * for its legacy ABI behavior.
> +	 */
> +	if (pkru)
> +		*pkru = 0;
> +
> +	if (hdr.xfeatures & XFEATURE_MASK_PKRU) {
> +		struct pkru_state *xpkru;
> +
> +		xpkru = __raw_xsave_addr(xsave, XFEATURE_PKRU);
> +		*pkru = xpkru->pkru;
> +	}

What about writing this as:

	if (hdr.xfeatures & XFEATURE_MASK_PKRU) {
		...

		*pkru = xpkru->pkru;
	} else if (pkru) {
		*pkru = 0;
	}

to make it slightly more obvious that @pkru must be non-NULL if the feature flag
is enabled?

Or we could be paranoid, though I'm not sure this is worthwhile.

	if ((hdr.xfeatures & XFEATURE_MASK_PKRU) &&
	    !WARN_ON_ONCE(!pkru)) {
		...

		*pkru = xpkru->pkru;
	} else if (pkru) {
		*pkru = 0;
	}


Otherwise, looks good from a KVM perspective.  Thanks!
