Return-Path: <linux-kselftest+bounces-8263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CFB8A8991
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5971C237C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AA171E60;
	Wed, 17 Apr 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5cBF2ud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6F171E41
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373219; cv=none; b=aHXFGY68DQXIe55ztM7ATytzPPeBjW/4u8AweoRWTlPXhl06y+RUzbiPbjqtI9WI1Ds1YxglxKmUFlTzNAFYwDZh21DqZQHFHgcMEghY4Lz4xGmJc6Hr1PbF1T8g6lkUV43fACeIscxT54PiKc35HkBkUGCJhctYT2zQysh3vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373219; c=relaxed/simple;
	bh=56tOu9eUB47d8KPYjjK51a05MyD+g5MwMnzZxCMBDX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2Hg1Vg0ZXUSuM9VqGOSsyDEckuDs8G6o/xQsHtfMHKzgf/VBO9QfmKY18YvnqwT+ZQWBxYWVqD8EDiSO9pgUDgBty7mYxOknhafo6qS3KDABtI+yUq47VbF7Zj+melQbyabJvr4gtxke/6PhwqcK2gqH8skPOayMgbh8FhWsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5cBF2ud; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4375ddb9eaeso8103001cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373216; x=1713978016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgC6tWfrCjT+R+mHvE+Tw2Te80mN3OqYF5qyRLtY9IQ=;
        b=i5cBF2ud5goFCJNgvzTtmt1ggaprX1WLQZGDghBAmOuz7h62nhqA60VBQzkFhITLNY
         r2NQP2PlWUOBsanF039+EPyBdwIJPMzWQr+iBIOQfNd0GwNZnPVjjXNwjvwiCYaLssrT
         C7zdTrwDK8BWAgQQQepK1LMGTaVltAWOJTCtNzXa2E8rvgzXGzIMWQrE1TEyfbAcGqSU
         zJ52j+KEyYd83mIjIZxpq+5IpOmtPgo+cr7+sW0Gq+a/qoUP4eSVzv6dZlhlIqXZ4lpc
         mnjvVk7D57ZXMYoXgfaWog8pBHS5cvZ7Y75eSUA2c+cTT8sFtAHnGc1/bQ6/EXSpLBNW
         cV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373216; x=1713978016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgC6tWfrCjT+R+mHvE+Tw2Te80mN3OqYF5qyRLtY9IQ=;
        b=hbtuxHxke59ejg1OeqdzTzmZqPxncqCLAXC0kykoI36geC0ZrOwxtw6YwuwaS1B8Lr
         2HK2Ie0v4gPAge53KPmnQsG87+gWt44H3eGDqVXel6bRKbIjHWCXwJQ29DBAk4UaQXUS
         2Sk7Scwi/G4C70ajcfmtM6DDkGgtvwgzk7pUvQEdBZzC2OB5bY3NccfkS0aAB9THefIG
         7A6zGSa4TgSw6rP/6woKrAW/Q1/ebO9G+GF4vNO2Z0GRba2TKJwm5m9WTkINLqeptvqt
         Q7lEQQiKIUf5lOCPtzQXKBE+acsHaLF6U7BekvnumXpBtIUrBPEa0qZAAdcZ5BncvSOA
         OYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/9uIMTzFFs4z1Zdv0onlgNBVTv9D4n6pUKzJ2Ss+kSbS9FwGzBzghOoe6EDbKzjgMajC/NtDuCqmkPsLpZ/4mnfZKSxoGQpgRknzVXqQp
X-Gm-Message-State: AOJu0Yyw+F8WhEVZW9eLa/7ERlDHq1UDDrIdxgwIts29g7h1Xqq6QN+E
	bEnzpQ4v04hKYJkKeDge4I4KfZe+3QyDfP7kUrqkjMGK+q0yrqrT3DS1MjrPFiHit+jq3vUy696
	iX9fhJUHXQZZmL3rB2OLvPg4JMzOF9CBww+YA
X-Google-Smtp-Source: AGHT+IFXiu93+9CON0CZlmqFKCb6l2EaLUrXof0ILnYpyXQf/L4IDG/UItFW263lu19ZxV/stOYbPZz4raXJd9UoXfY=
X-Received: by 2002:a0c:e852:0:b0:699:2b62:2f19 with SMTP id
 l18-20020a0ce852000000b006992b622f19mr18794026qvo.30.1713373215547; Wed, 17
 Apr 2024 10:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-3-jrife@google.com>
 <65b2f4a3-bd8e-495b-adca-1e7adce5301d@linux.dev>
In-Reply-To: <65b2f4a3-bd8e-495b-adca-1e7adce5301d@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Wed, 17 Apr 2024 12:59:58 -0400
Message-ID: <CADKFtnRYnJG0dk53erhuEK8Ew148nuTRwFgbUxkV6LRZQ=y+Hw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs
 for bpf_testmod
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin,

