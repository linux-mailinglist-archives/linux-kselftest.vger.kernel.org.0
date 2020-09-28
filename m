Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D988327B661
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgI1Uee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgI1Uee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:34:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57EC0613CE
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:34:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so2232415pfd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fSqGGre3K5gDxqZQhBBAgkB/XW4ArHnxdL9/PVe8UEw=;
        b=NhEgCMqvIk+RvaHqH61RFdho/oyavhy1mnawXx73Z32KtMmWrdQ3TF3Wdl5xGJWAF4
         HJ7MvCec9xWmOfe2vmH4pRHVPw4F2RLEFJS+4IHA6SOXqWq1vixOup+3/VsF76zS/3fH
         NNK2l+sjcwTbNoDengDe+AnKeGhAQtj5ceh68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSqGGre3K5gDxqZQhBBAgkB/XW4ArHnxdL9/PVe8UEw=;
        b=Ofpi3crUahM8pxJu8yaUYCxEdo6Zgnl9kKGlJJ4B8kYKryCrpcgdFPlO+BsCFRoGdL
         6pcS+Uw+H1ooiKa6sNN2mRBmCaYm8DCdt6DWMOkpm7+Aeil/4q04dPnfdBHxI9kFirBB
         AWxt2oaTjR0CbVBshxS/hfNyKlXoRbRa7TCnCi82WZAA6+7CpAhDA9aE8SoRCloNNUm0
         jmIZNVOZIzPgIY5eiDEaz767PTGa/ci6HV5s1DxdN6jkU4pxDw3aoXrfByZvZozYJsfH
         b46Gj+8swG3VoZHg74iRH+jrxYyzWDLyM0Q6ydXsD5EDpEw076gGUC1gm6cmLuyRBEuL
         BZ8A==
X-Gm-Message-State: AOAM532FUKCpYsbTiOQ+RgGom587uJ7CQpEw6o+wE5lOLBH565Ad+jMl
        QX5Yt4IPcbDea1+JZAnoRFPSrw==
X-Google-Smtp-Source: ABdhPJyzYBgjXDVfi/ERFQgeS7WYZoqBnC+zZTP9Vn+PQLPLjF+pMQ37sNjCiSdOAaPnfO95UdERzg==
X-Received: by 2002:a17:902:7589:b029:d2:686a:4ede with SMTP id j9-20020a1709027589b02900d2686a4edemr1142882pll.45.1601325273788;
        Mon, 28 Sep 2020 13:34:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm2209702pgm.42.2020.09.28.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:34:32 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:34:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, shuah@kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, arve@android.com,
        tkjos@android.com, maco@android.com, christian@brauner.io,
        hridya@google.com, surenb@google.com, minyard@acm.org,
        arnd@arndb.de, mchehab@kernel.org, rric@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Message-ID: <202009281331.444F36A7B@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <20200927233526.GA500818@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927233526.GA500818@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 27, 2020 at 07:35:26PM -0400, Joel Fernandes wrote:
> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> > This patch series is a result of discussion at the refcount_t BOF
> > the Linux Plumbers Conference. In this discussion, we identified
> > a need for looking closely and investigating atomic_t usages in
> > the kernel when it is used strictly as a counter without it
> > controlling object lifetimes and state changes.
> > 
> > There are a number of atomic_t usages in the kernel where atomic_t api
> > is used strictly for counting and not for managing object lifetime. In
> > some cases, atomic_t might not even be needed.
> >     
> > The purpose of these counters is twofold: 1. clearly differentiate
> > atomic_t counters from atomic_t usages that guard object lifetimes,
> > hence prone to overflow and underflow errors. It allows tools that scan
> > for underflow and overflow on atomic_t usages to detect overflow and
> > underflows to scan just the cases that are prone to errors. 2. provides
> > non-atomic counters for cases where atomic isn't necessary.
> 
> Nice series :)
> 
> It appears there is no user of counter_simple in this series other than the
> selftest. Would you be planning to add any conversions in the series itself,
> for illustration of use? Sorry if I missed a usage.
> 
> Also how do we guard against atomicity of counter_simple RMW operations? Is
> the implication that it should be guarded using other synchronization to
> prevent lost-update problem?
> 
> Some more comments:
> 
> 1.  atomic RMW operations that have a return value are fully ordered. Would
>     you be adding support to counter_simple for such ordering as well, for
>     consistency?

No -- there is no atomicity guarantee for counter_simple. I would prefer
counter_simple not exist at all, specifically for this reason.

> 2. I felt counter_atomic and counter_atomic64 would be nice equivalents to
>    the atomic and atomic64 naming currently used (i.e. dropping the '32').
>    However that is just my opinion and I am ok with either naming.

I had asked that they be size-named to avoid any confusion (i.e. we're
making a new API).

-- 
Kees Cook
