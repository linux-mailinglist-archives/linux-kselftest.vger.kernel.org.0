Return-Path: <linux-kselftest+bounces-41905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA8B879C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 03:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052DC1BC0442
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C411F3FEC;
	Fri, 19 Sep 2025 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgkzJrXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA729408;
	Fri, 19 Sep 2025 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245525; cv=none; b=IYFmAmZgn5/CT85RMs2kH3Y1ZK9cX+ZGk+5KRJC91A2PJd+0IAdkIwp4+Y3GNg8Z6DaR6rKtQlJS02oTrMucCPEVPYGxVg+JKXTsycK7BxE2YA/4t8PEGq9Ik0h5arTNhLQCGe+PkwME3/YsEFiyAPRHzI2YrML0s7gee4ajSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245525; c=relaxed/simple;
	bh=r9r5P1pDsAO1RtvUMBMRM6SqndCJSqetTZtA19T5plM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YCRB5Fhv+Qmd60U27YZyQzqK+7w0AViLo7qoXJnQN46k9yEjGEjgPCg7l9qwYnRjJNlkRNlgR4ZeqDFzCmZsBzeHvlDbLVMz1+B6kgaiPWEeHtwUp91iCUbCQ1jjq2qWIh3tU3KIN9DdlVYMG9Sb7aCKxY4ksahllm65Gfq68D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgkzJrXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209CC4CEE7;
	Fri, 19 Sep 2025 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758245525;
	bh=r9r5P1pDsAO1RtvUMBMRM6SqndCJSqetTZtA19T5plM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UgkzJrXt0vEvXlXfpPu9BwAmHvoO+JHBXnHA/kL+C872Pwo51sJeXR2ZZ0mz51Rg3
	 E66IVqLjVbbPY8YtsaQ3LOlp7BDgAod8bdw1fZc84CwEPaNVr967FjWnff8xhN5Q+j
	 cwz92/DjI23I5MCDjhbQRR1D/M90vXBFdRAC73QlQ5YO4PFtmi4YQP0FjmDZtybn9l
	 FCuKG74DmkCLd0thooYGSCHuOvIKymaJx0o+tY1Y6l9O/VJe0JC6EWc++Y8Xp95iuq
	 +KQSrgzf3AFjJVOQyRHLoEeKYAWB9M+v7oFovsn9yPzSuAUMbfJp6Upv0G3esx2dHg
	 5brq0zuQCl8dA==
Date: Thu, 18 Sep 2025 19:32:00 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
cc: shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests: riscv: Add README for RISC-V KSelfTest
In-Reply-To: <20250815180724.14459-1-reddybalavignesh9979@gmail.com>
Message-ID: <0a05a409-b161-88ee-a731-4a773b21dcb9@kernel.org>
References: <20250815180724.14459-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, Bala-Vignesh-Reddy wrote:

> Add a README file for RISC-V specific kernel selftests under
> tools/testing/selftests/riscv/. This mirrors the existing README
> for arm64, providing clear guidance on how the tests are architecture
> specific and skipped on non-riscv systems. It also includes
> standard make commands for building, running and installing the
> tests, along with a reference to general kselftest documentation.
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Thanks, queuing this one through the RISC-V tree for v6.18.


- Paul


