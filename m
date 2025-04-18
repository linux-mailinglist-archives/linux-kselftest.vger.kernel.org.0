Return-Path: <linux-kselftest+bounces-31173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E773A93C83
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FEB177039
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B5420C029;
	Fri, 18 Apr 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc0EhWrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424284A3E;
	Fri, 18 Apr 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999442; cv=none; b=tSaHjBthR6b8G+5+8YLHKRGnQGXjrrP2QJ1JE04dxeEkTN5y2h2RGDBgKBYsCV4mLcXqr85ZI0UaOWWHMUg45YSiUKICptpFiNixFKu1e1zF2C76a67QhXVM5ajRjBvH57WX/tP5CZlehlWIJmTgXXuY+qaNH1F48nrbWxLdt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999442; c=relaxed/simple;
	bh=NaeCcSP6DCirfqAipsADTtNWV3q2qdvhgZOsW/GhJXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl1aPI4OQtSO+Px4F6ScMTAUnGESvhAmTEoAmx0myChJ9CAGhPwB2EYqkeDSUOwe63ImZu3DVHFsda58sl8HCNbYAZqWAsnO0A/0snJSzV4JXltQdXNwWg52gVzHDwcrutTdiOw+lvjHJvjNOlxH/cYM3G5WUxl9spfGQY6xAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc0EhWrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95038C4CEE2;
	Fri, 18 Apr 2025 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744999441;
	bh=NaeCcSP6DCirfqAipsADTtNWV3q2qdvhgZOsW/GhJXU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jc0EhWrYPnnoA3Xv2hluLsIQHobLE/zY9vGf2gm0uO1k0F1cTtRbnxd3/bT827+x2
	 5AShxhJfeyhhW60PV59GyeQwYbeovHdZaCQ9YgFpfLPOm8aRbqXGKX4MjeQr6KQh7z
	 KgA/K1qdrCgsfXqc9sfm/6fh+PKnoc3x9XXlemTLZghpbAlgIOc7YDwuIUld0Owkrq
	 wRlErLhuR9Prz/g603vkneK3keus+cXbz93vFacsQ2GKxTh4IskfSEruponcJma6xx
	 JIzbJrV0c/BRupX/bQLc0vzXNBk5LOoPxXSJF4xCAsJ/mL0vteL/STt1mlTRfpCXpD
	 yv0IrEfdloT4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4240DCE077B; Fri, 18 Apr 2025 11:04:01 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:04:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 12/14] torture: Add testing of RCU's Rust bindings to
 torture.sh
Message-ID: <42da7c8e-08ff-4b04-ab58-6c0c2e287eb3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
 <20250418161005.2425391-13-joelagnelf@nvidia.com>
 <CANiq72nCfBdsfKzP72DWxLBh+Eueack9sS-E97wtsr0UtkAnUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nCfBdsfKzP72DWxLBh+Eueack9sS-E97wtsr0UtkAnUA@mail.gmail.com>

On Fri, Apr 18, 2025 at 07:31:53PM +0200, Miguel Ojeda wrote:
> On Fri, Apr 18, 2025 at 6:10 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > a rust_doctests_kernel kunit run.  Note that kunit wants a clean source
> > tree, so this runs "make mrproper", which might come as a surprise to
> > some users.  Should there be a --mrproper parameter to torture.sh to make
> > the user explicitly ask for it?
> 
> One may run KUnit without using `kunit.py`, i.e. by enabling the
> Kconfigs and booting the kernel. Would that help?

Potentially?

Suppose we fired up a guest OS and captured the console output.  Is there
a way to make that guest OS shut down automatically at the end of the
test and to extract the test results?

In the short term, I am good with this the current state of this being
default-disabled and those of us wishing to run it regularly adjusting
our scripts accordingly.

But, longer term, if there is a better way...

							Thanx, Paul

