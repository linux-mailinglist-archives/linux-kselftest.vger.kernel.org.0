Return-Path: <linux-kselftest+bounces-31185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5ECA93EED
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D251B67C8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F223F434;
	Fri, 18 Apr 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emkHc8Bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1923F40C;
	Fri, 18 Apr 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008129; cv=none; b=e750Gz4Tm8AqMN4ZK1Lg/+miVM1NzNsJqyp4/MvE4vzMc0NbSs+bEIt+VCp7Uk15DCpCjQWZvWDtwSHeWB7Cg0TcciFO7qnNdvd323LHi2Z6aXCpnsi7pOufFE2rS+xkNu0aXy6zezSLOaTZr6syxTl7UrgjSQ1z5gUtjvuT+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008129; c=relaxed/simple;
	bh=e4VxNsvSZ16THA298RXtulbkphYJ1Y/POENNBgWIozU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRcTN00vWXpHf7wG0rVBRHsWA1931piEf8QDdiwXkCCxP/eqha+JMDs1zz+TxjNLUCKiUbCsyqRbVkNOVVoluFnlUdIecKLaYH1+o2804cqF/GEnV/YYYpIAnuzzTgaLD2Bn9T0nQaqF4K90tDqs7UnaHZjBZKByMrBILA7gY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emkHc8Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066D8C4CEE2;
	Fri, 18 Apr 2025 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008129;
	bh=e4VxNsvSZ16THA298RXtulbkphYJ1Y/POENNBgWIozU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=emkHc8BfxSLCXF7voFL0ws4qpZ5RaMIB7Y2p6QCZC6+Qt6Q0g/yEa/GLATp6+1gJI
	 bDanaG08pREZTWWHWXf/TbJI5fRbq5q+o0v2asunefHJk8nRb3lpCei2IGWMsuq3sn
	 T/zCLO9bXDqksvAe8VsffE85y+mhvY/39NhN4ye9RyfemdsVwqZoKQ3P4iQReUHAOn
	 nbfdbHWed0uaDUwd5BTJjaKr7GSEHwFp38qSRzeULFhE/9lDWj0Lj5e7jx7Xwv9ysP
	 z3HlsvSH3VRjcvnKh97h2JvJKktviwQ+ph58kJHIyR+OQP1Y54rPDOu+ZkUeTWH+IY
	 BoqYkFVQ3OvSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9849CCE077B; Fri, 18 Apr 2025 13:28:43 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:28:43 -0700
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
Message-ID: <cbf1a147-0a24-4146-98a0-a9666bb60433@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
 <20250418161005.2425391-13-joelagnelf@nvidia.com>
 <CANiq72nCfBdsfKzP72DWxLBh+Eueack9sS-E97wtsr0UtkAnUA@mail.gmail.com>
 <42da7c8e-08ff-4b04-ab58-6c0c2e287eb3@paulmck-laptop>
 <CANiq72nE2cH93W2qZrzAxfbz3hjsw4Xy0YYNwOUQ74SeGiirgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nE2cH93W2qZrzAxfbz3hjsw4Xy0YYNwOUQ74SeGiirgw@mail.gmail.com>

On Fri, Apr 18, 2025 at 08:32:46PM +0200, Miguel Ojeda wrote:
> On Fri, Apr 18, 2025 at 8:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Suppose we fired up a guest OS and captured the console output.  Is there
> > a way to make that guest OS shut down automatically at the end of the
> > test and to extract the test results?
> 
> Ah, sorry, I thought you were already doing something like that, i.e.
> that perhaps you could reuse some kernel build you already had and
> avoiding a full rebuild/`mrproper`. The KUnit Python script uses QEMU
> and parses the results; e.g. you could look for the results lines
> like:
> 
>     # Totals: pass:133 fail:0 skip:0 total:133
>     ok 2 rust_doctests_kernel

Alternatively, I could clone a copy of the current archive into a
temporary directory, "make mrproper" there, run kunit normally, then
clean up the temporary directory.  Extra storage, but quite a bit
more robust and user-friendly.

Other thoughts?

							Thanx, Paul

