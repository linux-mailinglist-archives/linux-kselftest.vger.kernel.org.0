Return-Path: <linux-kselftest+bounces-44059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BCC0A4BB
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D354E39FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5326D4C2;
	Sun, 26 Oct 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFW3R7M1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE221254B;
	Sun, 26 Oct 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761467761; cv=none; b=L+1iBwC6XNvZMcmsy8igVA/yrnX8C4HgJ3gJKdVxAyQJelNvLGwP8mXEmyfxTcmO4tEl4If+NeaMjfRSdZNYp50NtrgkPcS4EY2QvfbY0W84KxkHlQZItNFePmnnDPmIyxqWEhnI0oOHsNTRGxI8RO6/DT1ESKOkTNtfhYy+O5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761467761; c=relaxed/simple;
	bh=ERCgAQxpXEfEwS2OB4jbX7cHDxV1u4EV4btd63GElsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6U3u6bvkfbtvOvAevz17/JtiOhCv3E6DQnYOEG6MpZtRyijZ+D9rUMqgrIejgkqhh1Jz2GF86LU1XNobfhMOb1fj6EWsl6a5tHOh0EP8K4wyo11SgxSZkFo4xp4gg4ZWvlO42ZTdx30nBapMs9+O8TbactVFhpHE/QZ3kuMP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFW3R7M1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADD6C4CEE7;
	Sun, 26 Oct 2025 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761467760;
	bh=ERCgAQxpXEfEwS2OB4jbX7cHDxV1u4EV4btd63GElsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFW3R7M1xZ4UPh84WP/AESwDFe20vMM+AS8rMhnS4x+R0B6topzCkS3JHnrgB/E+C
	 to+bveUKeaY+Kza/MyHTfgM0KWHbZlwDs+PaIP4axeL2nAqLS6PG1Cecq5e/JIytF8
	 QN9k0WAPJBg/9AGf4BKb+1ox3bLyjZ8cpJ9I6wRE=
Date: Sun, 26 Oct 2025 09:35:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: Re: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Message-ID: <2025102633-dandruff-clang-e91d@gregkh>
References: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
 <20251026072554.48786-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026072554.48786-1-krishnagopi487@gmail.com>

On Sun, Oct 26, 2025 at 12:55:46PM +0530, Gopi Krishna Menon wrote:
> Building the tty selftests generates the tty_tiocsti_test binary, which
> appears as untracked file in git. As mentioned in the kselftest
> documentation, all the generated objects must be placed inside
> .gitignore. This prevents the generated objects from accidentally
> getting staged and keeps the working tree clean.
> 
> Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
> staging the build artifact and maintain a clean working tree.
> 
> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details
> 
> Suggested-by: David Hunter <david.hunter.linux@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changelog:
> - Improve the commit wording and explain clearly why this change is needed.
> 
>  tools/testing/selftests/tty/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
> index fe70462a4aad..2453685d2493 100644
> --- a/tools/testing/selftests/tty/.gitignore
> +++ b/tools/testing/selftests/tty/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +tty_tiocsti_test
>  tty_tstamp_update
> -- 
> 2.43.0
> 
> 

Shouldn't this go through the tty tree that added this test?

thanks,

greg k-h

