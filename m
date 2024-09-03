Return-Path: <linux-kselftest+bounces-17043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6FD96A0A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8CB23AE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE680C02;
	Tue,  3 Sep 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMPhAULP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D158F45;
	Tue,  3 Sep 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373840; cv=none; b=oUM/4N6VJMDEgtlGne9SfGvajTa2mHCS6/+DYXD/6fJY14hWzcmg5QxiiqZqKDQeqIQJAuMXiXW/GEp2DCVNa2FRCmyPPefB1++Hd7QOQT/Mb7UodTK7wbZ+M6Jno6Wq8H3E0sfLNjkfsBPIL2mVwbECZPpyair5H+VXeWeIJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373840; c=relaxed/simple;
	bh=8hIsX3Gtu284V91gL7N6GgFB7NiLigl/6FXHMFI6wzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EcmcJ/XzZDvM9I9nvcG2lhyf5KfbOOd1v0suK8wLNMkj9fzRUe2PTfdiJZHQ+8LXPH8KqOHSMUbtogB99LQKkNdkY6ECfNwuOQWYd6iLpOdo1WBnM7PBw2UA1+LozXBxrDvZbxrtkUNR0O4jG/v03B9u2F0Lc3M2jxYqZ9xwznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMPhAULP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A67C4CEC4;
	Tue,  3 Sep 2024 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373839;
	bh=8hIsX3Gtu284V91gL7N6GgFB7NiLigl/6FXHMFI6wzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMPhAULPDWSY4mHmyASlsRi7jgsoFCb5qncdk7Jm9YyLKiP1V8Y7lViX0Z6v3UdYZ
	 3hKlLIzyD2wxeMBcwS/sM7csrpCqg2Gyjj2PTMKkz1HE52x+8QTO9oVINqw/wZ2dUO
	 K2GI7Dq8dYPFk8SxBa/XdFK/R9fQuUz2A4ORDKHr/WrikJkdbS9Am/Mrvvj1XDChZv
	 3Ox2jpueSGC5u4BsN/VgskFOuyyrur94yhgpyyREzRNvsoDIOZa9PFmdM44MBZo0T9
	 SIeZAFnHAaXTNNGkeABnF026+EK3JOBXANHgq4uXE78oPEQayzpL+KZbZR908BCG70
	 yWXz2nhHg9VtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF53822D69;
	Tue,  3 Sep 2024 14:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] riscv: mm: Do not restrict mmap address based on hint
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172537383996.320952.12145351414026889643.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 14:30:39 +0000
References: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
In-Reply-To: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, shuah@kernel.org,
 cyy@cyyself.name, rsworktech@outlook.com, alexghiti@rivosinc.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, palmer@rivosinc.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 26 Aug 2024 09:36:44 -0700 you wrote:
> There have been a couple of reports that using the hint address to
> restrict the address returned by mmap hint address has caused issues in
> applications. A different solution for restricting addresses returned by
> mmap is necessary to avoid breakages.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [1/3] Revert "RISC-V: mm: Document mmap changes"
    https://git.kernel.org/riscv/c/954260ff5a46
  - [2/3] riscv: selftests: Remove mmap hint address checks
    https://git.kernel.org/riscv/c/83dae72ac038
  - [3/3] riscv: mm: Do not restrict mmap address based on hint
    https://git.kernel.org/riscv/c/2116988d5372

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



