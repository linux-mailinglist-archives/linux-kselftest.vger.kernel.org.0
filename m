Return-Path: <linux-kselftest+bounces-9894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C428C178F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252551F25691
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23F79F2;
	Thu,  9 May 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIhFWTXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47C29AF;
	Thu,  9 May 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286683; cv=none; b=MxfK+HHZExRviTnS776143pl/fQuXzpFfRB1DTbA1SnNXBNI9mn3aQfIbPI4IYSNB9w4rw9xzaZCjRkKctJQRKpuDsP2/rTijmU2FMkcjfSoU7KxqLUC0JyP+dS9y1uHQebOTsXazlE87ZWmzPE0ZfMM6Emass15cQhWO0J2hgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286683; c=relaxed/simple;
	bh=3hRwl2K12SkRKNM78wLsl/4te3kJ4BT9nZoF6sCbxbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6ORVS9/MHH8gFbRDYwZJhLkNKqr4JFJxkH3AUoj/kOCYYaeKjIfN4DoLs0hiYYB0PB6o8mTYUvLL4WU5l/kc4AFBDplL53pYWIbh7vOyD1Qfrs0/9Jgyk7g0RaRAs3k2tTyroZFVLLfc1v7dFAPKndPczpRGUSojeAyZTH37mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIhFWTXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEF6C116B1;
	Thu,  9 May 2024 20:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715286683;
	bh=3hRwl2K12SkRKNM78wLsl/4te3kJ4BT9nZoF6sCbxbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIhFWTXoUfrZEXYXnNpjyqAaUa4FKNKp1liB8UAZMze9KVv4hdAFmJylc4iA2ekx7
	 0fhwWAgIWjmCNyvHeQ0baHNbtDX7ycaHfa2SXUNVmD1OT3lznGSH7W9ZOMYVq8XzPS
	 XNdetjkAICbPLl6ZcBlFpBrF6uOo19eNlFEH04hmul98ViHyviLWxshHNPkuB4YW8R
	 j/XqzRH4eUz9DNnhN6j1c2zTJ4wOzQvR5+5d/39yVSA5AWK7LBuN0WnPSyQoM+Na7F
	 +byhIpw32XvdJTGUefGzhSRK/x2pK5XgOnr0McvVxwaDjfNk0mDdQZSj4xrD1fIuDV
	 XVepSil5D0/gg==
From: SeongJae Park <sj@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>,
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>,
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
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@android.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
Date: Thu,  9 May 2024 13:31:13 -0700
Message-Id: <20240509203113.63537-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509200022.253089-14-edliaw@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Edward,

On Thu,  9 May 2024 19:58:05 +0000 Edward Liaw <edliaw@google.com> wrote:

> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")

I show Mathieu's comment on this[1].  I have no strong opinion on this, but if
you conclude to remove or change this line, please apply same change to this
patch.

[1] https://lore.kernel.org/638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com

> Signed-off-by: Edward Liaw <edliaw@google.com>

I also added trivial comments that coming from my personal and humble
preferrence below.  Other than the above and the below comments,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
>  .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> index 0cc2eef7d142..7a17a03d555c 100644
> --- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> +++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> @@ -2,9 +2,6 @@
>  /*
>   * Author: SeongJae Park <sj@kernel.org>
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>

I'd prefer having one empty line between the comment and includes.

>  #include <stdbool.h>
>  #include <stdint.h>
> diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
> index b06f52a8ce2d..4aeac55ac93e 100644
> --- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
> +++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
> @@ -2,8 +2,6 @@
>  /*
>   * Author: SeongJae Park <sj@kernel.org>
>   */
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>

Ditto.

And I realize I also forgot adding one empty line before the above #define
line.  That's why I'm saying this is just a trivial comment :)

>  #include <stdbool.h>
>  #include <stdint.h>
> -- 
> 2.45.0.118.g7fe29c98d7-goog


Thanks,
SJ

