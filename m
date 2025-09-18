Return-Path: <linux-kselftest+bounces-41826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFADB844A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBDE1C002D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66124302174;
	Thu, 18 Sep 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxDjo7Dl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7323ABA0;
	Thu, 18 Sep 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193616; cv=none; b=dxGJv0PkD97WUg8CEg4ORA1u2F0k3Kc+/PBOkJRAmDJWDV0K0HRP90Omr7naP08pwVAc1ePk7+yv8gq9cO6FzT00QXdldh1BUj5qqFrHIbg6VRi3GYowKwtI4U+5lPLwG+DXgh/5iqOCtnkbv1TmzFi17vWTdsivkTx0jxiLu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193616; c=relaxed/simple;
	bh=NpAPPFF/yuRMT+fZ+lNvZK5IuyxseW1m/ZM8WE7yyA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGtZf3ALZGICIm60d2GwUafasOVHLWjEmTJUGaC9lxejQN9pssTZhakK4mlJAnjthqwW/dLHiNJmJSQZHLLkXocbmvPj9h16XRKJkQ+Kfcbz/Sdz6bDYlSQQlg3IYbTxKvnWLZ5xdg/VggVjho6W7i9fXC6LSOWK0GvtLOTtHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxDjo7Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C330FC4CEEB;
	Thu, 18 Sep 2025 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193615;
	bh=NpAPPFF/yuRMT+fZ+lNvZK5IuyxseW1m/ZM8WE7yyA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxDjo7Dlh4cat8V+DFX0tGwOab5YO0Mq5EbhkpwO8jTQm6fF0LCFC4v+NZspjwsXp
	 G4FQUB6OOg+LGgkFU65eRPlJ4/xm41JkDMkBcQQMOSHgVLsckbToTS6L1PeOjYnfsw
	 mxqtfoYVA2YqYapAih3FT4fR6g5/zOeVsRWEOEa5BlFA/V4Fp15MMg9UjGrkbllJw4
	 pydcRWePrPjMSXj2uupkY4lZcJpYkeweVSi0LWDo/kh5V/chKnv0xFuSOiIT+V9ZYV
	 MIGfrTt4ZV8+8cic9+L5iPB0FpeFOkCsOgqWa+T9Hyb0MaqJgsM7bicBBOMYxI+SfW
	 rrQN+cHXmZelw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] kselftest/arm64/gcs/basic-gcs: Respect parent directory CFLAGS
Date: Thu, 18 Sep 2025 12:06:36 +0100
Message-Id: <175812312276.1711921.12702494152718461208.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916-arm64-gcs-nolibc-v1-1-ee54aa65fc26@weissschuh.net>
References: <20250916-arm64-gcs-nolibc-v1-1-ee54aa65fc26@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Sep 2025 18:51:35 +0200, Thomas Weißschuh wrote:
> basic-gcs has it's own make rule to handle the special compiler
> invocation to build against nolibc. This rule does not respect the
> $(CFLAGS) passed by the Makefile from the parent directory.
> However these $(CFLAGS) set up the include path to include the UAPI
> headers from the current kernel.
> Due to this the asm/hwcap.h header is used from the toolchain instead of
> the UAPI and the definition of HWCAP_GCS is not found.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64/gcs/basic-gcs: Respect parent directory CFLAGS
      https://git.kernel.org/arm64/c/5b7bdc4402b1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

