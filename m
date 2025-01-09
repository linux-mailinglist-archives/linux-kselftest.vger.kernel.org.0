Return-Path: <linux-kselftest+bounces-24159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7DA080AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C681695A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D51FDE28;
	Thu,  9 Jan 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOePwsB/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D41FCFFB;
	Thu,  9 Jan 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451622; cv=none; b=h5hWAZxScOdFldvQ7+dSaxDb0KNg1PJxoo1NBpi0fHhCBg9F8j04zeRElZoQ1I2rv9LQZUeZ5+leoDlyrERz+crnTZGM93W9ue0vqkqJFoj9J4T2lE8+j26eRVPOuXDxOf0kw6fdb0aOqUcVOJw+ytD61u2KLafSMDeO9YSScvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451622; c=relaxed/simple;
	bh=XqjSog8RAzpbGe8ofP1xutDuavH7WHqQwghnzd6J0H4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZyVRLlJV0N70a4ZxC1BPliAfps+V7GUpMJcSaIJ3cwIZMpRpRck3TRrP42llI17EmdTvVGJ/EU8/db5h7zPFMz6uqiGkX4tPA5Vz0gUn2iTWVQ4r/3jdVxRN1/pR0E8RFpzVJKJ+uFjBhCbalXXoOdHNAb7nVxB3atO93y0DZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOePwsB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F84C4CEE1;
	Thu,  9 Jan 2025 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451621;
	bh=XqjSog8RAzpbGe8ofP1xutDuavH7WHqQwghnzd6J0H4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOePwsB/0XCB2GYwI4KDuZ8rZ9IMXDWiDYhfCN6z00wYxkeCIHxSETk3qvNmjsRGu
	 boF6vAacKeRcOIlnpew/szbWNAyjgqYtyp7bsYpMyAfg8nThFAy690i7H5NG75Lb10
	 EwUNMWm2+rnwANkpnbYOmS+v4jCzQu/9hDuyOcjBSGALNw6PdmXemKFN7SV/lKjpJt
	 2G1xQZZIrMKHLrk2CMFFzVfeOsVoiiOJSfO2yI/wXSVDS2RefjVerYSg0ZxiwVabho
	 +fqvy8r5v5G8MC9gh9ovX5NF/VW5fu++IvO5EMjM1pQyzbFgmbN6tGIIBazvLp1f8g
	 sc6yMPmR8+AXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE105380A97F;
	Thu,  9 Jan 2025 19:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] selftest: fix riscv/vector tests
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173645164323.1490121.6057718076513912259.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 19:40:43 +0000
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, andybnac@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 20 Dec 2024 17:17:25 +0800 you wrote:
> Add test counts and pass message to remove warning of riscv/vector tests.
> 
> Yong-Xuan Wang (2):
>   tools: selftests: riscv: Add pass message for v_initval_nolibc
>   tools: selftests: riscv: Add test count for vstate_prctl
> 
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
>  tools/testing/selftests/riscv/vector/vstate_prctl.c     | 2 ++
>  2 files changed, 6 insertions(+)

Here is the summary with links:
  - [1/2] tools: selftests: riscv: Add pass message for v_initval_nolibc
    https://git.kernel.org/riscv/c/503465d4dc40
  - [2/2] tools: selftests: riscv: Add test count for vstate_prctl
    https://git.kernel.org/riscv/c/ebdc22c51ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



