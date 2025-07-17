Return-Path: <linux-kselftest+bounces-37471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B35B084EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0AB4E255E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDA1E3DDB;
	Thu, 17 Jul 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsGvkZFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A233E7;
	Thu, 17 Jul 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733931; cv=none; b=HCraCFc64w2468o+WisBgTU+BvVDT0Dvpgo0tPqyrCN4vb5aMgv/K2OkqLHW4L4qrpVdpBkrK+w+YlWarOiaJLpyQLSGX+HGxs2XFSmg3hamY2+NK0TPD1t3xaWdNLb/jNSjLSG7OntCnXA71iH/BUxiwLWOfQ8DoLb2p2hXFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733931; c=relaxed/simple;
	bh=+yFhIefRVvO5mFTlHDo+mGVZ6GGeVH3AyfcylMAGY90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjRa3pWB7rSRXJijNGoOHXzBuBtr/+4XUu4A9Xe2hiP63WcMyDLr5UbcuUw8oLsyJ9Q8eGjtxD0B0T9hT+gteZh2Cgb64OJd9XhzdJV4Rk77yUN/tnwSkxOE6AXuRJNdt4fZKS/VakOnDxQaAGB+2ELXgU/0IKvCP8fva4ztkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsGvkZFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345E1C4CEE3;
	Thu, 17 Jul 2025 06:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752733931;
	bh=+yFhIefRVvO5mFTlHDo+mGVZ6GGeVH3AyfcylMAGY90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsGvkZFGirMpIzCHR6ol/dkrsbbiI3alJbBK31ey+mYM+tx8tpDEuWhLGmtGlLx9J
	 /ROvCRz9yRZv8jtmt3hpSKJliidkmgzWluOAJrZHTmg50WaamzK80VbrmQIm8hqNSa
	 LCqw7+U7q4gO76Yy41jfJK4eSZvYhQQTs16k07KvxPvbAnjehRSjlcqGEO83VjMcKx
	 VuQAqCAYiUWUXiqgOKgYUWuMcd92w03hIVDeCFAEc5IebR52lSwz3i0Wmd7/rN/m+4
	 +YwDsvjJ9U/Ws85VeC9Fy7/MIFltbo4WE0gucQhWHzTT8lKbJvLkQBUGJock3x6FD4
	 ahQgZqmohatRA==
Date: Wed, 16 Jul 2025 23:32:10 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
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
Message-ID: <202507162326.5A827E93C@keescook>
References: <20250717011011.3365074-1-ynaffit@google.com>
 <20250717011011.3365074-7-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717011011.3365074-7-ynaffit@google.com>

On Wed, Jul 16, 2025 at 06:10:09PM -0700, Tiffany Yang wrote:
> Each case tested by the binder allocator test is defined by 3 parameters:
> the end alignment type of each requested buffer allocation, whether those
> buffers share the front or back pages of the allotted address space, and
> the order in which those buffers should be released. The alignment type
> represents how a binder buffer may be laid out within or across page
> boundaries and relative to other buffers, and it's used along with
> whether the buffers cover part (sharing the front pages) of or all
> (sharing the back pages) of the vma to calculate the sizes passed into
> each test.
> 
> binder_alloc_test_alloc recursively generates each possible arrangement
> of alignment types and then tests that the binder_alloc code tracks pages
> correctly when those buffers are allocated and then freed in every
> possible order at both ends of the address space. While they provide
> comprehensive coverage, they are poor candidates to be represented as
> KUnit test cases, which must be statically enumerated. For 5 buffers and
> 5 end alignment types, the test case array would have 750,000 entries.
> This change structures the recursive calls into meaningful test cases so
> that failures are easier to interpret.
> 
> Cc: Kees Cook <kees@kernel.org>
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> [...]
> +struct binder_alloc_test_case_info {
> +	char alignments[ALIGNMENTS_BUFLEN];
> +	struct seq_buf alignments_sb;

This really screams for a struct-based way to in-place declare a
seq_buf. The current macro only works on the stack. I think this
will work; I'll send a patch once I get it tested:

#define DECLARE_SEQ_BUF(NAME, SIZE)		\
	char NAME##_buffer[size];		\
	struct seq_buf NAME = {			\
		.buffer = &NAME##_buffer,	\
		.size = SIZE,			\
	}

But yes, this and the seq_buf_init below is correct.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

