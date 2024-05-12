Return-Path: <linux-kselftest+bounces-10119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8078C3910
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B05128154C
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD615822A;
	Sun, 12 May 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugQmEqXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CE101CA;
	Sun, 12 May 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715554093; cv=none; b=B/CU40jBZagjumScB6HC9k0xesmb7FYmZInTEf4xg6/gQMdAU4qUrsYDj/f9hhBCGWGUG+BKs+cmPjKP0usmvmuBEjessioLZeM1iF5MHrQyJyF4OwVMhsD8cNObFZCP7W35byS70UPXEf5zxWXAJTI0aivgGhJvWMkzAg5/7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715554093; c=relaxed/simple;
	bh=9fjv1Y0rdNDQySl7fq7segrFXEEv9wxh8sZupY1PCcE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oLB9ChXozgQKBEw8399RfyifIAxrERXSbwugiDIQ4z/juWLsFP3Dunzx097L1vrvH2SKfII/0g4v9AmiJg1qovAuUNX7kQ6dSe0ZPEhQyDMKS6vSiS+yiNl+vnjxxJVN6qBjRf1zmPCxbhCzH5sMdCxO9UlD0gds9N2LODV3TGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugQmEqXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDFCC116B1;
	Sun, 12 May 2024 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715554092;
	bh=9fjv1Y0rdNDQySl7fq7segrFXEEv9wxh8sZupY1PCcE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=ugQmEqXm73wMGXT8ED/pTvPxEJe/tZ2aDWfEpBdzleYcuf3JHjcTfYKavLXn94Wbm
	 aN6uoqbdBtUqGnnOCvX/VvczeVUVPDlhhqZ72dPLa4ACRSno8QBcbw3kx8toFMPbsu
	 l7iJOcr/0cj/UNFUUau2sA+Vsx5mc0LVyIu6I+8tGC1gxcluEtA8t3fROvq7wq2uPp
	 Skmpp3JwTqQpA8v1HvY/t2yQyu5dBOUgPbksGTakEZvNcX0069/HW2EIVfZuJv5Wix
	 7ADTY+ZyzIYfoWYN82nbuyfQL+unxQyZA/k5DN1EOw4mcTHbmtAsaS8fFVGNgWYay/
	 EqxigTyA1H31Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 01:48:09 +0300
Message-Id: <D18164GGOJ2P.UC10KNQCPM6Y@kernel.org>
To: "Mirsad Todorovac" <mtodorovac69@gmail.com>,
 <linux-kselftest@vger.kernel.org>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>, "Shuah Khan"
 <shuah@kernel.org>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Edward Liaw" <edliaw@google.com>
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
In-Reply-To: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>

On Fri May 10, 2024 at 11:37 PM EEST, Mirsad Todorovac wrote:
>  tools/testing/selftests/sgx/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index 9820b3809c69..f5cb426bd797 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -6,6 +6,9 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
> +#ifndef __USE_GNU
> +#define __USE_GNU
> +#endif
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <stdlib.h>

__USE_GNU is an internal define, never use it for anything.

Use #define _GNU_SOURCE instead without ifndef/endif [1].

[1] https://man7.org/linux/man-pages/man3/asprintf.3.html

BR, Jarkko

