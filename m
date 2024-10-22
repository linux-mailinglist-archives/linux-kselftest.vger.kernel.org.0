Return-Path: <linux-kselftest+bounces-20384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 871079AA139
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32780B229A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52F19AD94;
	Tue, 22 Oct 2024 11:37:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5513D516;
	Tue, 22 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597029; cv=none; b=X8ZNpAt+hJEkkZItP9lxDBzG+V4umQCPYOtWu0JoGjYzEqPy6VvKhvXyAaIt1LaPxXP8W8aemvI9BD1F6HCVNvG5x6V/8aPyBi6Ueg2AbWSQl6B7+oz68OMeVt1pli4e18C7Vd3ajBR7pmLGrQHEMpQl8aeUTIYshH03SlNKVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597029; c=relaxed/simple;
	bh=AtZ/+dMaS/nQkAbuUhC70d+sLdjqItoaSsbPIpHiquQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdr0uHCpt8aRmzbkUeUgrb3whcWp38LXG4ypwnHCogqCt0w9dFWF6lC5wJ5cRqHYxp0uy4UEWR6DCdDn3K1iCR6x56ygoTRvT/NhOLJxmxaT3z4NYBTi+2fPHqN/aocKgJolqq6tHpS4uVEFKmZBOOmkoAUs+I4hLCIArtBSfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A7C4CEC3;
	Tue, 22 Oct 2024 11:37:07 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fail the overall fp-stress test if any test fails
Date: Tue, 22 Oct 2024 12:37:05 +0100
Message-Id: <172959701881.951357.12349097859376316498.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241017-arm64-fp-stress-exit-code-v1-1-f528e53a2321@kernel.org>
References: <20241017-arm64-fp-stress-exit-code-v1-1-f528e53a2321@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 17 Oct 2024 18:43:31 +0100, Mark Brown wrote:
> Currently fp-stress does not report a top level test result if it runs to
> completion, it always exits with a return code 0. Use the ksft_finished()
> helper to ensure that the exit code for the top level program reports a
> failure if any of the individual tests has failed.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fail the overall fp-stress test if any test fails
      https://git.kernel.org/arm64/c/7a08cb9b4bb9

-- 
Catalin


