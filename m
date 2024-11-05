Return-Path: <linux-kselftest+bounces-21501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FF9BD7C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 22:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE321C22879
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27231D5CEB;
	Tue,  5 Nov 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4oAf7sJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03B1802AB;
	Tue,  5 Nov 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843170; cv=none; b=dmgLwWqmR5YAOdc+8UXJrhebRSTuwQ2UrifYp42PC59PF2dk8CyIWGHvzTenhi51lRYZIu6+Yzw27bzMDunPVgRF+VGsWY6KXQnzql3euGWodaM+2HRnUPrSAp5Shcqne87kaMVL3qrd6sZMF4kk4kN2yl+Rojv0aRSvmTA3hTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843170; c=relaxed/simple;
	bh=N3m1pmUCk5+shGGMJd14R0AcqDv48RJhC8SUV/O2lOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY2NCoN64vOVTmapHejzpitbQymhr16QmU8TuFnDVp8IE2jRQqJmt3uIFL/7BSBxdEblajKF9Rf7HhZP162JT4BMyUYyASWpZk2amACMRXUyejff4yZbVEMUlIcdSR5xLzsLFNXkpSvDqeNXkuxiNV25L5aVxAnBO9FUn45aTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4oAf7sJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso5351688b3a.2;
        Tue, 05 Nov 2024 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730843168; x=1731447968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybYPUXB/lIT5SsU4lxVN2yhYPcQ7G39uxj1h3toObWg=;
        b=I4oAf7sJ1M/qHbHZldxRf681UCL869uRLJHwDbabTlktzNaXKMK4I5Yw4Aoboyr9aA
         ZKKYeXEV8mXHBIab9CHOcUTB25YyoPlb5WGTlW6R0lbWq1Byssmste5whzIr7K350Nbw
         BCwjh7r7JADzEX7MCNGTy143PvV4obmdMweBwfyrTtwYScuZK/aIFBOTkskGOocwFpgk
         ukX9Zo4UX4j9mR0NQ6Rm7h33udSwYRcVAZevpZyc2+VBgZJVFtfei+R4qXb8DfraQMVx
         kY2Lxzh5kRBNdxpCYci+ZyfIR3xF3/l9GpvGumba/Hf0HJMXSn1mUvBVs+JofAxZNyRs
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730843168; x=1731447968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybYPUXB/lIT5SsU4lxVN2yhYPcQ7G39uxj1h3toObWg=;
        b=nRKtXUxien5Epqk4cM87ABSUvUTK83k0ctU9g3qi48tNi6KkQTT6PJiEsskKTuRwbo
         tibVJJP+DjEnCuIJF+nggusgytJzCvD3pOybbsCua8ZMf3q+selb2KL+8oRmUS+xHbtJ
         4/jxdBxgULBqaiN4R+9RCf/MJGHdgx12Nh7CRT2IQ3kugdE/2X+FBb9rJX0acy1wwxcs
         unobliAFZ47AuQijKQMsbkeeeXO/vZQTiiK4ALAdd8jbc9jq9KBmacckC3jBr7DoHq7j
         Pd8u43Uu4/2F6DVnPpAiwJSEFqWyj9w02l6cjJnOyKqVdokLSAHagGtp4usTx/hWn0TQ
         Ubkg==
X-Forwarded-Encrypted: i=1; AJvYcCVjLrQjx+YWhY+hKFxKSgGdRRwTyrKRq46leuH7ZIplkqCJpsSkMwqOl9M11gPN2obCRBgPf9IX8FMoRTJev6jF@vger.kernel.org, AJvYcCWD8ygbb64jJ0kTPyq7bOQDRH5MkWa778hfsJMHywydnrdgcZDb2OHku3Vjpe6u2VT38l0gpi0GGRZ+vo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6NNtwfMGDYYB+RLMH0UBO5wLY94Zhau2rkcf0qfCtaebe1e3
	GchT8Jq0QZQen31unu6KfwRywGxRF3ltedbBaJqRWNDpVPP3+VM=
X-Google-Smtp-Source: AGHT+IHqsl0o+82EOYrTKv1J51r+IusnmKEpN0rRI1L2Csi0pGjRd5wab4bo5mL9M6S5Efuodj99Jw==
X-Received: by 2002:a05:6a20:8413:b0:1db:ed7c:b8f6 with SMTP id adf61e73a8af0-1dbed7cb957mr7627058637.2.1730843167882;
        Tue, 05 Nov 2024 13:46:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5717sm10180608b3a.54.2024.11.05.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:46:07 -0800 (PST)
