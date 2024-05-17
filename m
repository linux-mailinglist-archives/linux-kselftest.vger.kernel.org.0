Return-Path: <linux-kselftest+bounces-10344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2698C8864
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECE91C23B30
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874D664DD;
	Fri, 17 May 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QNIiwpei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5E60263;
	Fri, 17 May 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957295; cv=none; b=pwRLH5XlGIZ3CcZZUG5OlTc0LgInhGYbHiXcerPUCcLjMw5RZ5ldKRt3jVDItJjmAO7ZKRpUJeCdKamMSRb3oeZdaCFYlqt8A+b6mAgji8DTYoDe8u4Rd6wkd977P2++vXC9Zp0CPictZOgMno34/bA+8PRijJX8sQm9Q4YkH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957295; c=relaxed/simple;
	bh=sR1b4hovpLB3+hUo2qFNbqPLLe083HhBBkJ1S7HtDB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0ZcNUDcvjHXG88aKHhDaWteZDBPkFMqt/FXVMWy6AH2Z3oDG1BJq6aWHsHVT3zWvQfEu9yTQOScuVu0svuh2vCZPUP8QND9swCsSwWE6CCMFHoXJz2e4IC3tMjSLhJB8u5qJNgaI7zpr8yPgbaZ/W6a5xj6wPYz6OTDv3p+2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QNIiwpei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C99DC2BD10;
	Fri, 17 May 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QNIiwpei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1715957290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cBkPJS4a5BxMhrLDaw8NzLtBZZCj9gi/zQctsonxVI=;
	b=QNIiwpeic5qa/l6WvUy8VnPkDhwOw2O5t+Zqc3jVrwko+I6pojUkkvxst2Jk4OyqKLfd3J
	wK3xBSDhEAAJSz2SFq6ZkSt6Q5XXRnLGDdX/Nfp8hnhqgf1R4vLiNcFi+jHwY6DQZ+aShR
	9DLIWT0iMqYDchSnSp1S9+BJggdRqMU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ba86458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 14:48:09 +0000 (UTC)
Date: Fri, 17 May 2024 16:48:02 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Edward Liaw <edliaw@google.com>
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
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, wireguard@lists.zx2c4.com
Subject: Re: [PATCH v4 65/66] selftests/wireguard: Drop define _GNU_SOURCE
Message-ID: <ZkduIlhF2XswiAJr@zx2c4.com>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-66-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-66-edliaw@google.com>

On Fri, May 10, 2024 at 12:07:22AM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/wireguard/qemu/init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
> index 3e49924dd77e..08113f3c6189 100644
> --- a/tools/testing/selftests/wireguard/qemu/init.c
> +++ b/tools/testing/selftests/wireguard/qemu/init.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   */
> -
> -#define _GNU_SOURCE
>  #include <unistd.h>
>  #include <errno.h>
>  #include <string.h>
> -- 

But this file doesn't use lib.mk.

