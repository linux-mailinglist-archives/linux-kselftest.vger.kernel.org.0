Return-Path: <linux-kselftest+bounces-4935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6685AA1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 18:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D90F1C213D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFF45961;
	Mon, 19 Feb 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnZR8Mf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79414594C
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364148; cv=none; b=fU4uleMzktBAN93G6yF8DMt8gzsv1xpRJTii1h894aBoGrSkQZsyRskp2xTCGYnjpgLyYk/+1XgXsFxS7WY+nSRMSCZot14gJkTO9qJw17sayNSRxIELG1qwWv2m80q/cC1tD1EzYf6KZjeK+7wPxuTBs/Wk05qYwoeoLEewNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364148; c=relaxed/simple;
	bh=wJCpYntqq8nCglIkq88Zs9qTSRweYslEK0KjbQBa4Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZWYJJ5SRuMudEx7V8fcQph2R3pKuJuIeey4+YBiTC2G7UJSGgiq3ddXGi52FoDNrErB7xFpTUNdz6hbp6flk0aW8+ZFmh+0qYTtdoMcu4VLjv8VQoHOcRg1Swm+jHmXH053h9gJkzmE6jWx/ezFT8d9xFxGrDWSw3oLcNlZakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnZR8Mf9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so17971a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708364145; x=1708968945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpH+GG/JxRVKqFjHr33MFZWda+dSzZgj8Xxgn4JwPS8=;
        b=qnZR8Mf9OXg9M88jTqacpGR0VokQ4cl6dxm4BrwfAqkIhovRA2gUuTEyZfLnhAEcFR
         Mo9djPgblUq9mIGUmbSlFtdv61274wgtpdJo05I4wr109y9ULgiAGKw1GPFDscQ/38zk
         YDJ9hkomHCkHZ9UMUWaCflYoPokfEpf/uw5+so3Jo4nbDk9YS8Uq4Ovzq2Bp2q3DGJOt
         8E0azaZNDmTnNKhnMUTpG5osWaTJ0OT9q2jtAn+1o/OxJ63OsK6Vhgi54Wua6AZPXNWO
         ABxCAfNG1ylw8P6sg6xGDNEeQqNm+Su0XA7/FuQ2lOuUtRynVGVJlqxFtcYP67f2bIVQ
         FhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708364145; x=1708968945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpH+GG/JxRVKqFjHr33MFZWda+dSzZgj8Xxgn4JwPS8=;
        b=LXWBoCPftmAs5KPTEn8ra1hlDYeQ+OPwMIS87lKAG/gqIvsALhDw1b2Ab7ngVrSCGe
         KkRq1DLjHTlHWujV8bAXO2HTXr7+Km5yabjTy6OFYpEYC01Poq/tnsyg/usw7x0N0jgt
         nVZdOal5odL/Xs/anIsPx35hHN4HmByyxhf6jsUBaX0bLjjJnHG1nYtlrZPBV3xpKVJ2
         sT4TqzTz13g9B02RxvBEKKtoCgc98crEhALBWcHOVoYolV7fyrmq/uYarODDc5RYOqjB
         08qlSN+T8uujzoPDdoqvF56nZaroH7N0HMMVDEkeIyff2gPHAAvnFMmGyubroh/KJTS4
         /IsA==
X-Forwarded-Encrypted: i=1; AJvYcCVLXvO6tmAw2mXkRym6A41qoVJshlqsXRJObN4pQw97uEn99/a8xvcBrgRE36X4M2QAnw2wcpcN92piEUtziKW4AFlQOXx1fPuRePnPJ54D
X-Gm-Message-State: AOJu0YzUqE51ylGTsodqyJOh4CXYlkQBVJK0QgqadBy+BAX4zv9xLotV
	pQPsLJUiaIyFzfbT5Xio/27BaEJi8ShKkTTHsaDNg7K+iZbVIU2ajOOPGgSh1B3pGnWshAKTNpT
	j69RIF/VrKmTfBxA7sdzom2ct8aodbH9IrNeo
X-Google-Smtp-Source: AGHT+IE99wN/PQYfiDNakz6zkMQR7kOEOngXX0T7gN2tvc5IjeQakHE9Z1BsxKNQN8jOzpCri2PXj7rsMGF+tGMHWj0=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr322644edc.1.1708364145075; Mon, 19 Feb
 2024 09:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org> <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
In-Reply-To: <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 18:35:31 +0100
Message-ID: <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 6:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > Since the introduction of the subflow ULP diag interface, the
> > dump callback accessed all the subflow data with lockless.
> >
> > We need either to annotate all the read and write operation accordingly=
,
> > or acquire the subflow socket lock. Let's do latter, even if slower, to
> > avoid a diffstat havoc.
> >
> > Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Notes:
> >   - This patch modifies the existing ULP API. No better solutions have
> >     been found for -net, and there is some similar prior art, see
> >     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
> >
> >     Please also note that TLS ULP Diag has likely the same issue.
> > To: Boris Pismenny <borisp@nvidia.com>
> > To: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  include/net/tcp.h  | 2 +-
> >  net/mptcp/diag.c   | 6 +++++-
> >  net/tls/tls_main.c | 2 +-
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index dd78a1181031..f6eba9652d01 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
> >         /* cleanup ulp */
> >         void (*release)(struct sock *sk);
> >         /* diagnostic */
> > -       int (*get_info)(const struct sock *sk, struct sk_buff *skb);
> > +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
> >         size_t (*get_info_size)(const struct sock *sk);
> >         /* clone ulp */
> >         void (*clone)(const struct request_sock *req, struct sock *news=
k,
> > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> > index a536586742f2..e57c5f47f035 100644
> > --- a/net/mptcp/diag.c
> > +++ b/net/mptcp/diag.c
> > @@ -13,17 +13,19 @@
> >  #include <uapi/linux/mptcp.h>
> >  #include "protocol.h"
> >
> > -static int subflow_get_info(const struct sock *sk, struct sk_buff *skb=
)
> > +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> >  {
> >         struct mptcp_subflow_context *sf;
> >         struct nlattr *start;
> >         u32 flags =3D 0;
> > +       bool slow;
> >         int err;
> >
> >         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
> >         if (!start)
> >                 return -EMSGSIZE;
> >
> > +       slow =3D lock_sock_fast(sk);
> >         rcu_read_lock();
>
> I am afraid lockdep is not happy with this change.
>
> Paolo, we probably need the READ_ONCE() annotations after all.

Or perhaps something like the following would be enough.

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa2941bc04c680bacd9f79fc65060d..7017dd60659dc7133318c1c82e3=
f429bea3a5d57
100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct
sk_buff *skb)
        bool slow;
        int err;

+       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
+               return 0;
+
        start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
        if (!start)
                return -EMSGSIZE;

