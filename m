Return-Path: <linux-kselftest+bounces-21498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA699BD79F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 22:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECBD283EDD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A4E21643B;
	Tue,  5 Nov 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gR+NMJE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D22161EA
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842144; cv=none; b=Tlm8PUf2ZCPdbiS1rY4XqXAyqo2hako9lOzikoINiIdf7o2EabDwQsD/NgoJfkjeZXkpLoYlUR7fmBc9CKdghIbbNdJmh1+M3COR1nNBvgIaMreQ5Uw+54a4RNCpoGxLWggMJXbxfXB28JJe8XyUHMZ5c+z2VWYSt6favckUbl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842144; c=relaxed/simple;
	bh=0vlrR7m4wjvDiUOsNx/txRfIE+ymrJZzhXVyiDgB9BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9T8hog8kM84CNPIygD1kYfFhxbpLEBdcVlmMremG9spSmi4dQKVZOVL8CvPVLybYID/RPhqA53At1JjZwQNcO7/FJvEhff7r9fa/+f7OiFpnVDulF+SopmBuCBVf/p1Uil9uXFu+mDsbioUQlRMhslvckLVodZxn6ABRpLhgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gR+NMJE9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so79931cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2024 13:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842141; x=1731446941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4h1iJYzcKiOZWJuU1HDZyOsv6VUMD/8hUZDwNyB5Yw=;
        b=gR+NMJE98f8ZtMubbC4ZK29JywhAVqu7wCdR0bTEeLRApHUiDE/BGq0D8cu9G9LBR0
         1NWzYWW245z/EAe4y2CDL1ch2Cppg5Jyxrw9QZWSuKUaduaHcLcnaQvitbYH+ZFuMrDo
         ArNp7H139jpIaz+5YtgsbYiRHKN7+HV6QrenAzILqJSwNsHpShViEtKyhU9FzITa9VCi
         r4meDKacRyzc5wSG3NwhJIDY1Hubuf+P2gWS+YREiGtSvu45Y/SkMIWA/qpz7Vw9Ains
         u46HmXjHT+jDuYaItLsp2cqxouUAT/lDhNrru2fqJxq667I/6pPmE/SS9lFdRTNa4Z71
         u5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842141; x=1731446941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4h1iJYzcKiOZWJuU1HDZyOsv6VUMD/8hUZDwNyB5Yw=;
        b=KgciuppYnYGS58EAWrLPRZB8mE5hr+RwvvmD+DLVgJMaqixjatddE1jKgg7id2x7Ga
         sGon+RWIjx5PlfDe5OK7Alnk8m0EgyffQTt/R93lnBdaExQERRdC2SYg2e2JbmGdF6Da
         jSZPnZYHcEuFvBAmbSlVMetVNAW0LuoZ1Cuax+ONvriivqQqnFfvLHxQLEVoJlEbhTdf
         BICkzE34Dga4oPZMP0blV8sSzld5Nse5og7ZEx4Ejmu3KB8qK/03RppmnoN8bkVh6vaa
         2g3uT7+HXI3t3/nZGCvNnKhYiJ7scKVuW4d1HkucAN+RkRDGEaso4kHU+I7lHuKObyYa
         e9RA==
X-Forwarded-Encrypted: i=1; AJvYcCW3RhY1AqecQMnnTRlgSPAkAb5x/0k+6T+6w1vJAbLRwsaMgCtcykZDb2vEltFhYtfMHzACOaHqzV+2CqgH7Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbxlSZQOA8WzqyQXxXTirkFV2PtQI8P8ja1an2fai253lflOY
	fA/Vdjnrp6XgtDbbXprYuQb0Gkr6SJavQPsRSN0TF6y3HTwP0jlxmv0xT3HLA6aaar+eU5aywQx
	2RYwIfW4ohtDTsm743jG6acbh21mfU4ygbxfD
X-Gm-Gg: ASbGnctX0H8X4DrKH2az/PvAHm9fHgTQERWqK8toWhoSM5mkjjo5hI1idaOeldjXXhJ
	E2dhK4m/XnAcH7S5btVveCQgaL8cWrLtycSA+VQYzVUaADhmXiHM5lsiq0icIuQ==
