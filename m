Return-Path: <linux-kselftest+bounces-42657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9EBB106A
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E351883182
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C1262FF3;
	Wed,  1 Oct 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuoqHnJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B81DF97C;
	Wed,  1 Oct 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331955; cv=none; b=eJxi+zL1Juzj61apjs6VVSUw9BNooycsk8f4f2cz4i/eYi3t+RlgJbJG+0RcrXgbewzVvofZ89372pGaLAJV0WoCsHid47TzC4baHNCNzMS2ZKqVov0bvp6moZWQa7GApSv7or4jLkDE1tq23JjQExEIV0rdbOc2eZ2qId3i8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331955; c=relaxed/simple;
	bh=WXEou4ARuKup3FH9I0+HUiGykmkp3l62lW8nRFhHN8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjaJIgcx0SXeKHPd4nHdUcRh83eUnYC/QtKUUDn8YdoO1BJTXFl0Ovo6kOilug5kcTxv2OebwHrAyF+SW74i2q/rKrmvNG0EOCE+x10/QLWIDbjJK5G1t7+rCmOyPN9tIbJefxmri7ltTkDYp+sy5PFTkS6da+xa9yo8cajdGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuoqHnJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8348FC4CEF1;
	Wed,  1 Oct 2025 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331954;
	bh=WXEou4ARuKup3FH9I0+HUiGykmkp3l62lW8nRFhHN8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuoqHnJB4uDafvFk7iuZGQkcCUA3QEMjyIqZ6xDxBrSgY+YTmCQD/oPgtUKWKuyAW
	 nCQIigEARI0lG1SCft2s3eJAulFR0CMjz49AhqI12m672C1dWwK7jcm5JssOMNHDX2
	 4AcTOYPRovnCmZ9IxfiyTLkrV64NnLDCv9AlUesolUaIgz5mXGjipfaG0KAAZ8i8DT
	 zBiu3UEjmuaBi/q5RLD1iW0xkOXjLVDYdrEvUFFFDVzh5OppCibjEUBe2ayQeM8ODX
	 pvy110WPSJvRORa+F8LYwcrW+7V+6snvbd0bsfaPHkRAhS5xQfmeu9tMrOYIdM4u8X
	 iVC0ZOSrnGjWg==
Date: Wed, 1 Oct 2025 16:19:09 +0100
From: Simon Horman <horms@kernel.org>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH net v3] selftest:net: Fix uninit return values
Message-ID: <aN1GbUiQNSTgOUhN@horms.kernel.org>
References: <20250929211241.55701-2-sidharthseela@gmail.com>
 <aNueLn3Wy-2X_GeE@horms.kernel.org>
 <CAJE-K+AeEYkAN8wX3FbBCbQMGTDsueA-YiC4w_qi+TZgUzkS-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJE-K+AeEYkAN8wX3FbBCbQMGTDsueA-YiC4w_qi+TZgUzkS-w@mail.gmail.com>

On Tue, Sep 30, 2025 at 03:17:02PM +0530, Sidharth Seela wrote:
> On Tue, Sep 30, 2025 at 2:39 PM Simon Horman <horms@kernel.org> wrote:
> > Hi,
> >
> > I don't want to block progress.
> > But there are some format problems with the commit message.
> >
> > Locally, git truncates the commit message at the line above ('--').
> > Which, omits a lot of useful information.
> > Most critically your Signed-off-by line.
> >
> > There is also another '--' below. Just above the fixes tag.
> > Which would cause a similar problem.
> >
> > And the v2/v3 information should go below the scissors ('---'),
> > below your signed-off by line.
> >
> > Maybe the maintainers can fix this when applying,
> > given how close we are to the pull for v6.18-rc1.
> > And that I believe there has already been some
> > discussion of this patch with the maintainers.
> >
> > > ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > >  1587 |         if (!sock) {
> > >       |             ^~~~~
> > > ovpn-cli.c:1635:9: note: uninitialized use occurs here
> > >  1635 |         return ret;
> > >       |                ^~~
> > > ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
> > >  1587 |         if (!sock) {
> > >       |         ^~~~~~~~~~~~
> > >  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  1589 |                 goto err_free;
> > >       |                 ~~~~~~~~~~~~~~
> > >  1590 |         }
> > >       |         ~
> > > ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
> > >  1584 |         int mcid, ret;
> > >       |                      ^
> > >       |                       = 0
> > > ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
> > >  2107 |         case CMD_INVALID:
> > >       |              ^~~~~~~~~~~
> > > ovpn-cli.c:2111:9: note: uninitialized use occurs here
> > >  2111 |         return ret;
> > >       |                ^~~
> > > ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
> > >  1939 |         int n, ret;
> > >       |                   ^
> > >       |
> > > --
> > > Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> > > ovpn module")
> > >
> > > v3:
> > >       - Use prefix net.
> > >       - Remove so_txtime fix as default case calls error().
> > >       - Changelog before sign-off.
> > >       - Three dashes after sign-off
> > >
> > > v2:
> > >       - Use subsystem name "net".
> > >       - Add fixes tags.
> > >       - Remove txtimestamp fix as default case calls error.
> > >       - Assign constant error string instead of NULL.
> > >
> > > Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> > > ---
> > >
> >
> > This is where the v2/v3 information should go.
> >
> > ...
> 
> Thankyou Simon, I didn't know that double hyphen would cause
> an issue. Although I need a logical separator between commit message
> and warning log, may I ask what could be used instead?

Good question. And, TBH, I didn't know that '--' does that either.

A blank line should certainly be safe.
Perhaps ~~ and == are too.

You can check by applying the resulting patch using git am.

