Return-Path: <linux-kselftest+bounces-9305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476CE8BA50B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AA0284CAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E82101CA;
	Fri,  3 May 2024 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPjALbxq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B95DF5B;
	Fri,  3 May 2024 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700811; cv=none; b=hRq6vBYf9cFOof9/+Twza/+vVQJejzZSlzxN+ln2C0CQcDspjuN9iF9AQv3oHYIylt8M9fE9/fyywwLNXapcWfgdr66hWlLFqirC2GXIxcmZo844P95+epZZAFL9bDB31e9TyETuZ60KZziG6d0369jMSSNXo8vyC95O1UCdOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700811; c=relaxed/simple;
	bh=JKgTE6YUHTKq659Fh+4WxOwvtYqFaO/UHPdHf0PyxU8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RJ4/L/ZJJSRT/o+dlvt/gOFYSILX/mwZESqCh5/MzQeJPNZgvPkPR5RRIYomfkwQBmtfnvVogUrmlWqyAKlFOINpp5ULJaz3xKJf0UzXy3MSm/geQAinPyMhsqix4iyq3chN5hufVf39WImVSpQsbVu/ML3KR+YqnD9V6mxcMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPjALbxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D76EC113CC;
	Fri,  3 May 2024 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700810;
	bh=JKgTE6YUHTKq659Fh+4WxOwvtYqFaO/UHPdHf0PyxU8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PPjALbxqtye4I1DIDKjHVl3qcro5MlE9tek/ju94lTHQ9wY/pjbVv71TylRbsvFvW
	 CreAHaLMHr1FL/n18IY54+vHGoxxHhpj2LSSdkdGE2XA5WU4uy97Bq/ZcEdTxqTaJu
	 Nr5j403GWzpYiPXxaJV0a73HDuaPrDeeRiTQAyNx0x50uJCVjldPII9JL+L7BRBCF7
	 VOEwB9bAfcnBooec5W605A00+FEMqc97nE1f9fjytDNUkxb0cxbgGBDl+GZY4E4r6t
	 Qqc4adGqWtNz7GkLUA41T2o/j6mF1PCbadNmSnqlRreB2PpKAqYryTJoC3Nnbgq+N7
	 BCl62C/NQ2Row==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 04:46:43 +0300
Message-Id: <D0ZMPEICUP93.YHFFOSJBS27X@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-team@android.com>, <linux-sound@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <kvm@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, "kernel test robot" <oliver.sang@intel.com>
Subject: Re: [PATCH v1 01/10] selftests/sgx: Compile with -D_GNU_SOURCE
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Edward Liaw" <edliaw@google.com>, <shuah@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires"
 <bentiss@kernel.org>, "Sean Christopherson" <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Bongsu Jeon" <bongsu.jeon@samsung.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Muhammad Usama Anjum"
 <usama.anjum@collabora.com>
X-Mailer: aerc 0.17.0
References: <20240430235057.1351993-1-edliaw@google.com>
 <20240430235057.1351993-2-edliaw@google.com>
In-Reply-To: <20240430235057.1351993-2-edliaw@google.com>

On Wed May 1, 2024 at 2:50 AM EEST, Edward Liaw wrote:
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
>
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@=
intel.com
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/sgx/Makefile    | 2 +-
>  tools/testing/selftests/sgx/sigstruct.c | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 867f88ce2570..272da790d9ae 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -12,7 +12,7 @@ OBJCOPY :=3D $(CROSS_COMPILE)objcopy
>  endif
>
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
> -HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC
> +HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -D_GNU_SOURCE
>  HOST_LDFLAGS :=3D -z noexecstack -lcrypto
>  ENCL_CFLAGS +=3D -Wall -Werror -static-pie -nostdlib -ffreestanding -fPI=
E \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/self=
tests/sgx/sigstruct.c
> index d73b29becf5b..a0c2de7c5302 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*  Copyright(c) 2016-20 Intel Corporation. */
> -
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <getopt.h>
>  #include <stdbool.h>
> --
> 2.45.0.rc0.197.gbae5840b3b-goog

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

