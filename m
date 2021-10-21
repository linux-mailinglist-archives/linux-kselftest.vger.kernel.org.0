Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A8436BCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhJUUMk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJUUMh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 16:12:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC8C061243
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so4023535pjl.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s1+yeGZaBzg+DezicZ/S6RHWxeVrK0TuafKlv+G0xjQ=;
        b=EVANbVhuKeeWYQIcn7fQOXbd1T2PwQDfbVieAkktbi+BjSgOHLLzFKAPgw4SV4AHbN
         mFbenZ0P/2cuckeJEs+U5N7XMQ6Th8ZYlWsvNijcJ6uthuX2rDJOE5u5YKi8XJW7IOV/
         6eQFtmVgdxEToNtR0hrlXfpEANf+fgtYlACP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1+yeGZaBzg+DezicZ/S6RHWxeVrK0TuafKlv+G0xjQ=;
        b=mOKJ5BINCSO62QiI6y8LtMZ8yUG3NcEY+ahVnQpq8VMxYoAmfmTUPUgoIqHxygj2uu
         w3NKc03kPh8MwST6KjRBgVjnU7vXsFtjN+x4tgWxQO8DbiUeIn/j/BNC+C3Ld9eWLZaJ
         t71SBu6UD0FeDMb3QeUElBx8CI7g/zr0NDX9q5YQHZoETx1O0ymYt0gHyxsY8eDOfe9a
         9gduSuoUAz0EBpBVYDDleCUSjhSheSVJFn41K8ikyQK1MQ75SUnaJNxHHB1BzTz3TAr6
         EEuosUfVjgl2FSXkQzzG1E50FVJgPnjRPQ31CzgIjhM7oUuEvcZbT44FQ/kFmNtshXWZ
         WqPg==
X-Gm-Message-State: AOAM531vjT5c3Jy1vdfn4JUVqJd6ZphTr24Mbxq9oE3tbU34qxFmzsBT
        zN2FpcIoIjn4KtV8n3ElWyoDqw==
X-Google-Smtp-Source: ABdhPJxCvQAVXdM2Ce6Kgyx1ISIlaRS4sllWhsl1Vw4PA9wUov2YtR7y2YSEZwksZFFzJsN0YeLcrg==
X-Received: by 2002:a17:903:1c6:b0:13f:2b8:afe8 with SMTP id e6-20020a17090301c600b0013f02b8afe8mr7205298plh.81.1634847020362;
        Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b130sm7124117pfb.9.2021.10.21.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:10:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110211309.A4DFAE27@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <202110211008.CC8B26A@keescook>
 <20211021193033.GW174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021193033.GW174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 09:30:33PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 21, 2021 at 10:09:33AM -0700, Kees Cook wrote:
> 
> > > Hi Peter,
> > > 
> > > Can you add this to the wchan series, please? This should help wchan from
> > > regressing in the future, and allow us to notice if the depth accidentally
> > > changes, like Mark saw.
> > > ---
> > 
> > I'd like to make sure we have a regression test for this. Will you add
> > this to the wchan series please?
> 
> I have it there, but it's in the part that didn't make it in yet. I'm
> currently in the progress of reworking that.
> 
> Do you want it it ahead of all that?

Nah, that's fine. I'm not in any rush; I just wanted to make sure it
didn't get lost. I didn't realize it was already there (I had only seen
the -tip emails). Sorry for the noise; thanks!

-Kees

-- 
Kees Cook
