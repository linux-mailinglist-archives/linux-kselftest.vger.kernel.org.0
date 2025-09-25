Return-Path: <linux-kselftest+bounces-42359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E8BA0906
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AB93A7324
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7F304BA9;
	Thu, 25 Sep 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Y+Ovmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA91288C26
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817119; cv=none; b=Cdr55djtVnDCFeAHEGyedOzlUvLEQ9IrANF2qveq4+UQJWsnhHpRwcxMF9nm6Vp9CVpJJUWGf70gFxDUUacOX853B1VVwCEY0Q9Yx4bGflQmjGd+GpxUjaj6st+T+WPDQLTTnEe+NnxbhtTo81Z5Fdnrh8clWM2696o/XVf57RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817119; c=relaxed/simple;
	bh=B39erYFu+IADpwH47mN8zsMtIScBC4vuaTnziuWPKH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMHVYJ30GdrkQIGGNPOf2pKseO+/z01I2uujNj7KcKsNnJQRTbmB4Y5vATUhLpLoGwKC1fxpDK8qejlbNhliW/cmOA61YLf7f0swjAdOVpG5VXYq8ZDON8FIUzx0eS5EO1aJfxAAZSelwsJWtxQLC8oaycYbo/k+jo3vf4/2IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Y+Ovmr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b33d785db6fso228819966b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817115; x=1759421915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5xevkUUTmwlKwAyY0Wx9nWf1Int/iLI6fP1YJUNaVA=;
        b=B5Y+Ovmrra4dXWKtLm3K9PZye+O1v3ro5Woqt6BD9MTX+kd1cohHm7vFQ2j9BQoqfq
         p6ViAsWDFlSl9KWe0jcJwC5t2dt0mi4U6cggvfyKnn6Di1BAPd21rvjUtz+eS25X7cEO
         sLERZjRHjXqlHGWWMjuC7QmJzm7U2V0wya74o+AvvUdTfhs1gx1eStrw5uPKz6LS+7/z
         pwB4zKDNXyUacCYpo45re0vOyqfQGsFHZNKICjNQYln3yY87wEcW2UUWFwALkvK5v/xU
         /Cd/mSJy9hGqMXGkUHE2rNf5Uu+YHrNpPRoMGeMXFnPf3csH2YT3rIAKXfCGXrOy1y5r
         Dhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817115; x=1759421915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5xevkUUTmwlKwAyY0Wx9nWf1Int/iLI6fP1YJUNaVA=;
        b=AkBBAMNVx41Bs3BZbpQdSK/Z8Fs0x8YOeGrkDEQkK0IIa42iDg6WM3rGKyhegp9LRV
         gow9+6Zp+BoAaTOiQP5D1JIZv2Cm+1Ny7UkTX7BONXY8Lb+eSN7zHQXegvTFh1VhaKbA
         6C6yXmsnlQg4y7xyNzR6d/IM/pSA161LPTVfm1mB1UfzBb47Hd+BJ+qQUOVHwVYYhhK6
         LgynSirWg9HdGOPAmrxqZqqo/w9qVe+fJCKZS4s5OQfylrVyRhTw6Dl7D9i7WEXtd5me
         9z4HDHYiKofCEnslWI7Hv5msMwZzFYWaMm4H5LYLl8NUrTQtXvdDfv3GJ1xxa9Dk/s7J
         lLeA==
X-Forwarded-Encrypted: i=1; AJvYcCVC4d0aQeeu3AvgNrgrhFFjQHxn7cdbJtLzp6NIKgaD/Z91CsaiU9ZJ946x7KhXwuJtH0gYugL1perEKUdT+Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/O2tGcVifHZV9gcUgOE1JHf70HjR8tvUyyBn7aTHjkZfjbUZ
	qIe/kGM8Rj2YzKF8VUYE+Q2+fJr3TDCSlSPjMQFIzbuqpugfzQKYYQRj4xmAXG7uYH+FYHdeQ7m
	H19HDgRNaKZM/5k+/lKJQDsnmH00CJIE=