Thank you for the detailed feedback.

> Can a separate global lock/mutex (not the lock_sock) be acquired first be=
fore
> using the sock pointer in the kfuncs?

Sure. I will add the mutex around the socket operations. As for the
single global sock pointer, I wanted to keep it simple in this patch
series to fulfill the current use case. I agree it might be overkill
for now to add the bpf map and such.

> Is it better to set sk_sndtimeo in bpf_kfunc_init_sock() ?
> All these new kfunc should have the KF_SLEEPABLE flag.
> bpf_testmod_exit() should probably do this NULL check and sock_release() =
also.

Ack. I will add this.

> nit. Can "struct sockaddr_storage addr;" be directly used instead of a ch=
ar array?

When using "struct sockaddr_storage addr;" directly, the BPF program
fails to load with the following error message.

> libbpf: prog 'kernel_connect': BPF program load failed: Invalid argument
> libbpf: prog 'kernel_connect': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; return bpf_kfunc_call_kernel_connect(args); @ sock_addr_kern.c:26
> 0: (85) call bpf_kfunc_call_kernel_connect#99994
> arg#0 pointer type STRUCT addr_args must point to scalar, or struct with =
scalar
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'kernel_connect': failed to load: -22
> libbpf: failed to load object 'sock_addr_kern'
> libbpf: failed to load BPF skeleton 'sock_addr_kern': -22
> load_sock_addr_kern:FAIL:skel unexpected error: -22
> test_sock_addr:FAIL:load_sock_addr_kern unexpected error: -1 (errno 22)
> #288 sock_addr:FAIL

-Jordan

