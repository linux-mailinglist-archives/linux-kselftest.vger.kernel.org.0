Return-Path: <linux-kselftest+bounces-33200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B0ABA00C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E70FA231C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24A1D6DC5;
	Fri, 16 May 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFf1em0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210A1C4A24;
	Fri, 16 May 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409885; cv=none; b=rrRvhD9w6wkjX2BFJ6wXCAgXVTOdF8865HPJDaIAjZE6LpDS5O/3Ua+3AK+1uy6tEsbYgvVydvdPnAhFynPZ+bUSf1eol+DzMO+aN80kcCvxdhZCTZ7lNjfpCmoXqJBMaLjtNJXV65/jOB68wyxazFJQEXBz9VSzjTMsNn3F5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409885; c=relaxed/simple;
	bh=YsofLFLi3rdB3bGp7np0mUh3ypEZ87RyG+A4xj6xx84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwZdl2b2XQGDvrnEBSXmlu4PUvjy2ru30SOdB6ConocSkGqLaNuyQWuyYJyNRTUxgcy3H3pADJQdiGysjlfIhIpl3yXvIj1Mqg9zR33t3USNX+kzZ9qP60xa5aI/cekiYkgysrQmOxR3Px/Tnvr0s9ipRDAKe6IVFxCpk69OU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFf1em0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE0C4CEE4;
	Fri, 16 May 2025 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747409885;
	bh=YsofLFLi3rdB3bGp7np0mUh3ypEZ87RyG+A4xj6xx84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFf1em0ht+ti4QfG0xqp1Qw4JWmpOu+Jpo2sUOOJbWuWJWYgDAIdtymXVoIynGOu7
	 UtAcGdynv9ncMRYgfM8O58HDRZDMvuoYW1tlvi3riQPfwRh0FXMLx1Uu8rda8ISLhm
	 9GUDabp9ExuL+Ft1v2wG0Uqlu9dKCZ+Dn1YmpJLcOFbQ9r6IJk8XQbROh7RY1B9nLZ
	 +6xepgfkvy338wJ2k+NxVpT4rkyWDnz6GqfwcsPnKe5DYjq5jMjjgmU4oBZU+5CRZ1
	 acwEvHETayI/8C4brH6nCPl/EX3f93htoIRkJHCuwqOHV2Djsom2oKmvaLsp28Aqla
	 5nau2g65icDuw==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	shuah@kernel.org,
	tanze <tanze@kylinos.cn>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Set default OUTPUT path when undefined
Date: Fri, 16 May 2025 16:37:48 +0100
Message-Id: <174740491354.2576982.10627092971010791317.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250515051839.3409658-1-tanze@kylinos.cn>
References: <20250515051839.3409658-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 May 2025 13:18:39 +0800, tanze wrote:
> When running 'make' in tools/testing/selftests/arm64/ without explicitly
> setting the OUTPUT variable, the build system will creates test
> directories (e.g., /bti) in the root filesystem due to OUTPUT defaulting
> to an empty string. This causes unintended pollution of the root directory.
> 
> This patch adds proper handling for the OUTPUT variable: Sets OUTPUT
> to the current directory (.) if not specified
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Set default OUTPUT path when undefined
      https://git.kernel.org/arm64/c/b225219a4002

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