X-Gm-Gg: ASbGnct5E0yJx7znHjADBEfnPxZrZ0cK6TUM9lfnnsaDbXbdaZTDt/pR0JcIujt5Wh6
	Llu1Fru1zRMEUZoys3OqHKR+6yvqZXS8UBKkAW2R4IrSsKQTPzWgJUm+gnbd02ovzGVvkELmvtw
	CW/jiYdkp/2FPXGU4Vfo4aM7cDIwav1sBnW55RdrVCx6v7E8VKYoCIrftJ+GjRATUAyr3a1hkze
	bXxYFXpeY0Pel9iUr4RgM9eDgmAp4aS+E802tN09VaPp9HKFaU=
X-Google-Smtp-Source: AGHT+IFwv2YwsWAIKIDmxsrJN0NY39IA3xgFkg9Xv9DM8KA1HxgqMZQFSM1VnRv5Sj5R14hL06ntb/V9/P6xF1NLvs4=
X-Received: by 2002:a17:907:720b:b0:b2a:7f08:23da with SMTP id
 a640c23a62f3a-b34bbebe2f0mr416672066b.56.1758817114676; Thu, 25 Sep 2025
 09:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com> <5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@iogearbox.net>
 <4b77c830-2a7d-444a-adeb-4d1370f8923f@gmail.com>
In-Reply-To: <4b77c830-2a7d-444a-adeb-4d1370f8923f@gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Thu, 25 Sep 2025 21:48:22 +0530
X-Gm-Features: AS18NWDavCeJ5JOczMPLBfdxzac54ktOAMOZM_aUlp9EmmRHO_1O8MKFqbGzkPg
Message-ID: <CABPSWR7_w3mxr74wCDEF=MYYuG2F_vMJeD-dqotc8MDmaS_FpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf tests
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, 
	ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com, 
	emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com, 
	a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com, vmalik@redhat.com, 
	bigeasy@linutronix.de, tj@kernel.org, gregkh@linuxfoundation.org, 
	paul@paul-moore.com, bboscaccy@linux.microsoft.com, 
	James.Bottomley@hansenpartnership.com, mrpre@163.com, jakub@cloudflare.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,
You are trying to do much with the patch series. I don't think it will
help much as reviewers will give comments and you will revise the
patches. This loop will continue forever.

I totally agree with Daniel. Please write a proper commit message.

While writing a commit message or creating a patch.Please try to give
the answers of the following questions.
1) What is the issue which your patch resolves?
2) Are you trying to do more than one thing at a time? Please don't.
3) if a patch modifies more than one file then either these changes
inter link with each other or they have similar kind of work.

~~Vivek

