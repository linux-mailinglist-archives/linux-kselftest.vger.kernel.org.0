Return-Path: <linux-kselftest+bounces-9989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E670A8C1E85
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86244B21DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15815217A;
	Fri, 10 May 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LoPMsBkp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F119F9C9;
	Fri, 10 May 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324293; cv=none; b=SzmC2VjVkGIzzMc6qvNH1l+x5qIlTEqyb/eFHzxsqNnjcYM7AHMNrTr8r9pSvMsmONnATxJG76SBcfDNH7X+dLPNeLxj+JVUgnCrYzcE6Cx6YC+20wNHnVKB5W0+TOitL/0qlpUp3t6R5y9xYk1o2zrROu2s3FXRGujMJtANgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324293; c=relaxed/simple;
	bh=ze4zdjo0fbz33aF2z7EukPA4jLCJ45hoe9ptXCI2FWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxyRiQt7ZD6H2dfXVd065zwmac1fMRkGIoOR372z8Epszb2NAcojqaf+YVKZKugyEKlqZmi9IsRdMmJ8eSlFuGsx9KZn9IuzndHHiRvaX8TO6k7HQsRObdR1nSOsrhRPqFF2OuH8cBi5yml29wg8pWqGniW3bKlQoRL+8CKn5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LoPMsBkp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715324286;
	bh=ze4zdjo0fbz33aF2z7EukPA4jLCJ45hoe9ptXCI2FWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoPMsBkp+4SADwS6jrdQNBJGi7DCW73il17aUnDwIa1oyXji8Q/4pc/iKFIzJLY/c
	 Q+z//3FFDHszb0g6PtGL5I026GJFKPn+JmHgnAvadcY419eX/foh0ynFGckgalFFOq
	 HLg577n8fZ8bMgT8eQfvMVA4UfdUCoQF6nttbLmM=
Date: Fri, 10 May 2024 08:58:05 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 37/66] selftests/nolibc: Drop define _GNU_SOURCE
Message-ID: <b2ed9fed-0263-405d-9e5a-71c49421619a@t-8ch.de>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-38-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-38-edliaw@google.com>

Hi Edward,

On 2024-05-10 00:06:54+0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.

The nolibc tests do not use lib.mk.

This change breaks "make libc-test", please drop it.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 94bb6e11c16f..a28813f4367f 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1,6 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define _GNU_SOURCE
>  #define _LARGEFILE64_SOURCE
>  
>  /* libc-specific include files
> -- 
> 2.45.0.118.g7fe29c98d7-goog

Thomas

