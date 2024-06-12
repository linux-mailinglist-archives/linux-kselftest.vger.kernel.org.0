Return-Path: <linux-kselftest+bounces-11781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F724905871
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250FDB2C239
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D0180A8C;
	Wed, 12 Jun 2024 16:08:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A037180A88;
	Wed, 12 Jun 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208533; cv=none; b=dQ/w5ruzdoLXeq9zA+8m6PGay4ZxhKHvA2x1MGLp5vtJampNlCZHiM4mnSAFqeSKsnB0ROvdExhNO97PYIqYh+Y1t/EzfT955os1QwI0JdqjRtLPx6shPjXjRrxTgyOVcGKKW1KAuhF3fvMaMJg2miUTJDrk1/aX54M01ModyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208533; c=relaxed/simple;
	bh=Ip32zJidhkVImJldvuG8RpUllNiXoa6kdBVrAJd6yK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZyp9ks1FF1TiNEZTaLUQGf3RGpqQM6ZhPoQcwy9D8vIgQNJGmAj0zj33niOk4X6xCvtUP1qaYSmTk7lqI0qfTwrluH5cV7N7Q0/4uCEOVjefKLn6v2NW4euwgXMTx5UExNiQVrksMc1hb7dWH8YvzbUewnCN7wNzVFGBvw88LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98B8C116B1;
	Wed, 12 Jun 2024 16:08:50 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	will@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Cc: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests: arm64: Fix redundancy of a testcase
Date: Wed, 12 Jun 2024 17:08:48 +0100
Message-Id: <171820848288.4013585.9352407974182180231.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240605115448.640717-1-dev.jain@arm.com>
References: <20240605115448.640717-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Jun 2024 17:24:48 +0530, Dev Jain wrote:
> Currently, we are writing the same value as we read, into the TLS
> register; hence, we cannot confirm updation of the register, making the
> testcase "verify_tpidr_one" redundant. Fix this; while at it, do a style
> change.
> 
> 

Applied to arm64 (for-next/kselftest), thanks! I removed the increment
style change.

[1/1] selftests: arm64: Fix redundancy of a testcase
      https://git.kernel.org/arm64/c/031d1f20d5db

-- 
Catalin


