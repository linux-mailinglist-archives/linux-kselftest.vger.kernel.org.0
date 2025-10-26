Return-Path: <linux-kselftest+bounces-44064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35766C0A586
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EAE3AD151
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37C256C8B;
	Sun, 26 Oct 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0esH9B9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5D1DA0E1;
	Sun, 26 Oct 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471351; cv=none; b=unaFpUgKwr5EpTuqaMm6qchNhKqq1uNvg5aZb/34V221wNQ6MMJK7pqehXrH1aw6hROSBb+B2yylj2IrwUTGRsKzZ8rGKEMHeDu/6zXLdOziPCctPlZV56ss8g6s2KGLDA6MZehTXOFeBcFYwneAK1ML5Z9cam6DRxapEOtiv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471351; c=relaxed/simple;
	bh=9fLzqCKLRVH1pdiWjq3bK9QYrYxlC+mhmnkEd7WZtwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdbngCNfW7ATykBBlgZNuLAnWRLg2YDBv9Bpr+Shzl0x4G3ewYabh6kYkoLGk5s4LLFq+PTFSemsuJ8Y+qZ8zNoTRTTX3BfgYsPIn2IWcGg8EldIS8wVQqlbG4BlP8bKDg9wVtx+r0WSvw0Oy60DopbFrgw96Ppr+ca0lViAUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0esH9B9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3468C4CEE7;
	Sun, 26 Oct 2025 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761471349;
	bh=9fLzqCKLRVH1pdiWjq3bK9QYrYxlC+mhmnkEd7WZtwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0esH9B9h9lJaovKBUwc5QHyos7flgYnt4H1y4M1zSK1rssLNFrj1k2aLiBIHBEQA4
	 3DlzH9wV4XB2eVkdCF0jha/W+579ejFdTk6tw9HTS0KHlZN9TIWUM6OaJ/OwFyyww8
	 B+TNrznpxD166ne0Y4bM8CoCV7zF7zVe+w7RGEhs=
Date: Sun, 26 Oct 2025 10:35:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: jirislaby@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com, xandfury@gmail.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: Re: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Message-ID: <2025102634-relive-glutinous-df0c@gregkh>
References: <2025102633-dandruff-clang-e91d@gregkh>
 <20251026092341.2896-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026092341.2896-1-krishnagopi487@gmail.com>

On Sun, Oct 26, 2025 at 02:52:32PM +0530, Gopi Krishna Menon wrote:
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

What commit id does this fix?

thanks,

greg k-h

