Return-Path: <linux-kselftest+bounces-26195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94063A2F55F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15B01887E10
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F5255E30;
	Mon, 10 Feb 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRb7VSAc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99678255E2C;
	Mon, 10 Feb 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208934; cv=none; b=ZWOUp289AX+M/uqq64PGNpgOlCUwGCFMPpley5qZddy1aE53uUtmLAVOKqGhEdhncrJUNfkBIwnNcEfWDFbm5drYVNrVKPML/Cn54jw4klpZFks1q/w2oV54q9o7yNavWP1X2eF6paCvD9ryrGpgp8w3GB4KtNxVi7o8UEON8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208934; c=relaxed/simple;
	bh=lvR3N9o/7sGph9dQQjX/ztRNTBXY/foJLpqclKRllZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ge9uRY/cGnIxOVKRP4luJ41QrdYejM09ufS5oj39ff18v/Aezq7DAeIL/gqDqecLu6uIU7RDQR0OsogybF38rzN4LPnSWKMCX+3kPvgHPvrZp2bOij8DzAvXwPT6Xc+iHXNYqKoobhVedtwzHzJGAcD0anobK7fTp+8rGSaSEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRb7VSAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A679AC4CEE6;
	Mon, 10 Feb 2025 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208934;
	bh=lvR3N9o/7sGph9dQQjX/ztRNTBXY/foJLpqclKRllZo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=uRb7VSAcSs42JJVMn3WEF3+W6c2aXG+W2CYEJaJoFq6LFWRfBpVHpRWnDyYupelF7
	 TBgeIqd+bhjeKhGn+9iWjl/5PS+H5W+A3XG9fLwL9OHQmJLBaxwqEPsA+QIzK/y9Qh
	 fKsqTBxrRadpKz0zHyLkEkSD0QyMXRR5bLhWFK/F6H36uCgYaFAbodtortS+9Fkym4
	 zQHAz7OYOhkCq7bx3aWITaYuCJmN2hT/uV9u4wdKt2eHjxi3SM6bEYJPofP2QM8kAs
	 lEFWOH3YP02w9ai0UEZ+Ykqh0eFVi7DNkuwZf/cpwrfol24J57wBaVSKXqL5fUJSYF
	 AxLdQip1xs0Gg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 19:35:28 +0200
Message-Id: <D7OY3ZVGJOV5.R3SL9SBFT2DF@kernel.org>
To: "Ahmed Salem" <x0rw3ll@gmail.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 <shuah@kernel.org>, <skhan@linuxfoundation.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.20.1
References: <zdfnlpdb24tk6aikzucyomylf4lqdyhdvlingwyku46fy75eyg@giq5dqojdxj5>
In-Reply-To: <zdfnlpdb24tk6aikzucyomylf4lqdyhdvlingwyku46fy75eyg@giq5dqojdxj5>

On Mon Feb 10, 2025 at 7:03 PM EET, Ahmed Salem wrote:
> test_smoke.sh:9: expression uses non POSIX-conformant operator
> symbol '=3D=3D', resulting in skipping the remaining tests.
>
> This patch ensures the use of POSIX-conformant operator symbol '=3D'.
>
> w/o this patch for test_smoke.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> $ sudo make -j8 TARGETS=3Dtpm2 kselftest
> make[3]: Nothing to be done for 'all'.
> TAP version 13
> 1..3
>  # timeout set to 600
>  # selftests: tpm2: test_smoke.sh
>  # ./test_smoke.sh: 9: [: 2: unexpected operator
> ok 1 selftests: tpm2: test_smoke.sh # SKIP

The fix is fine but cut out snippets of transcripts pinpointing
the issue.

BR, Jarkko

