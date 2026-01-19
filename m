Return-Path: <linux-kselftest+bounces-49414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F2D3B823
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72B383011B30
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4952EC0B5;
	Mon, 19 Jan 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr78xs/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9612E7BD3;
	Mon, 19 Jan 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854125; cv=none; b=KDFb2wdFXoirPi4UZPzeN5TuMggoYsSokGJHEja+xAAHXbniEyzZF3l476wBXewopd9hWTn2AioCLZUC38PeBMVNuWE2ZxasVN+uP6wsMrPx5jhxUyihJRZfKJdfXTE6LMB2Y/7R0xC2xUIkRQh6Wzt8C1+EFZhHfUUbGsyqjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854125; c=relaxed/simple;
	bh=Yy3X/BAgxUsw+7jxErv41X2LtK0A2Px3bMZ5Nmop+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbEHIvQwi/TdOSyraSVUDjtaOe0AtWKrbcaF7qs/rE7ORzee5RlpEPtU943uxebUsxgt+nhNlAVi5vM2QPhyY6zuMaZ1V18hAq6FK0o58cvNDjlu50eF6v++OqqBmQfIUVvbcPVNcTEtWlKq0h/JvJIOz1e9MF/vscMd6OaJFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr78xs/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF023C19422;
	Mon, 19 Jan 2026 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768854124;
	bh=Yy3X/BAgxUsw+7jxErv41X2LtK0A2Px3bMZ5Nmop+EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sr78xs/IzjfhaiPSKibT3ZElg1QKI7TtftSWc7mpM0MeW8byJ5D0CC0nprn0uFVNM
	 /Ozmr7KE+WmIFLZFJInnH1AQp3NDv01fnmlulUnq8aWKPdk2yaydMwu90EawfWh4KP
	 sGkL5vmBk/p4mszZlVMV4l83AuWhyTFghtMDUM2EAvKS6C+4lOiPMGf1j+fy15hH0V
	 d1jbjizUfAmNzldiqTxbOWGpb02g5FgIfPNBNZDUpl9QANryJ5xD9HOu2F7mTjJDiI
	 cojVifXPfJM3yTBoXy9xv8I05MykEMNErG/n/m0M8E5GmRCOsT/rP9E7pBx/blwWsi
	 xevxCuif283sg==
Date: Mon, 19 Jan 2026 12:22:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Mahesh Bandewar <maheshb@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Message-ID: <20260119122203.5113b16f@kernel.org>
In-Reply-To: <20260114064921.57686-3-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
	<20260114064921.57686-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 06:49:20 +0000 Hangbin Liu wrote:
> The current ad_churn_machine implementation only transitions the
> actor/partner churn state to churned or none after the churn timer expire=
s.
> However, IEEE 802.1AX-2014 specifies that a port should enter the none
> state immediately once the actor=E2=80=99s port state enters synchronizat=
ion.

Paolo, how do you feel about his patch with 2+ weeks until final?
The first patch is definitely suitable for net. If this one is not
it should not have a Fixes tag. I'd lean towards getting them all
into -rc7 if we can.

BTW please make sure to CC Nik (based on the Fixes tag I think).
Always run get_maintainers on the patches.
--=20
pw-bot: cr

