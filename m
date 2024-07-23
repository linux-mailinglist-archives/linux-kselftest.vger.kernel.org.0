Return-Path: <linux-kselftest+bounces-14077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28325939E4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D31F2300E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E314C5BD;
	Tue, 23 Jul 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iV9BTXIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641638F9C
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728536; cv=none; b=UgF7FZb4DzFaDeI1fE+TS5LvKROtYM5PLDFmr//UoeyocNJuqCJoYpIQ+16yeVyA3dsEi5sb4OtIfz71DoluYzBbyfW/m+BJiUpNbZS1UB8f7bHFXSG7GUTB/Qr3htRTD+AfMxsBnwp3zIYhHDTi3fh4/QZEKeQ4M6wJX1HMZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728536; c=relaxed/simple;
	bh=C+2n1Y86DJkiGkGcPT2Sbz/de2572NO++LFNC9n73ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U36Gcnv/SMLzfBZ5XyDsxD3abrxKolK8GMhP34pyBwYqyuJTOtimz1vMkYRk3VSgMvzzR0DVJ/NVn3EV8oXlbwtB4xSEWc7dIvFVc2X6mo9ouIKhgJCMOmCbn46k+Ooh7tCUU9+5uiZ9gH35dxBs8Ib2C15elFln39hOdoyO3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iV9BTXIW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tony.ambardar@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721728532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISAHzVtAs0egczMSE6oCt0+LTA8eJ6eefA+LRiu1SZY=;
	b=iV9BTXIWu56TnofgD9JURKIvi3rPbgQltVXZns+UkxqlD7yLjYL2RtNLCEDEPJq3+WVPcL
	tjObPfaRbeuT4rQbqQ+dRvxYKhm4JRAawjjPo+UH5v5TRnXUqZODN1qkllAOkjfOOR32xl
	G71GFNA9T8cCPBekKGV/olUxrK8MoNg=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: mykolal@fb.com
Message-ID: <18d399af-d79e-40af-bb80-2e6443bef220@linux.dev>
Date: Tue, 23 Jul 2024 10:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 18/19] selftests/bpf: Fix errors compiling
 crypto_sanity.c with musl libc
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
 <911293968f424ad7b462d8805aeb3baee8f4985b.1721713597.git.tony.ambardar@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <911293968f424ad7b462d8805aeb3baee8f4985b.1721713597.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2024 06:54, Tony Ambardar wrote:
> Remove a redundant include of '<linux/in6.h>', whose needed definitions are
> already provided by 'test_progs.h'. This avoids errors seen compiling for
> mips64el/musl-libc:
> 
>    In file included from .../arpa/inet.h:9,
>                     from ./test_progs.h:17,
>                     from prog_tests/crypto_sanity.c:10:
>    .../netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
>       23 | struct in6_addr {
>          |        ^~~~~~~~
>    In file included from crypto_sanity.c:7:
>    .../linux/in6.h:33:8: note: originally defined here
>       33 | struct in6_addr {
>          |        ^~~~~~~~
>    .../netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
>       34 | struct sockaddr_in6 {
>          |        ^~~~~~~~~~~~
>    .../linux/in6.h:50:8: note: originally defined here
>       50 | struct sockaddr_in6 {
>          |        ^~~~~~~~~~~~
>    .../netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
>       42 | struct ipv6_mreq {
>          |        ^~~~~~~~~
>    .../linux/in6.h:60:8: note: originally defined here
>       60 | struct ipv6_mreq {
>          |        ^~~~~~~~~
> 
> Fixes: 91541ab192fc ("selftests: bpf: crypto skcipher algo selftests")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/crypto_sanity.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> index b1a3a49a822a..42bd07f7218d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> @@ -4,7 +4,6 @@
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <net/if.h>
> -#include <linux/in6.h>
>   #include <linux/if_alg.h>
>   
>   #include "test_progs.h"

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


