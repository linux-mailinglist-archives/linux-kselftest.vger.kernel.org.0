Return-Path: <linux-kselftest+bounces-10181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04B8C595D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26AF1F24344
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE861802A9;
	Tue, 14 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+OBw43Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52001802A0;
	Tue, 14 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702789; cv=none; b=oDIZpeiWXAgKHRx0pOidLEhFVEVG2fRRDB00F55VMSOpKb2jXOlJ0BKxoxA/0XCd0TQqLIImf1FIx4816422kQVJq52e3KxbmE5f6vkAvCQsqG36U7hyGgnQhYkkedBh3g4YgyM9rrHyA1bOlSR1iC1wqn5vPY0t1S7X89Wbmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702789; c=relaxed/simple;
	bh=OUpfe59PRQDeM1cQhdaHMmPeDNi2VRMZB6dWmBoosa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCdNqL1uGTO0sSpgRcBERK2qeQvRt4T7mFwN/kNl63B59+zd+HTQhrIYiQrkxVyknqEwCyrU5xboBEjp9t5pWtZp/w0aG8K9tnDiTKQK6KUIPdZ11R68P+AEVJ/LngeWQCpyIvkhvAdDGIs2WM01yGEmCHCo6h6C35wmX8D1zJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+OBw43Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38A9C2BD10;
	Tue, 14 May 2024 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715702788;
	bh=OUpfe59PRQDeM1cQhdaHMmPeDNi2VRMZB6dWmBoosa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+OBw43QsXeZNkmo/L13EC+aN91K+ai7e33BLEKVkignD9OgUkbKiMLr/3MdHdHOw
	 3NX5q6lvxxLqYUFIMfe0vOdFoDBJP8XL3NdHQpH9xnB7qqzB2c5R8C450bQ7RceM7z
	 l9Xp4nmH5RAi6UAe9C4IcD9R1VnGcqXOx/3/stF8fTRuR7lgynTy419y4wEc1VHiVM
	 Y8blMEm9j372q8Ltpe3Rt5UjNYLt0mm+G1MSlRyFISzTO9lFg6LQbg4W5+/LymKvLo
	 FRI4xo/pQYDp7pS0xKXZLI6H87pzcqCSReKJSc6Iput3TPWHuqydUbI+DFnmTlbUb9
	 WkZiNK6s7V/hw==
Date: Tue, 14 May 2024 09:06:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, alexander.duyck@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
Message-ID: <20240514090626.69676cb5@kernel.org>
In-Reply-To: <8e0b027d-4d30-4f0f-82ef-113287f17c6a@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
	<20240509190819.2985-3-richardbgobert@gmail.com>
	<CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
	<20240514071407.257c0003@kernel.org>
	<8e0b027d-4d30-4f0f-82ef-113287f17c6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 17:56:44 +0200 Richard Gobert wrote:
> > Hi Richard, any chance of getting this fixed within the next 2 hours?
> > I can't send the net-next PR if it doesn't build on one of the arches..  
> 
> Hi Jakub and Geert,
> I'm only seeing this mail now, sorry for the late response.
> I can fix this within the next two hours, would you prefer a standalone 
> patch or should I add it to this patch series?

Standalone patch, please!

