Return-Path: <linux-kselftest+bounces-14084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC493A3FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E74A2832A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B597155A2F;
	Tue, 23 Jul 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+z8cxfY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847B1586F2;
	Tue, 23 Jul 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749632; cv=none; b=E3lFu5Y1T7T8kKu4Xl1KgaSqEawD5qoWf9fdykSqLRO3woVdtYLlRUsB966QEMtjY6adVHPoa8VGdPS256hzkzEiB7gZVN+V/a2Z7w+kySvt9fbvE/QYdqhgNork1BbH4qbf6/ZjXyf0olKf33w+N75OJGlfckWmEvYBH8N/ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749632; c=relaxed/simple;
	bh=cc/Cwqg1Lefx3edwkMBrlhBCPFfGd2B9MSL/+igqzsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFT+BTYvOKWB2wLkFyLD03evucEkK+tuJP1jv2a/VX2WCBU95xR/GPo1JSEfZ1PzB9NzBor+VqZADXIBY3BrCO+NQRo6smZHIGkw2k/uCYM16QZg0nOfzHdyY8erJsFglc9q3IdvIiP38wHaORFvi7qwKk5uyccHFh+NE9DbWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+z8cxfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A89C4AF0F;
	Tue, 23 Jul 2024 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749631;
	bh=cc/Cwqg1Lefx3edwkMBrlhBCPFfGd2B9MSL/+igqzsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+z8cxfYjbqHDJuwF3Ru86IFYYrZeHTX+DKUWSxWarR8OPdaBFxOy/0G+vNEiUWJY
	 r3XGznDR8ZJdDC6b+0HAsmQ7iUWMxSnqWHlFSa2KdOW1NWFQgirTcL9aVn0iGpOI6R
	 a38K7x8uTVU6lxCoaKjwfODGHumkLMd7L0MATfFrWoaBqkwEXX3MJjpbsf+yjyiguV
	 drRIcpCdA3AWJwXRIl6T75vMsxBf3+oLWV8+9h128G3wx6Hzz/HfB0ZsZWTNJqgSNq
	 608PFOYXg4wLiFfDNO44itvb+u0v9htXqvwUPtjOn4nRiCUxJZ1CRhusyp48btnYfi
	 MjhQFDA3xy9/g==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Remington Brasga <rbrasga@uci.edu>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] kselftest: missing arg in ptrace.c
Date: Tue, 23 Jul 2024 16:46:56 +0100
Message-Id: <172174483699.279607.15579753732481002106.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240712231730.2794-1-rbrasga@uci.edu>
References: <20240712231730.2794-1-rbrasga@uci.edu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 23:17:30 +0000, Remington Brasga wrote:
> The string passed to ksft_test_result_skip is missing the `type_name`
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] kselftest: missing arg in ptrace.c
      https://git.kernel.org/arm64/c/0c35e3bd412a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

