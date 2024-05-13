Return-Path: <linux-kselftest+bounces-10128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F188C3AE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 07:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C41F21040
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE6146583;
	Mon, 13 May 2024 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hw3En7ij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE850289
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715577110; cv=none; b=CD5dTN2mrteV+ldr1zP54ounI3ZUZzb3P/Ar1A8zRykWie1wg5++jAXzh7BYooHehlJbmDOhYqZm4SnFJdhOIsgk3duolydeRIDgGqFtmCE9HbZz1lwbMbpmGgyIYFUlP/AdBvEfBFYEYUHMlPmJuOoA5S5Dp4ukmJJn3TSWBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715577110; c=relaxed/simple;
	bh=KFDDDGcGm/oWMDzWP22M7FfCz2XpGYOkwlgc6byenZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDyrX8DhF4uiZvF4RwlUsZsBa5naYunsYZjhfi02YoUcbz5q6WmniMqP4FrCZOzVxMSWNhn2vJKrcEsZV9v4IHtoku7qa3XW/Tnh+hMva+BuRyiQTLiqyA2Fm/hA8NnR86oeMJ4mWbvt11cJ65Z+bi33lE0yPPM9baoLBkb424M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hw3En7ij; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vd6zD72sYzBRV;
	Mon, 13 May 2024 07:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715577096;
	bh=NzaTA4RcapZkISmaHLv46iIYK7VaukIA9ZguF6MFZZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hw3En7ijFCwNJoThQiowXkrUxCT44rzwcTmIeGAxmMKpeUBmBD1BLh+85VHxhgwc7
	 JBbg/rqFfZCDo0dPtfgcvOHScY8qdox00AoYekCDtfXJcIcsUmdc+pInQOE27YE5Ni
	 +P34v4BDOwCSyvCB1aryA/Skhpq3+1VxUbfjd74w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vd6z94yx1zHTv;
	Mon, 13 May 2024 07:11:33 +0200 (CEST)
Date: Mon, 13 May 2024 07:11:31 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 27/68] selftests/landlock: Drop define _GNU_SOURCE
Message-ID: <20240513.wo9coof8Dae4@digikod.net>
References: <20240509200022.253089-1-edliaw@google.com>
 <20240509200022.253089-28-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509200022.253089-28-edliaw@google.com>
X-Infomaniak-Routing: alpha

On Thu, May 09, 2024 at 07:58:19PM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>

Please only remove lines with _GNU_SOURCE, not the empty lines.  I think
it would be better to not change such style choice for other subsystems
too.
With this change for the Landlock selftests:
Acked-by: Mickaël Salaün <mic@digikod.net>

> ---
>  tools/testing/selftests/landlock/base_test.c   | 2 --
>  tools/testing/selftests/landlock/fs_test.c     | 2 --
>  tools/testing/selftests/landlock/net_test.c    | 2 --
>  tools/testing/selftests/landlock/ptrace_test.c | 2 --
>  4 files changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 3c1e9f35b531..c86e6f87b398 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>   * Copyright © 2019-2020 ANSSI
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 6b5a9ff88c3d..eec0d9a44d50 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -6,8 +6,6 @@
>   * Copyright © 2020 ANSSI
>   * Copyright © 2020-2022 Microsoft Corporation
>   */
> -
> -#define _GNU_SOURCE
>  #include <asm/termbits.h>
>  #include <fcntl.h>
>  #include <libgen.h>
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index f21cfbbc3638..eed040adcbac 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>   * Copyright © 2023 Microsoft Corporation
>   */
> -
> -#define _GNU_SOURCE
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..c831e6d03b02 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>   * Copyright © 2019-2020 ANSSI
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> -- 
> 2.45.0.118.g7fe29c98d7-goog
> 
> 

