Return-Path: <linux-kselftest+bounces-10556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6709A8CB869
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F221C20881
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443679D1;
	Wed, 22 May 2024 01:19:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7565224CF;
	Wed, 22 May 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340750; cv=none; b=KVzrFcZZWsmM+YeH/p0xBs6R2oa/EhRp/K3C4pgXiFcOLpmzvgVUnGnaUCnq88U93lp3xbH6eOHOrgSm6g0lKuV2DzsZBbgN0LAaLpkGMSEc4djaeaLFIF0LTxHz6xsv1Unzq4bTQ/wEcOe16UdZOUDpdl/COql3srwWuyzyzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340750; c=relaxed/simple;
	bh=weadA3+mmgcWotP/FdF0QwQETssaX/ZYIE9jI5omFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2HDFXgoeXSeKoaWKoO9PYY3W4Xrkmw2vhYGC3s9fQEVXgpQWeFgbPJ6zZWsAkYoQ8JbyZbN57ul3QEUtI78x1EODSP+Imz0Urw6N66eUYUwOfCYgEVW7MrYK/7m6/EM5nxDc1sZfthiTiZ7Cknd/MF6duzd3v0y6TGg4bxBxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3D4EC72C8F5;
	Wed, 22 May 2024 04:10:31 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 2249B36D0168;
	Wed, 22 May 2024 04:10:31 +0300 (MSK)
Date: Wed, 22 May 2024 04:10:31 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Edward Liaw <edliaw@google.com>, Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
Message-ID: <20240522011031.nps5dejrgk5b442y@altlinux.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-3-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20240522005913.3540131-3-edliaw@google.com>

On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> Commit daef47b89efd0b7 ("selftests: Compile kselftest headers with
> -D_GNU_SOURCE") adds a static_assert() which means that things which
> would be warnings about undeclared functions get escalated into build
> failures.  While we do actually want _GNU_SOURCE to be defined for users
> of kselftest_harness we haven't actually done that yet and this is
> causing widespread build breaks which were previously warnings about
> uses of asprintf() without prototypes, including causing other test
> programs in the same directory to fail to build.
> 
> Since the build failures that are introduced cause additional issues due
> to make stopping builds early replace the static_assert() with a
> missing without making the error more severe than it already was.  This
> will be moot once the issue is fixed properly but reduces the disruption
> while that happens.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index b634969cbb6f..8e53686b71cb 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -51,7 +51,7 @@
>  #define __KSELFTEST_HARNESS_H
>  
>  #ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> +#warning kselftest harness requires _GNU_SOURCE to be defined

Maybe this should be `#error` if it really requires?

Thanks,

>  #endif
>  #include <asm/types.h>
>  #include <ctype.h>
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

