Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E013AD536
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFRWdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFRWdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 18:33:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA6C061574;
        Fri, 18 Jun 2021 15:31:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g12so8758507qtb.2;
        Fri, 18 Jun 2021 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3hKwBiwkFtX8Quhcjsyp4PHnp2ob2D51MYzkaHMQegg=;
        b=qnGWS66cjqd6rNhCqCBrV8KmXirBAx3VifmQ4MnoxQo4dPVXQEfP9yTZGa1WZHiJpZ
         91kwPkjVGRSPIuk3F381E3fNTk9ltpGb4et8x8siPTifgy0PJT8/tnlIFdlG0h/1dXOL
         8DWXya5D92ebT/ThQtygKGSf2SBd8haJGUCTQDw5SEqkiDp6dNYza4bQorCur7FL1maj
         cewrabaTR3mVAWIGxX1vY3zDkqkWN/IJNOVq7sbR7RlgIGb8f7iR8BVDiIINAKEmrEwL
         NNWR6rDKMinIgc8OfTWP002DlTcZtuRhAqcAYdu+Ur4UhwLoZhw7hPdIdT73ZdhyNpyx
         O+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hKwBiwkFtX8Quhcjsyp4PHnp2ob2D51MYzkaHMQegg=;
        b=F9SqMeIsVkC2kuRLKW7z3d3W8WEpEtzkbPnd9tZyBNStUbPmgYi/XOzEuNz1XJE7m6
         yqNr/MUV5qqjf8YgzZ11RJkTkm2txmmH1I6QQtZKXebfE3f/0gpcBhQylzu3xVKTbgcx
         3tZwOTnwzBa/u4bnoj2z9HjRSajgAZMCEmnRH7AtV6kU4gOMRGStbBHnX9Sz4eaG5cnc
         fv0ZYg3jhWl8OEvkBPsIRleOqZmCKc1tBtSNj74WtjxM3rcsoNZnC+cdjWkHQYo6eEqP
         o8UCKiknL/71Y5ZuNd6v564MYHrkinMZf92pzedTIFbj4jyVtpa74Babj1zRJtIjh5c2
         SmeQ==
X-Gm-Message-State: AOAM530oKYUphT1dsQpknn68PxKYHt6e6UW+Ly+GijsSYe7jlLu3U2lt
        n39tWDq6AS7fMSAtAGDxav0=
X-Google-Smtp-Source: ABdhPJypzDrCnYiXRpijNJ6cfKxcSk4IskDJYkDufgt5VSNVdFBJ87VeepJhtqeypZUCvfghlNA1uA==
X-Received: by 2002:ac8:4e29:: with SMTP id d9mr13230533qtw.136.1624055486314;
        Fri, 18 Jun 2021 15:31:26 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o14sm3269929qtx.62.2021.06.18.15.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:31:25 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:31:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v1 1/1] tools: Rename bitmap_alloc() to bitmap_zalloc()
Message-ID: <YM0evEbGPG9J73sU@yury-ThinkPad>
References: <20210618143854.62967-1-andriy.shevchenko@linux.intel.com>
 <YMz80O2mkEWyl2Xx@yury-ThinkPad>
 <CAHp75Veti-7h=BoH9ZXXPMS1e8gq3rb19QS4TAB1J33GTdLKRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Veti-7h=BoH9ZXXPMS1e8gq3rb19QS4TAB1J33GTdLKRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 19, 2021 at 12:36:44AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 18, 2021 at 11:11 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Fri, Jun 18, 2021 at 05:38:54PM +0300, Andy Shevchenko wrote:
> > > Rename bitmap_alloc() to bitmap_zalloc() in tools to follow new coming
> > > bitmap API extension in kernel.
> >
> > Can you please tell more about the new coming extensions?
> 
> Ah, this is outdated text. It was about the time when bitmap_*alloc()
> was introduced in the kernel.
> 
> > Anyways,
> > Acked-by: Yury Norov <ynorov@caviumnetworks.com>
> >
> > All bitmap patches together can be found here:
> > https://github.com/norov/linux/commits/bm-f1
> 
> Should I resend with that fixed (I have also noticed that your address
> in Suggested-by is outdated)?

Yes. Please use

Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
