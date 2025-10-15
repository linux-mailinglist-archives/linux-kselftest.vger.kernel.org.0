Return-Path: <linux-kselftest+bounces-43211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE56BDF93A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97031A20F3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBEC32ED2C;
	Wed, 15 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de33f1g4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FE186E40;
	Wed, 15 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544621; cv=none; b=qFjyLZ/2TqjNhjNvtkqfaXSUo/3F+esVrXsN1sY7zTl51qpWHzee9dDs1bbovnD3HknsMr2JumQU46UgO20lcYANoRrskoRyhxbIpkwCv3EZsyNt3odMSGSiCPqqNGQT/6ke2Sb0lh2VXOALoWqXfVJL3u/RX1rD8vtFlAXPy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544621; c=relaxed/simple;
	bh=ZkMJxnD7i+PX1B2a2WXmajNSuDANnptfpfJF02+EnhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+ieNtklAIbEmYAXWELttlVfKbTJIezCl+EzyX0ggI/vJ/RpW1991jhvNNtxCCVNp12XeAodK3TaV6ldzHlkQ279o2oFJatAq11Co153nIW58F4d7X/fqaeTruRUp0Rlft51AuZGhsO4VjuwVkFSzoATjSyaxfcj3WwSwLGt1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de33f1g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9EAC4CEF8;
	Wed, 15 Oct 2025 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544621;
	bh=ZkMJxnD7i+PX1B2a2WXmajNSuDANnptfpfJF02+EnhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=de33f1g4w1DxVUrrkiWW8urDQfEDynrjl5AgUlWnXvKy+2A0sIJQL24dJcUsRi8U6
	 uzPEBJ9aakRXMGTlLsbMR/sUl68kwI+487u8xQ/0zmMNq36GDIrSwgfxG3h5eb45ez
	 0y9fpcKA8e1RJ+G1jal03N+IXeNNdCK1Zn40SiFVaBqx8dJXajXP+XSBWT2TCTdf75
	 Zl2tUeTqF8aS6UswAy+X9O//44zgBMPChNl4GyFApliS9k+BkOxktMSvxHOZ7r37nD
	 apXj3vjNY08qChtSatMLclXlvD7wZ9h8dhoXXLqS1nnqsUEUpyJLOL6K3WyT/klp7S
	 7qyKm9LprBlQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71744380CFFF;
	Wed, 15 Oct 2025 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176054460627.940684.18292912943742394253.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 16:10:06 +0000
References: <20251015025049.9492-1-higuoxing@gmail.com>
In-Reply-To: <20251015025049.9492-1-higuoxing@gmail.com>
To: Xing Guo <higuoxing@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, olsajiri@gmail.com, sveiss@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 15 Oct 2025 10:50:49 +0800 you wrote:
> Recently, I noticed a selftest failure in my local environment. The
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
> 
> [...]

Here is the summary with links:
  - [v2] selftests: arg_parsing: Ensure data is flushed to disk before reading.
    https://git.kernel.org/bpf/bpf-next/c/27aab47b347e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



