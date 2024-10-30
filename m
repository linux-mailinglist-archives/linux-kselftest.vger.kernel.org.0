Return-Path: <linux-kselftest+bounces-21126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D119B66FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453C61F2169E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A80200B8D;
	Wed, 30 Oct 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyKqntCY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516431F4737;
	Wed, 30 Oct 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300822; cv=none; b=JM/oFXC2z7ib7gBEQ+LaNQ56xwKOgGg3YjhRL6N08tpwVEOtBJZliazX2wNNwDmG/+A+PGyHnVlH1wXPRvlbN9bPMZfu96GLUTEG7tOi9mwP2NvC6hPW3lJ3pt+kxRMwUsqtDBAPQLTj2QA2SNQuwhflJTNzdxOYQUc/pU3gx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300822; c=relaxed/simple;
	bh=voi/WMWGAYJexGuW4J0qxHijwgOTwDVYv2O9Z9zK46s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWE9PizQZ6xnT9apn+gnMFU6ZE0+CP9lpWQT1cylZfzN3zUJ85iAXP7ZOFL+wjisdVBaqZCx/ZoH3aOKAKzctz5LSElMOO+KXjRAAf6nCYg1OXrD8fr3qf8TBYE33l+D+Ocjz1OumTL2Zd3cFrWZ0D35MEz76VpAyW4VLy2Oq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyKqntCY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso5500439b3a.2;
        Wed, 30 Oct 2024 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300820; x=1730905620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MB84HWvBH3NxPapEB0SefI1X/ByDzD9jXGtFhi1lXmQ=;
        b=cyKqntCYqWa4Wuv75ghJh3/5k5omadFPBjrnJxLOjzbe05Z3dIfNDIB1Mvkcxdojma
         3Xym7OAJwAEiV28ywilcldB6vdAqhFGcGj1j43P6HT/MI+SmaTMBmjazdkkPlZC0U1xH
         aMj9w76fLpuEZhKQ5spEKOs3rP3daTJ0vHdSQWNm4WdFMUj/7nvfMsTr9LNOSWD068FH
         Aw9pES6+TC1dxBJn8xkFkwDZH4CC9hwDx53mTwWIA/xl11W8ubgdf+KQSbNFs/nV5bc0
         vtiVvSuYE0DUgxLKhXAWu6dJ029WCdmR1g0L+pYNu1dIWi05zKhqfZ5otUgMczR140y0
         XBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300820; x=1730905620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB84HWvBH3NxPapEB0SefI1X/ByDzD9jXGtFhi1lXmQ=;
        b=Z+IkyylVhvvzkWlGLQPOsvzSZHGWPeth90IPoJGLsE9P8DBLnLLvkuEeEfHYy9rPKQ
         knlo2S5msTH3/w88GzhArz8ou7ms+bqqw3OAPVq5dNbD7bJooUd9RZUqCEBxRoi8gECJ
         PRubGiGrVhVk9g1hlw4Al9PUoudN5kDMduDckGlOvQoJRhtpxF5mTRlTQ/K0MsZOvtIk
         nVeKHU+anxXbb9htvxmyX36m0TetKsW3fhIolbwNsOd7ORY0UCEfdAjiV1m+9iU7mOyh
         ROxgrc3wxc6YpjuMduqhR3E5MJAJnY5kTOUs4TK5sOY4dcL2fZoJYx8jvSwKek0cOhqg
         J59Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ok/PZDmOgKfwyf2sfsNsv+pugL+D7HpAjcEsIdey7ITwiPw+sB5JYw6Xn8gwbus7dOOBHkl5DB3jiZh2wf2G@vger.kernel.org, AJvYcCWZW/1IHF7OO6/rsw8ssdaC9J1YHicvXa3x8ByaMh0JRZ5FIb1B/Fku4i2zEwFAvgTm3VlRovW05wSQnYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2mzWKdVS6DRIcLArLHmas5JBJF3XqSl0okL7ol0RLZ10kTy9
	I7RuccRJF7lsZAieXw1sO1t9Vx3lntNqx6+L3Mihn9bYjrK2QzQ=
X-Google-Smtp-Source: AGHT+IHWQsFYQ+/1CjBOC2KuLnSgq+FLfdQk+eaCTU+JoZgp3d066RPg8EvTg7d1ZDBQIPuOzRDRIQ==
X-Received: by 2002:a05:6a00:3929:b0:71e:2a0:b0d0 with SMTP id d2e1a72fcca58-72062fd4b4bmr22516404b3a.13.1730300819407;
        Wed, 30 Oct 2024 08:06:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fc16sm9393619b3a.161.2024.10.30.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:06:59 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:06:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>, Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too
 long
