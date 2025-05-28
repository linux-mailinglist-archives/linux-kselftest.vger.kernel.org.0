Return-Path: <linux-kselftest+bounces-33969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D46AC742C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7387C3BBBA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF391F463F;
	Wed, 28 May 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKpLgpeF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838324A28;
	Wed, 28 May 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472466; cv=none; b=dUOBg94N/4THqhfAqAWnEsOW40V5ccTB5CGQKBkhus1oZ8ZY0Ezr4xuRBRHITa4r/Ks2ESEAwsYUbDLZIxNR3pCUzTjTyCxfMCjfEibtyyXvName3e8D4voIRLT8GCF6ZlOF9CZdjKfd2GXi91kIy61SPdBxJqvxqh+9AmyTSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472466; c=relaxed/simple;
	bh=/uDiyMlExuXwk0cv6TZbVIbgRWnKfXUvjrWMarhJ84Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIJeP90jJqFqEYTNyyCCDrnBIWoRhceBFOTfGs9MI3/VL3u13VlBt24bRN1Rc+LIOaZRj0OvvFhJwG8xOcec2PATQky8Hw0wUiAR626dkczk5oskjGyko8iKqB2KLOszd4YO1i5BMtAzeDB20Xi+TUi96wou2xEIejowXp9OGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKpLgpeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B44C4CEE3;
	Wed, 28 May 2025 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748472466;
	bh=/uDiyMlExuXwk0cv6TZbVIbgRWnKfXUvjrWMarhJ84Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKpLgpeF80eASQqHsPI8iGn5i7bfvDJ1492ewVMoXYTI8z5Ayuumyi6MAH8ZsrOav
	 1L5ORSKgDxJNP7FBAVp+QU7piq1ayeEaTu8cF8qU8qw0hRBJ2W2FT2y4f6WozDlhG8
	 VR/cHHOzWLam2CZCRn+kQ0529ABJg+WX9NTYDW1HF/mhUe31akNPoZZkyWGciPMCS7
	 yfeFiHmMcYs3fyEySn6w8h2bvq6gqYs0pg2tILIXELvQW6hjI/+gw/ge/isQWo+Lsb
	 lclU0ZEMwMrb5MlD1x02dVAXb1iitCoIoNvybAuDC9ng+NcaFKYy5VlAMCHZQ5kG6D
	 O3u3wPl037MSA==
Date: Wed, 28 May 2025 15:47:42 -0700
From: Kees Cook <kees@kernel.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <202505281546.DB9D9029@keescook>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132755.166150-2-acarmina@redhat.com>

On Mon, May 26, 2025 at 01:27:51PM +0000, Alessandro Carminati wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons:
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
> 
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multiple
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum.
> 
> Implementation details:
> Check suppression directly in the `WARN()` Macros.
> This avoids the need for function symbol resolution or ELF section
> modification.
> Suppression is implemented directly in the `WARN*()` macros.
> 
> A helper function, `__kunit_is_suppressed_warning()`, is used to determine
> whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
> sites reside in non-instrumentable sections. As it uses `strcmp`, a
> `noinstr` version of `strcmp` was introduced.
> The implementation is deliberately simple and avoids architecture-specific
> optimizations to preserve portability. Since this mechanism compares
> function names and is intended for test usage only, performance is not a
> primary concern.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I like this -- it's very simple, it doesn't need to be fast-path, so
a linear list walker with strcmp is fine. Nice!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

