Return-Path: <linux-kselftest+bounces-614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7677F91FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AFC1C209D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1DA6123;
	Sun, 26 Nov 2023 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448B6D2;
	Sun, 26 Nov 2023 01:28:40 -0800 (PST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3AQ9SSUZ007756;
	Sun, 26 Nov 2023 10:28:28 +0100
Date: Sun, 26 Nov 2023 10:28:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/nolibc: add support for getrlimit/setrlimit
Message-ID: <20231126092828.GB7407@1wt.eu>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
 <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

> +int test_rlimit(void)
> +{
> +	struct rlimit rlim = {
> +		.rlim_cur = 1 << 20,
> +		.rlim_max = 1 << 20,
> +	};
> +	int ret;
> +
> +	ret = setrlimit(RLIMIT_CORE, &rlim);
> +	if (ret)
> +		return -1;
> +
> +	rlim.rlim_cur = 0;
> +	rlim.rlim_max = 0;
> +
> +	ret = getrlimit(RLIMIT_CORE, &rlim);
> +	if (ret)
> +		return -1;
> +
> +	if (rlim.rlim_cur != 1 << 20)
> +		return -1;
> +	if (rlim.rlim_max != 1 << 20)
> +		return -1;

I think you should used two different values here for cur and max so
that you can also detect stupid API bugs such as a union being used
instead of a struct, or copy-pastes in the implementation etc. For
example using 1<<20 and 1<<21 should do the trick.

Otherwise Ack-by me for the whole series, of course.

Thanks,
Willy

