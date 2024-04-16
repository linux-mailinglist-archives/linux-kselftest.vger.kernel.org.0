Return-Path: <linux-kselftest+bounces-8177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C58A6FBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EAE1C214AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5D130AC7;
	Tue, 16 Apr 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HefGEfta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F2130A4B;
	Tue, 16 Apr 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281210; cv=none; b=AyUuxKXt8oOHy6o7L/WgQwpBVOytJK9Fad0ihOGu5Fx2Xrvb9Rab0sBJp94ahbooeARP/+mUCbKTQ6xx9A6e98yIHMqLZQASeQtYgu6M1bWc6riKPfFG6XcYVmAJGwuTRZv+Kx2jcD4T+tjS3npeYyoJYPZfGfAaVF+xYXS2fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281210; c=relaxed/simple;
	bh=FNHcD4Sgv7zzl0ohaid6qhEVjUCQjGVryAxf4STZYOk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mpebKCLeWvlXEpIqEaereA/6aE64rq2JzG9DCPeZJa3nkp857+6HSFjZQYEWwAbHm0ze89Szt/9HsbiJA3Bxu47hwcn1GNJ8POxsG5O08/+EQLqftZyPtbcuZsoXhP+nk9AlUlLHpM7Fal0S1uIz9igaVmhnNUOzlkBDM8y91fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HefGEfta; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713281206;
	bh=FNHcD4Sgv7zzl0ohaid6qhEVjUCQjGVryAxf4STZYOk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HefGEftahFgejDtXc8DcfD2s20vgfqbcpqof6CwHu727DcM/DC9SfycAdes0bq8td
	 dOGpLR7g0/h3N2J+Q+7XRmB4z6/tpbhnVqf1h/0NlzgmsfwIsbvw8SRXByijNOgaUB
	 Pg74NYKiXzXd18H1Gaa9/o+AvsXeUsXTkhlSFMmdEtv/7pbaP44U6ISfSaE9OXXcXk
	 ejyArPgJMY6GmxWOyGNCuOkGjGtKnvJ4ojvK0JCCPbvs/ti+5Z35fP6oRJy5HHR4+/
	 C8kjTlD/6j/lzeq0/YA/ZfpmejzswWwQFAJFkLRut9l6tqVylDet5M0pD0KAzwqvPz
	 eTRSNJcvwEs+w==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 000D937804B2;
	Tue, 16 Apr 2024 15:26:40 +0000 (UTC)
Message-ID: <76103169-4c8c-4c70-9d42-058557115b52@collabora.com>
Date: Tue, 16 Apr 2024 20:27:12 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: exec: make binaries position independent
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Yang Yingliang <yangyingliang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240416152341.3186853-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240416152341.3186853-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 8:23 PM, Muhammad Usama Anjum wrote:
> The -static overrides the -pie and binaries aren't position independent
> anymore. Use -static-pie instead which would produce a static and
> position independent binary. This has been caught by clang's warnings:
> 
>   clang: warning: argument unused during compilation: '-pie'
>   [-Wunused-command-line-argument]
> 
> Tested with both gcc and clang after this change.
> 
> Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/exec/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index fb4472ddffd81..01940d9165d67 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS = -Wall
> +CFLAGS = -Wall #-Wunused-command-line-argument
Debugging artifact here. I'll resend by removing it as v2

>  CFLAGS += -Wno-nonnull
>  CFLAGS += -D_GNU_SOURCE
>  
> @@ -29,8 +29,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
>  	cp $< $@
>  	chmod -x $@
>  $(OUTPUT)/load_address_4096: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -static-pie $< -o $@
>  $(OUTPUT)/load_address_2097152: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -static-pie $< -o $@
>  $(OUTPUT)/load_address_16777216: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -static-pie $< -o $@

-- 
BR,
Muhammad Usama Anjum

