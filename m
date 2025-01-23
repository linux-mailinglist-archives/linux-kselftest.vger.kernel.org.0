Return-Path: <linux-kselftest+bounces-24988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58742A1A112
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42338188E4A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7220B80B;
	Thu, 23 Jan 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7pYezD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F81E529;
	Thu, 23 Jan 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625630; cv=none; b=WEPxGHIByi1+E0ClakCa+j8XWuGDslLawQiVmqnsdG/qr8mg+AUmQzwbNKOw9UX93jll7rFuwA8PW2PwvJJcgCNrzvY6wRuNoVXI3Tp+i41EqvQIXFcx8TQqAj//XrWRmfL8fxN0R9w/M7S3KnIKl5cTSvnX2e9sapJQt+J+OAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625630; c=relaxed/simple;
	bh=cef/yhjFoHiBejTFI5iuwZBDLn0M5tFaCwgwLcm7FUs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z30/hvu2sl/XUgdd776seCZu8is5p1N35Fmr5sdnXhxYvo4agGmmARCKB5IsbTMzyiXLISZ7p+OHsNQixvlizFsnbmHqZOTUUow9vnTnsQ/8UJqiGWvDjqsfshwE3OSHiNlfSPdbCdSdqp3BJhxNJ1lxGmdf5wpzH+UT1HkSoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7pYezD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1149FC4CED3;
	Thu, 23 Jan 2025 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737625629;
	bh=cef/yhjFoHiBejTFI5iuwZBDLn0M5tFaCwgwLcm7FUs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=p7pYezD/409W0i6FECytDiLQ39xtyUI3duCoQWc9c28r236zIDdU15JsFQvmN7lks
	 biSz2YGJ9NjWMWllqAypu/DX1UzRlgeIO3KjnF2NoDaRrfoFz1ZFOZ+aKTVh4I/GpJ
	 ejbvo0VIPsEbcL9eBdlcOLjoN9SoG5FN3imh1055np0dXEI7WNOg36u0eeLonuVGaJ
	 Xe803DLnPFBlJ+AWHHDTgNbCABmbyJlvMJ/lPYk2xAsVi7cBm+Wud0jj+61xbQSJ7u
	 JKMHQyJ3LW0t0bDeyYRXYKfSet1Jjfhh4eF6xDBmEHw/E20mWRKH9mkZa8icQIKa3O
	 xv12OU9mZz5VQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 11:47:03 +0200
Message-Id: <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
Cc: <linux-kernel-mentees@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Khaled Elnaggar" <khaledelnaggarlinux@gmail.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <shuah@kernel.org>
X-Mailer: aerc 0.18.2
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>

On Wed Jan 22, 2025 at 8:50 AM EET, Khaled Elnaggar wrote:
> Create a dedicated .gitignore for the tpm2 tests.
> Move tpm2 related entries from parent directory's .gitignore.
>
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> ---

Why?

BR, Jarkko

