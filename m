Return-Path: <linux-kselftest+bounces-13594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097FB92EBE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9871C2256A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76716C852;
	Thu, 11 Jul 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om0Ee3a9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3828FF;
	Thu, 11 Jul 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712654; cv=none; b=XkU54qegFCeJtVbCJO14YiwR+0t2M5xYRoOOfw/b5J6q40EaZ8WtRBFS1b8VufIcDhreNz+qG+N/isM2tSyHfsRnu73lWNdTr2MBPu2WQTLZXFKCN29ygciMWJBbSV89MRGzn8M56erJYG6HWe35S5rTv/zb2/7lB0J4Uvwqtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712654; c=relaxed/simple;
	bh=mvnQ2GGfI3Sic7vqHBGI17+ZN2XRbPD+DKi9dY/pObo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF9n7ZjftWT/V6E6kcJKGuH5jg5cTZW5bgtb3V3X/oN/fiJylmR/LX7K6mO0q+/16TOZOhIVcRT6SLH/Pjeiu1xFP1g3pHeNvMa5uNYxVkMccx8DkDbrKEKGcNCUL9ENiGmrjkyHOi4aEILpO9GGK0svCSWrS4U1+345IpyUNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om0Ee3a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71739C116B1;
	Thu, 11 Jul 2024 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712654;
	bh=mvnQ2GGfI3Sic7vqHBGI17+ZN2XRbPD+DKi9dY/pObo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=om0Ee3a9Q+/0Sw6QMHqGP5E/9caOU4mgN3+Ani/XWc+xKhFp/4GVyk1xnFCvBy3+y
	 e7yAD+7CaVJEGcqbQSP4vrDfsaNoClIQckJF+zJqhLM1/qrurMmbXGdFO2ccV9Lo1h
	 JbJI/wIaAdOlCHAWYruPiMoY0ZBJHnVSm9Znk6yoVoRbsX2ORH33DBZcUC2G2jxUr2
	 sDwGo9m8sCMMl5IOZQJwG+Ey9qnHzr489qdGkFZoskkcvWuYO2iu5BncSCu9fgwZ/8
	 eVweNM5+J0bJbYdnDqQHpv2OdYWOuh6wzObyfpZjTLz2av2eSgNqSEUrxz7EGYuxIa
	 PEl+ZkDGo6moA==
Date: Thu, 11 Jul 2024 08:44:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v2] selftests: openvswitch: retry instead of
 sleep
Message-ID: <20240711084412.4cb31e63@kernel.org>
In-Reply-To: <CAG=2xmMsgmZosNvuVC-uGjkKGQfSq0kjwpMSgS46jpd5Zbpp7A@mail.gmail.com>
References: <20240710090500.1655212-1-amorenoz@redhat.com>
	<CAG=2xmMsgmZosNvuVC-uGjkKGQfSq0kjwpMSgS46jpd5Zbpp7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jul 2024 09:41:08 +0000 Adri=C3=A1n Moreno wrote:
> This patch is supposed to fix openvswitch selftests on "-dbg" machines.
> However, as Simon points out, all recent rounds are failing [1]. I don't
> see this patch being included in the batches and I was wondering why.
>=20
> Also I see a (presumably unrelated) build error netdev/build_32bit.
> Is there anything I can do?

Hopefully fixed now, we'll see if it gets into the next run.

