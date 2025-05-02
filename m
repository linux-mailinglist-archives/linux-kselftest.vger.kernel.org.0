Return-Path: <linux-kselftest+bounces-32227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A6AA7B34
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE89177D5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190D1F2C44;
	Fri,  2 May 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExgqAER2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90315376;
	Fri,  2 May 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219647; cv=none; b=phzoEtbcGEGn3mUDUBB7FwD/KfaAWIwxUUTuIKSBWSpeiufcXldLRtVGCIur6591Hm9az0EGrbVAAXAo1besStUOWwAQwktSGpkEJbDxHBCOcX/ACqL45TGQ2W+T8LF56OcdBKha0BKJD32TvmjRkCNaIksPQkfR7KP/NkvjiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219647; c=relaxed/simple;
	bh=QV74l1IOGVbOqoSkpgRlO6NEjTmym0E/wjU2qkQ32fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO0Zaakx+DGRRTjtd+4TylIF+aoWeOynM2ZrvbgROptKx2KbvkZMV5B6R0SDbL1L63EJuIGE5f+RbFgh1B4t3B8Fw4yNcCuaudHf3EIFNmTCl6YwQha9XUu3tsNJnZmFecTN8i4ECzrpt4KRS1/cLZQ0dzWbsMk5XzYY3pkIpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExgqAER2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCBAC4CEE4;
	Fri,  2 May 2025 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746219647;
	bh=QV74l1IOGVbOqoSkpgRlO6NEjTmym0E/wjU2qkQ32fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExgqAER2CsxrCnnAMm6jRg6gINgp9LGlOtbpHezQgKA+SlqChKBhWB5JTT3F8BKcz
	 WyBu8J75GKcBiBoM493HVF8pnLHXaYp6WJzC0Sbxf8kv72/jKkJsmWg37D3/E6DH9x
	 AVMJ/pp3eIG8LdZs9D/W1CiAOFAC3NhB8+3+QS2zaYnHn+HpmNaNfYeALRPcqkW/8K
	 dVgYMpGiSWtxAIENr8F9WMYO1YCTIdNL3WBIxgpMQPFCzktf4xO/PaZtyphqAiNU9n
	 3OzuLYfo5zx6WMa/dh7nLZo3pf9Love+B/Ys5wJLPmSUhMMraXMrOReDrSZuvwz5Li
	 L/yI/DomKf2lw==
From: KP Singh <kpsingh@kernel.org>
To: bboscaccy@linux.microsoft.com
Cc: James.Bottomley@hansenpartnership.com,
	bpf@vger.kernel.org,
	code@tyhicks.com,
	corbet@lwn.net,
	davem@davemloft.net,
	dhowells@redhat.com,
	gnoack@google.com,
	herbert@gondor.apana.org.au,
	jarkko@kernel.org,
	jmorris@namei.org,
	jstancek@redhat.com,
	justinstitt@google.com,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	mic@digikod.net,
	morbo@google.com,
	nathan@kernel.org,
	neal@gompa.dev,
	nick.desaulniers+lkml@gmail.com,
	nicolas@fjasle.eu,
	nkapron@google.com,
	paul@paul-moore.com,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	shuah@kernel.org,
	teknoraver@meta.com,
	xiyou.wangcong@gmail.com,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
Date: Fri,  2 May 2025 23:00:34 +0200
Message-ID: <20250502210034.284051-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch series introduces the Hornet LSM. The goal of Hornet is to provide
> a signature verification mechanism for eBPF programs.
>

[...]

>
> References: [1]
> https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/
> [2]
> https://lore.kernel.org/bpf/CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com/
>
> Change list: - v2 -> v3 - Remove any and all usage of proprietary bpf APIs

BPF APIs are not proprietary, but you cannot implement BPF program signing
for BPF users without aligning with the BPF maintainers and the community.
Signed programs are a UAPI and a key part of how developers experience BPF
and this is not how we would like signing to be experienced by BPF users.

Some more feedback (which should be pretty obvious) but explicitly:

* Hacks like if (current->pid == 1) return 0; also break your threat model
  about root being untrusted. This is all the more reason I think signing
  should be integrated into other LSMs, only a proper LSM policy can breathe
  life into the root / kernel boundary. 

* You also did not take the feedback into account:

   new = map->ops->map_lookup_elem(map, &key);

  This is not okay without having the BPF maintainers aligned, the same way as 

  https://patchwork.kernel.org/project/netdevbpf/patch/20240629084331.3807368-4-kpsingh@kernel.org/#25928981

  was not okay. Let's not have double standards.

* And you copy pasted tools/testing/selftests/hornet/frozen_skel.h which
  is what you expect users to do? Not acceptable either.

So for this approach, it's a:

Nacked-by: KP Singh <kpsingh@kernel.org>

Now if you really care about the use-case and want to work with the maintainers
and implement signing for the community, here's how we think it should be done:

* The core signing logic and the tooling stays in BPF, something that the users
  are already using. No new tooling.
* The policy decision on the effect of signing can be built into various
  existing LSMs. I don't think we need a new LSM for it.
* A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/bpf.h in
  the BPF_PROG_LOAD command:

__aligned_u64 signature; 
__u32 signature_size;


