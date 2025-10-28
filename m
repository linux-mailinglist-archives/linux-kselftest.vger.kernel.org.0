Return-Path: <linux-kselftest+bounces-44190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB849C159C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F7C1B2255D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CD33507A;
	Tue, 28 Oct 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcvh7iOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070A2EB10;
	Tue, 28 Oct 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666361; cv=none; b=AMzP1VDCtlLmn1aJgPTV0r9zcHNnzBCC6qgn6DZ9GBRK/7DyJ6W4aN+aY8jcjNqwakFznmmSWiMCkCfgFszWRWnXk4YV/bKu+Nslp3MLLxPoO4z6X3mSWOIwWbviHwwM2jbgx3bAq9okpNJdv5ToilicvrV7zz9sZpvprHpY14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666361; c=relaxed/simple;
	bh=VTIxz/3zuddnuEaQ1nt5lKaeq5iypJAyx2SFwKpH2sM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fj66jKhvY8DGS++eazBJ8KGSGb/bLY/5CYM9LntII/gjk00s5l/W/HpER2hd1rejRsD88TXpsc0ep+6BOycMm+zXHH1MYzuYj6g9ek5/PpBt/KN1CPbg5h6HALKqeIXGHGFFVt/DoHnvtK+2ZFMpVJAJHD1CHuyfZmrOwXNGnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcvh7iOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3F3C4CEE7;
	Tue, 28 Oct 2025 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761666359;
	bh=VTIxz/3zuddnuEaQ1nt5lKaeq5iypJAyx2SFwKpH2sM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Dcvh7iOmr67fDH1BuTJlUAHGq5otYqLXrHQUHdfMWbY4IrE1wciHif3Xc7EYivL2e
	 7OwZlsTGPRTZVHINgK+5lgbxbSgGzsNXugvghLtTScXWUVteA/to7AhmkldUePrtCs
	 mB1/yN2h+8bFm9Cg8xnItVcXfYKTf54yNYN+t4WrrvfgWwMEZTxrJumjsfb5iMTl1i
	 dAW09yT7lVIRZUn5/RlSHMLBXF2AUD4XvCwnN/lXuyg4XjxbGAFszVP70WJOxI1dfu
	 zrY57hX6putPBXlB6UoHmvaPv3eY2nTnEq2sikCmA+4SPs7R52Bwzp95+Nk16GBH63
	 uu/e14EMKN5Vw==
Content-Type: multipart/mixed; boundary="===============7624904711199010423=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
In-Reply-To: <20251028151938.3872003-2-kafai.wan@linux.dev>
References: <20251028151938.3872003-2-kafai.wan@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix tnum_overlap to check for zero mask intersection
From: bot+bpf-ci@kernel.org
To: kafai.wan@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,paul.chaignon@gmail.com,m.shachnai@gmail.com,kafai.wan@linux.dev,harishankar.vishwanathan@gmail.com,colin.i.king@gmail.com,luis.gerhorst@fau.de,shung-hsi.yu@suse.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 15:45:57 +0000 (UTC)

--===============7624904711199010423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 16cbc4520eb13d2065d145c76b97fb93035d81e8
Author: KaFai Wan <kafai.wan@linux.dev>

bpf: Fix tnum_overlap to check for zero mask intersection

This patch adds an early return check in tnum_overlap() to detect
non-overlapping tnums when their masks have no overlapping bits. The
fix addresses a syzbot report where the verifier failed to recognize
that two tnums couldn't represent the same value.

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com

> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index f8e70e9c3..1a75b7c9a 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
>  {
>  	u64 mu;
>
> +	if (a.mask && b.mask && !(a.mask & b.mask))
> +		return false;
                              ^^^^^

Does this logic correctly detect non-overlapping tnums? Consider this
counter-example:

  a = (value=0x5, mask=0xA)  // binary: value=0101, mask=1010
  b = (value=0xA, mask=0x5)  // binary: value=1010, mask=0101

The masks are disjoint: (0xA & 0x5) == 0, so the new check returns
false (no overlap).

However, these tnums actually represent overlapping sets:
  a represents: {5, 7, 13, 15}  // 0b0101, 0b0111, 0b1101, 0b1111
  b represents: {10, 11, 14, 15} // 0b1010, 0b1011, 0b1110, 0b1111

Both sets contain 15, so they do overlap. Can this cause incorrect
verifier behavior when is_branch_taken() calls tnum_overlap() to
determine if JEQ/JNE branches are reachable?

>  	mu = ~a.mask & ~b.mask;
>  	return (a.value & mu) == (b.value & mu);
>  }


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: Fix tnum_overlap to check for zero mask intersection`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18880108453

--===============7624904711199010423==--

