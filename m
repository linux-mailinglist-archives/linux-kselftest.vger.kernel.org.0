Return-Path: <linux-kselftest+bounces-49385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA34D3B480
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC5F306515C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6A328B7B;
	Mon, 19 Jan 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCOwGj3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543532C15A2;
	Mon, 19 Jan 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844216; cv=none; b=q59fomMRthPXAUgahce3YJtB/UTgkR1P1tKBiEeVFEk1Qql30v008CLJJW6ylj+Q5xolgP5KOP4Ox5x93jtrO9ThYd1JRq30NBmUkxRpoecpAgmAt4r8bkI4Ce/c4dhAnVdUIQKzNhGFcgVQNcXrhG3Nsxv700q+SeRmkI0uszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844216; c=relaxed/simple;
	bh=fFgd95nSjvrID0DnCS212EAtXufITrbCGDdc4IoPG8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsSjn5hCwWnN0X2t8IZgOXMC7wDLJ03j7IKFlcJlGpDQnF04R/agB1T0MSQC2ADdF7iLN2+PgxEJtYSa9ZlG/sDQ8oBMa86WddkkzqhMU7Tw4vhPh2LDQ7r6oT/HHVAL+7IxlHZPQyqZzSTUw1mFrzMBPTBhpcLmstTobnSwnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCOwGj3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C3C116C6;
	Mon, 19 Jan 2026 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844216;
	bh=fFgd95nSjvrID0DnCS212EAtXufITrbCGDdc4IoPG8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gCOwGj3rhF1Fo8fhlTMwPgVai9begodtq8jK9xcNAetWIgmSy8jTgiHVHcV4D81KD
	 h564KLTxsFJHKulFUSh6i6OVx+01bVqcAWFVuOa+ROsriR6hmtr1kadIDj5ib8ZVrk
	 aTJL1KQ5yuoSYCGovFuI06/d35GiR2AUlNr8B0UTzrz9Dho9UGAKfEQN7L4m0JiorY
	 Ktej4bWgLfdG8aKtmIGcy84IeFWeN8TXhcI2phnyWU2OXWQsM64tARi1GPxO+MGsoF
	 gwz8TYUozpiBPTvbXpE+ms+YfGpQeCruj3ld1+QMENjpTRzayoYfXtkMc3FjuOv11C
	 qjK2RZCBJCdcg==
Date: Mon, 19 Jan 2026 09:36:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "shuah@kernel.org"
 <shuah@kernel.org>, mlxsw <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next] selftests: net: Add kernel selftest for RFC
 4884
Message-ID: <20260119093654.1d893f2d@kernel.org>
In-Reply-To: <DM6PR12MB451623DAE30582C45BB95A3FD88BA@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260114113141.2522209-1-danieller@nvidia.com>
	<willemdebruijn.kernel.1ad957d6f7314@gmail.com>
	<DM6PR12MB451623DAE30582C45BB95A3FD88BA@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 11:30:14 +0000 Danielle Ratson wrote:
> > -----Original Message-----

Could both of y'all trim your replies please? :)

