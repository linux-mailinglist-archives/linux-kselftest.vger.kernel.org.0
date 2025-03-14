Return-Path: <linux-kselftest+bounces-29070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD97A61D08
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FE33BCD59
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3897142624;
	Fri, 14 Mar 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBLDFEKu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C6A32;
	Fri, 14 Mar 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985156; cv=none; b=qI8xL5m3gIs6ElDpCMROoZj6AlpbHsWrfjdxT368U9p1iDvFHrHXPz0RILaCCR5W4J6oCMa9N6ctVq4R4s/Hz2rpVcdJ0MPuEjVNFJZrZR7ROZVC6AUQAcKAMV009KKj7Nuy18qQOv6F2aZktmfVyffJaA+ddSwX1rjEANXrOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985156; c=relaxed/simple;
	bh=EOO8H6PnKJZsg0sd1wxBqgWeZrDQtxasN7DklNFE0Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suY4yZmIaPzXVRZg2RS+ErEKBJYfWIcpzggyAU3mOYb+HELVGCL4+RghzYHbz6h5REtBadj958glxvd2/Oo6tJdX+TFrQej5/vOyMRDzZSRDrMbF/1Fy6gssprGZvAGtZkJov+0IXTTcI+HpFBRcn8RJhpq7WVQrWIVt9b5nBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBLDFEKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6E1C4CEE3;
	Fri, 14 Mar 2025 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741985156;
	bh=EOO8H6PnKJZsg0sd1wxBqgWeZrDQtxasN7DklNFE0Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBLDFEKuR1Cszc60BSg1fQkxGIckBK/7hmz9wcqfhmGkPlxdzCTZhMY4SSK09xe2U
	 iO3VrmQiyTStgNn10QhHBHd3VMqvUs8usY3ZYAoLvULUyXClF8HWWLcf4QUqwqGGuz
	 F23WU9t/h5wHquMUYTHzVqCdvprQnb/agqRvmaYZp+uwXsjG9j+jH+RLfW01ZvCYNG
	 KUz8t8ii7cRTfCQ8p6Xz9WCW/XvsbxNu5dNROtiJsjT0rv0MHn+CXh3fRFyXu9EOB9
	 qEd9+Os0EqjrPTAL8FEE59ta411NSI1rLIccgZbGj7bScrwKoRI2HI0NAGAsVxqWn4
	 MR1HqlqZIxkRg==
Date: Fri, 14 Mar 2025 13:45:51 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
Message-ID: <202503141345.0D3FB87E3@keescook>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <Z9QvRJE0Yun5mfsN@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QvRJE0Yun5mfsN@pathway.suse.cz>

On Fri, Mar 14, 2025 at 02:29:40PM +0100, Petr Mladek wrote:
> On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and printf), the rest having been converted to KUnit. In
> > addition to the enclosed patch, please consider this an RFC on the
> > removal of the "Test Module" kselftest machinery.
> > 
> > Tamir Duberstein (6):
> >       scanf: implicate test line in failure messages
> >       scanf: remove redundant debug logs
> >       scanf: convert self-test to KUnit
> >       scanf: break kunit into test cases
> 
> Kees, could you please take the above 5 patches as well
> via the tree moving the KUNIT tests to lib/tests ?

I think you mean 4? Sure!

-Kees

> 
> They seem to be ready for linux-next and the next merge window.
> 
> >       scanf: tidy header `#include`s
> 
> This one is a bit controversial and might be added later.
> 
> >       scanf: further break kunit into test cases
> 
> This one was just an attempt. But I personally think that
> it is not worth it.
> 
> Best Regards,
> Petr

-- 
Kees Cook