On Tue, Apr 16, 2024 at 2:43=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/12/24 9:52 AM, Jordan Rife wrote:
> > This patch adds a set of kfuncs to bpf_testmod that can be used to
> > manipulate a socket from kernel space.
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 139 +++++++++++++++++=
+
> >   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 ++++
> >   2 files changed, 166 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 39ad96a18123f..663df8148097e 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -10,18 +10,29 @@
> >   #include <linux/percpu-defs.h>
> >   #include <linux/sysfs.h>
> >   #include <linux/tracepoint.h>
> > +#include <linux/net.h>
> > +#include <linux/socket.h>
> > +#include <linux/nsproxy.h>
> > +#include <linux/inet.h>
> > +#include <linux/in.h>
> > +#include <linux/in6.h>
> > +#include <linux/un.h>
> > +#include <net/sock.h>
> >   #include "bpf_testmod.h"
> >   #include "bpf_testmod_kfunc.h"
> >
> >   #define CREATE_TRACE_POINTS
> >   #include "bpf_testmod-events.h"
> >
> > +#define CONNECT_TIMEOUT_SEC 1
> > +
> >   typedef int (*func_proto_typedef)(long);
> >   typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
> >   typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1)=
;
> >
> >   DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) =3D 123;
> >   long bpf_testmod_test_struct_arg_result;
> > +static struct socket *sock;
> >
> >   struct bpf_testmod_struct_arg_1 {
> >       int a;
> > @@ -494,6 +505,124 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static=
_unused_arg(u32 arg, u32 unused
> >       return arg;
> >   }
> >
> > +__bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
> > +{
> > +     int proto;
> > +
> > +     if (sock)
> > +             pr_warn("%s called without releasing old sock", __func__)=
;
>
> hmm...this global sock pointer is quite unease. e.g. what if multiple tas=
ks
> trying to use init/close/connect... in parallel.
>
> Storing sock in a bpf map will be better but that may be overkill for tes=
ting.
> Can a separate global lock/mutex (not the lock_sock) be acquired first be=
fore
> using the sock pointer in the kfuncs?
>
> > +
> > +     switch (args->af) {
> > +     case AF_INET:
> > +     case AF_INET6:
> > +             proto =3D args->type =3D=3D SOCK_STREAM ? IPPROTO_TCP : I=
PPROTO_UDP;
> > +             break;
> > +     case AF_UNIX:
> > +             proto =3D PF_UNIX;
> > +             break;
> > +     default:
> > +             pr_err("invalid address family %d\n", args->af);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return sock_create_kern(&init_net, args->af, args->type, proto, &=
sock);
> > +}
> > +
> > +__bpf_kfunc void bpf_kfunc_close_sock(void)
> > +{
> > +     if (sock) {
> > +             sock_release(sock);
>
> bpf_testmod_exit() should probably do this NULL check and sock_release() =
also.
>
> > +             sock =3D NULL;
> > +     }
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_connect(struct addr_args *args)
> > +{
> > +     /* Set timeout for call to kernel_connect() to prevent it from ha=
nging,
> > +      * and consider the connection attempt failed if it returns
> > +      * -EINPROGRESS.
> > +      */
> > +     sock->sk->sk_sndtimeo =3D CONNECT_TIMEOUT_SEC * HZ;
>
> Is it better to set sk_sndtimeo in bpf_kfunc_init_sock() ?
>
> > +
> > +     return kernel_connect(sock, (struct sockaddr *)&args->addr,
> > +                           args->addrlen, 0);
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_bind(struct addr_args *args)
> > +{
> > +     return kernel_bind(sock, (struct sockaddr *)&args->addr, args->ad=
drlen);
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_listen(void)
> > +{
> > +     return kernel_listen(sock, 128);
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *arg=
s)
> > +{
> > +     struct msghdr msg =3D {
> > +             .msg_name       =3D &args->addr.addr,
> > +             .msg_namelen    =3D args->addr.addrlen,
> > +     };
> > +     struct kvec iov;
> > +     int err;
> > +
> > +     iov.iov_base =3D args->msg;
> > +     iov.iov_len  =3D args->msglen;
> > +
> > +     err =3D kernel_sendmsg(sock, &msg, &iov, 1, args->msglen);
> > +     args->addr.addrlen =3D msg.msg_namelen;
> > +
> > +     return err;
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args)
> > +{
> > +     struct msghdr msg =3D {
> > +             .msg_name       =3D &args->addr.addr,
> > +             .msg_namelen    =3D args->addr.addrlen,
> > +     };
> > +     struct kvec iov;
> > +     int err;
> > +
> > +     iov.iov_base =3D args->msg;
> > +     iov.iov_len  =3D args->msglen;
> > +
> > +     iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, args->msglen);
> > +     err =3D sock_sendmsg(sock, &msg);
> > +     args->addr.addrlen =3D msg.msg_namelen;
> > +
> > +     return err;
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_getsockname(struct addr_args *ar=
gs)
> > +{
> > +     int err;
> > +
> > +     err =3D kernel_getsockname(sock, (struct sockaddr *)&args->addr);
> > +     if (err < 0)
> > +             goto out;
> > +
> > +     args->addrlen =3D err;
> > +     err =3D 0;
> > +out:
> > +     return err;
> > +}
> > +
> > +__bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *ar=
gs)
> > +{
> > +     int err;
> > +
> > +     err =3D kernel_getpeername(sock, (struct sockaddr *)&args->addr);
> > +     if (err < 0)
> > +             goto out;
> > +
> > +     args->addrlen =3D err;
> > +     err =3D 0;
> > +out:
> > +     return err;
> > +}
> > +
> >   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
> >   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> > @@ -520,6 +649,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRU=
STED_ARGS | KF_RCU)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
> >   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
> > +BTF_ID_FLAGS(func, bpf_kfunc_init_sock)
> > +BTF_ID_FLAGS(func, bpf_kfunc_close_sock)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_connect)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_bind)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_listen)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname)
> > +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername)
>
> All these new kfunc should have the KF_SLEEPABLE flag.
>
> >   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
> >
> >   static int bpf_testmod_ops_init(struct btf *btf)
> > @@ -650,6 +788,7 @@ static int bpf_testmod_init(void)
> >               return ret;
> >       if (bpf_fentry_test1(0) < 0)
> >               return -EINVAL;
> > +     sock =3D NULL;
> >       return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_f=
ile);
> >   }
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.=
h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > index 7c664dd610597..cdf7769a7d8ca 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > @@ -64,6 +64,22 @@ struct prog_test_fail3 {
> >       char arr2[];
> >   };
> >
> > +struct init_sock_args {
> > +     int af;
> > +     int type;
> > +};
> > +
> > +struct addr_args {
> > +     char addr[sizeof(struct __kernel_sockaddr_storage)];
>
> nit. Can "struct sockaddr_storage addr;" be directly used instead of a ch=
ar array?
>
> > +     int addrlen;
> > +};
> > +
> > +struct sendmsg_args {
> > +     struct addr_args addr;
> > +     char msg[10];
> > +     int msglen;
> > +};
> > +
> >   struct prog_test_ref_kfunc *
> >   bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
> >   void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksy=
m;
> > @@ -106,4 +122,15 @@ void bpf_kfunc_call_test_fail3(struct prog_test_fa=
il3 *p);
> >   void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
> >
> >   void bpf_kfunc_common_test(void) __ksym;
> > +
> > +int bpf_kfunc_init_sock(struct init_sock_args *args) __ksym;
> > +void bpf_kfunc_close_sock(void) __ksym;
> > +int bpf_kfunc_call_kernel_connect(struct addr_args *args) __ksym;
> > +int bpf_kfunc_call_kernel_bind(struct addr_args *args) __ksym;
> > +int bpf_kfunc_call_kernel_listen(void) __ksym;
> > +int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args) __ksym;
> > +int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args) __ksym;
> > +int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
> > +int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
> > +
> >   #endif /* _BPF_TESTMOD_KFUNC_H */
>

