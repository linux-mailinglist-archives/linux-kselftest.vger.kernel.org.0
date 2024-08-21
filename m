Return-Path: <linux-kselftest+bounces-15804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E41959221
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 03:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94B71C20DDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4BD4687;
	Wed, 21 Aug 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKxkhDic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7CBE4F;
	Wed, 21 Aug 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203310; cv=none; b=VS19WlqWFx8PPg834uVBtz6hTDEvcYusXTof3Zgcl8Ta99icSkIFVqXavup2JuMBnhwm4fLe/fyfkEr/oUn4GoDWxd6IOIq0HdAeQj/+KE/Is7qP8Fu3BLbtNnw4TAa81YxhnkEvxCTkuN0scMUMTgnu5VuqEaNi9WT/5BolQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203310; c=relaxed/simple;
	bh=NfHpS/2oNy8BbhVFvSHovdHAcJTYTcOjR0L8joeVgd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ1NGLyNDSlzFNZ/xCyrhpPalfuQH59TF9IqFiM+ilWhW4xxxUFliwXMZ/hJnIkAZZLPMKTFkpj0N6qKhS5eRqgT+SoRHa4f90K2QnAiUddCFrotbjJClLnmY6gTCUn/aqE+PBEcs0JkOmTrNAhguDPwS56DVfe9M3J/vIkGSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKxkhDic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC69C4AF0E;
	Wed, 21 Aug 2024 01:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724203310;
	bh=NfHpS/2oNy8BbhVFvSHovdHAcJTYTcOjR0L8joeVgd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKxkhDicgLuBzpwhc+B+zbksY6DYE4BviMp2Y+2BGJrwGPiV5tUWc8ZPlPLCAsTSK
	 A22owBVKOqcHyd8AdSJr5LTFXr61u09wrtS3ExRAGJOGgCcOTmvL0tRgaxXW6QpD/G
	 jqxxRHXBm+eQtV3flGeJ2io9H0ct/akl4KsrjjG0omCRiIG3uoVpRVQc5R6ovUkBfZ
	 lJrM5rs86vz5uQ4ckeTFFd9+flT9LttH6SFdBd/EwuD868stw+Oxjf9bDSOp1uEXPU
	 YzS1rztvyos/I2gQRo4VStZQn8S7KKyckhe3mxAVSsuWFAbPqsEVjxldZDAjxvVt89
	 VCw6f5X76BUlQ==
Date: Tue, 20 Aug 2024 18:21:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, Ido
 Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next v2] selftests: net: add helper for checking if
 nettest is available
Message-ID: <20240820182147.462226f2@kernel.org>
In-Reply-To: <20240820084412.4aa6abfb@kernel.org>
References: <20240820004217.1087392-1-kuba@kernel.org>
	<ZsQLFwkNa-JnymGg@Laptop-X1>
	<20240820084412.4aa6abfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 08:44:12 -0700 Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 11:18:47 +0800 Hangbin Liu wrote:
> > Excuse me, what's profile used here? I can't find the definition in
> > Documentation/dev-tools/kselftest.rst.  
> 
> Ah, sorry, I added timestamping output as a local patch for NIPA.

To be clear the profile=1 enables the timestamps from my local patch

> Random example:
> 
> TAP version 13
> 1..1
> # overriding timeout to 7200
> # selftests: net: amt.sh
> # 13.15 [+13.15] TEST: amt discovery                                                 [ OK ]
> # 16.27 [+3.12] TEST: IPv4 amt multicast forwarding                                 [ OK ]
> # 19.14 [+2.86] TEST: IPv6 amt multicast forwarding                                 [ OK ]
> # 670.88 [+651.74] TEST: IPv4 amt traffic forwarding torture                           [ OK ]
> # 1203.28 [+532.40] TEST: IPv6 amt traffic forwarding torture                           [ OK ]
> ok 1 selftests: net: amt.sh
> 
> It's not great, makes the lines longer and misaligned.
> But it's helpful for debugging slow tests.


