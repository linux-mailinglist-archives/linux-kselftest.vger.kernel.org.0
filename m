Return-Path: <linux-kselftest+bounces-20449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A619E9AC887
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 13:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A891C2139E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65E1AAE3A;
	Wed, 23 Oct 2024 11:05:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C181A727F;
	Wed, 23 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681532; cv=none; b=SgFxwkisASXXf9ZNfLG7x3n69pN0xC7G0Gpe+ZKlRmQ8+dNtTsVV+uqhNgie669QOjixFraW8jcdIiupC2vehGRw/Iv2McyMo1qikGgjCp8Ji0spR69dtSdWou0zQPKoWyhpz72tK4KOtVHUo8B6y4eq5Vmw+jjhkbpBKWiw3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681532; c=relaxed/simple;
	bh=AzdjkwSqqB7mlV3P/gR9jT205/qic9jsRLSTZyAQ0Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcdO4ldyXs0AoOQAqdiYjIDYMeju913I6/EA0Jd1p+Jv3N8C1Z+98W4gqzxHaHwJWFvna2OXaoDNgmyfvg/t99R5muSH4aLqvlTCBCvVHGz7XiEw272acfDoI9C+OHHpq5oYUJlxva71Uc5uAn37RlpIOraamsv8F0PaMOl5874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80CC4CEE7;
	Wed, 23 Oct 2024 11:05:30 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Log fp-stress child startup errors to stdout
Date: Wed, 23 Oct 2024 12:05:28 +0100
Message-Id: <172968152193.1430866.7898159592219415431.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023-arm64-fp-stress-exec-fail-v1-1-ee3c62932c15@kernel.org>
References: <20241023-arm64-fp-stress-exec-fail-v1-1-ee3c62932c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Oct 2024 00:20:45 +0100, Mark Brown wrote:
> Currently if we encounter an error between fork() and exec() of a child
> process we log the error to stderr. This means that the errors don't get
> annotated with the child information which makes diagnostics harder and
> means that if we miss the exit signal from the child we can deadlock
> waiting for output from the child. Improve robustness and output quality
> by logging to stdout instead.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Log fp-stress child startup errors to stdout
      https://git.kernel.org/arm64/c/dca93d29845d

-- 
Catalin


