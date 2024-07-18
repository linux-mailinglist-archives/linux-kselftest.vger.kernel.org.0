Return-Path: <linux-kselftest+bounces-13855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219579345FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FCB281F34
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCB1FA3;
	Thu, 18 Jul 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AxDq1xNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAD186A;
	Thu, 18 Jul 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268444; cv=none; b=MUzv838Wcb5Brb8trUW52GH67HIUJmFDRkOyGLPaSO81ekuyF2WmN5eapzyVWqp+JEYktsb3HEbHDGM4qxPGp14vlWLgUvmbUq9Ti2L0qZEXf4XoJ4YZ33FwRKcHs3bBHRVXxwKT9eogQdAzyUDqVgmmE4djEcKvsOCpeq1P3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268444; c=relaxed/simple;
	bh=iDshzoZBpRnf7yCKH9wLBLFebN6C/f+B8ZPFo2nQCA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA+nyabdmBRoMr3SjV+R92Rv8186hpHDGbMqrQ/EyeqcMcfU537UEHm2YGc8DCqg/FuO6tu1cnDCxhdJtDykzIEB7N4Wix91WNp7voXWN3Wa6bkIrkPQMR6mSy4gLzY/gqjD0WLe6rrimO58weMULbG6eXVNi4MIZO/xMct+Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AxDq1xNJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MN9opQMCZMviT3QhqcL4hZlD2HbsMe34z7Elor7TtjE=; b=AxDq1xNJF92YMPtsE0UXbEol1z
	9dpZD8t1GGjjzVyW1G89DDN3szdL5Ie/4L2atlFZFcXr6VVlEQjjjyg8ILkwOReAoR/X8Ij9DSrcH
	Lt0mY2MlfaeVU3G6CUzJdVtuuecq7E1ZNeeDAdiY3tDh+Vy950i/4Z75NzFWyyBJw3/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUGXe-002kZB-Jj; Thu, 18 Jul 2024 04:06:46 +0200
Date: Thu, 18 Jul 2024 04:06:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Manmohan Shukla <manmshuk@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Ben Gooding <ben.gooding.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v5] rust: str: Use `core::CStr`, remove the custom `CStr`
 implementation
Message-ID: <d63e56d7-368f-42ec-bcee-605289c974cb@lunn.ch>
References: <20240717160339.146371-2-vadorovsky@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717160339.146371-2-vadorovsky@gmail.com>

> v3 -> v4:
> - Provide the `CStrExt` trait with `display()` method, which returns a
>   `CStrDisplay` wrapper with `Display` implementation. This addresses
>   the lack of `Display` implementation for `core::ffi::CStr`.
> - Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
>   which might be useful and is going to prevent manual, unsafe casts.
> - Fix a typo (s/preffered/prefered/).
> 
> v4 -> v5:
> - Keep the `test_cstr_display*` unit tests.

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

In particular, the bit about 24 hours, and the merge window.

Thanks
    Andrew

---
pw-bot: cr

