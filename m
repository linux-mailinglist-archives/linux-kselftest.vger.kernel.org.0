Return-Path: <linux-kselftest+bounces-48023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52ECEC47E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 763BD30024A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1622D780;
	Wed, 31 Dec 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Q1BmDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEF18AE3
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199585; cv=none; b=Go6GLzD+LwFRhKkOWkDJ5FcJwFOQ8OxymJQBHw1Cq+jxdNyJp8NQc8CnKijaVIeEx6NiRzMEguoIWqmFZViHsgaDEqw827LtBU5jfVc+Lnt7OBTNzO/Pfi3QdJ3SwWJntuIDuiE7lJ317VWGho1hkRo6y50iXqH+GZ1fKLB8PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199585; c=relaxed/simple;
	bh=S5FrASt+YDKWNZTWLUxIzOWqzcCixdTDssK3Do4Djq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnGtYvnr/jM4pAGlelTZHWZ9uKAOFZ22UsBxZTlJgQij+/1FuHok/O38AObRvQYuIp2fIwz2i9P82DjOPI450vvcvuAJB/9IBeiUmvFqWnXWVk+LamVvDlolSIdBrlYUXFmTlr1tZOZgvP/sJNWp5ILJyCKB2h0eaUe5flSL1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Q1BmDM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so4460944f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767199582; x=1767804382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZrBM1S9/mxya9NEItGvHC9zqInI4GbMnOrymniIuV0=;
        b=G1Q1BmDMKbX7g78zGbvE/BS3EyjdsuMPNj8ivgdxbJI7nFxeTC8KVADUhevyBUNU+f
         IYZvlcbRMA2B+/5QaMeoYW+sLoC6PBNLxnOBA9BfPJoJKlEUdji5ZuAUQhIhelhm3mxP
         BI8ucvNNk9NtNjhXekJbhWJS4lc8x7LjhethExRLiRMTa0YOGys15e/UQGJKo40sgulp
         AafCsCLyOWg4nQoEQtW0zyqcwvrSpae5Jk6rTbpb3VetuwLLr7L4v9Qf58UfgCR3UOHC
         HFQFjNmSod0z5SIQ0D5CMB0eVGE8t3qtsn6ZGSza6jb+kllpFCfbPKPmCJJFmcqOk+Qx
         i19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767199582; x=1767804382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZrBM1S9/mxya9NEItGvHC9zqInI4GbMnOrymniIuV0=;
        b=BlvNE4skwJew8V7+vkSuTLhBQwsg76MgvRC7re4f2k8qbKrwnafiWUiMFZKTHp3M1O
         W3jdBYyVpL31+OhznPpFasakYDdT8ip+xV2no4uWJJdx5Msh9kQOQ6glMGzdP/8aPKSW
         yqDrxDGPFfP5S1l2th9vMwI4b7S0GJ0d8Jb6VhqZ6miX0NzhpNNbkQ+xz/ufD5OMRFvT
         vPELxV3hC9SNbksKvkhHAXxFYENIR3DX60sjiOx92U++bCk74aGVH3dB/gNeb9lxIS3I
         7O4fGqvwFAJvLbNAAchXo/PpI0sbRIEj2i/XILRGraDdKJ4rxvAFvBPhGVeD9CIqu9+d
         ueUA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQQTqAPAHgbNm2olxNcsaTT7bCc76evtXoc9VmzGjkTQsjcq81YtJBEOO2MMv0o0l3L97obf9OtZ9Vcr8W1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwdau7YLbfVAKPo9iNVB71gNmjXS8MjwFwRwyyYOte8fn66Aa
	ot5/a6VWd9afTxkrHlZ1QzgIwNmMYASTgyxxDtyn+m18zpKvukV9DXTNgnqmE9ntJjczQF4Efl1
	rfqvAEKgKq6qP6HJG3smPLyFAX2xHvXY=
X-Gm-Gg: AY/fxX6WxOQw6p0aqj/2/UN4WPUkY6ULB0P+kxM3/V5/7+BXEd7EYkY8KWPkv1R6uF8
	1LbqOLP7kdw8jaFEZ+grpFdf94ExN1pO+kGfOyNj2ivCBtvlwWXtmbcn6YYDl6NrO6be5qVqoBl
	/ruiT4gDxG8IlFSd8K8gH4FE0J0cECItB9yF+NILyVtLwHf85HbIKC7k6FSmByixXaaxyn+mZb5
	C1hHQXqwMtE1lDEN39oN4ZfHxNgdUoAuMnZszR0z+LUnaOUMdQMlKYGN/CbeiKjix52q88iadAb
	A8NxYY+WjBafw6i7jifhPvz8/zRq
X-Google-Smtp-Source: AGHT+IFRcWZVoxPPY6i1WyZlhvMd8V51vC8I4ra0MIHhsEDMgQUIBj25Y6d8K/+d1Lb6vZ8sZiVoaWZQKphbtFDOWsE=
X-Received: by 2002:a5d:68c5:0:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4325bf9d091mr34543547f8f.5.1767199582223; Wed, 31 Dec 2025
 08:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231163329.4831-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20251231163329.4831-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 08:46:11 -0800
X-Gm-Features: AQt7F2prI8DvYiKhoVc-rKAAMki7kJ7gPtmB6oFWzCNLzBOKRRGRMGSAHJUKNpo
Message-ID: <CAADnVQJm8xoxbuq3Lck3Yen2k9KOQoQFd9e2UTyL-cH4fEaJbw@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: fix missing declaration for bpf_copy_from_user_task_str
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 8:33=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> Clang BPF compilation fails in bpf_iter_tasks.c due to an implicit
> declaration of bpf_copy_from_user_task_str(), which is a BPF kfunc
> exported by the kernel.

nope. It's there in vmlinux.h
Fix your build setup instead.

pw-bot: cr

> Add an explicit prototype in the test program to make the kfunc visible
> to the BPF compiler and fix the build error.
>
> No functional change intended.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_iter_tasks.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/t=
esting/selftests/bpf/progs/bpf_iter_tasks.c
> index 966ee5a7b066..f5f396b5aa27 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> @@ -4,6 +4,11 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> +extern int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
> +                                      const void *unsafe_ptr,
> +                                      struct task_struct *task,
> +                                      u64 flags);
> +
>  char _license[] SEC("license") =3D "GPL";
>
>  uint32_t tid =3D 0;
> --
> 2.43.0
>