X-Google-Smtp-Source: AGHT+IEjSIel43idNBo3lwSTd9iu0fSJLfqvR0Aru+x0iW0YghL0qiYES/xu1qLkLznMBR9vBO3PhLQzAVjOfrFcDVg=
X-Received: by 2002:a05:622a:189f:b0:462:b36f:294 with SMTP id
 d75a77b69052e-462f01e3099mr804661cf.24.1730842140683; Tue, 05 Nov 2024
 13:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com> <ZyJDxK5stZ_RF71O@mini-arch>
 <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com> <ZyJLkn3uM1Qz6NZn@mini-arch>
In-Reply-To: <ZyJLkn3uM1Qz6NZn@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 5 Nov 2024 13:28:48 -0800
Message-ID: <CAHS8izMWbcKSr3uOVWQDmo5=aQvFdcD6o_myz1bw=a1rzrJE_A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too long
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Yi Lai <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:07=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/30, Mina Almasry wrote:
> > On Wed, Oct 30, 2024 at 7:33=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 10/29, Mina Almasry wrote:
> > > > Check we're going to free a reasonable number of frags in token_cou=
nt
> > > > before starting the loop, to prevent looping too long.
> > > >
> > > > Also minor code cleanups:
> > > > - Flip checks to reduce indentation.
> > > > - Use sizeof(*tokens) everywhere for consistentcy.
> > > >
> > > > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > > >
> > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > >
> > > > ---
> > > >  net/core/sock.c | 46 ++++++++++++++++++++++++++++-----------------=
-
> > > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 7f398bd07fb7..8603b8d87f2e 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock =
*sk, int bytes)
> > > >
> > > >  #ifdef CONFIG_PAGE_POOL
> > > >
> > > > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNE=
ED in
> > > > +/* This is the number of frags that the user can SO_DEVMEM_DONTNEE=
D in
> > > >   * 1 syscall. The limit exists to limit the amount of memory the k=
ernel
> > > > - * allocates to copy these tokens.
> > > > + * allocates to copy these tokens, and to prevent looping over the=
 frags for
> > > > + * too long.
> > > >   */
> > > > -#define MAX_DONTNEED_TOKENS 128
> > > > +#define MAX_DONTNEED_FRAGS 1024
> > > >
> > > >  static noinline_for_stack int
> > > >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned i=
nt optlen)
> > > > @@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockp=
tr_t optval, unsigned int optlen)
> > > >       unsigned int num_tokens, i, j, k, netmem_num =3D 0;
> > > >       struct dmabuf_token *tokens;
> > > >       netmem_ref netmems[16];
> > > > +     u64 num_frags =3D 0;
> > > >       int ret =3D 0;
> > > >
> > > >       if (!sk_is_tcp(sk))
> > > >               return -EBADF;
> > > >
> > > > -     if (optlen % sizeof(struct dmabuf_token) ||
> > > > -         optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > > > +     if (optlen % sizeof(*tokens) ||
> > > > +         optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
> > > >               return -EINVAL;
> > > >
> > > > -     tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL=
);
> > > > +     num_tokens =3D optlen / sizeof(*tokens);
> > > > +     tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KE=
RNEL);
> > > >       if (!tokens)
> > > >               return -ENOMEM;
> > > >
> > > > -     num_tokens =3D optlen / sizeof(struct dmabuf_token);
> > > >       if (copy_from_sockptr(tokens, optval, optlen)) {
> > > >               kvfree(tokens);
> > > >               return -EFAULT;
> > > >       }
> > > >
> > > > +     for (i =3D 0; i < num_tokens; i++) {
> > > > +             num_frags +=3D tokens[i].token_count;
> > > > +             if (num_frags > MAX_DONTNEED_FRAGS) {
> > > > +                     kvfree(tokens);
> > > > +                     return -E2BIG;
> > > > +             }
> > > > +     }
> > > > +
> > > >       xa_lock_bh(&sk->sk_user_frags);
> > > >       for (i =3D 0; i < num_tokens; i++) {
> > > >               for (j =3D 0; j < tokens[i].token_count; j++) {
> > > >                       netmem_ref netmem =3D (__force netmem_ref)__x=
a_erase(
> > > >                               &sk->sk_user_frags, tokens[i].token_s=
tart + j);
> > > >
> > > > -                     if (netmem &&
> > > > -                         !WARN_ON_ONCE(!netmem_is_net_iov(netmem))=
) {
> > > > -                             netmems[netmem_num++] =3D netmem;
> > > > -                             if (netmem_num =3D=3D ARRAY_SIZE(netm=
ems)) {
> > > > -                                     xa_unlock_bh(&sk->sk_user_fra=
gs);
> > > > -                                     for (k =3D 0; k < netmem_num;=
 k++)
> > > > -                                             WARN_ON_ONCE(!napi_pp=
_put_page(netmems[k]));
> > > > -                                     netmem_num =3D 0;
> > > > -                                     xa_lock_bh(&sk->sk_user_frags=
);
> > > > -                             }
> > > > -                             ret++;
> > >
> > > [..]
> > >
> > > > +                     if (!netmem || WARN_ON_ONCE(!netmem_is_net_io=
v(netmem)))
> > > > +                             continue;
> > >
> > > Any reason we are not returning explicit error to the callers here?
> > > That probably needs some mechanism to signal which particular one fai=
led
> > > so the users can restart?
> >
> > Only because I can't think of a simple way to return an array of frags
> > failed to DONTNEED to the user.
>
> I'd expect the call to return as soon as it hits the invalid frag
> entry (plus the number of entries that it successfully refilled up to
> the invalid one). But too late I guess.
>
> > Also, this error should be extremely rare or never hit really. I don't
> > know how we end up not finding a netmem here or the netmem is page.
> > The only way is if the user is malicious (messing with the token ids
> > passed to the kernel) or if a kernel bug is happening.
>
> I do hit this error with 1500 mtu, so it would've been nice to
> understand which particular token triggered that. It might be
> something buggy on the driver side, I need to investigate. (it's
> super low prio because 1500)
>

Hmm, I've never seen this, in production (code is similar to
upstreamed, but I guess not exactly the same), and in my ncdevmem
upstream testing.

FWIW leaked frags are extremely bad, because there is no opportunity
to reap them until the entire dmabuf has been rebound. You will need
to root cause this if you're seeing it and are interested in using
devmem tcp in prod.

sk_user_frags is only really touched in:
- sock_devmem_dontneed(), where they are removed from the xarray.
- tcp_recvmsg_dmabuf(), where they are added to the xarray.
- tcp_v4_destroy_sock(), where they are freed (but not removed from
the xarray?!).

The only root causes for this bug I see are:

1. You're racing tcp_v4_destroy_sock() with sock_devmem_dontneed(), so
somehow you're trying to release a frag already released in that loop?
Or,
2. You're releasing a frag that was never added by
tcp_recvmsg_dmabuf(). I.e. There is a bug in tcp_recvmsg_dmabuf() that
it put_cmsg the frag_id to the userspace but never adds it to the
sk_user_frags. That should be accompanied by a ncdevmem validation
error.

The way to debug #2 is really to test with the ncdevmem validation. I
got the sense from reviewing the test series that you don't like to
use it, but it's how I root cause such issues. You should familiarize
yourself with it if you want to root cause such issues as well. To use
it:

client: yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 \
          | head -c 1G | nc <server ip> -p 5224
 server: ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5224 -v 7

If you see a validation error with your missing frag, send me the
logs, I may be able to guess what's wrong.

> > Also, the information is useless to the user. If the user sees 'frag
> > 128 failed to free'. There is nothing really the user can do to
> > recover at runtime. Only usefulness that could come is for the user to
> > log the error. We already WARN_ON_ONCE on the error the user would not
> > be able to trigger.
>
> I'm thinking from the pow of user application. It might have bugs as
> well and try to refill something that should not have been refilled.
> Having info about which particular token has failed (even just for
> the logging purposes) might have been nice.

Yeah, it may have been nice. On the flip side it complicates calling
sock_devmem_dontneed(). The userspace need to count the freed frags in
its input, remove them, skip the leaked one, and re-call the syscall.
On the flipside the userspace gets to know the id of the frag that
leaked but the usefulness of the information is slightly questionable
for me. :shrug:


--=20
Thanks,
Mina

