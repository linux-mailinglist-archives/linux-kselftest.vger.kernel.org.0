Return-Path: <linux-kselftest+bounces-37610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F8B0ACA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 01:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE583AEDCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 23:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7022B8D9;
	Fri, 18 Jul 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcpyUqeG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E76A923;
	Fri, 18 Jul 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883019; cv=none; b=XWOuFaaTql9CGr/UCjzw8raidkcxBluE6n80XgIeauwDZQRxcNd1C7vPYgbalrnibeuPpi2rjJaKp9rsEpCJHsR6ZRLCMr5Xbu+LQKW2FIBMYHtEw2mbvRRKe0MNMWXveCUYE0WePSi3dL6onY2H9tV+kk9kq5tvo0M1jz3ITzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883019; c=relaxed/simple;
	bh=DsFP1DUFewpaZcQNuymV8rymiU74CtBi6/pMKJOetY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeMY3OCcdjE5C7SRxoJJmK5V0ZMG8rCZfSGR6DQ7pJyDjAYingIxzDd/T6xbxjBQlu69ixWF/FC1MlCQ9vby2cAOKiGiOQJfRTsiberlDGW4ty7ND3/lbqDZ6OdjUhhmeLOKERj5FFDyHEGQzq0aA+/dqOwsuRbPY8GGnhIqqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcpyUqeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2433CC4CEEB;
	Fri, 18 Jul 2025 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752883018;
	bh=DsFP1DUFewpaZcQNuymV8rymiU74CtBi6/pMKJOetY4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kcpyUqeG6wj5AFhlZV4htN/8lnh5QcDVlbKERkm/gHP9YDGM5aPa3eMg3c7SfCCmq
	 HGm0gBNVxbFyFl7lK/eNqxNuw/jBblvrvERi2PSoKgmL8fddsgcrCRhXgVXJy5zo3z
	 nfI8obslij66M5loZMUIeYQnUGVj7U/zixjcL9cuKQ3hRGh5fM7UcEyg+ZM6XglYn8
	 skJKoRYMPYuLEYMWO13BWQro10eXECwLRbcb32f+EQLfXfob2Zbg20uiM/SkvwY2YW
	 qtOY7sCdUil3cayYLuitSvGe2Wlf07+blp8LR9AnPodFn1FrrDy9q02fATG7BYfesP
	 4SCXa2BGPqvUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6449CE0D3A; Fri, 18 Jul 2025 16:56:57 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:56:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
Message-ID: <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
 <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>

On Fri, Jul 18, 2025 at 03:03:43PM -0600, Shuah Khan wrote:
> On 7/14/25 17:01, Paul E. McKenney wrote:
> > The pidfd selftests run in userspace and include both userspace and kernel
> > header files.  On some distros (for example, CentOS), this results in
> > duplicate-symbol warnings in allmodconfig builds, while on other distros
> > (for example, Ubuntu) it does not.  (This happens in recent -next trees,
> > including next-20250714.)
> > 
> > Therefore, use #undef to get rid of the userspace definitions in favor
> > of the kernel definitions.
> > 
> > Other ways of handling this include splitting up the selftest code so
> > that the userspace definitions go into one translation unit and the
> > kernel definitions into another (which might or might not be feasible)
> > or to adjust compiler command-line options to suppress the warnings
> > (which might or might not be desirable).
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: <linux-kselftest@vger.kernel.org>
> > 
> > ---
> >   pidfd.h |    4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > index efd74063126eb..6ff495398e872 100644
> > --- a/tools/testing/selftests/pidfd/pidfd.h
> > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > @@ -16,6 +16,10 @@
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> 
> Please add comments here about why we are adding this so there
> won't be any confusion later.

Good point, thank you!

Like this?

/*
 * Remove the userspace definitions of the following preprocessor symbols
 * to avoid duplicate-definition warnings from the subsequent in-kernel
 * definitions.
 */

> > +#undef SCHED_NORMAL
> > +#undef SCHED_FLAG_KEEP_ALL
> > +#undef SCHED_FLAG_UTIL_CLAMP
> > +
> >   #include "../kselftest.h"
> >   #include "../clone3/clone3_selftests.h"
> 
> With that change:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thank you!

> I am assuming this will go through Christian's tree. If not I can
> take it through mine.

I am of course good either way.  ;-)

							Thanx, Paul

