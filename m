Return-Path: <linux-kselftest+bounces-45943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E7FC6C59F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6185D358D61
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F327F4E7;
	Wed, 19 Nov 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui7GpCR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB51F0E29;
	Wed, 19 Nov 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518776; cv=none; b=Qtt9SUZPZhzIB726diPem0y1+WdKaGeuagrsszlMZMBRExhkdouh1ragq0yW73iyT6WiJ9uScWOyJ1ZOsUBVB8OQsExAK5lnRG2zY+d6eJMkkHBQigWF7DGA81UK0tHa1bin6raH+7gRQjeZW0d0qo4J7ifYJGsHuASD2WKxt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518776; c=relaxed/simple;
	bh=zFT1wKMUonwvnujQpKQ9C7jGYAhkyYfIkOuaAqgQWBg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YjMZNUSvw4xrb1ugreI+pzmlqdIlLFpM24uHFPmK6tAjmXqbBD+B2+xLPFV6JjtedLF3/YRagjU4tRig6hFELi6Mv7zS6yFbYxHmhwealdc2DHhwy9L4ADyj0MJXJuijjM55TSFQH4UUpJFqZd//qbRB/TuVJdMwa9lBlOPn06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui7GpCR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E38EC2BCB6;
	Wed, 19 Nov 2025 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763518774;
	bh=zFT1wKMUonwvnujQpKQ9C7jGYAhkyYfIkOuaAqgQWBg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ui7GpCR2qAi7IvNhX22dV6lmhwHRxEqV6rPUTSXuMvn/iqOm0gZu4Rj9VwwGxBPm8
	 E2tFrRz+cyNZt89cOeyasE9e5IMOA15otuOf0IldGB13dZewupGM88QIEkpYUotGoU
	 hmxFtd+wcE9oj0SxakiLbMfS/QDJO4tzwd79CaBTqlt3+IF0+t63Bs7BaVgk7oDy8S
	 RAzsQekpND5yx3RP8oNfKUVTrITWs05sgLoGaGvjwMekK45EkzhiX8Sqkmun4iUHzx
	 Ak58tlOSlpTMXEx/bLVz6mA6IEDFMiIedNYd6X4LgHAwJTPTV9Sum3RUVIJsOZHPhB
	 OLALci/K3cZJw==
Content-Type: multipart/mixed; boundary="===============5091828915502704464=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <694cd72d2f4697ed5ed8abb0721820b25c228916ce225b4524174f9af0f8cd6f@mail.kernel.org>
In-Reply-To: <b470e1e2e3c1baa97a7bc6637863b3f52336ebb1.1763457705.git.zhuhui@kylinos.cn>
References: <b470e1e2e3c1baa97a7bc6637863b3f52336ebb1.1763457705.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 3/3] samples/bpf: add example memcg eBPF program
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Nov 2025 02:19:32 +0000 (UTC)

--===============5091828915502704464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 78b414902..3a70521cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6357,6 +6357,8 @@ F:	mm/memcontrol_bpf.h
>  F:	mm/page_counter.c
>  F:	mm/swap_cgroup.c
>  F:	samples/cgroup/*
> +F:	samples/memcg_printk.bpf.c
> +F:	samples/memcg_printk.c
                     ^^^^

The paths here are missing the bpf/ directory component. The actual
files are located at samples/bpf/memcg_printk.bpf.c and
samples/bpf/memcg_printk.c. Should these paths include the bpf/
directory to match where the files are actually created?

>  F:	tools/testing/selftests/bpf/*/memcg_ops.c
>  F:	tools/testing/selftests/cgroup/memcg_protection.m
>  F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19486904708

--===============5091828915502704464==--

