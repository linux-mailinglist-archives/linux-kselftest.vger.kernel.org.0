Return-Path: <linux-kselftest+bounces-27253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ED6A40474
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9750B19C59D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F773451;
	Sat, 22 Feb 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKVrPf1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3FB663;
	Sat, 22 Feb 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185848; cv=none; b=VgN6EireX1NpjB1z+KbbP3uR3kIHBiPXUxVwFeI3ie1gcnDUirm5oOXqsbWq/bTxAh5RJdD2iF1xe96cOQxJ/ngbvW0flcjxHiDEcwJVdSIFbkqTf890iXC850ZPP8E6hYlea3XXXKt3InfVuZdYOJEcg9Ow6eM3iSHgS374BV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185848; c=relaxed/simple;
	bh=I8vbpVgLCG8niJZmpLp3ylZ/cFF0g23l4NoZUlXPx5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocMSLLlHQWzOxkFlDmQl2A/YT9LBVn8Ehk0Xo1hJpGechZH5zmWSmdOQGeWNHfyLzydzuiMre0XcioFkKwFeBCXzT72GVNePIO5XrjTo8aapB2XCARw1LZVV1H6jfM556OCN4azqYA3BzG9VquNQNO3qz9YxkBJPu9gICoVgqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKVrPf1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D2C4CED6;
	Sat, 22 Feb 2025 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185848;
	bh=I8vbpVgLCG8niJZmpLp3ylZ/cFF0g23l4NoZUlXPx5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKVrPf1PsJZemT331Lf/SDeCrxsNR38QpDgh9aOw4y4IbeNxtyOnF4xMUaR/2jjyH
	 yzFFXNrxQ1yYVMBCcEDDLBuY2Cyb7Fb9JXd7Cr/65zlWucWFZ63FhDQponsIfL5ido
	 RoE6tagmeijZHDNynVt9ZftxfpAHcH+gLcq6tqWSZ8sz/JLlN7F3xxKID2+UlZxDBp
	 YHBzTVa9ruynTLyvMLvdFTKt/pRNvLb/IYL6tNit4u7i5jjxkARh+UiQb32futfWc1
	 fwj/UCr3lU4TQlChJzeselbiD29zDv/041WIvw7SP5mcZyBRDpkZfqe9VHu7SUVZ9k
	 yTjjm8Arr5xgg==
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	oe-lkp@lists.linux.dev,
	lkp@intel.com
Subject: Re: [PATCH] selftets: lib: remove reference to prime_numbers
Date: Fri, 21 Feb 2025 16:57:07 -0800
Message-Id: <174018582427.3369509.6023266709728991391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217-fix-prime-numbers-v1-1-eb0ca7235e60@gmail.com>
References: <20250217-fix-prime-numbers-v1-1-eb0ca7235e60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 08:30:44 -0500, Tamir Duberstein wrote:
> Remove a leftover shell script reference from commit 313b38a6ecb4
> ("lib/prime_numbers: convert self-test to KUnit").
> 
> 

I fixed the Subject typos and applied to for-next/move-kunit-tests,
thanks!

[1/1] selftets: lib: remove reference to prime_numbers
      https://git.kernel.org/kees/c/03d0e920d775

Take care,

-- 
Kees Cook


