Return-Path: <linux-kselftest+bounces-31216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6CA94603
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 02:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED16B3B3C5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB76D23A9;
	Sun, 20 Apr 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caUQcNlD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BC2594;
	Sun, 20 Apr 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745108248; cv=none; b=MpjobDuC+bS+a9pga/LpxLsdc+jBv1oiWJFYMWtWXMcCFONjtGq+e1A0B376V0uyYQZIucyX1IcZWQfUzK4Tqxw6gq9IzTiEQZRpdtoFAe0qm4kxok4/b1urgk9V/p0KC04/DXz1bMz70Q5bDsVitXNaheBtDVNhg96PXPCHvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745108248; c=relaxed/simple;
	bh=XbWywE/ADb2906GHPJBQp0phcFHCX/X3oZAeWJ380SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX7DLE9bndQsty3InQ0HmufZM+c3jzxS90AU4kJ0Cghv9VMV+AC22QHprzRk6kxFfPMccEKXbO/JpN0bMWCvTzt0o/mp47GYI+Z8sFtsTHlM1v6QgtvO8pCsKt0IWZVrlNUw56756AJOonOl+LQTJbPMO9TTdnPT+cNACqhIPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caUQcNlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E591CC4CEE7;
	Sun, 20 Apr 2025 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745108248;
	bh=XbWywE/ADb2906GHPJBQp0phcFHCX/X3oZAeWJ380SY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=caUQcNlDyhi08AGRBTfHqosDM1URsh8+/uGYOZE9+OjuXF4/8z+ttextlXUAmaRzm
	 9kn0ASYgrE1aJ6MDuaakk9n1zJdXxbi+9U7+RYV90In5e4vnHXPxjQ8VF/Lx4fiDQT
	 keVv0G1eWTwGotGqrI6kB0Qopl0mqt/i8moU0HGQWZ8jjty0IoIGh5qbVHzFbjck3d
	 d2WeaPswgeDexu5gyW2nM0Su61/LO2Wy5ihNd8b7Hqq1FV9Yh2AyOdw5P0SaUd9RJe
	 3l/3jQX/Qf76/U3gpZv4hPg5Ag7F/q/HjXujLHFqtazRE6KqTjtLc69jM5F18Q/TXI
	 AI066KsWPTlrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 901EDCE095D; Sat, 19 Apr 2025 17:17:27 -0700 (PDT)
Date: Sat, 19 Apr 2025 17:17:27 -0700
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
Message-ID: <5d339b87-3eb7-4c1f-b862-79ea8e659a9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
 <174501535977.2294.12061268025763464111@patchwork.local>
 <a0743fa8-7676-4930-b9de-73650b577bd9@paulmck-laptop>
 <b26e8dc2-ab0e-4d68-aaa1-5c2353f2ef52@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b26e8dc2-ab0e-4d68-aaa1-5c2353f2ef52@nvidia.com>

On Sat, Apr 19, 2025 at 06:24:56PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On 4/18/2025 6:45 PM, Paul E. McKenney wrote:
> >>>>> Suppose we fired up a guest OS and captured the console output.  Is there
> >>>>> a way to make that guest OS shut down automatically at the end of the
> >>>>> test and to extract the test results?
> >>>> Ah, sorry, I thought you were already doing something like that, i.e.
> >>>> that perhaps you could reuse some kernel build you already had and
> >>>> avoiding a full rebuild/mrproper. The KUnit Python script uses QEMU
> >>>> and parses the results; e.g. you could look for the results lines
> >>>> like:
> >>>>
> >>>>     # Totals: pass:133 fail:0 skip:0 total:133
> >>>>     ok 2 rust_doctests_kernel
> >>>>
> >>> Alternatively, I could clone a copy of the current archive into a
> >>> temporary directory, "make mrproper" there, run kunit normally, then
> >>> clean up the temporary directory.  Extra storage, but quite a bit
> >>> more robust and user-friendly.
> >>>
> >> Just to be on the same page, is the concern about the
> >> slowness of mrproper or that it kills the kernel build
> >> artifacts requiring a clean build?
> >
> > It blows away things like tags and cscope databases.  Me, I have my
> > cscope databases elsewhere, but lots of people build them for their
> > live git repos.  And they are (quite understandably) unhappy when their
> > source-code browsing tools are blown away by some random test doing an
> > unsuspected "make mrproper".  😉
> 
> Cool. One thing is, running other test modes in torture.sh also reconfigures the
> kernel and potentially recompiles the entire kernel as a result. So if someone
> is already having their own kernel build, running torture.sh already may cause
> them to have to do a full rebuild, AFAICS. But yes, and to your point, the
> cscope DB and stuff may get blown away for additional disruption.
> 
> > 
> >> What kind of improvement are we looking for and why would
> >> this patch in its current form not work?
> > For the near term, I am OK with its current form because it is
> > non-default.  Longer term, though, we need it to be tested by default,
> > and that means making it avoid undoing people's work.  My short-term
> > approach is to enable this test on my employer's test systems, which
> > have Rust set up correctly, and skip it on my laptop, which has a strange
> > FrankenRust due to my early playing around with that language.
> > 
> Or we teach kunit.py to not require a mrproper? :-) I wonder why it needs to do
> that. I may run into that too considering my other kernel project requires me to
> mess around with rust.

They might have a good reason for that "make mrproper", but it does
sound like a good avenue to investigate.  Otherwise, as noted earlier, my
thought is to clone the repo into a temp directory, run "make mrproper"
there, continue being a non-special user of kunit, and avoid messing up
people's databases and tags.

							Thanx, Paul

