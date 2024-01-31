Return-Path: <linux-kselftest+bounces-3855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2B8442C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E20295896
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8884A48;
	Wed, 31 Jan 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y26/QDIo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8B84A25;
	Wed, 31 Jan 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713992; cv=none; b=EEroFml9eBwPy6574ApGwcZJMm3PLGZffUlPygmGHYI/ZfcFtvMM3Idbyhb/rTTxQBu9SmL58McPI1fZ+bfyPQeAa6FKmRBBWNmA11XL6Ak/FbHZC84AyhcROnBzcxCAngGuoeDjrRuCjDuohdpaQ4mA+yAABunqNHYt/1ZiyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713992; c=relaxed/simple;
	bh=4QNpDnJj6sY1RMbSyQ3tc9VjMeu5QPeXohxGGaoShxk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hXWK8XNFRVBTr4XohnrwNUaFJiCIcRxzggrNrYIDv4sRObUUqun/xF3F0POL+FMhJmgOhVCpDAXxARJ709tEm0OyX0RSuDqhRSkRnPoB2/WhOZbLCaXsirZoOdc/JDvwo5Dk+Y4eXDTze9I/7JOp79tHem/kYYFSjvwjYCcStnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y26/QDIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0712FC433C7;
	Wed, 31 Jan 2024 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706713992;
	bh=4QNpDnJj6sY1RMbSyQ3tc9VjMeu5QPeXohxGGaoShxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y26/QDIoJcqtEzpzPqBXCkzhWxN/hBzdZy6bCzYaRHcQvc/1kp5ziUdp/wepWnExm
	 v41H88RiGcy9pZYtLsrNupjEU3hhHi+Y2H/JUF/eHT5krs41hs9eM7dA66UR221CNt
	 xoMU0R7fxRmAg14NpPqD5wMRGuCVncsVQZnr6kyegyXYjjPnwlg6svRvipzION8uH5
	 N6uAU83ApWPfuiF6Oc4Ul3cBTZ7oQRDobVnYkhu/ML11KJYjNMyUAN9qN9iaXWIaZb
	 NS3JzDFxvVDG2of3WveGn2pYph/IS7dZKJgaMbIaFEjJryxfkCIQ99/Hq1fMywEze5
	 wW4LlUBpj9MOg==
Date: Thu, 1 Feb 2024 00:13:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ali Zahraee <ahzahraee@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: ftrace: fix typo in test description
Message-Id: <20240201001308.c206e16376a173d4129ba8ab@kernel.org>
In-Reply-To: <20240131133306.7723-1-ahzahraee@gmail.com>
References: <20240131133306.7723-1-ahzahraee@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 14:33:06 +0100
Ali Zahraee <ahzahraee@gmail.com> wrote:

> The typo in the description shows up in test logs and output.
> This patch submission is part of my application to the Linux Foundation
> mentorship program: Linux kernel Bug Fixing Spring Unpaid 2024.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
> ---
>  tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> index add7d5bf585d..c45094d1e1d2 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> -# description: Test file and directory owership changes for eventfs
> +# description: Test file and directory ownership changes for eventfs
>  
>  original_group=`stat -c "%g" .`
>  original_owner=`stat -c "%u" .`
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

