Return-Path: <linux-kselftest+bounces-34510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B507AD2481
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F747A13D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42521B196;
	Mon,  9 Jun 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkLViPEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79561624CE;
	Mon,  9 Jun 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488295; cv=none; b=O4SHXWk/MMCn+T08zGbgSCyNpjiymia6U16wY2hN+tz6wCIgyHQ8VZq3SV38u2nSjjaigsnDIrrnfg90U6LlUcyEPRx4kGOV5nvvz9xcTB94OhgZCWMsrDEgVB0PGng03anRPpvstqkgzy80RlOgN4zc3jYqWEo2XC2JGEQ/D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488295; c=relaxed/simple;
	bh=dvLQWopZLx4yj+2d43xvqT4CLcTXZhfOrVd200EwOGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvgnSjyrG8KOArWf14TF2zHi6lhYYFBLZ8zLb0Q6fFJ286anxrRkpN6ZpI7EUp2B2lP0wxeRKpEBGEgc6B/wDZ6RgeWN4fidxwF9TX8XiNphPapxTpsF/O3NJDzXT0eKU7tnpC67Ov9J/Cq1CVCtrFYf7ujY99Vcpsk2iLsqB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkLViPEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2318CC4CEEB;
	Mon,  9 Jun 2025 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749488294;
	bh=dvLQWopZLx4yj+2d43xvqT4CLcTXZhfOrVd200EwOGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UkLViPEHbn3F+IUOZEjdRwjyj+Ni9YwaR7c3OItVzyezQmyzLmoMCln9HtkM2jTHy
	 LP78Bx8p+X7NzjLH088lwzJZEXn1nccftTSnO04m6ARfzurh5qwwx7C5ypEhkXXE1B
	 doFZOf/0Gmg0osVdM05bH4Oia2AtBm2FhI6H1xWX4oZ2tEMECqtTYIQalbz7Kx6xCW
	 PLIPhifbAP/Alkx8x315u3hPbgWvkmVAZzH58+N55cmhe/qvJC//f5p3/Wi4zGfjsM
	 WkDRIJCeJ48OtNgpCmGLxSurce6v8+11StjlfFWkAjchILi0UmcIDO5Hf2CA15O1lJ
	 KrJoSCxaktJOQ==
Message-ID: <447f265b-c7e2-49df-bd1a-76292e92cb0a@kernel.org>
Date: Mon, 9 Jun 2025 10:58:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: ir_decoder: Convert header comment to
 proper multi-line block
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
 skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <65743e71-fc2c-4a04-b7f1-b977031a4fb8@linuxfoundation.org>
 <20250606223914.117449-1-abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20250606223914.117449-1-abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/25 16:39, Abdelrahman Fekry wrote:
> So, this is an updated version following
> the right way of writing change logs while
> making sure the signed-off-by mismatch is fixed.

The above doesn't belong in the change log

> 
> The test file for the IR decoder used single-line comments
> at the top to document its purpose and licensing,
> which is inconsistent with the style used throughout the
> Linux kernel.
> 
> In this patch i converted the file header to
> a proper multi-line comment block
> (/*) that aligns with standard kernel practices.
> This improves readability, consistency across selftests,
> and ensures the license and documentation are
> clearly visible in a familiar format.

Refer to the submitting patches document for details on imperative
mood.

> 
> No functional changes have been made.
> 
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
> Changes in v2:
> - Fixed multiple trailing whitespace errors
> - Fixed Signed-off-by mismatch
> - Appropriate change log
>   tools/testing/selftests/ir/ir_loopback.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
> index f4a15cbdd5ea..c94faa975630 100644
> --- a/tools/testing/selftests/ir/ir_loopback.c
> +++ b/tools/testing/selftests/ir/ir_loopback.c
> @@ -1,14 +1,17 @@
>   // SPDX-License-Identifier: GPL-2.0
> -// test ir decoder
> -//
> -// Copyright (C) 2018 Sean Young <sean@mess.org>
> -
> -// When sending LIRC_MODE_SCANCODE, the IR will be encoded. rc-loopback
> -// will send this IR to the receiver side, where we try to read the decoded
> -// IR. Decoding happens in a separate kernel thread, so we will need to
> -// wait until that is scheduled, hence we use poll to check for read
> -// readiness.
> -
> +/* Copyright (C) 2018 Sean Young <sean@mess.org>
> + *
> + * Selftest for IR decoder
> + *
> + *
> + * When sending LIRC_MODE_SCANCODE, the IR will be encoded.
> + * rc-loopback will send this IR to the receiver side,
> + * where we try to read the decoded IR.
> + * Decoding happens in a separate kernel thread,
> + * so we will need to wait until that is scheduled,
> + * hence we use poll to check for read
> + * readiness.
> + */
>   #include <linux/lirc.h>
>   #include <errno.h>
>   #include <stdio.h>


I don't think this patch is necessary. We have files that use // style
comments. How did you find this issue.

thanks,
-- Shuah

