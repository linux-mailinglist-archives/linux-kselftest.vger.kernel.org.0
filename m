Return-Path: <linux-kselftest+bounces-5938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80987263D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4AC28831E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A817BCF;
	Tue,  5 Mar 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqjS3WUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5B18C36;
	Tue,  5 Mar 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662002; cv=none; b=UIFyC5j40f3d1psTnr9a5Sdv/4WeZa8Sh0fD4C1nxa0XeMI06FKMzbZ7OvS1zi7QCuxjNcYAwiWS9iTmBMg5wNyUyQBWVebdBhNerZlLscGRkc2ptQmldw3FEk7YBDFA551IPVmruVEFB0UZ6E++0dADRnr2xT6N4IqF2UzWyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662002; c=relaxed/simple;
	bh=eB5Eb7Q3N9lX4JEVIO23Ppah4P9/QNE627ZDXVi0+XY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaUxx1JSLBzT9H/q3gF5HGtGdf9WH2ihHm6h4Ci+rmbQaIquExxbjgoNIf04On4eu4gstomSDgVzYe5jJuJm0udKzvcEZ5qHLszy9ikXEbzRaVNrC3iFoaEUleOQFRdHsw0lPWjbboC9AAIDqqW1SNb+KyNlUGzCKwJX0omKLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqjS3WUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0465C433C7;
	Tue,  5 Mar 2024 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709662001;
	bh=eB5Eb7Q3N9lX4JEVIO23Ppah4P9/QNE627ZDXVi0+XY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JqjS3WUm7GikRVtckKDdUPG+Rm9/j09YCPbybc7JMp6FM/XRLUgwJMuPveP1Ku24m
	 2gHefV7Ak72RynftzhUJ7qS5Bvg3UlQ5/Lg3+lMMlTn3AYxKvWmAROTP+lhtzriMxm
	 t/94GNKuXknVgRzamQ1tkqggMPBTb9UzLu5NDoOp7xRGA3FLNmtr+l+F+O6XggKLM1
	 jQHkrjLZuRoeGMIXR2GWuZ79+4ia9Z74EEXMMmfurHdc8IOr/UC8QysmO4qfFJglaz
	 oh6iPgesdlHyHJIcWGaOle4AUxDWIygXkFU4lDEMbgSvXEBcHPoHNdyTe6FnuWkaGN
	 BfKK12Wse/AhQ==
Date: Tue, 5 Mar 2024 10:06:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305100639.6b040762@kernel.org>
In-Reply-To: <20240305.phohPh8saa4i@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
	<05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
	<20240304150411.6a9bd50b@kernel.org>
	<202403041512.402C08D@keescook>
	<20240304153902.30cd2edd@kernel.org>
	<202403050141.C8B1317C9@keescook>
	<20240305.phohPh8saa4i@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 17:05:51 +0100 Micka=C3=ABl Sala=C3=BCn wrote:
> > I think we have to -- other CIs are now showing the most of seccomp
> > failing now. (And I can confirm this now -- I had only tested seccomp
> > on earlier versions of the series.) =20
>=20
> Sorry for the trouble, I found and fixed the vfork issues.  I tested
> with seccomp and Landlock.  You can find a dedicated branch here (with
> some Reviewed-by and Acked-by removed because of the changes):
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=3Dks=
elftest-xfail-fix
>=20
> Jakub, please send a v5 series with this updated patch and your
> exit/_exit fixes.

DaveM merged this already, unfortunately. Could send your changes
as incremental fixes on top of net-next?

