Return-Path: <linux-kselftest+bounces-33970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD6AC7435
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 00:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C1C9E389C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 22:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C11221725;
	Wed, 28 May 2025 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4oUCb6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DD220F49;
	Wed, 28 May 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472761; cv=none; b=Bgn/s/mIgm7y+q7sj+Pwley6X6CxTfw3cDEMk0YIUlaaHIdkskqj1uaUp6GfjTRMlwpKMeTig4LQ3wwIva8I5X+assBI3NUr7NVmwnNDbWTUi8j8pfb2YM3quoAykIT0eStWkvQy47zFLuE3bVPjWTIXnv7kZ/dBRDTU7TWBnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472761; c=relaxed/simple;
	bh=iYcf9YR7Z4+2/xsCojP+jHho5nR4qku/etCXFMtxKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLXIktvw35jugm61GVqhbzX/9YIdEjGsA5L6lIddZe9lwUb2d1ExmL72GM4+K1u1fOabOJiPZzy2jQAmZAGH1god0H4gCL5wE7PRTdgxP6w0Fd6gjeWO9RLbL8VwHEILkcvFWsGETisv8IYh98XNpC8+js9nS2OSGZoBZ/o6Vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4oUCb6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A76C4CEE3;
	Wed, 28 May 2025 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748472759;
	bh=iYcf9YR7Z4+2/xsCojP+jHho5nR4qku/etCXFMtxKJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4oUCb6O6O8uFlE9+AfMj/s7q/HQzTa//bQkDQrYBtK3561GQ4tmNZCbtX16fcdxC
	 fPQCV4H2kY6GQYKpD+DLEQrUxNDrIhLg9Ysa1rKEumcAZc1DCqstXHVDSzelcCACrg
	 QssGImgolEqUEIo8fEPjzVfA1RiXFHP6cfeOWw1NI/ly2fouxtG7x59XLknI/BGHqo
	 7TAxSuCg5VpzzlTlxTHo9qQRKtsl1o/H6Su5Jx3cFqctOCVlosY9b+W/8RVF4FN4yT
	 rSb+T5+y66BTHlVQI9zuZC+Ql8Ji/OPt73cl0kVaUOniW/0CqqD8x5R5pnL1aaEuHH
	 K9Yma78GGhmxw==
Date: Wed, 28 May 2025 15:52:36 -0700
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
Subject: Re: [PATCH v5 2/5] bug/kunit: Suppressing warning backtraces reduced
 impact on WARN*() sites
Message-ID: <202505281549.9B51A7D2@keescook>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-3-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132755.166150-3-acarmina@redhat.com>

On Mon, May 26, 2025 at 01:27:52PM +0000, Alessandro Carminati wrote:
> KUnit support is not consistently present across distributions, some
> include it in their stock kernels, while others do not.
> While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> features, the fact that some distros ship with KUnit enabled means it's
> important to minimize the runtime impact of this patch.
> To that end, this patch introduces a counter for the number of
> suppressed symbols and skips execution of __kunit_is_suppressed_warning()
> entirely when no symbols are currently being suppressed.

If KUnit already serialized? I should have asked this before: you're
reading and writing a global list -- I think some kind of RCU may
be needed for the list? One thread may be removing a function from the
list while another thread is executing a WARN-induced walk of the
list...

This global may have the same problem. Why not use a static branch, or
is that just overkill?

-Kees

-- 
Kees Cook

