Return-Path: <linux-kselftest+bounces-6602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A888B774
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 03:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E181C2ECC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 02:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E533128378;
	Tue, 26 Mar 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr4BgcbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5D1272DC;
	Tue, 26 Mar 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420421; cv=none; b=fAG+oHgScDenvqYC79RGLZ33s3KUp58x4MNnt79vsff/BFGLTYfST/biJKdGLfPnm4xjZHLix/37fesMhdJMxuf8AcdBH9iE1oiZ/eoGu3ZB2Rmk+jdHKdDQhFRBLB2vgNjIolcbJM2iLaNMGH0XLMp48DFN+ZuRke8L9K89HKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420421; c=relaxed/simple;
	bh=PWWez+GCtzHxL+Q3cBOsyLC3Pjq/o440jxyRuUA0HBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meXvpgOb3C1jIns9U7xkb2xD6XbB6dv0OQae5WEZTMfnqE/riXFyyBrSbwDNupuGz6xbp1JNxJp+o6KpVs0dsgQj21ilypNunBICnRYemJh88+zAvxaktnAThoqaMs3lPn3kp3SrMpd1Qq1/w1Jp0UmiO2N75nIgRNtMwdM9XuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr4BgcbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1C2C433F1;
	Tue, 26 Mar 2024 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711420420;
	bh=PWWez+GCtzHxL+Q3cBOsyLC3Pjq/o440jxyRuUA0HBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nr4BgcbTvRaBmyTyiDaqh0FqlHuYfefFC+IXxVFq/ApLTk1sVLb0xjv7r92kJ1iqV
	 2ZYyhky/tPHOmOjpy7qvb4YoufvMY14ilBjZ+3zTbAzbh7GAIN5cEmXgC+xAfJ8e6E
	 qD1MN4pmY5qylBsJ3UNrBubrI6A1PPhYyb2wORcke8wmPAyeHrrkq8FfcH/LENJqzn
	 ZVoC1igpWA10v1Mn7ViEqvNT9d107JB5gFcpeVsNJBX6dnjQRxkYdoZUnqM+1P3zu0
	 XXLP8GvSOwQS9KyjaLMkf8Smbbqf0jWPUn3YrHsIL9q4u1yAwqGxKBKJ9rspU9iLJX
	 8+1/BFu4yearg==
Date: Mon, 25 Mar 2024 19:33:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru,
 shuah@kernel.org, idosch@nvidia.com, amcohen@nvidia.com, petrm@nvidia.com,
 jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
 liujian56@huawei.com, horms@kernel.org, linyunsheng@huawei.com,
 therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Message-ID: <20240325193338.565a4e45@kernel.org>
In-Reply-To: <20240325182543.87683-5-richardbgobert@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
	<20240325182543.87683-5-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 19:25:43 +0100 Richard Gobert wrote:
> +	const u32 id = ntohl(*(__be32 *)&iph->id);
> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> +	const int flush_id = ntohs(id >> 16) - ntohs(id2 >> 16);

The endian conversions don't match types here. sparse is unhappy.
If id is in host endian shouldn't it be htons(id >> 16) ?
Also if you cast to a bitwise type you need __force
-- 
pw-bot: cr

