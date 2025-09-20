Return-Path: <linux-kselftest+bounces-41988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209CB8C439
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CC517D546
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EB287516;
	Sat, 20 Sep 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Om1UD5I6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60D221FC6;
	Sat, 20 Sep 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359327; cv=none; b=f9AxZJRlBMW+Kx35BPUSHHgKZ0kdm/qvtE3FGb58SDj6xq73wjUlBEZtkEQ7kpSR82aH2JUXEgxUxf473fP8YWoroOq3ZWkhL1xnQlv1NDJgIU7RWfHIT9Hk9lYMhdOhNF7p9p+HRdb+5WDI1nyuKHF6q1uPDMzZRnYtYizbmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359327; c=relaxed/simple;
	bh=7AgmdpzSbvpoPfhFtsyGjsBMS0m2QapvG7NWSOjL1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDg8Ih9TpFcz85o51WXFvFONaojpF+l2Yp4/gmn6rdkUoEumvdC4ZhGUuHUmtDlpYlVXTHVixfp/+FaD0X0d3evfmhqVj22serZp5Sx3EP+ViGuyGdpRRl2CV7q38JBh1v1Y4vF6PP3M+HwJi2PAQx4HqlEki0kBngh46f3ptos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Om1UD5I6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758359322;
	bh=7AgmdpzSbvpoPfhFtsyGjsBMS0m2QapvG7NWSOjL1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Om1UD5I6sqy+ggkvuslzI8wAAQY6oqwalnu5jQUtP5sKaW6Uc3rsuO2X6XejW/a0y
	 HzxD5VMzM1IA9TCrACVY78KDwXWRUeq9DikOOYvlcFWQWPVQfdufi4QvhsKvKZGtaJ
	 MFJQUqC8UslATs9k9e5W/VstrU8DA3Hv5iG5taoo=
Date: Sat, 20 Sep 2025 11:08:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 06/11] tools/nolibc: add option to disable runtime
Message-ID: <a6f669b5-6a4e-4735-8c9d-9debdd65cbc9@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-7-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-7-benjamin@sipsolutions.net>

On 2025-09-19 17:34:15+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> In principle, it is possible to use nolibc for only some object files in
> a program. In that case, the startup code in _start and _start_c is not
> going to be used. Add the NOLIBC_NO_RUNTIME compile time option to
> disable it entirely and also remove anything that depends on it.
> 
> Doing this avoids warnings from modpost for UML as the _start_c code
> references the main function from the .init.text section while it is not
> inside .init itself.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> 
> ---
> v2:
> - Renamed from NOLIBC_NO_STARTCODE to NOLIBC_NO_RUNTIME
> - Put the #ifdef around relevant comments
> ---
>  tools/include/nolibc/arch-arm.h       | 2 ++
>  tools/include/nolibc/arch-arm64.h     | 2 ++
>  tools/include/nolibc/arch-loongarch.h | 2 ++
>  tools/include/nolibc/arch-m68k.h      | 2 ++
>  tools/include/nolibc/arch-mips.h      | 2 ++
>  tools/include/nolibc/arch-powerpc.h   | 2 ++
>  tools/include/nolibc/arch-riscv.h     | 2 ++
>  tools/include/nolibc/arch-s390.h      | 2 ++
>  tools/include/nolibc/arch-sh.h        | 2 ++
>  tools/include/nolibc/arch-sparc.h     | 2 ++
>  tools/include/nolibc/arch-x86.h       | 4 ++++
>  tools/include/nolibc/crt.h            | 3 +++
>  tools/include/nolibc/stackprotector.h | 2 ++
>  tools/include/nolibc/stdlib.h         | 2 ++
>  tools/include/nolibc/sys.h            | 3 ++-
>  tools/include/nolibc/sys/auxv.h       | 3 +++
>  16 files changed, 36 insertions(+), 1 deletion(-)

(...)

