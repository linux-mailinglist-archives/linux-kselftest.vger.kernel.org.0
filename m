Return-Path: <linux-kselftest+bounces-17044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD096A0AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE66528214C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558AF158DD1;
	Tue,  3 Sep 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djQpSUit"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0A13A87C;
	Tue,  3 Sep 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373842; cv=none; b=J7EiJtnAvYFZ/f8kEvt0Kl3iOG3oWvQPl5/FbDl4yxW2PSv6qUBeN8m695aBcuA+8JaftmvGiorDxrX+scVwSFeITZVe3BCGEzVMZY7MBNXMDtvAuuRTdMavwQawC3CIdWNj/NsSFhrCBtq/nn1/KwyOJeuB2jl1Yqv0u1sWM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373842; c=relaxed/simple;
	bh=wrzvstu/DVvPe126O5wbylKc3BmtEGTZ9Vu4W4NBnf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/iYFsnWfmF+CTP0eDrwfhtQ2l06zd5/Niqv/I/ovpOpTGPWRbBlw69wC1xR566mPZ5xEIsB/+vRu5T8ZwKQZt2AAGW/oL7paHPL9CepJ3SiDfhc4JrwlkFUDuPAgwB3bzA9qIMnO5Clr05NNVhcvtsQBV7Fmu1OFhwJR5yvi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djQpSUit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EFAC4CEC7;
	Tue,  3 Sep 2024 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373842;
	bh=wrzvstu/DVvPe126O5wbylKc3BmtEGTZ9Vu4W4NBnf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djQpSUit+bIb2uQLuyHb8vLwJI5gmjKQTgv57YB7l0ZdlcenMhD2DLReE9bRmfJZU
	 OiCWn6rBAb1HRiMCe+iIfnt4OTh+O7t/6Olu4IEsXgQQxtliFIIbpovhBzJzhHrw9K
	 JZKngt5klqP2xAM0JWIIJw8lhTAbhDO3ZSS9diXYwCL/FbKyuir6p6t2Nk0bNLL+h5
	 Q0qkU5UxQTOhg/1ehrZG4Fwfponi24VByF3yWDlpPZCDP55FWcioALl70lOHe7radQ
	 hcrMCohwe42HfUx6JESBIMLYp0b/lgiHipBqHjkWx+VfEhj8/6TZW2YEL08paXtQEU
	 ZtmzwwiNm4RIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA33822D69;
	Tue,  3 Sep 2024 14:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] RISC-V: mm: do not treat hint addr on mmap as the
 upper bound to search
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172537384274.320952.7351958259552393532.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 14:30:42 +0000
References: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
In-Reply-To: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, charlie@rivosinc.com, corbet@lwn.net,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 shuah@kernel.org, rsworktech@outlook.com, alexghiti@rivosinc.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, palmer@rivosinc.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 27 Aug 2024 16:05:15 +0800 you wrote:
> Previous patch series[1][2] changes a mmap behavior that treats the hint
> address as the upper bound of the mmap address range. The motivation of the
> previous patch series is that some user space software may assume 48-bit
> address space and use higher bits to encode some information, which may
> collide with large virtual address space mmap may return. However, to make
> sv48 by default, we don't need to change the meaning of the hint address on
> mmap as the upper bound of the mmap address range. This behavior breaks
> some user space software like Chromium that gets ENOMEM error when the hint
> address + size is not big enough, as specified in [3].
> 
> [...]

Here is the summary with links:
  - [v3,1/3] riscv: selftests: Remove mmap hint address checks
    https://git.kernel.org/riscv/c/83dae72ac038
  - [v3,2/3] RISC-V: mm: not use hint addr as upper bound
    (no matching commit)
  - [v3,3/3] Documentation: riscv: correct sv57 kernel behavior
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



