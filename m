Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488B27B6ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1VRM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1VRL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 17:17:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88375C061755
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 14:17:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so1952501qtq.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TsieN2AyZd+fHurZfoVnAsK/371QDPaE9PSaaOsF10M=;
        b=E/E+O1Kdz8L/LgV+e3noNHmCUepRX8tYRdZmhvH1oqH1ALQLGP9YZ/dETKdHtGk05j
         wpvbZI+tcv1EpJog3kH/xRzfufYZLAbq6RvYEyNhs/6/SDQpmj5TkCNNlF085WCvLpfS
         QF38VkMXId3KqzhLsBF8KxCGWUfAw8jaSZCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TsieN2AyZd+fHurZfoVnAsK/371QDPaE9PSaaOsF10M=;
        b=kGZVVp1Mx2yQMIELLanhEv17aYUQ3jIbcr/vNIG/w3npcRtLhcOvVd/Pzqiza+5SMB
         xpo7W+gPQJlf+hjJ8aIp5ogsm5C10h3VkZxOyCO0oV0j++RreVWfIz6FAdkbwiVJDzjY
         dTeufLDI4sZk3qqOqREiO1rN3/9PsmmNNVk12NQGJxe977wc/vtE+3ptnqeQDOkLvP1X
         ovU0jsKEXqYr2VgdTxv6DDGWpX5d/9yYGXcHW4KjyCxlxxrwNzPCTJNNJA3MWQWzge52
         OXOihGrFM6C5uQeTmYtZdhh03OPIVAfyKhQFkgTWGRnlZFje2acpCE9CzLdJ42dEgpJf
         E4rw==
X-Gm-Message-State: AOAM530o+rzF7WDtba0EdncQR7CwYWCuapnle2sjjbe5DlGzJzs7Wh07
        Psz4cSkjxbivNMdohRRgL36e8w==
X-Google-Smtp-Source: ABdhPJzchTLFzFK6iluf3Jf7o3/ZyyOrcF3IVJNDVf1TIaEdhxhcd/ElF3y6FMMqh5p80QFSd1shxA==
X-Received: by 2002:aed:25d1:: with SMTP id y17mr11236qtc.375.1601327830218;
        Mon, 28 Sep 2020 14:17:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x26sm2483053qtr.78.2020.09.28.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:17:09 -0700 (PDT)
Date:   Mon, 28 Sep 2020 17:17:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200928211709.GA2641213@google.com>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <20200927233526.GA500818@google.com>
 <202009281331.444F36A7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009281331.444F36A7B@keescook>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 28, 2020 at 01:34:31PM -0700, Kees Cook wrote:
> On Sun, Sep 27, 2020 at 07:35:26PM -0400, Joel Fernandes wrote:
> > On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> > > This patch series is a result of discussion at the refcount_t BOF
> > > the Linux Plumbers Conference. In this discussion, we identified
> > > a need for looking closely and investigating atomic_t usages in
> > > the kernel when it is used strictly as a counter without it
> > > controlling object lifetimes and state changes.
> > > 
> > > There are a number of atomic_t usages in the kernel where atomic_t api
> > > is used strictly for counting and not for managing object lifetime. In
> > > some cases, atomic_t might not even be needed.
> > >     
> > > The purpose of these counters is twofold: 1. clearly differentiate
> > > atomic_t counters from atomic_t usages that guard object lifetimes,
> > > hence prone to overflow and underflow errors. It allows tools that scan
> > > for underflow and overflow on atomic_t usages to detect overflow and
> > > underflows to scan just the cases that are prone to errors. 2. provides
> > > non-atomic counters for cases where atomic isn't necessary.
> > 
> > Nice series :)
> > 
> > It appears there is no user of counter_simple in this series other than the
> > selftest. Would you be planning to add any conversions in the series itself,
> > for illustration of use? Sorry if I missed a usage.
> > 
> > Also how do we guard against atomicity of counter_simple RMW operations? Is
> > the implication that it should be guarded using other synchronization to
> > prevent lost-update problem?
> > 
> > Some more comments:
> > 
> > 1.  atomic RMW operations that have a return value are fully ordered. Would
> >     you be adding support to counter_simple for such ordering as well, for
> >     consistency?
> 
> No -- there is no atomicity guarantee for counter_simple. I would prefer
> counter_simple not exist at all, specifically for this reason.

Yeah I am ok with it not existing, especially also as there are no examples
of its conversion/usage in the series.

> > 2. I felt counter_atomic and counter_atomic64 would be nice equivalents to
> >    the atomic and atomic64 naming currently used (i.e. dropping the '32').
> >    However that is just my opinion and I am ok with either naming.
> 
> I had asked that they be size-named to avoid any confusion (i.e. we're
> making a new API).

Works for me.

Cheers,

 - Joel

