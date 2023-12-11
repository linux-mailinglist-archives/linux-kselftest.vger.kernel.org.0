Return-Path: <linux-kselftest+bounces-1617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC880DB96
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CB1C21471
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AC53E0E;
	Mon, 11 Dec 2023 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBLNCfzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B59537FE
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 20:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE81DC433CB;
	Mon, 11 Dec 2023 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702326467;
	bh=jnLDKDObyODrW4yUrf2GM7i1XjdC3e8rJg72m1Tdr7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBLNCfzvYJYRFpXpFHfkENqbdH5VwClbg0FEVqhK2k77qqCLGe4hcR0LVoyptVhKb
	 ClBEgSoItksIlWWs4//e+gJntjm0K6/Itq2ewvl6pN2FgqqozgpEFfEwWaWmgo6KIL
	 RkZEDR2Yx/XsgeHFrshsD4lnKf26WmjxGj+AUB8DHc20Ax0DsDu5rI6ARaNWsUEdN2
	 IAlQwQpKjxBM39qKUSKO3ywheqH6dW4bSvyd2yQdNBlspcOCFi0YzkGsuemjTukKdM
	 0orZFg9DQGJm5SZkxUMfnWSv7w7NsJ98f8wovP9Ozz/Oc8WczYDnsUS+1tl5f3L4FQ
	 1Uzf122VTthEg==
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Log SVCR when the SME tests barf
Date: Mon, 11 Dec 2023 20:27:30 +0000
Message-Id: <170229612040.43237.5946498917108951815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231205-arm64-kselftest-log-svcr-v1-1-b77abd9ee7f3@kernel.org>
References: <20231205-arm64-kselftest-log-svcr-v1-1-b77abd9ee7f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 05 Dec 2023 14:24:44 +0000, Mark Brown wrote:
> On failure we log the actual and expected value of the register we detect
> a mismatch in. For SME one obvious potential source of corruption would be
> if we had corrupted SVCR since changes in streaming mode will reset the
> register values, log the value to aid in understanding issues.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Log SVCR when the SME tests barf
      https://git.kernel.org/arm64/c/48f7ab21f731

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

