Return-Path: <linux-kselftest+bounces-30458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEFCA836F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E501E444403
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A01DB366;
	Thu, 10 Apr 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBxsKnGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6294C9D;
	Thu, 10 Apr 2025 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254137; cv=none; b=gKcq1xEyctD8fRKVe+9Jn2X2+uL0mAcu8zdG8Y7639tkSJyDnQ1cI37U7RnethRGeZMD5wOIssxpt1+EXpd2mWf1HeFe+xKvr1KQJoquZrcJvdGy4if8KYstXDvJ0Ike2MhJiqA3281z6FlRaqCTtDpaj2Edsm7xHXZyrzLdaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254137; c=relaxed/simple;
	bh=SkZn5U4FeYjjSd+ibPg9tpFIH6uVaJpZtykZkZ+21s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu41CS2GXhi8W8gRKFC9v4PSltdLN5taWZBJtfECWpzA74Ez0ehPTJEbAPMSbru0p0qOKO+OYOZySH9bg7hcWVgI4GPyo3vvPINH9Z4a9rLqCqv28QXE/Ez5qZbUYF7v1nsxAhS2MVz1wOKbLd7z5ba4xDOsiDyeREOAopwOXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBxsKnGM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2f391864so113862f8f.3;
        Wed, 09 Apr 2025 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744254133; x=1744858933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TosMyF3hM14iMOWdmkP174aiYxZsY4oWZ8xk8+GUX5A=;
        b=IBxsKnGM3+nA9RmSFgkSC3r/RA4yJ8KOwCzXvcsLPOD1FdbwSYaqDSaltAu9HI9Xw5
         mas+YBZhfgFxBo8cdRoqcmsdpx0axGEY0RddzPchkJtuVqYPOnTnNuj395qJg0VSr/Rt
         RO9du8oCGsDH08hP8J/DjZXpaGlipcAGrdIvi3UYKulAhRjxdyvpdGS7Au/nP3McPBko
         8sAt+Xu6M2E1SIka+8M9UhX8e6IyTQ/BKSjdAkYN9aqLgOr6rOynL1EEaeQGrJzgvtdd
         SoKMco1ZiLHpkhSu5z22DnfPQ0Ftf/gbAEWOJ/fohQbq7wI3W2EkTMJK82DtBxT0Lc5l
         OjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744254133; x=1744858933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TosMyF3hM14iMOWdmkP174aiYxZsY4oWZ8xk8+GUX5A=;
        b=Mtw8qPF97KLlOXumSomA8Z16c7LtGzSJEed8TJMccZj6JTVN0Q6vAkzSJkLNH34f6N
         Olxc0zol6RRxLNCybAI++axkvTcFvEum/GMXpOBs7vsBxCBJgfnBdDOSA8QEeZ8fLpXb
         QfBKNo/bV2Yqk7URtO8Lbq9V8JLjJUU7LtG/PfwIslDNul1vnYnPqiQUR0EaV4vd9vfU
         gr6r912fjyBWn9uaOPoQubkrq9zRcaCjg8y70All7ZSb01V1LhvmyhjxgrAXVRSpL8V8
         xBIgagw5Oy9FLIpOCKlPWtdqtK3sPwwFqdK539Zaolaovyjf/+bINImRn8xV2SaoYmdr
         lFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa5WUyOKmQsiGhZS9S0eubNXD++mGRgsKNg7yXtrQy7r3B/wF6HcjPkN6REqKeRVq7MlpoCZlOV8Ol/khlTKfu@vger.kernel.org, AJvYcCWUsRkaPtn+hRY5cwGP+5udxvr7Y1/5QCcJTnL1b4UmTC55O8Itm/edBSBafMCIP/ecxF/f9ODZOj7h5rE=@vger.kernel.org, AJvYcCXdXzo29OJ0JCR6wJtAnTusyNux8gSOUgOXM1JQq5TDO3ly66Dt0pIUcNcMsFOd9beTsZ9wMGnm@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+akN/qVVSHd6r2lS+j1TzCqCD5wpaw+vTDzYM4Q22Y/yLnz1
	PMeHxLwLHytMnZfmQ+9u/Mi7eSY5SAT2K2VLWMzDeEhDod9cZ5zWABpk0yA6+KkM85ErQNQSmGv
	ObVyLTX2n4jW1NTXKrAKtwkceD/I=
