Return-Path: <linux-kselftest+bounces-13735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EE93187B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B96AB228F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EEE1BC41;
	Mon, 15 Jul 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHWSKDeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ABA17BB5;
	Mon, 15 Jul 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061123; cv=none; b=OpFWyZ/RYGAcbu+psKeMu57j+ou/p74XvgJMV8ejzslbId2zwi1E/JmdlOngpbYb14aZj1X1ngktw1JmtfodBnpFoYOnOEbQaqF1fb3FPNv3/t1mB/4AS/y5RC9KqocKG7sc/K6wK0BKSZJjL/jgGF6u2HmotbnR/T8xGebbyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061123; c=relaxed/simple;
	bh=QZ3Wmdv3G3ky6kIqGg3OLlwTgVdK1xs399MU5UVji1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=liOjafEy1irXc5+Epzb/nM1BUyOlbah24Y0/aJOpItoqF4mb9kfLw8fWQS5izuqxbi1X7zzw4dqkGd2lfquuOzz7Yk3635nBRw4NNdNiaKl/xdzJFL/hh4rSVsDgG1k48YqJQeoA5mP5u72QiwnAcy7aTfj10Fvn59pkTfxvask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHWSKDeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA2FC32782;
	Mon, 15 Jul 2024 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061123;
	bh=QZ3Wmdv3G3ky6kIqGg3OLlwTgVdK1xs399MU5UVji1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NHWSKDeRhZvip2iN9c4hYBO03UuD90bYHDHVFiwHVO2dSgwKIyywUHubpSvEZENl1
	 yLZRkMwFjBzk/fIxG8atKkpbQlzErXoB7T7xz7M/xdUkD4NNOZga3/OjH0zEDcTTMh
	 yvtD/47Um/2+SrmrVvfRVj/2vMav+eZprEdtxMHen7ZhIgugxKFHKQqY8LCjqPTBKe
	 nsfYt5QTqpcXLK9RVkp0Wo1DTu6MZ5krOPOSaaxv94SpS48cm7SX7WpXJS2LLApsNn
	 INT0ZV76Q+J4x1cUnNDUN9wqX0u/6ifgdR4pAvq3oyWMHHYmEezQADxZGpYg5+7Bj1
	 L9sgPAehWComQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, Manu Bretelle
 <chantra@meta.com>, KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov
 <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent
 Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org>
 <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
Date: Mon, 15 Jul 2024 16:31:48 +0000
Message-ID: <mb61pjzhmpqff.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain


Hi Daniel, Manu
I was able to reproduce this issue on KVM and found the root cause for
this hang! The other issue that we fixed is unrelated to this hang and
doesn't occur on self hosted github runners as they use 48-bit VAs.

The userspace test code has:

    #define STACK_SIZE (1024 * 1024)
    static char child_stack[STACK_SIZE];

    cpid = clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIGCHLD, fexit_skel);

arm64 requires the stack pointer to be 16 byte aligned otherwise
SPAlignmentFault occurs, this appears as Bus error in the userspace.

The stack provided to the clone system call is not guaranteed to be
aligned properly in this selftest.

The test hangs on the following line:
    while (READ_ONCE(fexit_skel->bss->fentry_cnt) != 2);

Because the child process is killed due to SPAlignmentFault, the
fentry_cnt remains at 0!

Reading the man page of clone system call, the correct way to allocate
stack for this call is using mmap like this:

stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);

This fixes the issue, I will send a patch to use this and once again
remove this test from DENYLIST and I hope this time it fixes it for good.

> It looks like there is still an issue left. A recent CI run on bpf-next is
> still hitting the same on arm64:
>
> Base:
>
>    https://github.com/kernel-patches/bpf/commits/series/870746%3D%3Ebpf-next/
>
> CI:
>
>    https://github.com/kernel-patches/bpf/actions/runs/9905842936/job/27366435436
>
>    [...]
>    #89/11   fexit_bpf2bpf/func_replace_global_func:OK
>    #89/12   fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
>    #89/13   fexit_bpf2bpf/func_replace_progmap:OK
>    #89      fexit_bpf2bpf:OK
>    Error: The operation was canceled.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZpVO9RQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2ndCwAP426bH2FCxvf7CjZ7hpQC8VBiIhqBjX
2TGu3R6J0jdmxAEA6SBP35Ixr7WsBoeK/1CFP5Rzkfi9ASb9QBiz10Qqcw4=
=rXzp
-----END PGP SIGNATURE-----
--=-=-=--

