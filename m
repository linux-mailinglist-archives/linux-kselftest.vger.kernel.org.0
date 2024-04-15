Return-Path: <linux-kselftest+bounces-7996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F258A568D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8871C20DD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BC7F46B;
	Mon, 15 Apr 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHODfBQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0347E0F4
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195289; cv=none; b=FrZIWagUcteFKtOwTxKhcdidacMwlZXgE2DXMFjcvXO4YjUBLFyCxW6uoFsdsyjkUoHfh61ahYHTHzMOH2jlELQ47SmyfQf3fbr0zwKMRQXwYnNO0hM1NEF+T0TfzlcVQOW3RuRTp1X8dTk+K0tzIoJ1AxCc0pyYcfZ4RGP0zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195289; c=relaxed/simple;
	bh=IwYA4nPc5BbxwIcf6/OEmE1dkRzISbAEzgGxd53FtS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb6+m676zYRMayli/IfCxeolPSIRHofpmIaA/g/CbV15yGisbpl8XaPD7CIDetBZLraDn286TxkK5zXV7cEssxlosY3omfYBn426t7jMErjlVYrDDVc8SVCyFh6VaPMlGAVgZsfEPoIpGF9SRR/qJ8KOuSiSwYQTNm36UcqfSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHODfBQD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so3900026a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713195286; x=1713800086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5isgrhDlchjsWw+RyYcbDzKVGeMdQo5ZvDW77w1gGG0=;
        b=AHODfBQDefSio959sxsfTbfbws2tHc8ftAoziPp+rqCf4uKEn68CaX0OM3RjxdJRT6
         6mL2HvBf8iEjNH6uorWZvL42ybWMF26qnD/OOXfeXwMinkx1T79McLPrsr7ascOWDm4J
         xq4ASwQya1cdT7STCx9JsoQniU3Pfd6Htyz8gzA0fk7uegsq0kIq0DU3DPdXZG5cEu/3
         ALvr6/DNLh0jdtmBhRyu84YyItdrJ/y9taBhCV+VI+ohirp+G39lEMC4Vn1lCqeHIM5A
         HxMnDNdby4eggg3LX7mY1Gi+9ScfsTf040duKAlwfKpzCOHZwq7AYJjMmbeVvxoN6QgD
         wblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195286; x=1713800086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5isgrhDlchjsWw+RyYcbDzKVGeMdQo5ZvDW77w1gGG0=;
        b=LKQdNMQG7hnYYzKszZIGmjufUg2sOB8KAxwwUGt4F0rgreaHEmNY0QLy6F+z1ZgIpe
         vd9BmEzpydLDsSV49Zi3qVR7kDa4uw7CpyfIyVctLRnTA1LT/+benlm81PqgtERhIQTf
         QBtlpKMlB7LmLs5TK12Fr+HuhOyUreppZeq9jc1svW3HgPfhYJXWO5a0glXlXt9Vdtku
         FP05Vl+X5+6utz30Lg4GC15UVAeUmMSN+h5i5QRhH+9XAGJZS2vB4JtYo/vHjnD7kHmU
         81wvNjFO/uvytBdkGLiLO+ShqzTZFKBm39868Gf5e2NmLwYPTuvYMXrR7JNXfVoO7u89
         kj0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCrnoyJ9dNACsoXHsDhDlVEZcOddRUDOmr+XSTFkx9KCh5PlgFqLQAPEMtriuY1isQdqreMY/WeIoEvq62Vy4iCJZ2wyQG9NLj4dNOuSVG
X-Gm-Message-State: AOJu0YwJoD5TbCK39kgnfW2hFbOBjcD1+OJYXpuOkExiAbKyI0AFMbkb
	GKP//7nITN1aRcUp57vdNkY6KTP74df9uyRH1iNS7lhatrVW/E6PB/YaTQBP83RZ605tF/Uurqm
	h8rqDxBhjmqLo8qd5533A4P2//0tZ+ogZkaGt
X-Google-Smtp-Source: AGHT+IFa+EKNpBzf/+vtFBCBAQYQC12uwnyQAcOCVuxPHpEVOK8w09KlvehTcsRUb/At2E6jk2cWTGnqNYDbJtXNI6A=
X-Received: by 2002:a17:906:c155:b0:a52:3d1:6768 with SMTP id
 dp21-20020a170906c15500b00a5203d16768mr7858126ejc.1.1713195286059; Mon, 15
 Apr 2024 08:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-3-jrife@google.com>
 <2f5b9a1f-ddbd-43c0-93e1-aca09552ef6b@gmail.com>
In-Reply-To: <2f5b9a1f-ddbd-43c0-93e1-aca09552ef6b@gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 15 Apr 2024 08:34:33 -0700
Message-ID: <CADKFtnTRrKWXsd0S20mZ9qQbQFAen7FuSt6viO5W9p7xJf-keg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs
 for bpf_testmod
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> It would be better to check if args->msglen > sizeof(arg->msg) although
> this function is just for test cases. Same for args->addr.addrlen.

Ack. I will add this.

Thanks,
Jordan


On Fri, Apr 12, 2024 at 6:26=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 4/12/24 09:52, Jordan Rife wrote:
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
>
> It would be better to check if args->msglen > sizeof(arg->msg) although
> this function is just for test cases. Same for args->addr.addrlen.
>
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

