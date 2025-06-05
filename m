Return-Path: <linux-kselftest+bounces-34405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DAACF90B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683B53A1316
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F527F171;
	Thu,  5 Jun 2025 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbUhexF/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A227F160;
	Thu,  5 Jun 2025 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157201; cv=none; b=rhXogB8uCIOBSNW/nqU6lXQ7R7prnmluCbfkCYxCy3wcobJjNTgUqA/6EFPMBq3CR7bZmROLFwmBH7jhDAjNnUvZS+UGyCEetVu0iKpDeiskiQc10EIMby/C1TjkpRFfdCPBu0xccTNktTU5iAEEvTYzSxzQVwUkvR//KVDcjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157201; c=relaxed/simple;
	bh=M6AWFw6DpnJscLYSXXW9hmN9ozrU6aQy3z0YghQmcmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=liytFGVMDql2IzjWyvGywtDKzIhWVPww15AnZS67cGpMqdzaCc7roGSyqPE47g/e5lRUeGbfX+X36lsTVDL8qmgX7xQ7eQNjiMMv11xF52dtJ+x5i25P53CRLtXS/Jlcd2qYRIptbPK1iDmCJ1FtwyaVSL3CjBHxZyKa/xSlpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbUhexF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6CDC4CEE7;
	Thu,  5 Jun 2025 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749157201;
	bh=M6AWFw6DpnJscLYSXXW9hmN9ozrU6aQy3z0YghQmcmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TbUhexF/yMtVtlj+z+d2SftvKDZKfqQ33LMsaklDBdR37OTtuEgLzuEiXBwpONkCQ
	 YSliPwBELN14U41qIcMuubhvik4iGjb0QyzDRwots2SIAG/tskncHpm6O6nNdsVG6B
	 t5PY59b0KQfQVa+aEss2Rn/nWK7BWbxkS/zaQLdbYO1pKL9ULBvSYxod2MdxeRWoJU
	 NkgAaRBdjEfixd0ez2gEQySCeHTYPuLqcabs3UpmlENfd1xx4uMztpslzknFAirk/2
	 yggm0cgLFa9YHw4GmXyUY0FqLHUMGnzneSRoDPoVl8czb/iOqwCPJHT6uFO5CTgnud
	 GS+Y7fuWanBNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE939D60B4;
	Thu,  5 Jun 2025 21:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays
 as strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 21:00:33 +0000
References: <20250603203701.520541-1-blakejones@google.com>
In-Reply-To: <20250603203701.520541-1-blakejones@google.com>
To: Blake Jones <blakejones@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ihor.solodrai@linux.dev, namhyung@kernel.org,
 irogers@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> The BTF dumper code currently displays arrays of characters as just that -
> arrays, with each character formatted individually. Sometimes this is what
> makes sense, but it's nice to be able to treat that array as a string.
> 
> This change adds a special case to the btf_dump functionality to allow
> 0-terminated arrays of single-byte integer values to be printed as
> character strings. Characters for which isprint() returns false are
> printed as hex-escaped values. This is enabled when the new ".emit_strings"
> is set to 1 in the btf_dump_type_data_opts structure.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] libbpf: add support for printing BTF character arrays as strings
    https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
  - [v3,2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
    https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