X-Gm-Gg: ASbGncsiNe0ytjTDEV4WwTmX5qGNvYOs2EQca/L0AP7tXRRaX1jgvUiwVvihYGIEJKi
	qm+p9NB9DUwEKA5DX7pWGq16d/o8Sh8B8sJUdR4rgUTHMlGr57vsSdvIz+Xk5t8Q03DT/pDjrla
	qBolC9+1UlhfdyVSsFiEMvK+T5vR9/jiMt+ln5L6H/d5ZT8304
X-Google-Smtp-Source: AGHT+IHpUwaWhgRZ41AT4rxFxUm3FAVIc7wt5lzcaYpnWiEJS4LCZo2epefVXB/w02Le3ZpXVE0na+iX0kvxlCmTFYY=
X-Received: by 2002:a5d:598c:0:b0:391:3b70:2dab with SMTP id
 ffacd0b85a97d-39d8fd47aaamr426855f8f.17.1744254132801; Wed, 09 Apr 2025
 20:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408073033.60377-1-jiayuan.chen@linux.dev> <20250408073033.60377-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250408073033.60377-3-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Apr 2025 20:02:01 -0700
X-Gm-Features: ATxdqUGJnbxliQPhDYbcypFW7z8hybrTt2fW909Abf4g0R0ZOjHv_LJpkdQTxf0
Message-ID: <CAADnVQJibNXGSxUnjb8q=vNNdJ7AOVm0Mq+1sQn9fdUMY0JPSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf, sockmap: avoid using sk_socket after
 free when reading
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Jiayuan Chen <mrpre@163.com>, 
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>, 
	Cong Wang <cong.wang@bytedance.com>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:31=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> There are potential concurrency issues, as shown below.
> '''
> CPU0                               CPU1
> sk_psock_verdict_data_ready:
>   socket *sock =3D sk->sk_socket
>   if (!sock) return
>                                    close(fd):
>                                      ...
>                                      ops->release()
>   if (!sock->ops) return
>                                      sock->ops =3D NULL
>                                      rcu_call(sock)
>                                      free(sock)
>   READ_ONCE(sock->ops)
>   ^
>   use 'sock' after free
> '''
>
> RCU is not applicable to Unix sockets read path, because the Unix socket
> implementation itself assumes it's always in process context and heavily
> uses mutex_lock, so, we can't call read_skb within rcu lock.
>
> Incrementing the psock reference count would not help either, since
> sock_map_close() does not wait for data_ready() to complete its execution=
.
>
> While we don't utilize sk_socket here, implementing read_skb at the sock
> layer instead of socket layer might be architecturally preferable ?
> However, deferring this optimization as current fix adequately addresses
> the immediate issue.
>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@goo=
gle.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/skmsg.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 6101c1bb279a..5e913b62929e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1231,17 +1231,24 @@ static int sk_psock_verdict_recv(struct sock *sk,=
 struct sk_buff *skb)
>
>  static void sk_psock_verdict_data_ready(struct sock *sk)
>  {
> -       struct socket *sock =3D sk->sk_socket;
> +       struct socket *sock;
>         const struct proto_ops *ops;
>         int copied;
>
>         trace_sk_data_ready(sk);
>
> -       if (unlikely(!sock))
> +       rcu_read_lock();
> +       sock =3D sk->sk_socket;
> +       if (unlikely(!sock)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>         ops =3D READ_ONCE(sock->ops);
> -       if (!ops || !ops->read_skb)
> +       if (!ops || !ops->read_skb) {
> +               rcu_read_unlock();
>                 return;
> +       }
> +       rcu_read_unlock();

This makes no sense to me. RCU doesn't work this way.

pw-bot: cr

