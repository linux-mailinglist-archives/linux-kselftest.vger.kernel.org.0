Return-Path: <linux-kselftest+bounces-43202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F0BDEC8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 484654E1448
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E1229B2E;
	Wed, 15 Oct 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E97htG3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864C224AF7;
	Wed, 15 Oct 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535705; cv=none; b=XmLsV1y1e6csO+f+bTPTepwn2Iax213a+tKO7HdjCL0zJOYpxo5t8EJJXoGB4hRAl6MR/HAf0jsFaVZM2N1NUmRkdMtg8iBYaEdigiONHdDTLcR7d/Dbg0XJQBhIziAdf9tkts7htju+YyQoM3iEv15BN6WnxQDPHYn041pdos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535705; c=relaxed/simple;
	bh=nAeey9X01+di4Hz2ofH42MXPibMnOK4mRl0o6hHQD/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3duVU/LbhhsdCPTT6ttr4nmEORh0ltaqbFC9rOFePxwTZYYGTvgLoTGbcoCY9hP22LsSvseQJx5e+/fvy+RN5GTFzrm924HVew8fx3ErMFV6Q6FtF4/i9FyzfqGpYc4ECh55ikr5B6ClrZx0bTvJ245UKUggH66u2zenNgC5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E97htG3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E201FC4CEF8;
	Wed, 15 Oct 2025 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760535705;
	bh=nAeey9X01+di4Hz2ofH42MXPibMnOK4mRl0o6hHQD/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E97htG3+LsSSZp/IxXswBaIHkWvE5f8B2PcQRyRxJoF+LdQfy/H+N6dWqar/3Ob0D
	 FBlsXnq4cjTZeAyCLSC6Oo3r9DrqLMZb/jPLP7LTdWSrx/klYq0Xb06TpIdoa99nbO
	 R2LhUdY3nxQFwPqroyyNbRXy2MGa0NyOo7rKq2EQWNXBKZH2EW0LT+7RJ3dbHv0uFX
	 /CO6u7CaVWH3Q1tszh9Rm/jwcqlwnJSB/P3yf5+v5dMd2hWnmTw4k722qeNtR0GAtJ
	 papMXz1DPCeFRiypN65fO+7H51RXLLUrS8Phh09K0owbPBvbeA7HtUUY+FMiL/QI09
	 WXZxHSRCFUy3A==
Date: Wed, 15 Oct 2025 15:41:40 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] selftests/fchmodat2: Error handling and general
 cleanups
Message-ID: <aO-klE_UoAtMuOoC@example.org>
References: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>

On Wed, Oct 15, 2025 at 01:36:24PM +0100, Mark Brown wrote:
> I looked at the fchmodat2() tests since I've been experiencing some
> random intermittent segfaults with them in my test systems, while doing
> so I noticed these two issues.  Unfortunately I didn't figure out the
> original yet, unless I managed to fix it unwittingly.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Rebase onto v6.18-rc1.
> - Link to v2: https://lore.kernel.org/r/20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org
> 
> Changes in v2:
> - Rebase onto v6.17-rc1.
> - Link to v1: https://lore.kernel.org/r/20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org
> 
> ---
> Mark Brown (2):
>       selftests/fchmodat2: Clean up temporary files and directories
>       selftests/fchmodat2: Use ksft_finished()
> 
>  tools/testing/selftests/fchmodat2/fchmodat2_test.c | 166 ++++++++++++++-------
>  1 file changed, 112 insertions(+), 54 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20250711-selftests-fchmodat2-c30374c376f8
> 
> Best regards,
> --  
> Mark Brown <broonie@kernel.org>
> 

It make sense. Thanks!

Acked-by: Alexey Gladkov <legion@kernel.org>

-- 
Rgrds, legion


