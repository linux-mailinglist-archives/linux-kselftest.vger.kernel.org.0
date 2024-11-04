Return-Path: <linux-kselftest+bounces-21369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F79BB10B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE63283EED
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CE1B0F2C;
	Mon,  4 Nov 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuKkNx6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DC20ED;
	Mon,  4 Nov 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715962; cv=none; b=NyzYWEO5+WxCT5GBHNnrNzg4x2JY+qpfs+TFTs8+Kz3a5uvqRTPpp2HFc+kAICFhX2mUvgua1F5zzaQHZ1LhUu9Cm5qwdxicvRoog4NU2WeUabeYDIS9mwNt9EPgws1klH/rn/4vUOV1eQMx+AQfs3KTXP8ISCxLC6mC7gam9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715962; c=relaxed/simple;
	bh=w+X3jD/IbBDhpvwEqajt/6fE2DKnI3nYbmMUj+IZ69Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuI4MBSgOkNrrkjh0PN6T1ZfzhFlJ7GABJrK8P/eQZLuYAmGZ/hnHFtrzf0ACYimEQxL6wzLTqJb7g5qn2pgTdai2efDSJkJX4tCnPXvGzFIzJsknmW7Pvc3dkvIcsyul5Y9YlUKSKvqeTqF3OZxalBsUPuvEdcZaInD+6o6Elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuKkNx6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18704C4CECE;
	Mon,  4 Nov 2024 10:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730715961;
	bh=w+X3jD/IbBDhpvwEqajt/6fE2DKnI3nYbmMUj+IZ69Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XuKkNx6qXQ9V9CwXutF//tCc4NatvFy8vEzvX9YDY13ar6v0JUnrIofYeDQxqHWKK
	 a0dyE1vdibGl9kFLSvs9yObV3k6u3fUeF8jpeKgmymKuqMFlTLFFqlQ6IMWaPdWWo3
	 BK3KM6Nfdx4gBsFOykvNmvpk75ftYTUboiwXOZKB30KgkPJmmjSkSnjq4JZUrCD/oX
	 6H2SDRIVAIFfGS/Rcost0rgGBIvmF0S3NxsrHZUMZQF/ck42BIP+kbjVL+oUrEJ+Ni
	 Cri5GhbO9q2MegEmGPODoR8602yjNs1OIy9DFaGHyJyGp8AqLhtzXgDtZm6ncOd0v6
	 6jsFDxRXaD6GQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org,
	=?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@rivosinc.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, charlie@rivosinc.com, Andreas Schwab
 <schwab@suse.de>, Anand Moon <linux.amoon@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
In-Reply-To: <172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org>
References: <20240927131355.350918-1-bjorn@kernel.org>
 <172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 11:25:58 +0100
Message-ID: <87bjyvpa6h.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

patchwork-bot+netdevbpf@kernel.org writes:

> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Fri, 27 Sep 2024 15:13:52 +0200 you wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> libbpf does not include the per-arch tools include path, e.g.
>> tools/arch/riscv/include. Some architectures depend those files to
>> build properly.
>>=20
>> Include tools/arch/$(SUBARCH)/include in the libbpf build.
>>=20
>> [...]
>
> Here is the summary with links:
>   - [bpf-next,1/2] libbpf: Add missing per-arch include path
>     https://git.kernel.org/bpf/bpf-next/c/710fbca820c7
>   - [bpf-next,2/2] selftests: bpf: Add missing per-arch include path
>     https://git.kernel.org/bpf/bpf-next/c/19090f0306f1

Andrii, I just noted that this landed into bpf-next, and not bpf
(fixes).

RISC-V libbpf/perf needs this fix in 6.12 to properly build. Would it be
possible to have it in the bpf tree, and have it land in 6.12-rc7?

Andreas that has a similar fix [1].


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/mvm5xq44bqh.fsf@suse.de/

