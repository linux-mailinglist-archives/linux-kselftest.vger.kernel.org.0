Return-Path: <linux-kselftest+bounces-21885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020029C60DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 19:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B910B2FE9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C9205148;
	Tue, 12 Nov 2024 16:10:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE6203713
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427852; cv=none; b=WhLNAPwHHbUki1x4Wd7EK8qL71F3k/PXlt0jed/tLX15eHD1ZZIfmnZHZMll6nDwQBLU1zE/c+9Ana5/oA4OOulOiyiY9WALvQYIRhNqf3weEVjZWa9KIEymVLkMoOmSygAKfZOPY+55CBLw0RHIwEiGf1i3tmvlu3JCysmGb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427852; c=relaxed/simple;
	bh=PPPTmhzefUOxRaG1VF5NgtHtMmt/Ur6Ur/KQr9CWeYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiOWZEveySmqLZvJErJaSs1obGzfS1mIjyc1N/8blZpu3OqP87r2FFQi26O/RY4VQaw3kRJg0iK49G86OZQwE+U3Tfl9xQWwFXPwYDouoWwvdVAO83/HOQYIvzQkOa1G+VeJ0jMFc3NP9o4Wu1KCzZNgUJBG6JY1f5aJH2gEHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A27C4CECD;
	Tue, 12 Nov 2024 16:10:49 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH] selftests/mm: Fix unused function warning for aarch64_write_signal_pkey()
Date: Tue, 12 Nov 2024 16:10:47 +0000
Message-Id: <173142783788.896701.6743208962860703144.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108110549.1185923-1-catalin.marinas@arm.com>
References: <20241108110549.1185923-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 11:05:49 +0000, Catalin Marinas wrote:
> Since commit 49f59573e9e0 ("selftests/mm: Enable pkey_sighandler_tests
> on arm64"), pkey_sighandler_tests.c (which includes pkey-arm64.h via
> pkey-helpers.h) ends up compiled for arm64. Since it doesn't use
> aarch64_write_signal_pkey(), the compiler warns:
> 
> In file included from pkey-helpers.h:106,
>                  from pkey_sighandler_tests.c:31:
> pkey-arm64.h:130:13: warning: ‘aarch64_write_signal_pkey’ defined but not used [-Wunused-function]
>   130 | static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/pkey-signal), thanks!

[1/1] selftests/mm: Fix unused function warning for aarch64_write_signal_pkey()
      https://git.kernel.org/arm64/c/929bbc16abfb

-- 
Catalin


