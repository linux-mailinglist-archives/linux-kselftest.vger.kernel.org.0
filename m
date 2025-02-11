Return-Path: <linux-kselftest+bounces-26405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20BA313C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B973D1888396
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C941E3DEC;
	Tue, 11 Feb 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZFiYDnC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7D1E3DDB;
	Tue, 11 Feb 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297409; cv=none; b=nkjPe2njpNICDRwe2AS8v8132UBHiCL2PY54TejOhb2qco3Rb/rh41WVi0jWpF3fgGhX3kscMw6zKT/EtviAo6bJe3jK6E3PI0GI0EEJ7tEr4xKVH1KaCpDoejc7cHFmDoWWexZssYoroSfoniSML8+iw6C/sMNtxCdpVYw2fcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297409; c=relaxed/simple;
	bh=WNGJKuUDrkH4gbStW9QsiLGBbcSx5cWWguYdVr2sa2o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RdaNxq9k+Ps0k8nevskgyaKA93GTc6TRw6gbZIo8pdij2Fo72HcRM3cPmbBUhZoSQUVt8jSvH7Hrmf5SzgCPu7wW9XMPj+cEWp3APMWm4ZnUwlFQW+NKX+3heBs54k/R8+sAI2U3TARFDXTpnEAxVz6MKIjRU6gsVaZN3xMwmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZFiYDnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86597C4CEDD;
	Tue, 11 Feb 2025 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297409;
	bh=WNGJKuUDrkH4gbStW9QsiLGBbcSx5cWWguYdVr2sa2o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kZFiYDnCz+Q1YmWXWDf2ixDY/MaYnKDWWMAExvviHoztp5iZEyXPqufAH2AaemRSZ
	 ypNqApnklqWOZelMKmbx5lOtBEX1G8w2OxMQEUflkQBJJMftNA0L369TXQgYwjaEmS
	 gOISLMcSqenI2RvdPr+CSV9iTN53LgRM+hDLsSBFm+VXuhZ/PKH8EpHua/fZd5zVlM
	 oTQQ5pR/2K12oakpZOA77ZtI6ZlTdjeaLJzszRL976P5vN0MaT0+K7H0zXwsyjltBJ
	 PbdASNxnzMvoeebP6SJ340aUT++uZf7C37sN7SDfd4D1bDlQG6hr927regHIp4x/R+
	 NBE+HSVutHKtg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Feb 2025 20:10:04 +0200
Message-Id: <D7PTH0ZUAH5L.VVEECLR4VEWH@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v3] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ahmed Salem" <x0rw3ll@gmail.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 <shuah@kernel.org>, <skhan@linuxfoundation.org>
X-Mailer: aerc 0.20.1
References: <nyskb7mbqk2dvlwhez4sua7ryz5gyi73yker6y3qhd4chyyeaw@x6nhqgtxcyvl>
In-Reply-To: <nyskb7mbqk2dvlwhez4sua7ryz5gyi73yker6y3qhd4chyyeaw@x6nhqgtxcyvl>

On Tue Feb 11, 2025 at 5:00 AM EET, Ahmed Salem wrote:
> Use POSIX-conformant operator symbol '=3D'.
>
> Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
> ---
>
> Apologies for my previous mistakes.
>
> Changes in v3:
>  - Reword mistaken commit message
>
> Changes in v2:
>  - Remove snippets pinpointing the issue=20
>    from commit message

OK I read what I wrote and I guess it could have been misinterpreted.

What I meant was to take the relevant part of the transcript that shows
the issue (and possibly also how it works when fixed).

Sorry about that.

[1] https://lore.kernel.org/linux-integrity/D7OY3ZVGJOV5.R3SL9SBFT2DF@kerne=
l.org/

BR, Jarkko