Message-ID: <ZyJLkn3uM1Qz6NZn@mini-arch>
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com>
 <ZyJDxK5stZ_RF71O@mini-arch>
 <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>

On 10/30, Mina Almasry wrote:
> On Wed, Oct 30, 2024 at 7:33 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/29, Mina Almasry wrote:
> > > Check we're going to free a reasonable number of frags in token_count
> > > before starting the loop, to prevent looping too long.
> > >
> > > Also minor code cleanups:
> > > - Flip checks to reduce indentation.
> > > - Use sizeof(*tokens) everywhere for consistentcy.
> > >
> > > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >  net/core/sock.c | 46 ++++++++++++++++++++++++++++------------------
> > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 7f398bd07fb7..8603b8d87f2e 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> > >
> > >  #ifdef CONFIG_PAGE_POOL
> > >
> > > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> > > +/* This is the number of frags that the user can SO_DEVMEM_DONTNEED in
> > >   * 1 syscall. The limit exists to limit the amount of memory the kernel
> > > - * allocates to copy these tokens.
> > > + * allocates to copy these tokens, and to prevent looping over the frags for
> > > + * too long.
> > >   */
> > > -#define MAX_DONTNEED_TOKENS 128
> > > +#define MAX_DONTNEED_FRAGS 1024
> > >
> > >  static noinline_for_stack int
> > >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > > @@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > >       unsigned int num_tokens, i, j, k, netmem_num = 0;
> > >       struct dmabuf_token *tokens;
> > >       netmem_ref netmems[16];
> > > +     u64 num_frags = 0;
> > >       int ret = 0;
> > >
> > >       if (!sk_is_tcp(sk))
> > >               return -EBADF;
> > >
> > > -     if (optlen % sizeof(struct dmabuf_token) ||
> > > -         optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > > +     if (optlen % sizeof(*tokens) ||
> > > +         optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
> > >               return -EINVAL;
> > >
> > > -     tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> > > +     num_tokens = optlen / sizeof(*tokens);
> > > +     tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
> > >       if (!tokens)
> > >               return -ENOMEM;
> > >
> > > -     num_tokens = optlen / sizeof(struct dmabuf_token);
> > >       if (copy_from_sockptr(tokens, optval, optlen)) {
> > >               kvfree(tokens);
> > >               return -EFAULT;
> > >       }
> > >
> > > +     for (i = 0; i < num_tokens; i++) {
> > > +             num_frags += tokens[i].token_count;
> > > +             if (num_frags > MAX_DONTNEED_FRAGS) {
> > > +                     kvfree(tokens);
> > > +                     return -E2BIG;
> > > +             }
> > > +     }
> > > +
> > >       xa_lock_bh(&sk->sk_user_frags);
> > >       for (i = 0; i < num_tokens; i++) {
> > >               for (j = 0; j < tokens[i].token_count; j++) {
> > >                       netmem_ref netmem = (__force netmem_ref)__xa_erase(
> > >                               &sk->sk_user_frags, tokens[i].token_start + j);
> > >
> > > -                     if (netmem &&
> > > -                         !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> > > -                             netmems[netmem_num++] = netmem;
> > > -                             if (netmem_num == ARRAY_SIZE(netmems)) {
> > > -                                     xa_unlock_bh(&sk->sk_user_frags);
> > > -                                     for (k = 0; k < netmem_num; k++)
> > > -                                             WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > > -                                     netmem_num = 0;
> > > -                                     xa_lock_bh(&sk->sk_user_frags);
> > > -                             }
> > > -                             ret++;
> >
> > [..]
> >
> > > +                     if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> > > +                             continue;
> >
> > Any reason we are not returning explicit error to the callers here?
> > That probably needs some mechanism to signal which particular one failed
> > so the users can restart?
> 
> Only because I can't think of a simple way to return an array of frags
> failed to DONTNEED to the user.

I'd expect the call to return as soon as it hits the invalid frag
entry (plus the number of entries that it successfully refilled up to
the invalid one). But too late I guess.

> Also, this error should be extremely rare or never hit really. I don't
> know how we end up not finding a netmem here or the netmem is page.
> The only way is if the user is malicious (messing with the token ids
> passed to the kernel) or if a kernel bug is happening.

I do hit this error with 1500 mtu, so it would've been nice to
understand which particular token triggered that. It might be
something buggy on the driver side, I need to investigate. (it's
super low prio because 1500)

> Also, the information is useless to the user. If the user sees 'frag
> 128 failed to free'. There is nothing really the user can do to
> recover at runtime. Only usefulness that could come is for the user to
> log the error. We already WARN_ON_ONCE on the error the user would not
> be able to trigger.

I'm thinking from the pow of user application. It might have bugs as
well and try to refill something that should not have been refilled.
Having info about which particular token has failed (even just for
the logging purposes) might have been nice.

