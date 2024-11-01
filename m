Return-Path: <linux-kselftest+bounces-21308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E79B968D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488C7282C53
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86D1CC178;
	Fri,  1 Nov 2024 17:30:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C11CBE8C;
	Fri,  1 Nov 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482216; cv=none; b=HQN/g+Gt0LGVojk6QPExg2GtwMCrcDcEIuBk6Ayc2/8LoIn4uRYDgdvFOjHqVc7/wNfYIEa2iwuActXngXMuZe/PXepax4zRg6/gwMHoUhX+ds9bvPupwRNoQwQwoy86Oy1PETGptGAQIsB2mYNC+RjPmRH0YLGxFhzC5yW+hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482216; c=relaxed/simple;
	bh=Ht8Ixqk57eKJM/1bG0+S/XYo/wFQbX2oZQ1qPkrkKXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1Jmlqv5pgp15+DzR3vjh4zetUFcWoHcPly3eRV35bVK3kqVKCnC2BHPhl8wCBcAfHKCZC5BIbImvHZmRyU1gweVH0kSHnECgcTi/xFDWEUDuHeWAL3RAKObauSWkz9saE8In2VFB049UjPjWYWQRkBGn1N7MVdlfdw83vwFioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48802C4CECD;
	Fri,  1 Nov 2024 17:30:14 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix encoding for SVE B16B16 test
Date: Fri,  1 Nov 2024 17:30:11 +0000
Message-Id: <173048220454.1105699.16636149578307021723.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028-arm64-b16b16-test-v1-1-59a4a7449bdf@kernel.org>
References: <20241028-arm64-b16b16-test-v1-1-59a4a7449bdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 20:22:31 +0000, Mark Brown wrote:
> The test for SVE_B16B16 had a cut'n'paste of a SME instruction, fix it with
> a relevant SVE instruction.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fix encoding for SVE B16B16 test
      https://git.kernel.org/arm64/c/69c0d8247798

-- 
Catalin


