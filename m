Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8DE279258
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIYUiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgIYUif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 16:38:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0BC0613AF
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z18so4352568pfg.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xalch59fDuEKl76YuuW9L6ISBYkH/TTx0Ff+RgikJxo=;
        b=hYaTNdNHJvLXhzfO+DdQhP+Y6AQFVGOXPqty1ToYGSxhw3Gg9u0qORgOjwXhmBR7X+
         3RBtz3lDH0PW6AmY/qY7MMzKY6CsGoSJzyEB+byHzQg5n948zglNKeCBqL+BXCy6ISuz
         pLQE8ykuQBc1+Zol1mYktHi8NsaELoQn/dyBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xalch59fDuEKl76YuuW9L6ISBYkH/TTx0Ff+RgikJxo=;
        b=p/tXZNw2grXVVtmCHijtEKRrAzebBbvBVMWwkaKFe3iqstu6w6XjEq+wavrFx763FQ
         ESyZ/ax2QVMyNqmL3jAbsAatZwoZLGK9p4yzYGaQI9EXD8abVqFlvh1pAmJ9/MsWJyVd
         V9GZ7OL2Es8RLBolLmiaUX4w8VAoCXcKPCgmi7LkcWfzM7OlBvLRUS2iA5PAifsY1UT0
         clcAjCZFWLDtfNwCKpvTxJLsmETvJEQQwmTHMywyYguX37bp6ST9uxepzzHCywc5PZCE
         ON808BkyTQPCcJUaIHTgU/RZZ9mszP7fWXBCf5d9oFFPGgfweqX7RvGHP7C7YK10kbpf
         hsOA==
X-Gm-Message-State: AOAM531Iu9RjKWGnCivHaUphiwF5h0GqqOA0KSUUIAerN60LSJYx4ROk
        fADx8HbbPLOQtglZ8MnuVPodUQ==
X-Google-Smtp-Source: ABdhPJzmfj4AEPYzK8yIYg6dWta0UdlI0MvUEx+twtC6hiM5Se1DgdD+x9UOcYpIEItGRJ46ESH7fA==
X-Received: by 2002:a17:902:c252:b029:d2:4345:5c7 with SMTP id 18-20020a170902c252b02900d2434505c7mr1152244plg.4.1601065859302;
        Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g1sm70849pjs.30.2020.09.25.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:30:58 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:30:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, luto@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009251327.587D111@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <202009221243.6BC5635E@keescook>
 <874kno6yct.fsf@collabora.com>
 <202009231349.4A25EAF@keescook>
 <87o8luuvze.fsf@nanos.tec.linutronix.de>
 <87k0whsuh1.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0whsuh1.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 25, 2020 at 12:15:54PM -0400, Gabriel Krisman Bertazi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Wed, Sep 23 2020 at 13:49, Kees Cook wrote:
> >> On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
> >>> Kees Cook <keescook@chromium.org> writes:
> >>> Yes, we can, and I'm happy to follow up with that as part of my TIF
> >>> clean up work, but can we not block the current patchset to be merged
> >>> waiting for that, as this already grew a lot from the original feature
> >>> submission?
> >>
> >> In that case, I'd say just add the new TIF flag. The consolidation can
> >> come later.
> >
> > No. This is exactly the wrong order. Cleanup and consolidation have
> > precedence over features. I'm tired of 'we'll do that later' songs,
> > simply because in the very end I'm going to be the idiot who mops up the
> > resulting mess.
> >
> 
> No problem.  I will follow up with a patchset consolidating those flags
> into this syscall_intercept interface I proposed.  I assume there is no
> immediate concerns with the consolidation approach itself.

I think the only issue is just finding a clean way to set/unset the
flags safely/quickly (a lock seems too heavy to me).

Should thread_info hold an entire u32 for all intercept flags (then the
TIF_WORK tests is just a zero-test of the intercept u32 word)? Or should
there be a TIF_INTERCEPT and a totally separate u32 (e.g. in
task_struct) indicating which intercepts? (And if they're separate, how
do we atomically set/unset)

i.e.:

atomic_start
	toggle a per-intercept bit
	set TIF_INTERCEPT = !!(intercept word)
atomic_end

-- 
Kees Cook
