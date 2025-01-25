Return-Path: <linux-kselftest+bounces-25177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EBA1C50B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C15164DAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F67E8635C;
	Sat, 25 Jan 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuj/CLad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF878F5E;
	Sat, 25 Jan 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737832823; cv=none; b=InDrw/cI3/Z9EvwGq05tJ/7yhmy7qTVA/lbkKtifXdidT6oA/mIYb3KdqR25L0+lqPo6gHMneg2/LQBRXako0ObqraR85zeJD/NRsXumyiTfHTkmH9zgI/AEskaGcJV4ff2UQiEbA9s35Qo4rv25GSZ4//wNd+h5kESxSIxHZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737832823; c=relaxed/simple;
	bh=V81glnhAI57xIxSg0Yi1lIoP1QuA4FULWWmvQ2CHS+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RuZ9uU1bYMCpYUJEM+SAf3Axfe/uHr9kh0w9N2AmPmK4yhFtbMxNrUG16cEyl8gMZcKwP6q05a4sqI4aEFyA4RU2L+qfFIfUcVsMNGo6UcmYIDLZupoP6iFTfVStehszAmXY5mj9PL1jAW4rLPfNpy77DopnmbxAkLODrJIdYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuj/CLad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C22C4CED6;
	Sat, 25 Jan 2025 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737832822;
	bh=V81glnhAI57xIxSg0Yi1lIoP1QuA4FULWWmvQ2CHS+8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Xuj/CLadqqMJOGJC4hZrgqywRUDrGKauZ0Kcfze77EPwv7SXnhQ2UiZ8IIjHEG1PS
	 EcajRqwcNayKscFlr+dw6ne3+seETl1OfbxAUyfMsFqN9oko5MLGHEsmBbUIDBrUvT
	 aRSo75vvjnyDlAHOR+R/pmRH7lCoabqoRCRbtIrRIn24gcBBTjuimR5dfHC/CQdECx
	 oDoareiya+GqT/JgodTfMKlu+P8DVtkRrG6iwslx0dD7d6bblVyHIC3OE4typYABjz
	 AQ2vvfgJrLRDGvFNPAQQ9L5/eTm09YV7ZZwmKLTSiAJ9M/P6hoHYW1DlwFFJWCWBiq
	 wx1kmD6lGzygQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:20:17 +0200
Message-Id: <D7BEBJ4R3QG0.20NP9ZJ3NWVP6@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Khaled Elnaggar" <khaledelnaggarlinux@gmail.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <shuah@kernel.org>
X-Mailer: aerc 0.18.2
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
 <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
 <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>
 <D7AGBYQ5T2P2.3L3HM84HUCS1V@kernel.org>
 <518c6b84-63f0-4192-89a1-af0e8000318c@gmail.com>
In-Reply-To: <518c6b84-63f0-4192-89a1-af0e8000318c@gmail.com>

On Sat Jan 25, 2025 at 10:58 AM EET, Khaled Elnaggar wrote:
> On 1/24/25 6:42 PM, Jarkko Sakkinen wrote:
>
> > Shortest ever commit message tutorial:
> >=20
> > 1. Problem
> > 2. Motivation
> > 3. Solution with explanation how it will map on addressing the problem.
> >=20
> > Do this for every possible commit and you will get it right 99%
> > of time. I can admit that even today I don't always get this myself
> > fully right but I try my best ;-) That does not mean you could not
> > do better than me.
> >=20
> > And generally, depending on subsystem tho, people usually feel more
> > confortable with "imperative form" rather than "science paper" form.
> >=20
> > BR, Jarkko
>
> Ah great, thank you for the review the tutorial.
> Hopefully, I will do better in v3 :)

Ya, sorry if I sounded rude. My "why" is "actually why", not "WTF why"
;-)

> Many thanks,
> Khaled

BR, Jarkko

