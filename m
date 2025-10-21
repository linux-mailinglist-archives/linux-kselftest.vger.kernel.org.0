Return-Path: <linux-kselftest+bounces-43646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF848BF4FD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37153351F92
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27927FD7D;
	Tue, 21 Oct 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGm9Zg6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915A27FB1E;
	Tue, 21 Oct 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032109; cv=none; b=UdaLrNcPx00TWFI2sjLEQ6vTxv/3A8j6yLLDS3Teti9j4fs8XHZoQj7mV05jRjb4CWVM8fQY2oC+j5nOFkMatJlcowAYAgCIJXRxY/rJzfnGS746On9NBBDiFaAucBBBJQzr5n8RFgnyoIvzKN4h68NVMD/bJw6EuXX8k6RHEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032109; c=relaxed/simple;
	bh=OwWy/3ZyBvLhFE9XTope3GptLHE7g08KOIFUWZ8LOy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrrD8kS7nNiQrWnscztZ+FdxeJTx1vJXnHIcBx8j3LL6E3OO1EZhwOgpApP2jZ/eJ6Q/IIqDqrHqTitUyyxbrJxDfF9XsLkjzJCy4DwEpuwhAfqQUTDrNc98Pb6WQjS7bpr3bv+M+KuhvnTa/dO1UsogGemC447gzbUnPWSKU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGm9Zg6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B579C4CEF1;
	Tue, 21 Oct 2025 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761032108;
	bh=OwWy/3ZyBvLhFE9XTope3GptLHE7g08KOIFUWZ8LOy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGm9Zg6QNmBnyYDKSNuh+6126gcu3ZMM6EpoP1L1PuAkqeV8G/boG3UPhStUiPMZ1
	 8E2dt2anosX9UlipJg6yUoon4DMlSs/l/I7K0/PjFpojYP0UpFuPGxN7KiYP8emIwx
	 a9kvCFnBDWMfKrg3pTa6raPQNOUAMunC4qrf/cgQ=
Date: Tue, 21 Oct 2025 09:35:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech, acarmina@redhat.com,
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Subject: Re: [RFC v2 PATCH 3/3] selftests/devmem: initial testset
Message-ID: <2025102151-distill-operate-a748@gregkh>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-4-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910170000.6475-4-gpaoloni@redhat.com>

On Wed, Sep 10, 2025 at 07:00:00PM +0200, Gabriele Paoloni wrote:
> From: Alessandro Carminati <acarmina@redhat.com>
> 
> This patch introduces a new series of tests for devmem.
> Test cases are mapped against the tested Function's expectations
> defined in /drivers/char/mem.c.

Cool, but:

> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---
>  tools/testing/selftests/Makefile         |   1 +
>  tools/testing/selftests/devmem/Makefile  |  13 +
>  tools/testing/selftests/devmem/debug.c   |  25 +
>  tools/testing/selftests/devmem/debug.h   |  14 +
>  tools/testing/selftests/devmem/devmem.c  | 200 ++++++++
>  tools/testing/selftests/devmem/ram_map.c | 250 ++++++++++
>  tools/testing/selftests/devmem/ram_map.h |  38 ++
>  tools/testing/selftests/devmem/secret.c  |  46 ++
>  tools/testing/selftests/devmem/secret.h  |  13 +
>  tools/testing/selftests/devmem/tests.c   | 569 +++++++++++++++++++++++
>  tools/testing/selftests/devmem/tests.h   |  45 ++
>  tools/testing/selftests/devmem/utils.c   | 379 +++++++++++++++
>  tools/testing/selftests/devmem/utils.h   | 119 +++++

That's a lot of files for a "simple" test.  Doesn't LTP have tests for
this api already?  Why not use that here instead?

Also, this is userspace testing, not kunit testing, right, is that
intentional?  You are documenting internal apis and then writing
userspace tests for those apis, which feels a bit odd.

Also /dev/mem should not be used on "modern" systems, so how was this
tested?

> +// SPDX-License-Identifier: GPL-2.0+

Are you _sure_ you want GPLv2+?  I have to ask, sorry.

> +/*
> + * devmem test debug.c
> + *
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + * Written by Alessandro Carminati (acarmina@redhat.com)
> + */
> +
> +#include <stdio.h>
> +#include <stdarg.h>
> +
> +#define DEBUG_FLAG 0
> +int pdebug = DEBUG_FLAG;

That's a funny define that is never used elsewhere.  I'm guessing this
was cut/pasted from some other userspace code somewhere?

> +
> +void deb_printf(const char *fmt, ...)

Who is "deb"?  You have more letters, always use them :)

Also, why debugging for just this one set of tests?  Don't kselftests
already have debugging logic?  if not, why is this unique to require it?

And am I missing something, or does this new tool not tie into the
kselftest framework properly?  I see lots of printing to output, but not
in the proper test framework format, am I just missing that somewhere?

thanks,

greg k-h

