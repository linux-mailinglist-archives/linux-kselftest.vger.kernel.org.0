Return-Path: <linux-kselftest+bounces-37476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D147B086FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 09:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE391A664D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D6256C6C;
	Thu, 17 Jul 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAbO4RBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC82550D2;
	Thu, 17 Jul 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737694; cv=none; b=rkPIKe28wmF7dPpwLls2TsfhfkvQwqkJ0ML6MaDRToSf+kRcfN3SiI9uFI7quXPKraIUgzi7NhdUg2PgHjlPOIcSeLr9WGYAe+ZgOLGvpOvgBsDX/hdrIUseT7V08rMdxFzPFIkT3H25x6XjuOdLOraev4KnGp+8GIY41Q9py/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737694; c=relaxed/simple;
	bh=FtW4lErOOpmfRZKob7B84VV7rL5W44vEIDwbZE6vNAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4SHWYyLxldG8ccfss1RqvOOvltRoIchyqypMWnonHGqfy5FUo58QRdIF3BcVIq1Fgh43Bp0YtAqc9QcPU662tvl5q/H12zNXkoIdk79oDWG37ay2We296dzA0NLUTFaebEQnNqH3V2iV0ChrKDsHpbOXfFBd8elvjGQMdoZJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAbO4RBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710BEC4CEE3;
	Thu, 17 Jul 2025 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752737692;
	bh=FtW4lErOOpmfRZKob7B84VV7rL5W44vEIDwbZE6vNAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAbO4RBK95NMmv+ZsW6HpzXN6oszfb7I5Vj34zd6CZc3jioIdvl7d/RTtBtLhsI4n
	 lUMY0UidlxjcYvuLw75s3YfDxVElD+JfPrHfcSflQYvNjI9Hs7OGWmM7HUCX6TBcP6
	 09Y2H0Dg+S/RRWdyQrm8i3PBOnKIC2xz3lRxj79mOXhLdXjcfPYwl+K0vJjooXOAIB
	 uXisiqNsWy3LvotbBi7WihX7t5+uib+bCWTBiQQo8lMdcCH4hbRQjE0pRxhpVjttAU
	 99tOxDeYVJGa5NMDvBaqCCvKREAbn6uUR0UEtXLU5gAa1/qP8aU4KxuKdzCafyc2jQ
	 P6cdH7mvs8a4A==
Date: Thu, 17 Jul 2025 00:34:52 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 6/6] binder: encapsulate individual alloc test cases
Message-ID: <202507170026.0850E08ED@keescook>
References: <20250717011011.3365074-1-ynaffit@google.com>
 <20250717011011.3365074-7-ynaffit@google.com>
 <202507162326.5A827E93C@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507162326.5A827E93C@keescook>

On Wed, Jul 16, 2025 at 11:32:10PM -0700, Kees Cook wrote:
> This really screams for a struct-based way to in-place declare a
> seq_buf. The current macro only works on the stack. I think this
> will work; I'll send a patch once I get it tested:
> 
> #define DECLARE_SEQ_BUF(NAME, SIZE)		\
> 	char NAME##_buffer[size];		\
> 	struct seq_buf NAME = {			\
> 		.buffer = &NAME##_buffer,	\
> 		.size = SIZE,			\
> 	}

Oh, no, that wouldn't work in a struct -- there is a static initializer
there. And my memory is short: this would have been a revert of commit
7a8e9cdf9405 ("seq_buf: Make DECLARE_SEQ_BUF() usable").

I don't think it's possible to construct a seq_buf in a struct without a
runtime initialization. And that's true for anything that needs to
actually set a value (size) for the data type to be usable. Hmpf.

-- 
Kees Cook

