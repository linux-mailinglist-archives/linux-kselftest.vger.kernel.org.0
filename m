Return-Path: <linux-kselftest+bounces-19854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36B9A0FBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A86CB229B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C23187346;
	Wed, 16 Oct 2024 16:30:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B713D53B;
	Wed, 16 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096229; cv=none; b=bgjgw3bLUZaUfoOLXrsJY+0J31+bFdTMqs+6vyYWam6Za2VvkwCVMbLM0CDqDI3wGXf5okLGfpwnIwvl3Mrzj4xwewH8duEDr0cu1xUGLBNkogOkJzbmNSXoCLEATgqBouOMvMCyjyEYPn1Hwh7PYsMoJjxZXqiy5pL+toWzN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096229; c=relaxed/simple;
	bh=hIzlgsXW9l/83UqMigPDgWe9alpKE1kP4eKo1iLmL9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua8oKkgRPOuEgZprc484923BmLc/YgYKI6P5Xqvrz9PjWZAnNwnggP3l6W6avYvpAUnoqwF8vfFSA89x2VI2QHCQcG/3j8S0J2Rs55REHP6F1e4pO+hS8dq0JY8rL7Y3PrYjHrt3lyTPxwo6+4bpej0kH1hgVDfTKIo7UZHomu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AA5C4CEC5;
	Wed, 16 Oct 2024 16:30:27 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Validate that GCS push and write permissions work
Date: Wed, 16 Oct 2024 17:30:25 +0100
Message-Id: <172909620948.3163505.16150872524185276788.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241005-arm64-gcs-test-flags-v1-1-03cb9786c5cd@kernel.org>
References: <20241005-arm64-gcs-test-flags-v1-1-03cb9786c5cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 05 Oct 2024 01:17:18 +0100, Mark Brown wrote:
> Add trivial assembly programs which give themselves the appropriate
> permissions and then execute GCSPUSHM and GCSSTR, they will report errors
> by generating signals on the non-permitted instructions. Not using libc
> minimises the interaction with any policy set for the system but we skip on
> failure to get the permissions in case the system is locked down to make
> them inaccessible.
> 
> [...]

Applied to arm64 (for-next/gcs), thanks!

[1/1] kselftest/arm64: Validate that GCS push and write permissions work
      https://git.kernel.org/arm64/c/48f8d9cef766

-- 
Catalin


