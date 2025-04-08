Return-Path: <linux-kselftest+bounces-30380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87531A816AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAAD1B855C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6B24DFFB;
	Tue,  8 Apr 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lreQcZmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D024BBFA;
	Tue,  8 Apr 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143126; cv=none; b=l/UQfFo9+WwSGTMiQ5IQJANMwyzl2W6dFMpwcE+Kg5yS2fb8FbHF0IN6krjx9vwRDyOgKvtUTN+xlMCn0BsjEYbRjiJG9wwxDS7VLDReypxa6gVR0ktDQya6lb2YZG63RZv8sIkEGZDkG0aGv87C/NxICsMuvLBWZI5lK/m4Fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143126; c=relaxed/simple;
	bh=hBtu8NtpehHXTJrd9hH08sVqKjdhn3nzADo3W7mKVZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKlh9/T4cPCQsB55y86Yx6wsj9Lqfod8Lpy+wVclfgHkpY2ljcyW64P/O32RryaWlEnyNVKiuMiU7lXupoVu/oO2eLbmO2jEXYKvvQ3sId2FwMpneKGK5/mKYmk0G5uWUEl0+t5W0LriG8tdkQsnavQpFA9xNV6GUvloLB+WlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lreQcZmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDECC4CEE9;
	Tue,  8 Apr 2025 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744143125;
	bh=hBtu8NtpehHXTJrd9hH08sVqKjdhn3nzADo3W7mKVZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lreQcZmyMyEerXb8j1lQsuZRTMutV1IbpoDZOLgujYjdTFG0fQoIV2nrO1rHH3wO2
	 cU2GwkdwGF2goPvGDNAqFZCVErq+4IdQiVTzDiW/t2RcTP3p9BK8E7fncjrMiQYKEl
	 ev0LvUD9ZgJcce+N8LGShxZIiqlzk0a0jZZe6pDtngNzRNoE+cvMxgO/tr0fJ2FRGY
	 eqkd3eIpugPieSAE0lojiDHtuy4OKYgzfHUr7rIxCz5Ez7/bWe3KzFIb4kieIw1iK2
	 iM3qobk1tP4ZrNlWKvz2wBgHV4DR9u9vig0dhnky3MPZZNOA3HfcnhFB4msPtSlbcB
	 S+jsDgpCwNHog==
Date: Tue, 8 Apr 2025 22:12:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND x86-next v4] selftests/x86/lam: fix resource leak
 in do_uring() and allocate_dsa_pasid()
Message-ID: <Z_WDEJdIFLLCpZ-2@gmail.com>
References: <Z_TZ138UxQ_uZzys@gmail.com>
 <20250408185248.7722-1-malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408185248.7722-1-malayarout91@gmail.com>


* Malaya Kumar Rout <malayarout91@gmail.com> wrote:

> Exception branch returns without closing
> the file descriptors 'file_fd' and 'fd'
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  tools/testing/selftests/x86/lam.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Why have you ignored this request I made:

>> Finally, it would be nice to quote the before/after output of the
>> leak detection tool you are using.

?

Thanks,

	Ingo

