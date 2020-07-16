Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF716222CBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgGPUZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgGPUZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 16:25:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175AC08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 13:25:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so4228544pfh.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hA+Aqo4SV3ko2kO8EuK2W/Tvr+vtNwBN3+1D4FXT5iI=;
        b=LjQmSvLJxhYwI0Uux7CkRfdDlLxJHThvP2ZmnUcX0HKl0LYtyj4F5cXRL7xqnFAJRv
         ELf6wnYFK3WPSx0yRsuvoVqq6x+YbYPCrfsKm9+nPf2JALM0X8q3PtOjmASBTTGpLXLG
         OgKrZ4p1AN7EzbMN8TB4ug/wl3tl/t2nhtzOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hA+Aqo4SV3ko2kO8EuK2W/Tvr+vtNwBN3+1D4FXT5iI=;
        b=ZzYVkbi8utreorPaifupnqNSe3ZV0lVBm13vtKJSaz2erv52a4ZAZySbcbWtYMGppF
         j7uwR1WgzvvTedtA9iJ4K/0R0cmBPxIteP5Xc546DMFi2XvOz0p1rqonVRdgMghb+XnU
         XI4xsBbsJkm2nFxUh8UPVsouzowRjUMZlG+O6nOuNmRgpw5z1dny+Gd9JSYAeXRyXV/G
         jF22svHmzj+TiSff2EUpKm0G3DAY9i4dYNhsTySI5OdqkUELWIDlfpQy7UKl8KISj95Y
         Kw/FcK+8tnxqlzbbNNELr78CID0PtlcUKe3dWq92877wQmQU8thr7Ham7cSF45s1n28z
         bV7A==
X-Gm-Message-State: AOAM531dP24f2OhZkcoRgxO9EfsayJR/Nr+1+Ym08rIU6o2+BZ8PzzFk
        /QZTZgYHEmH0gAYRdFGtDbnjQw==
X-Google-Smtp-Source: ABdhPJzluoB8Hr1x2E3MstyVdN1H30YSZ/nI6IrWid+cCKeHVafzMiYGYyTlGMFOxVnCzxBRlnzUmA==
X-Received: by 2002:aa7:9ec5:: with SMTP id r5mr4848033pfq.86.1594931145764;
        Thu, 16 Jul 2020 13:25:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t126sm5576396pfd.214.2020.07.16.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:25:44 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:25:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        gofmanp@gmail.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, jannh@google.com
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Message-ID: <202007161324.E75E01B@keescook>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <202007161300.7452A2C5@keescook>
 <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 10:22:34PM +0200, Christian Brauner wrote:
> On Thu, Jul 16, 2020 at 01:04:38PM -0700, Kees Cook wrote:
> > On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> > > This is v4 of Syscall User Redirection.  The implementation itself is
> > > not modified from v3, it only applies the latest round of reviews to the
> > > selftests.
> > > 
> > > __NR_syscalls is not really exported in header files other than
> > > asm-generic for every architecture, so it felt safer to optionally
> > > expose it with a fallback to a high value.
> > > 
> > > Also, I didn't expose tests for PR_GET as that is not currently
> > > implemented.  If possible, I'd have it supported by a future patchset,
> > > since it is not immediately necessary to support this feature.
> > 
> > Thanks! That all looks good to me.
> 
> Don't have any problem with this but did this ever get exposure on
> linux-api? This is the first time I see this pop up.

I thought I'd added it to CC in the past, but that might have been other
recent unrelated threads. Does this need a full repost there too, you
think?

-- 
Kees Cook
