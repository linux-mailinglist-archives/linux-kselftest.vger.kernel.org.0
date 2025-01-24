Return-Path: <linux-kselftest+bounces-25124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF427A1BAC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C12616E12D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECA919A288;
	Fri, 24 Jan 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0bN9Yw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18B192B94;
	Fri, 24 Jan 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736939; cv=none; b=cS3P/PRyOZK95MzmWeARQ8xDhCuO4JSN2qCgAG6Bc2MQh6PLjxcxJh98TnjmGhWVX86oVSHeO2F6sMF914a4hmO8IpKbifjoszFzVWiSNGutkc0Sfid6Yci1rm5VOKTelA5Owsqx7ibWJTyZn6oxcOHPSpATvSm8E0QAZrP4hO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736939; c=relaxed/simple;
	bh=cOtjrZRSj3FOMzlAs5wEx8a7FdbCzrGW6aSd4xe5lBM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=emVawJBw4dx8kzVNlrr5OxisoC4EZdl8MFr8yAEnxc9PGByLBRmgE+Zs4wEVt8tSSTdyD2FUtV/tbEvadD5ldYyGR2vHq5LpVUEkAsKy9IjZvkMaHlG60Vg+mu4DaaKPAdr28W1OYiQPqypulhr1OxxNIqo17ubfJWaVeB112BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0bN9Yw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B47BC4CED2;
	Fri, 24 Jan 2025 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736938;
	bh=cOtjrZRSj3FOMzlAs5wEx8a7FdbCzrGW6aSd4xe5lBM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=H0bN9Yw2pEYuSo3KZNHiHm2ienr2MfGH+ctCMKJkVwBjJ6BwhY7rgNE8zknY2VSFY
	 oq/EC+kOjj4SG0/Xs5D9MItDw+TDVjR/1fZXwelM8ix4VmpI3EUKALXiZ0atp3yxqC
	 YMBV+1EO83A0AoDZ0CY0pxu5Z6T2TcvmykA5h9aBgUuQsURh8KNYNk93O2dNNDVaQm
	 zFly1nu2Fx86qyQvBwTVCMAl6Rbbr/9Ij15T+28VCt072tawD+jOIRraBxcwPnj00A
	 /3yDcSAmdcumSbaRBeKJCWi3W61GcHG9QmCZ+K1FlDioGrAhSKn07iaWKspSlzhKL/
	 VKEr9yJAFkkwg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:42:13 +0200
Message-Id: <D7AGBYQ5T2P2.3L3HM84HUCS1V@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Khaled Elnaggar"
 <khaledelnaggarlinux@gmail.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 <shuah@kernel.org>
Cc: <linux-kernel-mentees@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
 <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
 <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>
In-Reply-To: <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>

On Fri Jan 24, 2025 at 6:37 PM EET, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 4:35 PM EET, Khaled Elnaggar wrote:
> > On 1/23/25 11:47 AM, Jarkko Sakkinen wrote:=20
> > > Why?
> >
> > Sorry I should have included v1 in the thread but I am still
> > new to the LKML process.
>
> No worries, relax, it was just  a one wonder question :-)

Shortest ever commit message tutorial:

1. Problem
2. Motivation
3. Solution with explanation how it will map on addressing the problem.

Do this for every possible commit and you will get it right 99%
of time. I can admit that even today I don't always get this myself
fully right but I try my best ;-) That does not mean you could not
do better than me.

And generally, depending on subsystem tho, people usually feel more
confortable with "imperative form" rather than "science paper" form.

Example:

1. Imperative: "Check the pointer for nullness."
2. Sciency: "We must check the the pointer for nullness."

BR, Jarkko

