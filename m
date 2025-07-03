Return-Path: <linux-kselftest+bounces-36474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF75AF7EDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8016BD2C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041328B417;
	Thu,  3 Jul 2025 17:30:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF228B40A;
	Thu,  3 Jul 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563814; cv=none; b=ED50TPz8yPtYDShKwJ0Y2TyY+y9M5tGZsA6F89RDS3fNUGyJmZvX28GJRo1+0qiYnn08+7pbo5IlIvDb5hVCsL8capdfTJJJxND9bnxSn1ubpe6guz2TtRIwGwztxDTIIYIzjhyY3ZbUeM9tuX9N715qVNYNn7tdUMhMt/aTiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563814; c=relaxed/simple;
	bh=4gVYGYnbs1vYUqUZ71neGpCyXuoHbTiMRIN2tQJULqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHlUZnEcT4MoGmFEelnZR5+K51wydVY6jEADUknsxas+B+DwqaAQNFp1bGw+vHMnSTIRS2dRaEtzz4sG+v2T5tT5gctSsH+En8nS9jztpM1gLNIbAL89ZuUaLFUpJL55QKg7Uug2cUxbP5IyaGStOOYuz6dlF1ze/yAkq895S/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915A4C4CEE3;
	Thu,  3 Jul 2025 17:30:12 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Convert tpidr2 test to use kselftest.h
Date: Thu,  3 Jul 2025 18:30:10 +0100
Message-Id: <175156379920.3469134.17202297123962878376.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609-kselftest-arm64-nolibc-header-v1-1-16ee1c6fbfed@kernel.org>
References: <20250609-kselftest-arm64-nolibc-header-v1-1-16ee1c6fbfed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Jun 2025 14:29:10 +0100, Mark Brown wrote:
> Recent work by Thomas Weißschuh means that it is now possible to use
> kselftest.h with nolibc. Convert the tpidr2 test which is nolibc specific
> to use kselftest.h, making it look more standard and ensuring it gets the
> benefit of any work done on kselftest.h.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Convert tpidr2 test to use kselftest.h
      https://git.kernel.org/arm64/c/6d80cb73131d

-- 
Catalin