On Thu, Sep 25, 2025 at 9:04=E2=80=AFPM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> On 9/25/25 4:04 PM, Daniel Borkmann wrote:
> > On 9/25/25 12:35 PM, Mehdi Ben Hadj Khelifa wrote:
> >> -Change only variable types for correct sign comparisons
> >>
> >> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> >
> > Pls write some better commit messages and not just copy/paste the same
> > $subj/
> > message every time; proper sentences w/o the weird " -" indent.
>
> Understood, though the changes are very similar / are the same with the
> same goal that's why it made sense to me to do that and I will remove
> the - in future commits.> Also say
> > why
> > this is needed in the commit message, and add a reference to the commit
> > which
> > initially added this as a TODO, i.e. 495d2d8133fd ("selftests/bpf:
> > Attempt to
> > build BPF programs with -Wsign-compare").
> I will do that in the upcoming version.
>
> > If you group these, then maybe
> > also
> > include the parts of the compiler-emitted warnings during build which a=
re
> > relevant to the code changes you do here.
>
> Okay. I will do that. Should i send a v4 with the recommended changes
> but not including the rest of the files meaning the ones that I haven't
> uploaded in this patch series which contain type casting or should i
> just make changes for these files in this series?
> Also will it be better if dropped these versions and made a new patch
> with v1?
>
> Thank you for your review and time Daniel.
> Regards,
> Mehdi
> >> ---
> >>   tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
> >>   tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
> >>   tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++-=
-
> >>   tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++-=
-
> >>   .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++=
--
> >>   .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
> >>   6 files changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> index 67a77944ef29..12ad0ec91021 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> @@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md
> >> *xdp, struct bpf_dynptr *xd
> >>       struct vip vip =3D {};
> >>       int dport;
> >>       __u32 csum =3D 0;
> >> -    int i;
> >> +    size_t i;
> >>       __builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
> >>       __builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> index 93267a68825b..e9b7bbff5c23 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> @@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md
> >> *xdp)
> >>       struct vip vip =3D {};
> >>       int dport;
> >>       __u32 csum =3D 0;
> >> -    int i;
> >> +    size_t i;
> >>       if (iph + 1 > data_end)
> >>           return XDP_DROP;
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> index fad94e41cef9..85ef3c0a3e20 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> @@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value
> >> *cval,
> >>       next_iph_u16 =3D (__u16 *) iph;
> >>       __pragma_loop_unroll_full
> >> -    for (int i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >> +    for (size_t i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >>           csum +=3D *next_iph_u16++;
> >>       iph->check =3D ~((csum & 0xffff) + (csum >> 16));
> >>       if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
> >> @@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
> >>       iph->check =3D 0;
> >>       next_iph_u16 =3D (__u16 *) iph;
> >>       __pragma_loop_unroll_full
> >> -    for (int i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >> +    for (size_t i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >>           csum +=3D *next_iph_u16++;
> >>       iph->check =3D ~((csum & 0xffff) + (csum >> 16));
> >>       return swap_mac_and_send(data, data_end);
> >> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/
> >> testing/selftests/bpf/progs/uprobe_multi.c
> >> index 44190efcdba2..f99957773c3a 100644
> >> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> >> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> >> @@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result =3D 0;
> >>   __u64 uprobe_multi_sleep_result =3D 0;
> >> -int pid =3D 0;
> >> +__u32 pid =3D 0;
> >>   int child_pid =3D 0;
> >>   int child_tid =3D 0;
> >>   int child_pid_usdt =3D 0;
> >>   int child_tid_usdt =3D 0;
> >> -int expect_pid =3D 0;
> >> +__u32 expect_pid =3D 0;
> >>   bool bad_pid_seen =3D false;
> >>   bool bad_pid_seen_usdt =3D false;
> >> diff --git a/tools/testing/selftests/bpf/progs/
> >> uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/
> >> uprobe_multi_session_recursive.c
> >> index 8fbcd69fae22..017f1859ebe8 100644
> >> --- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive=
.c
> >> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive=
.c
> >> @@ -3,6 +3,7 @@
> >>   #include <bpf/bpf_helpers.h>
> >>   #include <bpf/bpf_tracing.h>
> >>   #include <stdbool.h>
> >> +#include <stddef.h>
> >>   #include "bpf_kfuncs.h"
> >>   #include "bpf_misc.h"
> >> @@ -10,8 +11,8 @@ char _license[] SEC("license") =3D "GPL";
> >>   int pid =3D 0;
> >> -int idx_entry =3D 0;
> >> -int idx_return =3D 0;
> >> +size_t idx_entry =3D 0;
> >> +size_t idx_return =3D 0;
> >>   __u64 test_uprobe_cookie_entry[6];
> >>   __u64 test_uprobe_cookie_return[3];
> >> diff --git a/tools/testing/selftests/bpf/progs/
> >> verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/
> >> verifier_iterating_callbacks.c
> >> index 75dd922e4e9f..72f9f8c23c93 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> >> @@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ct=
x)
> >>   {
> >>       struct bpf_iter_num it;
> >>       int *v, sum =3D 0;
> >> -    __u64 i =3D 0;
> >> +    __s32 i =3D 0;
> >>       bpf_iter_num_new(&it, 0, ARR2_SZ);
> >>       while ((v =3D bpf_iter_num_next(&it))) {
> >
>
>

