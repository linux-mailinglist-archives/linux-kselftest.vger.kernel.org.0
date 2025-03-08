Return-Path: <linux-kselftest+bounces-28533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB81A57857
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 05:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8513AE66F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 04:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285B17A313;
	Sat,  8 Mar 2025 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQhEGZcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE5182CD;
	Sat,  8 Mar 2025 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409386; cv=none; b=QJPIVw4KrEO6GwU1UxhdDMoXw07aTlcBHOoMv9b9Z9NcCCOFtieVFHmG8jjFMhiVF7dGRzO2gir3YeABoyaWeIwqt6ZdvEBfAr2QuBSWftFaJJ4qk2Z0gN9QFk83pxCpo16xKotFr9QZnW8lWWkGKSS+Z5yYpZ/81Hu/hOWwvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409386; c=relaxed/simple;
	bh=cHCMyURT83iZ0bUABkH5vlmrxJCIFzOvc1VaYxMO3Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlT3HfG9je0tHbsTXtCUDMOLbD5PKZrU9Otn9eEuRp6ndOnhdenxNFFK932FUmxtxIL9BRy2ayGWn7KjeVJNCkFXcGuXSgP5uwcEtgKPvXwgWHnP0XqpNvrEwEHq43iLE46FMa4ZVzkw8hkpeUcxU3PJNBAYV8Xycjwo32A9D0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQhEGZcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48364C4CEE0;
	Sat,  8 Mar 2025 04:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741409385;
	bh=cHCMyURT83iZ0bUABkH5vlmrxJCIFzOvc1VaYxMO3Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQhEGZcWsRKjD++O8GD8HN1gxeWgouUnIwY6pBLAEja/E4u2sHlR/mnCjrAflSsg3
	 lwxxM4Uxsw34znfSyIG1sdJO2R15C2P4ru0l7G+13agou6e+c6f2w6sxNWBWPMxEed
	 RfAV2to3mAMvSdMEPwKrQmOSLZEklPw6FEKkGByg4c/tbi18yd+8SeoVbDvrQx63tI
	 0IqJ88Yba96DvfO5TWfo4MC1nHQ6B2ti/saXjIIU+T2iHcuVfwglqub8cgJG+6eb0p
	 rvWk3UbqYRVurjQOb95Mwdwtmqo2rLdKvi06CK26gorEVR2b+LiexRDOebcFVhyv42
	 SJUQs6HSj1mAQ==
Date: Fri, 7 Mar 2025 20:49:42 -0800
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
Message-ID: <202503072046.34DAF614E6@keescook>
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>

On Fri, Mar 07, 2025 at 05:08:55PM -0500, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and scanf), the rest having been converted to KUnit.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> 
> I have also sent out a series converting scanf[0].
> 
> Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v6:
> - Use __printf correctly on `__test`. (Petr Mladek)
> - Rebase on linux-next.

Thanks for doing this!

If Petr, Rasmus, Andy, and/or others Ack this I can carry it in my
"lib/ kunit tests move to lib/tests/" tree, as that's where all the
infrastructure in lib/tests/ exists.

-Kees

-- 
Kees Cook

