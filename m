Return-Path: <linux-kselftest+bounces-10120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E78C3913
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88677B209A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D0457CBB;
	Sun, 12 May 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AERLxGxi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79182942D;
	Sun, 12 May 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715554693; cv=none; b=LfAeRf/j/FEJt39axNhjPoBCkD1AKD3Fqk95Y824LECbdNz1PGo+80iU2bXwtPbqtg/wdqqjlftkarQe8q4n6a/QtT/D5+2F4P8xSdkjxi+B/+FdO8O0c3VBKrtQfkO2f63Ap5JzFG2dUa9yr6wTp8v2yiJYRpSxNEAumXuDmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715554693; c=relaxed/simple;
	bh=X74pd2a5KoxIL2JxKFtqxThMc2mOvXp6HeQig6+ADIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TzHvWiKBME5CLQEfpEjUjsaKf0WkD1ovymUJe5fZ546zbQZ/BJ+72HJlxlBl8UD69K0Tk77woJvPK66zTXpBu7lAdvWFTarZ9G/eYxNfIjWATep6AJMyka9gAMNLENPcTnm1YIlw7CgKeVZ1jFvOEmk7nfC4jGsI1YLH31SlaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AERLxGxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20CEC116B1;
	Sun, 12 May 2024 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715554693;
	bh=X74pd2a5KoxIL2JxKFtqxThMc2mOvXp6HeQig6+ADIo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=AERLxGxiJVXs5EsIlwwMl4BCHBSwAVV2e5wZ5cYQCYg+sFHKPCiVIxYES5WbUkchE
	 tPmzGnPokkTc3VRgsTK43+YJ0Qk2NAgC7S+RKVKyMf5/HUoiBBXrFTasxgQ5V0Crgg
	 aPhGiQEn2D8Zq5EVUh23+cSNITQ5Wis5VlQpNQQxJ/yflGOGg5zJ4xDPs+Vv7Dpk95
	 Ti6Gj3fQJYGoMpLoWcPgvlFNZdKP+a/vibCnSfi5Cg8lfQWoHDJEJ1H0PXlNl/WGyZ
	 YiQMA9DdpSWhzaN0ZYAlVhFB8tfcfX4pk77q7b8wy+lUUYos5GvfJLAXXPSZwZv6qW
	 0oH4kEXZf3OoQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 01:58:09 +0300
Message-Id: <D181DSFR01WT.J0TYDFE5AV5D@kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>, "Mirsad Todorovac"
 <mtodorovac69@gmail.com>, <linux-kselftest@vger.kernel.org>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>, "Shuah Khan"
 <shuah@kernel.org>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Edward Liaw" <edliaw@google.com>
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
 <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
In-Reply-To: <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>

On Fri May 10, 2024 at 11:52 PM EEST, John Hubbard wrote:
> On 5/10/24 1:37 PM, Mirsad Todorovac wrote:
> ...
> > The fix defines __USE_GNU before including <stdio.h> in case it isn't a=
lready
> > defined. After this intervention the module compiles OK.
>
> Instead of interventions, I believe the standard way to do this is to sim=
ply
> define _GNU_SOURCE before including the header file(s). For example, the
> following also fixes the compilation failure on Ubuntu:
>
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index 9820b3809c69..bb6e795d06e2 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*  Copyright(c) 2016-20 Intel Corporation. */
>  =20
> +#define _GNU_SOURCE
>   #include <cpuid.h>
>   #include <elf.h>
>   #include <errno.h>
>
>
> However, that's not required, because Edward Liaw is already on v4 of
> a patchset[1] that fixes up the _GNU_SOURCE problem for all selftests.
>
> [1] https://lore.kernel.org/all/20240510000842.410729-2-edliaw@google.com=
/
>
> thanks,


Yeah this and also

Link: https://man7.org/linux/man-pages/man3/asprintf.3.html

And those crazy dumps could go away. The code does not use per man page
aprintf correctly and that is exactly the rationale. It is enough then
to just tell that not having _GNU_SOURCE results a compilation error.

BR, Jarkko

