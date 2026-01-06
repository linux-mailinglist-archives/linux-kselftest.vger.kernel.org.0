Return-Path: <linux-kselftest+bounces-48283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1ACF7F4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACC733001629
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA53168F7;
	Tue,  6 Jan 2026 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="QOOfeEGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A62E8B61;
	Tue,  6 Jan 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697543; cv=none; b=B9LPL1VGXrLs4K4XStXOr5QMj5kdL6/jWNFlSiFBi1ZGyLjtEnvDI0dftBEFVfCQFHbKi9I99rXe3Oqko/KgieYGt94J8ChUKavsM/6j4aoKgHA+RiUREJ28wHaRBV3SF+Kh98/K8a5iv2qZliCaV2lkqfWHDDROc0+x7wZKxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697543; c=relaxed/simple;
	bh=v/QdUj7h4OU6WeVTgoX/UuvROT9koe/n1KfAiUvt0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLI8AFrsXKHQDqm0LG02XXYH6ZBX0hIDbXQmrmYkn8+boJOMs7e60z+d3QwvbS+Lgi/WfOyCpcv6BwDsA9GQDUxEdDbgNfqZTreqrwCxZmcdc+tHPj6ZlzktebObnOAnnfjH7I4oW2H6GIEYd06o8foCGnRU7yP9RH/+RhzxGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=QOOfeEGH; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1767697532; bh=Ct0o6ftVNIBD+geX5dLPlYbXp9yhh+ppYXl6tdZuDjo=;
	h=From:Message-ID:From;
	b=QOOfeEGH9mQ+4nOG6+q9C6zhCeQzip92GpNpKJjWfNozGEIrkCNT1NIO+uDgEchVc
	 gZkWC6KYvCcBQDXwJv7TTSRJe6FMDprBNF2UtDHk7UoH4c5AR+Y992XbeiOKKMQoJB
	 vbDbDCNwO55Ff/AejpHixei7ISF7LiNVWXFQBxiY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id C0514C0857;
	Tue, 06 Jan 2026 12:05:31 +0100 (CET)
Date: Tue, 6 Jan 2026 12:05:31 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/nolibc: always build sparc32 tests with
 -mcpu=v8
Message-ID: <aVzse_i9tuFOiUO7@1wt.eu>
References: <20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c2@weissschuh.net>

On Tue, Jan 06, 2026 at 11:39:55AM +0100, Thomas Weiﬂschuh wrote:
> Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
> 32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
> SPARC builds. -mcpu=v9 generates instructions which are not recognized
> by qemu-sparc and qemu-system-sparc.
> 
> Explicitly enforce -mcpu=v8 to generate compatible code.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Use -mcpu=v8
> - Link to v1: https://patch.msgid.link/20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net
> ---
>  tools/testing/selftests/nolibc/Makefile.nolibc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
> index b17ba2f8fb46..f5704193038f 100644
> --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> @@ -226,7 +226,7 @@ CFLAGS_mipsn32be = -EB -mabi=n32 -march=mips64r6
>  CFLAGS_mips64le = -EL -mabi=64 -march=mips64r6
>  CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
>  CFLAGS_loongarch = $(if $(LLVM),-fuse-ld=lld)
> -CFLAGS_sparc32 = $(call cc-option,-m32)
> +CFLAGS_sparc32 = $(call cc-option,-m32) -mcpu=v8
>  CFLAGS_sh4 = -ml -m4
>  ifeq ($(origin XARCH),command line)
>  CFLAGS_XARCH = $(CFLAGS_$(XARCH))

Thank you Thomas!

Acked-by: Willy Tarreau <w@1wt.eu>

willy

