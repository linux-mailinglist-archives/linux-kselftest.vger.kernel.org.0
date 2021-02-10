Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245583171CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBJU6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Feb 2021 15:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhBJU5t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Feb 2021 15:57:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B6C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Feb 2021 12:57:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l18so1886232pji.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Feb 2021 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBdoDN4qUUxmt8foO21and0+vT2d9JjhkDei+WMEUH0=;
        b=mhFHQFCT+3e5bIYcmTDo4QJG0JcHISUmF9GY7zp+RDHOMM2y8nwUWj0HipdGJffsbE
         a28r764RbTXh6sJEtPl2Rv7hXb5uScspoSlhinGpILswgx6NXjHVi1ncQpBpT3z+M3F5
         q6X0ZFCMDFRK6FGuBbaWSPsgwAH0TD6ZWePkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBdoDN4qUUxmt8foO21and0+vT2d9JjhkDei+WMEUH0=;
        b=kMxcQ/HP5hpR3IiLmhPhIzmLbtWeABbBr6z6+DX5TFP+Axevx4Hd7/MVv5aaLOhCm8
         +CcHRDx5s/XMCqSGfltD4sUXovAPKGii7akJbYkXCelZvUb9TitYaRCDq0uaTh9yR2OT
         IxCSzyslXPqivd3E534ERc+/CbJlDFwZzaUcE1J5ohdh+N8RNplweSQAmcYtqRxtcTPr
         L0bPq9a4szV5o91FDDTycZW+hYpVZKdencnijVa4Qrufc3aY91FgzcwivIklGsmwpkVT
         upGm55A6ceOqt0mwnrnYYtnUoRhgkUCX/jc/72DiJHmRJkjyNWpgeZBPNT04LAakChRB
         20wQ==
X-Gm-Message-State: AOAM533avUF3o3FRBYnQo6Lqp4jYxIvUWV8lMhPh0MKYulg1ACp7H9SE
        syzSpCpfE8Xx62pAjSC4k1Qvsg==
X-Google-Smtp-Source: ABdhPJzThXp2N8kuqFIOb3zp7b7bzhecd3pgcZxZhwI8/Jz9CiYHNneuzYgZwWk8iceJZQD8McZZZA==
X-Received: by 2002:a17:90a:6707:: with SMTP id n7mr798488pjj.88.1612990628444;
        Wed, 10 Feb 2021 12:57:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm3023315pgu.4.2021.02.10.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:57:07 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:57:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] selftests/harness: pass variant to teardown
Message-ID: <202102101255.D901256A@keescook>
References: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
 <202012111013.46FEA48C@keescook>
 <CA+FuTSdVS5Q7mw-of93T3=501J-PO_eXuNzRKwFg4vUd6xUvZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSdVS5Q7mw-of93T3=501J-PO_eXuNzRKwFg4vUd6xUvZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Any news on these? I'd like to see them.

-Kees

On Fri, Feb 05, 2021 at 10:11:52PM -0500, Willem de Bruijn wrote:
> On Fri, Dec 11, 2020 at 1:15 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Dec 10, 2020 at 06:10:10PM -0500, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as variant.
> > >
> > > In some cases, the variant will change the setup, such that expections
> > > also change on teardown. Also pass variant to FIXTURE_TEARDOWN.
> > >
> > > The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
> > > right above.
> > >
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >
> > Thanks! This was on my TODO list. :)
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Is this patch staged to be merged as is? Should I resubmit it?
> 
> Same question for another slightly older (2020-11-23) kselftest patch:
> 
>     tools/testing: add kselftest shell helper library
>     https://patchwork.kernel.org/project/linux-kselftest/patch/20201123162508.585279-1-willemdebruijn.kernel@gmail.com/
> 
> Thanks,
> 
>   Willem

-- 
Kees Cook
