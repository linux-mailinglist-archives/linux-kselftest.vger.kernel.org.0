Return-Path: <linux-kselftest+bounces-19595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA5399B2A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E127D283380
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE614D28C;
	Sat, 12 Oct 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY/9Umxj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14522064;
	Sat, 12 Oct 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726364; cv=none; b=EwP/DHvIJQwO97WoMWOA4XCGqXPqRDwlu88lKam44XGfN6Avi4NeJfls+N6/LRJqoi6fy88Y9bETU2kZRzBVkK7FhtFKvuI34PPBFd4AYWEhbORhKHLfKTwUGifBWTdfR0Y62pODgOuo5yGTgAdPve4PzNK7xrAbuS1BpQo/JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726364; c=relaxed/simple;
	bh=wVtBCqdyT2BF2o1eUMC6giOE8B3yLdyniylbLpZsFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr7yMwFPHNiM1DNvauXxCAWzzbQtM91fWG5GvxOp7+f3Rymz0/rQVSqOhTMdLBje6UmaL62hFFFgcIsrB9PDhukzisXtvrtHKHw1Ed/ZyNDlxKMkJX4DV1G0syRiEYM4OgfGisqO5Q4HpTAtkBLNSS2mpDyV85n7XxnUVqqbbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY/9Umxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E31C4CEC6;
	Sat, 12 Oct 2024 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728726364;
	bh=wVtBCqdyT2BF2o1eUMC6giOE8B3yLdyniylbLpZsFvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EY/9UmxjPGiGIEd/3pe+ch2+jZPwGdfXntjd9NTI9S9X31i6AesHUJrras6UtnRD+
	 N6AbnceWD9ZvLvaFWtDZcyiqJA2hzRJu2iUFILW+F5Ok1/zIMmfzSpUXxUEa0y6Cg9
	 daEZzuFFE3I+xbSzjQCN4rWC6lfcrxCkVe+LMlxtURm+LsGwUlzcfJ2CePO6+NZ8w5
	 7tbqyjedgIhfkaIEY0BTWB3ZPaOWB0rxZAB6PxdOL+92mgozU1ZHXcbn4UyixQ0917
	 gXSvTYR6S+xIHjyGvsabHccAF20K89puOhzY4XbPy/vnX8hz8j+/gxl+XFwfrR6OfD
	 lg6rSQ27mXKAw==
Date: Sat, 12 Oct 2024 10:45:57 +0100
From: Simon Horman <horms@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next 2/3] connector/cn_proc: Kunit tests for threads
 hash table
Message-ID: <20241012094557.GB77519@kernel.org>
References: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
 <20241012004532.2071738-3-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012004532.2071738-3-anjali.k.kulkarni@oracle.com>

On Fri, Oct 11, 2024 at 05:45:31PM -0700, Anjali Kulkarni wrote:
> Kunit tests to test hash table add, delete, duplicate add and delete.
> Add following configs and compile kernel code:
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_NET=y
> CONFIG_KUNIT=m/y
> CONFIG_CN_HASH_KUNIT_TEST=m/y
> 
> To run kunit tests:
> sudo modprobe cn_hash_test
> 
> Output of kunit tests and hash table contents are displayed in
> /var/log/messages (at KERN_DEBUG level).
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

...

> index 000000000000..2687492864ed
> --- /dev/null
> +++ b/lib/cn_hash_test.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the connector threads hashtable code.
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + */
> +#include <kunit/test.h>
> +
> +#include "cn_hash_test.h"
> +
> +#define ARR_SIZE	4
> +#define HASH_TABLE_LEN	1024
> +
> +struct add_data {
> +	pid_t pid;
> +	int exit_val;
> +	int key;
> +};
> +
> +struct add_data adata[ARR_SIZE];
> +int key_display[HASH_TABLE_LEN];

Hi Anjali,

adata and key_display seem to only be used within this file.
Probably they should be static.

...

