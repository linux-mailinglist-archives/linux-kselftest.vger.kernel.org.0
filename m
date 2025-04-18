Return-Path: <linux-kselftest+bounces-31190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EEA93FF1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 00:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B65446E41
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262E25334E;
	Fri, 18 Apr 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX9PnL5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27292505D2;
	Fri, 18 Apr 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016305; cv=none; b=l5K+L7SMUSIoTnmFcPXzvf5RMkwPcXGosiip5HUatOlHxNGCkdOChEBwNKZei6zZ0Y88zThL10HOZ4OD3mrjYPN+GpPZyIZcI9GMpp4aIbmjgXkjqfkOduuwDKIVjuhC5EPWxWwLC92XsHoILlPID9o92856PV30obRyB7ztL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016305; c=relaxed/simple;
	bh=/tOZQsdaxAH2MR1j7DrwnJ94+x9KpRmzcjIt2qnTatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8AAWnKv69hrco7n9qeYGB34Yujpz2wMP9Lgb53ZAZpsKo6HW3gUANt9EFjZk0s03JDigKOAR02G6SsBYd3Q0s4DZ9boVd8Crjv9vKZg+U9Sj43Xsf0/gUlZMKt7XY43HXIYWanpsfBl9+k1wleC2RUfbvqiEg8uE4b82uvoNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX9PnL5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E692FC4CEE2;
	Fri, 18 Apr 2025 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745016305;
	bh=/tOZQsdaxAH2MR1j7DrwnJ94+x9KpRmzcjIt2qnTatI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SX9PnL5nvXhhn+kDBBXj4s4E6KpXy9B6htu/vAT3uv5afm6fbddijt69SxGbeER17
	 D8GyaFIihCwhaeUKdTto9IJcZAeNfjQOJmUbeaqCHg5jjYqf55L9QpJpAy6FdCKpwU
	 uAcdCXWyFz2ng8O9aXEHpFvp+Gic8fPB/XL/IXHSPRYIw213a7trdqWRuT/ktuzegm
	 vUmH3qU7hRTRl/299UAOn8iD1AolSk/EUPWblLNksCviPJIHI9WVzanQWkfMCHrqVk
	 BUqGg0Q+e49qGQil8gp0jbqk8kN4+Nf6g4PExtrp0qBXEvBBCTmrXoRzxG1eUUWt6j
	 0BaEhn3qOmDLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84097CE095D; Fri, 18 Apr 2025 15:45:04 -0700 (PDT)
Date: Fri, 18 Apr 2025 15:45:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
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
	Justin Stitt <justinstitt@google.com>, rcu <rcu@vger.kernel.org>,
	linux-kselftest <linux-kselftest@vger.kernel.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	llvm <llvm@lists.linux.dev>
Subject: Re: [12/14] torture: Add testing of RCU's Rust bindings to torture.sh
Message-ID: <a0743fa8-7676-4930-b9de-73650b577bd9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
 <174501535977.2294.12061268025763464111@patchwork.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174501535977.2294.12061268025763464111@patchwork.local>

On Fri, Apr 18, 2025 at 10:29:19PM -0000, Joel Fernandes wrote:
> Hello, Paul,
> 
> On Fri, 18 Apr 2025 22:26:17 GMT, "Paul E. McKenney" wrote:
> > On Fri, Apr 18, 2025 at 08:32:46PM +0200, Miguel Ojeda wrote:
> > > On Fri, Apr 18, 2025 at 8:04 PM Paul E. McKenney <paulmck@kernel.org> wrot
> > e:
> > > >
> > > > Suppose we fired up a guest OS and captured the console output.  Is ther
> > e
> > > > a way to make that guest OS shut down automatically at the end of the
> > > > test and to extract the test results?
> > > 
> > > Ah, sorry, I thought you were already doing something like that, i.e.
> > > that perhaps you could reuse some kernel build you already had and
> > > avoiding a full rebuild/mrproper. The KUnit Python script uses QEMU
> > > and parses the results; e.g. you could look for the results lines
> > > like:
> > > 
> > >     # Totals: pass:133 fail:0 skip:0 total:133
> > >     ok 2 rust_doctests_kernel
> > 
> > Alternatively, I could clone a copy of the current archive into a
> > temporary directory, "make mrproper" there, run kunit normally, then
> > clean up the temporary directory.  Extra storage, but quite a bit
> > more robust and user-friendly.
> 
> Just to be on the same page, is the concern about the
> slowness of mrproper or that it kills the kernel build
> artifacts requiring a clean build?

It blows away things like tags and cscope databases.  Me, I have my
cscope databases elsewhere, but lots of people build them for their
live git repos.  And they are (quite understandably) unhappy when their
source-code browsing tools are blown away by some random test doing an
unsuspected "make mrproper".  ;-)

> What kind of improvement are we looking for and why would
> this patch in its current form not work?

For the near term, I am OK with its current form because it is
non-default.  Longer term, though, we need it to be tested by default,
and that means making it avoid undoing people's work.  My short-term
approach is to enable this test on my employer's test systems, which
have Rust set up correctly, and skip it on my laptop, which has a strange
FrankenRust due to my early playing around with that language.

							Thanx, Paul

