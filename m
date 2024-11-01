Return-Path: <linux-kselftest+bounces-21309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A919B9691
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E72528305D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D141CB51D;
	Fri,  1 Nov 2024 17:30:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8419B3D3;
	Fri,  1 Nov 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482232; cv=none; b=tY1Zbd+4XEC8+8Xe0GEHrt2zV/h/GN6jYhWGkm+kK9xasXlgNMRy7gsI5I+y04aiumFxHwfsOjw2WBLjx+BBxUmXqH67oCtSfmj9jSZ2XKLyAERc4vcF+8+BKNm0vz2tzvLUXWobFqYpIYcc3EOhOZV4b+OZ/orbNppXfoNxv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482232; c=relaxed/simple;
	bh=Hevd3XvI+k3FvqGimnkdAjM0oKrCOzvmal8t2cnhaLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRT7ytVdPugJ1eNwG8UJmH4liEAgBPN6AwVw4k+HlT3H6x1E8YRQtqDXwSUYPAtOElTNoV3hRQcvzaW5hOj/ISC1hqauq56Qe3FaadLfMrYH5lHJA/uuBwoRpmLX91DcED8kbKFMhSAXm6Jqlp5PSXZJzRg987M0OQbJBmEgN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F422BC4CECD;
	Fri,  1 Nov 2024 17:30:30 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Use ksft_perror() to log MTE failures
Date: Fri,  1 Nov 2024 17:30:28 +0000
Message-Id: <173048220452.1105699.13506806837234605292.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029-arm64-mte-test-logging-v1-1-a128e732e36e@kernel.org>
References: <20241029-arm64-mte-test-logging-v1-1-a128e732e36e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 12:34:21 +0000, Mark Brown wrote:
> The logging in the allocation helpers variously uses ksft_print_msg() with
> very intermittent logging of errno and perror() (which won't produce KTAP
> conformant output) when logging the result of API calls that set errno.
> Standardise on using the ksft_perror() helper in these cases so that more
> information is available should the tests fail.
> 
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Use ksft_perror() to log MTE failures
      https://git.kernel.org/arm64/c/17a2409783f1

-- 
Catalin


