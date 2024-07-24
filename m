Return-Path: <linux-kselftest+bounces-14186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2AB93B99D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 01:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1AB28563F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F51465B8;
	Wed, 24 Jul 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaDjDJxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F51448D8;
	Wed, 24 Jul 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864745; cv=none; b=LGBAAbFTV6hzfyVU4lLeC9q6Z91Pfkyd2Cwr+KOW4MNAp4E0+SdYeTx4z8M27IurJFxRkimhY+gZ8jjlP7WzNfSHfq6lvK5P1TbyCARKS7D8TxYVPSCzgP0TCiZKgqehdzoWpQ2Nw6kNymQtMbmj2ph0ft32zt1w271HAAgqlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864745; c=relaxed/simple;
	bh=nNcBK3qqEYrdakNaMVEX+EivAObu7UdW6tkB+jSYi+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJS0XC0AT/CjE3gO9N0wyhqXeSL8Z38kSO0X4axDG6clYO+AHjSWldlXMlYyN5KfPEtjy12BTeDdq3IvV5nEe5LwICGo/BPat/ThwbYXR0tMjMMdKMw1Oy6I3PXhuiyjbB7x0J0gIRVbM5Mw+bJtxk4tSeV/8XlyoSGkM24AmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaDjDJxJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f0277daa5so367188e87.0;
        Wed, 24 Jul 2024 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721864742; x=1722469542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VLjYFJOVqIG6dOIagIMyW+U6kIxFZ+21WyGDVoW0F0=;
        b=VaDjDJxJQPCXbMlX+GyWcV1Y5JNqDaEbAcW4TOzIDTGqw5lUisluA+qkPz+vLZHmKG
         HOqP+tmp12PY7o/UgPYfAVTy5RoYZAlbHuJlPiH2+WkSKSYQnZClV9yNdwSDjNtmyqWG
         Ex6FT2HuAHmtwmQvl8yusJvkhXXlGCIoZSyBrMNbDEBr187mQAKFTBCdTeInasYZ/285
         lWvCGp3Qjs3XrVRSnGnoq6TmBYucipU8NMYnQfdG0KtJvaRordRpCLKDZ4VMVbvSsRuu
         EwTfjkh5xsAJg2ORoCXC+bG7eEHxL4mTKQq48MfW+wP2gCwjvUNQ5Y/90AxTbPMRRVwr
         1euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721864742; x=1722469542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VLjYFJOVqIG6dOIagIMyW+U6kIxFZ+21WyGDVoW0F0=;
        b=e0+VZbOn9bSYniB+cc5MXrDZEG4H2etYwWRtroWN1/dOc7Y43Q5IIIu5kozjtc5VMq
         1m6/2f6z53K4LC+BTbo5REmxVr8GuFhQ1gFu/yU3dTjraWE8pxJ+oKySQSl2uMr6EzN5
         mnCRLBNgZ6AsUVijtamBJZN5hsYZQUwqDaFWt0S3eSdCagcYckuR4zaP5heCeWArbX/Z
         EsrDcmhvdM0jJlpESQrJzwUVlzx2qJhUVyVttZLZVwC7UDRhECVTx2kQWkZ9D9SIO8+p
         ua0iwcUc5oUzZV1d9FAN9YQTYqrEVvXsdcGC5xV0RFEFQguJxPBecYTxG7ZROrcp45Dh
         8dWA==
X-Forwarded-Encrypted: i=1; AJvYcCXH18+lM4oXOmHXBqDIi868+DmUlA/bdseRt80fKZf0Tarfs800CR59vEEbO44ek3bn1NqLXVQ9jbkR2H8frLsMz1MAWMfLnXKuJkMUCoQImPwFJRe5H+VK5eHai8zIq/QpGoFZ
X-Gm-Message-State: AOJu0YwoBuDulM5q8418bjIdEtS0cYiO6M3IZOG+zOeWPHRunKDTg9YB
	JQZpSGVCYa21D3F/oGs6WveebzipbqO6OYAZWzH1GxvrBWolDsl+Eftxqe3C4mHXl8U84ICr8KW
	URjbhf4mo/cUvk64a33A4xPh+7EB/FA==
X-Google-Smtp-Source: AGHT+IHZ3R4WLYBqBoCs3Ri8/kmIbWMrdsgvuKZdoxEyiQZoD4QYvLoZA/ySu3dLnen6fv/DcaTFxXkX2vF++TTpDQI=
X-Received: by 2002:a05:6512:1193:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-52fd60407ecmr101623e87.35.1721864741414; Wed, 24 Jul 2024
 16:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721713597.git.tony.ambardar@gmail.com> <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
 <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>
In-Reply-To: <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 16:45:25 -0700
Message-ID: <CAEf4BzaQP=Rs5zNOJPka2xYw=9C5FeNu4UjDuVDgCMHtccUDvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 19/19] selftests/bpf: Fix errors compiling
 cg_storage_multi.h with musl libc
To: YiFei Zhu <zhuyifei@google.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yucong Sun <sunyucong@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>, 
	Carlos Neira <cneirabustos@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Petar Penkov <ppenkov@google.com>, Willem de Bruijn <willemb@google.com>, Yan Zhai <yan@cloudflare.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:35=E2=80=AFPM YiFei Zhu <zhuyifei@google.com> wro=
te:
>
> On Mon, Jul 22, 2024 at 10:56=E2=80=AFPM Tony Ambardar <tony.ambardar@gma=
il.com> wrote:
> >
> > Remove a redundant include of '<asm/types.h>', whose needed definitions=
 are
> > already included (via '<linux/types.h>') in cg_storage_multi_egress_onl=
y.c,
> > cg_storage_multi_isolated.c, and cg_storage_multi_shared.c. This avoids
> > redefinition errors seen compiling for mips64el/musl-libc like:
> >
> >   In file included from progs/cg_storage_multi_egress_only.c:13:
> >   In file included from progs/cg_storage_multi.h:6:
> >   In file included from /usr/mips64el-linux-gnuabi64/include/asm/types.=
h:23:
> >   /usr/include/asm-generic/int-l64.h:29:25: error: typedef redefinition=
 with different types ('long' vs 'long long')
> >      29 | typedef __signed__ long __s64;
> >         |                         ^
> >   /usr/include/asm-generic/int-ll64.h:30:44: note: previous definition =
is here
> >      30 | __extension__ typedef __signed__ long long __s64;
> >         |                                            ^
> >
> > Fixes: 9e5bd1f7633b ("selftests/bpf: Test CGROUP_STORAGE map can't be u=
sed by multiple progs")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/cg_storage_multi.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/too=
ls/testing/selftests/bpf/progs/cg_storage_multi.h
> > index a0778fe7857a..41d59f0ee606 100644
> > --- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> > +++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> > @@ -3,8 +3,6 @@
> >  #ifndef __PROGS_CG_STORAGE_MULTI_H
> >  #define __PROGS_CG_STORAGE_MULTI_H
> >
> > -#include <asm/types.h>
> > -
> >  struct cgroup_value {
> >         __u32 egress_pkts;
> >         __u32 ingress_pkts;
> > --
> > 2.34.1
> >
>
> Hmm, some linter checks prefer headers themselves include everything
> they use. This header uses __u32 and after this patch it would include
> no headers. Would it be okay to include <linux/types.h> or we don't
> care?
>

This header seems to be included both from user space code and BPF
code, so it probably is for the better to not include specific headers
and rely on respective code to provide "basic" type definitions like
__u32. (For BPF side they might be coming from vmlinux.h, for example,
which won't be compatible with anything included in user space code).

> YiFei Zhu

