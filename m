Return-Path: <linux-kselftest+bounces-10580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2068CC0C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E01F23A88
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A3130A51;
	Wed, 22 May 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nelYOGVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E07E567;
	Wed, 22 May 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379347; cv=none; b=R7WVlurDdKi28QbABouA1RcZ3w3f59zrrrdhWTdeQItqi8SJHI0+SMMGfbxwLFLfErwA2hMRgTNX593phLZcaLO85JvRBXz4jnySWk81Psg9C9b5OLJ3SsyrOBtBxhgK1cSuRyRaAcscjQtE1h4oWRg4gPcPH2uUBlN0LfuKTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379347; c=relaxed/simple;
	bh=EMJVT5ZakDgrWxq+Pzu18YJ1rO0NK5CfLgZ0nMojMYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cODyXcsgilbrdorx/IdwE875wq9/a0OhTUxSR4u0jK2hWo1jMt4A+UbclZaMDrfDRYT5E8Mpe53u1PxXi8QeEquZicmRIFPJqtEgyAlNgzSSszN6gNaMBfF1X75slUIKhKeA5vJ1iwC3pRerbyreKZiavMZf66J8gRN8EU3Uj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nelYOGVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85904C2BD11;
	Wed, 22 May 2024 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716379346;
	bh=EMJVT5ZakDgrWxq+Pzu18YJ1rO0NK5CfLgZ0nMojMYU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nelYOGVGN6SeA/MqZPRrHYH3CNr81B6sLCq+x2diVvbQ/bjR2LAKWPe2UjlLFI76V
	 4BxzcsJbNXwbJH1mUzNt8/c6ww8iujAX9repqNTCFMl3o1cD32xzBOfID9S5hd2SQY
	 hIpgm23AwqT4s+QO23a9cDRtMBEexa2UpkCc77kEhq6n/uwRJGmm/EeUOQHBLOT8FC
	 hHGbvNvdVWZoDhGwLf2cn+lSmMOrwqxQ49xatAopsHB9N7gDGIOeL60WEp/oAlLnoS
	 x5WGOuEzlh9k18P8tsZYMm8H9toKZ/NnCe/KmhseHzTPiIkNGHqXtgpaf+2ibeR04N
	 c+17AzCNNwi2A==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 15:02:19 +0300
Message-Id: <D1G5P3B6BWGG.3EOYXHHI5MYPZ@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-team@android.com>, <linux-security-module@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <bpf@vger.kernel.org>, "kernel test robot" <oliver.sang@intel.com>,
 <linux-sgx@vger.kernel.org>
Subject: Re: [PATCH v5 57/68] selftests/sgx: Compile with -D_GNU_SOURCE
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Edward Liaw" <edliaw@google.com>, <shuah@kernel.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, "Christian Brauner"
 <brauner@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Muhammad Usama Anjum" <usama.anjum@collabora.com>
X-Mailer: aerc 0.17.0
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-58-edliaw@google.com>
In-Reply-To: <20240522005913.3540131-58-edliaw@google.com>

On Wed May 22, 2024 at 3:57 AM EEST, Edward Liaw wrote:
> Add -D_GNU_SOURCE to HOST_CFLAGS and remove #define _GNU_SOURCE.
>
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@=
intel.com
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/sgx/Makefile    | 2 +-
>  tools/testing/selftests/sgx/sigstruct.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 867f88ce2570..272da790d9ae 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -12,7 +12,7 @@ OBJCOPY :=3D $(CROSS_COMPILE)objcopy
>  endif
> =20
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
> -HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC
> +HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -D_GNU_SOURCE
>  HOST_LDFLAGS :=3D -z noexecstack -lcrypto
>  ENCL_CFLAGS +=3D -Wall -Werror -static-pie -nostdlib -ffreestanding -fPI=
E \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/self=
tests/sgx/sigstruct.c
> index d73b29becf5b..200034a0fee5 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*  Copyright(c) 2016-20 Intel Corporation. */
> =20
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <getopt.h>
>  #include <stdbool.h>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

