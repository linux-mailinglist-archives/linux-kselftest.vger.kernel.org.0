Return-Path: <linux-kselftest+bounces-31818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F44A9FA7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0407146507A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46611DF988;
	Mon, 28 Apr 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIKzXVSh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A68C0E;
	Mon, 28 Apr 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871866; cv=none; b=nwg+MhH6bQM+t+KNx6z2heEsuq59yjOjbuTiwUlhOa5MhgXupStQiUQvnLhFFx2cWdx/09rAOFIzfR3fFp4XipeKgt9O1DjWXarJrtIUw1zFp4efFKB2p4JpV+JOZ4oh/SuOTj9gf9PlnAhOHrburTJSgH0F4MD2CGgBWlCquwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871866; c=relaxed/simple;
	bh=FnPdT3yDzy4d40eoGx5T9RC4+m/2m94BRqXV3LfZe6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8e5s2wpXM8Ed6tucXifKqH6M3juuKnoB6JOM6zQQZG8MaRBXG5eQu5ShzKktLkvczras6rJBLsMgy94YvnIvf5LqkzoOgATlkWCWu0PElpy5e+iBz6x3+MpEixnDapRjuz6QzGgcXkmF70jcT+FShGXXhvzwajhTWXzyB7AQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIKzXVSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA84C4CEE4;
	Mon, 28 Apr 2025 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745871866;
	bh=FnPdT3yDzy4d40eoGx5T9RC4+m/2m94BRqXV3LfZe6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIKzXVSh0UQEAXC/ALm5hAQhwm4A14D02UGyA1nnTNneHXqiAQm7TjkEWptJOFFKZ
	 rkJUZHg0c34EHVJVUJdBob7klQu+TDZ/02QcP4XkyuN5KRhs0uinLavzHrYTw0Q65O
	 13MXJrstltppwKnM3bdWwMCW1NDp385VJKDwNjvOCidqte1Chebbdti908nOQ4Uro6
	 VFXJjmjPSuunyZW7tS5zJlNl9uxWp63eiey8A2MaSz49srwCH7+wrUU/qch9Lh0F63
	 bso8pRzl3/ktpVeq7jOJXMygdVjXoJ9nZn4H+PCwJDgL9wylv/TQxrYudXJ36tDPrR
	 rKimji0+N2sWA==
Date: Mon, 28 Apr 2025 13:24:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, willemb@google.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
Message-ID: <20250428132425.318f2a51@kernel.org>
In-Reply-To: <680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
References: <20250425151757.1652517-1-kuba@kernel.org>
	<680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 11:15:34 -0400 Willem de Bruijn wrote:
> > @@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
> >      return env
> >  
> >  
> > +term_cnt = 0
> > +  
> 
> A bit ugly to initialize this here. Also, it already is initialized
> below.

We need a global so that the signal handler can access it.
Python doesn't have syntax to define a variable without a value.
Or do you suggest term_cnt = None ?

The whole term_cnt dance is super ugly, couldn't think of a cleaner way.
It's really annoying that ksft infra sends 2 terminating signals one
immediately after the other :|

> > +def _ksft_intr(signum, frame):
> > +    # ksft runner.sh sends 2 SIGTERMs in a row on a timeout
> > +    # if we don't ignore the second one it will stop us from handling cleanup
> > +    global term_cnt
> > +    term_cnt += 1
> > +    if term_cnt == 1:
> > +        raise KsftTerminate()
> > +    else:
> > +        ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
> > +
> > +
> >  def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> >      cases = cases or []
> >  
> > @@ -205,6 +223,10 @@ KSFT_DISRUPTIVE = True
> >                      cases.append(value)
> >                      break
> >  
> > +    global term_cnt
> > +    term_cnt = 0
> > +    prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
> > +
> >      totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
> >  
> >      print("TAP version 13")
> > @@ -229,11 +251,12 @@ KSFT_DISRUPTIVE = True
> >              cnt_key = 'xfail'
> >          except BaseException as e:
> >              stop |= isinstance(e, KeyboardInterrupt)
> > +            stop |= isinstance(e, KsftTerminate)
> >              tb = traceback.format_exc()
> >              for line in tb.strip().split('\n'):
> >                  ksft_pr("Exception|", line)
> >              if stop:
> > -                ksft_pr("Stopping tests due to KeyboardInterrupt.")
> > +                ksft_pr(f"Stopping tests due to {type(e).__name__}.")
> >              KSFT_RESULT = False
> >              cnt_key = 'fail'
> >  
> > @@ -248,6 +271,8 @@ KSFT_DISRUPTIVE = True
> >          if stop:
> >              break
> >  
> > +    signal.signal(signal.SIGTERM, prev_sigterm)
> > +  
> 
> Why is prev_sigterm saved and reassigned as handler here?

Because we ignore all signals when cnt > 2 I didn't want to keep our
handler installed. Just in case something after ksft_run() hangs.
It should be equivalent to

	signal.signal(signal.SIGTERM, signal.SIG_DLF)

if the prev is of concern. Then again keeping prev doesn't change #LOC