Date: Tue, 5 Nov 2024 13:46:06 -0800
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
Message-ID: <ZyqSHic5hW_vi47l@mini-arch>
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com>
 <ZyJDxK5stZ_RF71O@mini-arch>
 <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>
 <ZyJLkn3uM1Qz6NZn@mini-arch>
 <CAHS8izMWbcKSr3uOVWQDmo5=aQvFdcD6o_myz1bw=a1rzrJE_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMWbcKSr3uOVWQDmo5=aQvFdcD6o_myz1bw=a1rzrJE_A@mail.gmail.com>

On 11/05, Mina Almasry wrote:
> On Wed, Oct 30, 2024 at 8:07 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/30, Mina Almasry wrote:
> > > On Wed, Oct 30, 2024 at 7:33 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 10/29, Mina Almasry wrote:
> > > > > Check we're going to free a reasonable number of frags in token_count
> > > > > before starting the loop, to prevent looping too long.
> > > > >
> > > > > Also minor code cleanups:
> > > > > - Flip checks to reduce indentation.
> > > > > - Use sizeof(*tokens) everywhere for consistentcy.
> > > > >
> > > > > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > > > >
> > > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > >
> > > > > ---
> > > > >  net/core/sock.c | 46 ++++++++++++++++++++++++++++------------------
> > > > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > index 7f398bd07fb7..8603b8d87f2e 100644
> > > > > --- a/net/core/sock.c
> > > > > +++ b/net/core/sock.c
> > > > > @@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> > > > >
> > > > >  #ifdef CONFIG_PAGE_POOL
> > > > >
> > > > > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> > > > > +/* This is the number of frags that the user can SO_DEVMEM_DONTNEED in
> > > > >   * 1 syscall. The limit exists to limit the amount of memory the kernel
> > > > > - * allocates to copy these tokens.
> > > > > + * allocates to copy these tokens, and to prevent looping over the frags for
> > > > > + * too long.
> > > > >   */
> > > > > -#define MAX_DONTNEED_TOKENS 128
> > > > > +#define MAX_DONTNEED_FRAGS 1024
> > > > >
> > > > >  static noinline_for_stack int
> > > > >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > > > > @@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > > > >       unsigned int num_tokens, i, j, k, netmem_num = 0;
> > > > >       struct dmabuf_token *tokens;
> > > > >       netmem_ref netmems[16];
> > > > > +     u64 num_frags = 0;
> > > > >       int ret = 0;
> > > > >
> > > > >       if (!sk_is_tcp(sk))
> > > > >               return -EBADF;
> > > > >
> > > > > -     if (optlen % sizeof(struct dmabuf_token) ||
> > > > > -         optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > > > > +     if (optlen % sizeof(*tokens) ||
> > > > > +         optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
> > > > >               return -EINVAL;
> > > > >
> > > > > -     tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> > > > > +     num_tokens = optlen / sizeof(*tokens);
> > > > > +     tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
> > > > >       if (!tokens)
> > > > >               return -ENOMEM;
> > > > >
> > > > > -     num_tokens = optlen / sizeof(struct dmabuf_token);
> > > > >       if (copy_from_sockptr(tokens, optval, optlen)) {
> > > > >               kvfree(tokens);
> > > > >               return -EFAULT;
> > > > >       }
> > > > >
> > > > > +     for (i = 0; i < num_tokens; i++) {
> > > > > +             num_frags += tokens[i].token_count;
> > > > > +             if (num_frags > MAX_DONTNEED_FRAGS) {
> > > > > +                     kvfree(tokens);
> > > > > +                     return -E2BIG;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > >       xa_lock_bh(&sk->sk_user_frags);
> > > > >       for (i = 0; i < num_tokens; i++) {
> > > > >               for (j = 0; j < tokens[i].token_count; j++) {
> > > > >                       netmem_ref netmem = (__force netmem_ref)__xa_erase(
> > > > >                               &sk->sk_user_frags, tokens[i].token_start + j);
> > > > >
> > > > > -                     if (netmem &&
> > > > > -                         !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> > > > > -                             netmems[netmem_num++] = netmem;
> > > > > -                             if (netmem_num == ARRAY_SIZE(netmems)) {
> > > > > -                                     xa_unlock_bh(&sk->sk_user_frags);
> > > > > -                                     for (k = 0; k < netmem_num; k++)
> > > > > -                                             WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > > > > -                                     netmem_num = 0;
> > > > > -                                     xa_lock_bh(&sk->sk_user_frags);
> > > > > -                             }
> > > > > -                             ret++;
> > > >
> > > > [..]
> > > >
> > > > > +                     if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> > > > > +                             continue;
> > > >
> > > > Any reason we are not returning explicit error to the callers here?
> > > > That probably needs some mechanism to signal which particular one failed
> > > > so the users can restart?
> > >
> > > Only because I can't think of a simple way to return an array of frags
> > > failed to DONTNEED to the user.
> >
> > I'd expect the call to return as soon as it hits the invalid frag
> > entry (plus the number of entries that it successfully refilled up to
> > the invalid one). But too late I guess.
> >
> > > Also, this error should be extremely rare or never hit really. I don't
> > > know how we end up not finding a netmem here or the netmem is page.
> > > The only way is if the user is malicious (messing with the token ids
> > > passed to the kernel) or if a kernel bug is happening.
> >
> > I do hit this error with 1500 mtu, so it would've been nice to
> > understand which particular token triggered that. It might be
> > something buggy on the driver side, I need to investigate. (it's
> > super low prio because 1500)
> >
> 
> Hmm, I've never seen this, in production (code is similar to
> upstreamed, but I guess not exactly the same), and in my ncdevmem
> upstream testing.
> 
> FWIW leaked frags are extremely bad, because there is no opportunity
> to reap them until the entire dmabuf has been rebound. You will need
> to root cause this if you're seeing it and are interested in using
> devmem tcp in prod.
> 
> sk_user_frags is only really touched in:
> - sock_devmem_dontneed(), where they are removed from the xarray.
> - tcp_recvmsg_dmabuf(), where they are added to the xarray.
> - tcp_v4_destroy_sock(), where they are freed (but not removed from
> the xarray?!).
> 
> The only root causes for this bug I see are:
> 
> 1. You're racing tcp_v4_destroy_sock() with sock_devmem_dontneed(), so
> somehow you're trying to release a frag already released in that loop?
> Or,
> 2. You're releasing a frag that was never added by
> tcp_recvmsg_dmabuf(). I.e. There is a bug in tcp_recvmsg_dmabuf() that
> it put_cmsg the frag_id to the userspace but never adds it to the
> sk_user_frags. That should be accompanied by a ncdevmem validation
> error.
> 
> The way to debug #2 is really to test with the ncdevmem validation. I
> got the sense from reviewing the test series that you don't like to
> use it, but it's how I root cause such issues. You should familiarize
> yourself with it if you want to root cause such issues as well. To use
> it:
> 
> client: yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 \
>           | head -c 1G | nc <server ip> -p 5224
>  server: ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5224 -v 7
> 
> If you see a validation error with your missing frag, send me the
> logs, I may be able to guess what's wrong.

Ack, let's put this discussion on the stack and I'll resurrect it
once we have something upstream that's mimicking whatever I have
on my side in terms of generic devmem tx + device drivers :-)

> > > Also, the information is useless to the user. If the user sees 'frag
> > > 128 failed to free'. There is nothing really the user can do to
> > > recover at runtime. Only usefulness that could come is for the user to
> > > log the error. We already WARN_ON_ONCE on the error the user would not
> > > be able to trigger.
> >
> > I'm thinking from the pow of user application. It might have bugs as
> > well and try to refill something that should not have been refilled.
> > Having info about which particular token has failed (even just for
> > the logging purposes) might have been nice.
> 
> Yeah, it may have been nice. On the flip side it complicates calling
> sock_devmem_dontneed(). The userspace need to count the freed frags in
> its input, remove them, skip the leaked one, and re-call the syscall.
> On the flipside the userspace gets to know the id of the frag that
> leaked but the usefulness of the information is slightly questionable
> for me. :shrug:

Right, because I was gonna suggest for this patch, instead of having
a separate extra loop that returns -E2BIG (since this loop is basically
mostly cycles wasted assuming most of the calls are gonna be well behaved),
can we keep num_frags freed as we go and stop and return once
we reach MAX_DONTNEED_FRAGS?

for (i = 0; i < num_tokens; i++) {
	for (j ...) {
		netmem_ref netmem ...
		...
	}
	num_frags += tokens[i].token_count;
	if (num_frags > MAX_DONTNEED_FRAGS)
		return ret;
}

Or do you still find it confusing because userspace has to handle that?

