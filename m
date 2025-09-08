Return-Path: <linux-kselftest+bounces-40959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06968B4947C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E441BC13E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F603112B6;
	Mon,  8 Sep 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbCh87f7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087931077A;
	Mon,  8 Sep 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346956; cv=none; b=ogMbV41qlCuExW4BbIe/5vNvZo395RqbkTnhbwbY75MtbSxVpLRioO02kOgD8E2avCINkhN1MOAhSaryUiIC0GfH0IzBH7IhUQofeOEWP8LwZzT7NAJ/55yoc/o8GdPpjcvudbcbVET9V/vNjFkvr4yABPYQ2WKHR6JdsZRoLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346956; c=relaxed/simple;
	bh=NZDJnhY8lU/HjSsPA1w4OkvvxgfbZxmjWKy8iU7vN7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3qowg8J2u0+C9oWjz10j2uiGtKOqSO/uyT/YwzS4rAp0w1+QSXnnnSNnJ2vJr4E3lo4I3F/+n9yclQFO/BjpcsJAlOD+AWbCB9rThdrtPyECDX7258CjW35oPyYfCu/9Ltn0azciP3yGpIl+2kBPzMY7rjYTraMIk/wOKryHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbCh87f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0420AC4CEF7;
	Mon,  8 Sep 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346956;
	bh=NZDJnhY8lU/HjSsPA1w4OkvvxgfbZxmjWKy8iU7vN7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbCh87f7vZk9K2GzwhXiVS7enXUJ0h9BzgE324mzIUxBmMaeuAJj8ITrdBVjX9C22
	 YrQ59pIc5R+OIpU9/I+G2HM7PvBK2Pe7T+u3ljZ6m8lB3r3reG+4vAuh/cBwjXe35R
	 5K+vLMZWeCaklHR59LtDwS9qd/CXLK5LvIhv5zziT7yS4HuJVpI8+osxZWo+j5kNSc
	 HkIOjfglBmUNxiTvg7OrAAVaNoTHN+n5X2Xjc8sQQtyUHNpc5OBrYZbnQsxgYIHGRq
	 rspukF8hzq4CY4pbbGUMIykMK4oHLNbrnQ11XEFPKkX6DiVJZ6YvUlfg8pxleNr7bY
	 FNbI3UZhVKK4Q==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	shuah@kernel.org,
	corbet@lwn.net,
	vivekyadav1207731111@gmail.com
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] kselftest/arm64: Cleanups and readability fixes
Date: Mon,  8 Sep 2025 16:55:33 +0100
Message-Id: <175734370604.150805.8413945497648461480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
References: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 23 Aug 2025 23:13:59 -0700, vivekyadav1207731111@gmail.com wrote:
> This small series makes cosmetic style cleanups in the arm64 kselftests
> to improve readability and suppress checkpatch warnings. These changes
> are purely cosmetic and do not affect functionality.
> 
> Changes in this series:
>   * Suppress unnecessary checkpatch warning in a comment
>   * Add parentheses around sizeof for clarity
>   * Remove redundant blank line
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/3] kselftest/arm64: Remove extra blank line
      https://git.kernel.org/arm64/c/3198780eaf37
[2/3] kselftest/arm64: Supress warning and improve readability
      https://git.kernel.org/arm64/c/a940568ccde4
[3/3] kselftest/arm64: Add parentheses around sizeof for clarity
      https://git.kernel.org/arm64/c/62e8a9fbaad1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

