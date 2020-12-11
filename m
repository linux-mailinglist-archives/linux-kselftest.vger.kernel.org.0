Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE02D6D13
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 02:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgLKBIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 20:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390348AbgLKBH6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 20:07:58 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187DC0613D6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:07:18 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2so5901081pfq.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXu6ntY4gEIjPODsEHuuJEaNmuWNjsKwEG4zl/z4Pz8=;
        b=vexfsCnkOKuFzCo43v4pUfxcjTGF6DGDwYFAN6Q6ByQlBjhxINfys96jig8RVQk6Al
         r+zc9DMuVgWpKfjjLU1hZ/vOiSxYuwANeILrzdZfwGeBtAXaEsBO0aCRL1+H/Ffa9WsC
         olDwHkkDX85ytcvhAsXkSVwmpPkveU/LJc4z/HXtHy1fTAP0sUbtqg5+k9Mk2WtLqXyu
         vFjEluZMOfVlUjtYa4MoF1LVFvU+xBF7dd73MAICCFshzPHrSufWm5ZYGvzn3VoYKfR5
         GW5957eGQKzehDrIUtkUcblm3R6nI3m66l2Db1oP/Szzydv2ngnuWJBUt43Hp9SHn0oY
         d2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXu6ntY4gEIjPODsEHuuJEaNmuWNjsKwEG4zl/z4Pz8=;
        b=BKNIU/DwqsC7cjKEC27mUPXH4T9xne5vCLFjYsBuJ631SMtWvgN3BTOJaz57ILGtpP
         PibHJ/L8p/9UKtZvsG1nEyFyfSYcGgEoJ3T5ZRJzr/jLhKaIfM9tYwLi6+CK8ZboN7y8
         hXs/cfKmvwTTM3gbu5rVzd9NT/fwDYBkG5I6FxcydOzSb0tqvCtYBq33WcfHzhtD7Avf
         jF7HkPpIsoLjEpttXJ2yU1GSOPSyJitxXpr5N47tfrCqU46KnS7eiXmjFVdiNnepLpAo
         0FbEGTk+x75SpJZ9mfT9OXrOp1PDKGD2mvOvtDidr47Kwtl8ZCA8KDWrBvYQkBFj15IN
         t4zw==
X-Gm-Message-State: AOAM530prWSuYrK5Nft/AwSMjUA2kNiZNu9mkfl/QOkbf3/MLW4pRRNj
        kt5t7VaXuT/AHF/EY8ZHb/LGXdK2vpIeYg==
X-Google-Smtp-Source: ABdhPJwSR8mC/mRqWH1NKU8ZC/YCMcWQWmmR8HXyFnDq9QlWrRSirJs3VN2mbvYmYlSB3j1UlZ7tPg==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr10475698pjb.48.1607648837911;
        Thu, 10 Dec 2020 17:07:17 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id w2sm8150536pjb.22.2020.12.10.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:07:17 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:07:11 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH] selftests: kvm: remove reassignment of non-absolute
 variables
Message-ID: <X9LGPwstuFU1HzRT@google.com>
References: <20201210043611.3156624-1-morbo@google.com>
 <X9LCQYB2yqMaUqkj@google.com>
 <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020, Bill Wendling wrote:
> On Thu, Dec 10, 2020 at 4:50 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, Dec 09, 2020, Bill Wendling wrote:
> > > Clang's integrated assembler does not allow symbols with non-absolute
> > > values to be reassigned. Modify the interrupt entry loop macro to be
> > > compatible with IAS by using a label and an offset.
> > >
> > > Cc: Jian Cai <caij2003@gmail.com>
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> > > ---
> > >  tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > index aaf7bc7d2ce1..3f9181e9a0a7 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > +++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > @@ -54,9 +54,9 @@ idt_handlers:
> > >       .align 8
> > >
> > >       /* Fetch current address and append it to idt_handlers. */
> > > -     current_handler = .
> > > +0 :
> > >  .pushsection .rodata
> > > -.quad current_handler
> > > +     .quad 0b
> >
> > Bit of a silly nit: can we use a named label, or at least a non-zero shorthand?
> > It's really easy to misread "0b" as zeroing out the value, at least for me.
> >
> I don't believe that will work. If I rename "0 :" to something more
> concrete, like ".Lcurrent :", then the label's redefined because of
> the ".rept". If I assign the "0b" to something, we're back with the
> unmodified code, which clang issues an error for:
> 
> <instantiation>:3500:6: error: invalid reassignment of non-absolute variable 'x'
>  x = 0b
>      ^
> <instantiation>:2:2: note: while in macro instantiation
>  .rept 255 - 18 + 1

Boo.  I assume 1: and 1b work?  Or my KVM favorite "666:" :-)  That's enough to
at least make me pause and actually read the code.

>  ^
> 
> > >  .popsection
> > >
> > >       .if ! \has_error
> > > --
> > > 2.29.2.576.ga3fc446d84-goog
> > >
