Return-Path: <linux-kselftest+bounces-21879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFA9C5FA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95206B37550
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184CB205E0D;
	Tue, 12 Nov 2024 16:07:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F420515D;
	Tue, 12 Nov 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427666; cv=none; b=Ic3bbD2dQJXTahjyKORvYIHqpTjNcrRV+iQU5xgBLliL+h2YNm2q9swxYZbvfXj1G2Y/Z6RWJ94RpI7P3qzEM2M0YhvP1vg9BrhBZ0a+jTJMTLMy+h4aAYs0xOhg1EmJ65RJm2wSSQBq1wNkp8vV7X1i6GAVXuty5Jb22dCpEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427666; c=relaxed/simple;
	bh=8DkATrIByn9r+OPoXqLIwF2qjZrVoXtkZx/eGnfvO5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJCGA77RDiPYSwzdNYbb0blG+xkUXQMHm0PRq/VY/dEGgW7SwsPeQrJuYoQYOr/A2Yj0QCrlo5ei0uVeVYBpR9yasFUhOnAlFbedeUrYVNgXmO786doSXb/JlZF2l8m8tFJ9Ej8XCLhNwfAoroHB1/oG8qUj2ILzETLQjkuoEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2109C4CED5;
	Tue, 12 Nov 2024 16:07:43 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Check that SVCR is 0 in signal handlers
Date: Tue, 12 Nov 2024 16:07:31 +0000
Message-Id: <173142698241.893467.12887782665454097847.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>
References: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Nov 2024 17:07:51 +0000, Mark Brown wrote:
> We don't currently validate that we exit streaming mode and clear ZA when
> we enter a signal handler. Add simple checks for this in the SSVE and ZA
> tests.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Check that SVCR is 0 in signal handlers
      https://git.kernel.org/arm64/c/116e50d6474e

-- 
Catalin


