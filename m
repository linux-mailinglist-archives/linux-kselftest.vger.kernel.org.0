Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5681A3AD6E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 05:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhFSDE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhFSDE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 23:04:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC7C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 20:02:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so4182307pji.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AL3IkUbQ1a/LRO+FbqYHn+oMeAp1U0V5I8weht9YTe0=;
        b=k53RtsI3wnZQDyMBB2CG0HfKnm17M/4fp/pxu553QmY3YKnUokW0BYYV2B/y43PAYi
         tsF8RSy9K9cPND3oMbY//QXYo86K/BfFm6Ux4OofTfucse1uj+WWaogWNVYFgcXwFt08
         BNSO1bFyyIhOdbD6j6MMJsA3VUDL87xawV8SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AL3IkUbQ1a/LRO+FbqYHn+oMeAp1U0V5I8weht9YTe0=;
        b=Uo2d/oxkIkzTkpNPb0FmCMMfguwBXpnjdVLHfxQZrctG4MwFx9gsZac8FRVHuW50OH
         TFQyS0PRb3rUYozY7JtQZvEyGubVtuI58MJqr94aHbDHqq97ldu3HsuueqnHjd99QD4K
         iJRRZV4NOLQ04SOeDQQMukAFBhNCGsxkxSRN/S2235q0u/BDgZ8YXhGOey4AIDrAy0PJ
         ANrhWHQZUESiPZo4ibN7RUCKzBxs2aHSDbg/wSHgZT3oIsHO4HbSa8ylePT6eqwobhxc
         tStrI44ZlbhJqi8MsNpKiodzvKdMj5q9CSQl69kQ7g4IE7TfeTUaOul9lonhx6JE9zZq
         sXzA==
X-Gm-Message-State: AOAM533KUllc+v+8x6eeWoCEmRl24FxxCEtyuPuTNXkPWOSV1qdVXHvp
        6BBHJAaBZvf/6ik0Y4Af0T117Q==
X-Google-Smtp-Source: ABdhPJy6MS0K3mHCnNh+tPj7v6JRbScEU8fnlcCNFoGwViNFPru2h4JAlYS997Vfx/7JHe0RA8woxw==
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr13697656pja.149.1624071765805;
        Fri, 18 Jun 2021 20:02:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h28sm9512020pfr.10.2021.06.18.20.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 20:02:45 -0700 (PDT)
Date:   Fri, 18 Jun 2021 20:02:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use /bin/sh not $SHELL
Message-ID: <202106182000.D49612B26F@keescook>
References: <20210617231027.3908585-1-keescook@chromium.org>
 <57775fe8-d9c2-4004-b8c5-0247faf33aa4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57775fe8-d9c2-4004-b8c5-0247faf33aa4@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 08:29:57PM +0100, Guillaume Tucker wrote:
> There's a bit more to it...  The lkdtm tests make use of the
> process substitution feature with the <() syntax which is
> specific to Bash.  The tests run by KernelCI use Debian, where
> /bin/sh points to /bin/dash by default which doesn't support this
> feature.  So one way to fix it would be:
> 
>   (/bin/bash -c 'cat <(echo '"$test"') >'"$TRIGGER")

Argh. I always forget that <() is a bash-ism. Thank you for tracking
this down!

> However, this might break others' workflows.
> 
> In fact the LAVA jobs run by KernelCI do define the $SHELL
> environment variable except it's defined to be /bin/sh - and that
> means /bin/dash gets called and we're back to the issue explained
> above.
> 
> I've manually run a modified test job which defines
> SHELL=/bin/bash and that works:
> 
>   https://lava.collabora.co.uk/scheduler/job/4055547#L2835

Yay!!

> So to avoid hitting the same issue in other places, as it seems
> like there is an implicit dependency on Bash, we can just change
> KernelCI kselftest jobs to always export SHELL=/bin/bash.
> 
> I suppose an even better fix would be to use standard shell
> features that would work with any /bin/sh implementation, but
> this is there to kill the sub-shell rather than the main script
> process so I'm not entirely sure if we can easily do that
> differently.  Maybe we can pipe the output to cat rather than the
> substitution syntax, e.g.:
> 
>   (/bin/sh -c '(echo '"$test"') | cat >'"$TRIGGER") || true

Yeah, this is the right fix. There's no reason anything should depend
on bash; I was just not thinking when I wrote this originally. :)

> So I think the "safest" solution is to not change the kselftest
> script and export SHELL=/bin/bash in the KernelCI jobs.  If the
> pipe approach is good enough at catching signals then it could be
> done on top of this patch as it's standard and should work with
> any /bin/sh implementation.  What do you think?

If you set SHELL=/bin/bash for now, the lkdtm tests should work as they
are, and once the v2 patch lands, they'll continue to work, and
SHELL=/bin/bash can be removed.

Thank you so much!

-Kees

-- 
Kees Cook
