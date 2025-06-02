Return-Path: <linux-kselftest+bounces-34149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA12ACBAE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8CA7A2427
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0D228CB5;
	Mon,  2 Jun 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDBayr8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E392288CB;
	Mon,  2 Jun 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887892; cv=none; b=i1HqsvX1Oz0IY/sI+t0cxI030IpnDa8pXygWuIo7KgH3cEp4YbgPZQWFXybKHMeBKH4T60ThnBtp3kZnk3IRIZk8dn67e48km0gkPB8IPEYzBVKCAE0waOpBr++SUuzHL7DB4m5mlpapKkilcyR/ZXldXVB6lDH3nN/vKIA1vaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887892; c=relaxed/simple;
	bh=pKayk//axGGraHGB1+iIPIKX+7C+PbImGLMS5A9QTJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDouxZJpS7zdLWlS22vfhKCJAKa8RHAuQx5bQcFIQ43vsR2DPKGntZeS9hs0Q65CRsoNExXqos+iCKum4DwfYlXy/mXZtKJOTXNeHNCbFh28XP0hAEQaAh0rFzMOZk3fKNSFEQjgkwgkB7Gtb8yBMhTV/2yFlMqLKbnp/FXVj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDBayr8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76482C4CEEB;
	Mon,  2 Jun 2025 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887891;
	bh=pKayk//axGGraHGB1+iIPIKX+7C+PbImGLMS5A9QTJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDBayr8/Lc+nq0Nvcf7flG3POh9qvI7+421CSQPBFo/8rtUgqueGctqpFg1LScGO4
	 zspG0+fazamdPVYFcTjQdLFr2wfNV5pdyELzLHNP08COVMypTdB75UtPl6xbpLTTQw
	 x4i6ipt+V77NuAogEpbLU2pLpWLqzApEOuezjukRocF+F8yG/zYnKk6q0B/TgqQ6xW
	 Er3uQi/+J50j3Eql3JRoZdvBqP93WaSnMdbzMQ2qFQ52XxmyU1eiSa+eOAMqyXd3QO
	 td4SMhyWGLPjjX1JeFvX3+1p3af4XJ0A3EopAZyeXrYYmFsrKy1Jq4NSZEwAFo0XjU
	 JuJZWlLOwJtig==
Date: Mon, 2 Jun 2025 11:11:28 -0700
From: Kees Cook <kees@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/tests: Make FORTIFY_KUNIT_TEST depend on
 FORTIFY_SOURCE
Message-ID: <202506021108.3AD999F73@keescook>
References: <e36d5e6996a7ea4dc694c4b8dedd15943952d33d.1748875801.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36d5e6996a7ea4dc694c4b8dedd15943952d33d.1748875801.git.geert@linux-m68k.org>

On Mon, Jun 02, 2025 at 04:51:44PM +0200, Geert Uytterhoeven wrote:
> When CONFIG_FORTIFY_SOURCE is not enabled, all fortify tests are
> skipped.  Move this logic from run-time to config-time, to avoid people
> building and running tests that do not do anything.
> 
> This basically reverts commit 1a78f8cb5daac774 ("fortify: Allow KUnit
> test to build without FORTIFY") in v6.9, which was v3 of commit
> a9dc8d0442294b42 ("fortify: Allow KUnit test to build without FORTIFY")
> in v6.5, which was quickly reverted in commit 5e2956ee46244ffb ("Revert
> "fortify: Allow KUnit test to build without FORTIFY"").

Same thing as for randstruct: I want the test to always be available. I
don't want 1a78f8cb5daac reverted.

-Kees

-- 
Kees Cook

