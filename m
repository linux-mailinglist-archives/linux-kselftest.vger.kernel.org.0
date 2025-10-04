Return-Path: <linux-kselftest+bounces-42771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F92BB9048
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5A84E512B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625B280A5B;
	Sat,  4 Oct 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FugQS3mk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920B1F0E3E;
	Sat,  4 Oct 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596533; cv=none; b=FatDsNpAsXYcnVKpzZv9Kxp5oqHhhZPrI2/tSuLb8PvgsMG0hK2HRtHt3ltE6Uu2h8IETHSoO+MVIK/gWUsFv7hhVMr0hFwo4NmtlgT8y68pFv6ltuA6Ek462D2vVAWBwu6rSjJV7z2LnxWwREwE9y3OUc5zngnlJozeYQxTMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596533; c=relaxed/simple;
	bh=1z0p50CsmcXRod4I++SMuzSJspd1KqMg8y7FgNT2J3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTfW95M/TktznE2HVi9j8gDM5mimArN7F1832Q4A2lw8L1XxQr+8IeiCSwvJk5b+1TcoUbIJp25Jox61EoWaAyr+NcmPecwUAl/JylHuLU4Yzdg6RfAfrE08brqnrJ9VGUTR4oLFTezVcxGjA6gdbPLOcIAKj8wK2/amcu5Jtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FugQS3mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095AEC4CEF1;
	Sat,  4 Oct 2025 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596532;
	bh=1z0p50CsmcXRod4I++SMuzSJspd1KqMg8y7FgNT2J3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FugQS3mkAg245aTA1vIyom40FBV4rDSw+Rfyt6in9+HIla0GqTnYwQSAdZiXl9mBH
	 trZXaATS+YJC2jb8U/iJvmQ84AVNcMNK9AcDQqdPV2UokcL/NGKF7Z5Fi6ncF3q/LA
	 doGnRJly9u+KUBCdvKeg445TY39UyJ2ygDBb3OtKCU/4Gli7TgBsuF/SgnK3n2gyuN
	 Z8miq6lAW5YJUc4I0Fo6dAy826cO5GufPWFqsrwyIQML/Xm35k5QbS4yahodlPOssf
	 c2ygJjpE9j0v+i5k5Z5cLb/cU9S9HNyMRxdCt7/zHimkumJwJ6qeZApZz6gpPUv8c7
	 hNWgBbULQea4A==
Date: Sat, 4 Oct 2025 17:48:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	shuah@kernel.org, joe@dama.to, willemb@google.com, sdf@fomichev.me,
	almasrymina@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 9/9] selftests: drv-net: pp_alloc_fail: add necessary
 optoins to config
Message-ID: <20251004164847.GM3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-10-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:25PM -0700, Jakub Kicinski wrote:
> Add kernel config for error injection as needed by pp_alloc_fail.py
> 
> Fixes: 9da271f825e4 ("selftests: drv-net-hw: add test for memory allocation failures with page pool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


