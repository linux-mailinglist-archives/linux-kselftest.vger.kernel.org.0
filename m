Return-Path: <linux-kselftest+bounces-48888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336DD1B0A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A41B302FBED
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611E36B055;
	Tue, 13 Jan 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNB74e70"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB535EDD1
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332475; cv=pass; b=MGQHB7FPFJ+zhpWA23dvUSX16I4W73hAAFWDGdX1vto+Jsli+tPI7fK/Euf8ymEoetchnToY23wMUym2CmotAMZ8ZQp15XWM0oGC7Sx0RrMHI2bj1Pmo0NKaFFRnS/JQmIGxEnyRpfshiKgTMOj5pqdx9hg19LB+ccfq0jOalRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332475; c=relaxed/simple;
	bh=4IsCMfhRh/B9Uo22vqTMh0RfCe5SWivcBNwMbwhIlPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8IKbC9qtAkeqK0NBWGZXoiubLUCSqkF7YbVRN8JZZPl2sVGARMDvo/K/fGkf4yznVyeKtWHM0i/lHqLlKwHB49nLOMFD2rDyLhQCIMG2SDDjT1ijTP64/EhjF+JauMg4Bf7u1V8nUx+spxuS1XfxaCWp8iR5crtJWmAy6lZ+i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNB74e70; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6935a784so888e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 11:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768332472; cv=none;
        d=google.com; s=arc-20240605;
        b=Qi7EunjdxOPUX+sSYRryET8f4ugPA6uko9O5SuVQ71JFfc+UFWgaeNjoNv6hdmN+Ku
         ihEFwLASZyBD+RogNHKBl1PcTzs7hs3tsxNU4KWowpbenRwtsAaW8v9blfg0DOd87mzx
         7BCbx9bHSMtppROYcu6Es/mASzyFiNDuuOmWDmN7WgbDKcJZItAtw+8ZrwC+fS9yYypq
         Lg/J1slk8eF5YaFWB9vUy0s+gvVf6g8HhzcZpgu35V7cjVd5A6rrtU4bIGFeUlAM2NLW
         hT3p9pP/e3Sv7Fek6GCX3sb5299X1nRuaJK88qSRkoickrsJ5ZLR7DnYwC9G5yg0LTdr
         btFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        fh=yIRsu9AudqQQWFmeUjNTihp7Ia51H6MRaYF7V4w1zI4=;
        b=bfU/STZpqORJKe1KM3E0Kh2+s5HfRadZVGbxEfCSo73HE1vMjzYzs7KG9Gr29IMTFJ
         phfxKGzJ5b2j2842MzLwFfBmtSdOQ8kmQ9ui3+Pe/4rbj/FPcuYxFPV5thf79aeG4wDe
         itEObJWcezdMpEv6058t6G62saPrklpP0YanfByS161mPv/m6aFlI8yClnHDouELo6rn
         Qh1FT8pSZRZvyO5r4O9nfe8I36Ps/S7NqQRpskpi7zLy7HftK3JbV/h929V/ckqKbesX
         tOzWqCIwgE7RNLIzRFQiDWWdjkgvMgFj9LXe3icAAArSz047tocab+GpMpCTUtKcpVzY
         c81w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768332472; x=1768937272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        b=gNB74e70F2Uskl0dxaCS2XnitZijgVCYmrn0xKONoazj27M+jR/iS6nIkLDUcqyuzb
         uKQjjJZwm9B3AXzFnmTMMcs8ecV8dki6GAYSzGSJgUmsK6BQ57gUUSVYLeayLtChd0cU
         bEhtFwb6wW0WzFIvDbzCGyZ6HZxLlva8ZFEqaOeOxtnHUYHuOe1FxN9drstApsNGtAVB
         srdYVI3cxCsIAmpmWZepn0P7I7XfXyToNtYSXzlCx0WEuhSjUNjl9FxJ11VHy51bu3Uh
         pczwLwEJfghCtOuXQohKw7avT2eVPxYFlHpPxmRUbZV+7pH0cKeE8h6AU2vSzRpCR4gY
         ToVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332472; x=1768937272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        b=ddDB+UfBkWxTUQ6SfTMCNIlv0//RmPeyRWwqATJ+bcqlQXmota37qZ6WjB0xdNsvVs
         18iQ4EFdLZ7uKJXLDS7PaFzcpvzOuglC5pMM/Eijd+ca/7Q9IPYGZWyHTiOt2ir6O9RP
         kJxKr8vEBaUNUpt6PrUBjxJqTmLjUBfsXZhlYMzSq+udP9ZmgcqzShbeauzUutLZ/qAb
         5+Dzor2U4ostXNXWq0H/QbCYysmDKGLD34Vmd8YbGuJgXF6HL6TKC280OOpjL27vDjK4
         jUsK8Z+EKIfYU55/ytlYc/UIobWhNAbwLhGBSPKFYruVQsb4oQMi2+MFWRRPxJCOfTlv
         9ggA==
X-Forwarded-Encrypted: i=1; AJvYcCVpyap9gq2VAEUrKEDEbHBOOpm4ZKu6yWFQWNmN7rb4o6Y2nc+W/gNbOLnP/vKTK/O1wtOtjrd5EkoOzyIeBU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZ6NEU7JIfGHXcKl04Uhox+r9mUJqhOhMUd58dtcD1YbmDr7w
	XSYSbNjiOIvTOp13I40eI31ta1beXkD3PScVbvM1U2jElOGoDBWpNPR2KJYdypSFgOAJ0Bpbyn9
	dFWmS4uKt+/KW9j8WW+bfrmwzOVtzCaly5R2kgQl2
X-Gm-Gg: AY/fxX55uqvq+pftrgEQlhp5hraoCHOtJo41TxNQ9oUFzgbXA3onnE4mGGzDV09T0Jn
	QJIWC+V034/acsHGviAgj9xcqCXr+YJeRS1q+OuYziC3z/AGS774L0SdDaXcwdOz3dVMYt+obP2
	tGDwTeWJmCX58ELYZ+ADgN193dEAHi6meI9qmbFx+w7pClOSuIAF8pAdrdgy4BH5//XdKr+5uVr
	WR/Mh5PiK+jq2qNCn+nuv+CvmSSnK4IBhHxFQpEQva/DaFuQ1p7HTiMdhdT/tTGoEhkZJ4fJFJ3
	3Ey03c/5BZ45n5CMXSy7rV4f
X-Received: by 2002:ac2:50a3:0:b0:59b:575a:734e with SMTP id
 2adb3069b0e04-59ba0c20474mr11294e87.9.1768332471126; Tue, 13 Jan 2026
 11:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com> <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
In-Reply-To: <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Jan 2026 11:27:38 -0800
X-Gm-Features: AZwV_Qh72XdPJ0Q75NEaLwmXlDEM3FmP8m-XvNun1YX56fFYinLxLpt6TBQb-mg
Message-ID: <CAHS8izMfw_m4ajVK-VHy-a4H4FXx45m33fP=vquHLGTJMX7aYA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/5] net: devmem: implement autorelease token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 8:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Sun, Jan 11, 2026 at 11:12:19AM -0800, Mina Almasry wrote:
> > On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> > >
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> > > Add support for autorelease toggling of tokens using a static branch =
to
> > > control system-wide behavior. This allows applications to choose betw=
een
> > > two memory management modes:
> > >
> > > 1. Autorelease on: Leaked tokens are automatically released when the
> > >    socket closes.
> > >
> > > 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
> > >
> > > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> > > attribute of the NETDEV_CMD_BIND_RX message. Having separate modes pe=
r
> > > binding is disallowed and is rejected by netlink. The system will be
> > > "locked" into the mode that the first binding is set to. It can only =
be
> > > changed again once there are zero bindings on the system.
> > >
> > > Disabling autorelease offers ~13% improvement in CPU utilization.
> > >
> > > Static branching is used to limit the system to one mode or the other=
.
> > >
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > ---
> > > Changes in v9:
> > > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVME=
M=3Dn
> > > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> > >   stubbed out when NET_DEVMEM=3Dn
> > > - only dec rx binding count for rx bindings in free (v8 did not exclu=
de
> > >   TX bindings)
> > >
> > > Changes in v8:
> > > - Only reset static key when bindings go to zero, defaulting back to
> > >   disabled (Stan).
> > > - Fix bad usage of xarray spinlock for sleepy static branch switching=
,
> > >   use mutex instead.
> > > - Access pp_ref_count via niov->desc instead of niov directly.
> > > - Move reset of static key to __net_devmem_dmabuf_binding_free() so t=
hat
> > >   the static key can not be changed while there are outstanding token=
s
> > >   (free is only called when reference count reaches zero).
> > > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be activ=
e
> > >   even after xa_erase(), so static key changes must wait until all
> > >   RX bindings are finally freed (not just when xarray is empty). A
> > >   counter is a simple way to track this.
> > > - socket takes reference on the binding, to avoid use-after-free on
> > >   sk_devmem_info.binding in the case that user releases all tokens,
> > >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > > - removed some comments that were unnecessary
> > >
> > > Changes in v7:
> > > - implement autorelease with static branch (Stan)
> > > - use netlink instead of sockopt (Stan)
> > > - merge uAPI and implementation patches into one patch (seemed less
> > >   confusing)
> > >
> > > Changes in v6:
> > > - remove sk_devmem_info.autorelease, using binding->autorelease inste=
ad
> > > - move binding->autorelease check to outside of
> > >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > > - remove overly defensive net_is_devmem_iov() (Mina)
> > > - add comment about multiple urefs mapping to a single netmem ref (Mi=
na)
> > > - remove overly defense netmem NULL and netmem_is_net_iov checks (Min=
a)
> > > - use niov without casting back and forth with netmem (Mina)
> > > - move the autorelease flag from per-binding to per-socket (Mina)
> > > - remove the batching logic in sock_devmem_dontneed_manual_release()
> > >   (Mina)
> > > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > > - remove single-binding restriction for autorelease mode (Mina)
> > > - unbind always checks for leaked urefs
> > >
> > > Changes in v5:
> > > - remove unused variables
> > > - introduce autorelease flag, preparing for future patch toggle new
> > >   behavior
> > >
> > > Changes in v3:
> > > - make urefs per-binding instead of per-socket, reducing memory
> > >   footprint
> > > - fallback to cleaning up references in dmabuf unbind if socket leake=
d
> > >   tokens
> > > - drop ethtool patch
> > >
> > > Changes in v2:
> > > - always use GFP_ZERO for binding->vec (Mina)
> > > - remove WARN for changed binding (Mina)
> > > - remove extraneous binding ref get (Mina)
> > > - remove WARNs on invalid user input (Mina)
> > > - pre-assign niovs in binding->vec for RX case (Mina)
> > > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > > - fix length of alloc for urefs
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> > >  include/net/netmem.h                    |   1 +
> > >  include/net/sock.h                      |   7 ++-
> > >  include/uapi/linux/netdev.h             |   1 +
> > >  net/core/devmem.c                       | 104 ++++++++++++++++++++++=
++++++----
> > >  net/core/devmem.h                       |  27 ++++++++-
> > >  net/core/netdev-genl-gen.c              |   5 +-
> > >  net/core/netdev-genl.c                  |  10 ++-
> > >  net/core/sock.c                         |  57 +++++++++++++++--
> > >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++----=
-
> > >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> > >  net/ipv4/tcp_minisocks.c                |   3 +-
> > >  tools/include/uapi/linux/netdev.h       |   1 +
> > >  13 files changed, 269 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/=
netlink/specs/netdev.yaml
> > > index 596c306ce52b..7cbe9e7b9ee5 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -562,6 +562,17 @@ attribute-sets:
> > >          type: u32
> > >          checks:
> > >            min: 1
> > > +      -
> > > +        name: autorelease
> > > +        doc: |
> > > +          Token autorelease mode. If true (1), leaked tokens are aut=
omatically
> > > +          released when the socket closes. If false (0), leaked toke=
ns are only
> > > +          released when the dmabuf is unbound. Once a binding is cre=
ated with a
> > > +          specific mode, all subsequent bindings system-wide must us=
e the same
> > > +          mode.
> > > +
> > > +          Optional. Defaults to false if not specified.
> > > +        type: u8
> > >
> > >  operations:
> > >    list:
> > > @@ -769,6 +780,7 @@ operations:
> > >              - ifindex
> > >              - fd
> > >              - queues
> > > +            - autorelease
> > >          reply:
> > >            attributes:
> > >              - id
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 9e10f4ac50c3..80d2263ba4ed 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -112,6 +112,7 @@ struct net_iov {
> > >         };
> > >         struct net_iov_area *owner;
> > >         enum net_iov_type type;
> > > +       atomic_t uref;
> > >  };
> > >
> > >  struct net_iov_area {
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -352,7 +352,7 @@ struct sk_filter;
> > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > >    *    @sk_scm_unused: unused flags for scm_recv()
> > >    *    @ns_tracker: tracker for netns reference
> > > -  *    @sk_user_frags: xarray of pages the user is holding a referen=
ce on.
> > > +  *    @sk_devmem_info: the devmem binding information for the socke=
t
> > >    *    @sk_owner: reference to the real owner of the socket that cal=
ls
> > >    *               sock_lock_init_class_and_name().
> > >    */
> > > @@ -584,7 +584,10 @@ struct sock {
> > >         struct numa_drop_counters *sk_drop_counters;
> > >         struct rcu_head         sk_rcu;
> > >         netns_tracker           ns_tracker;
> > > -       struct xarray           sk_user_frags;
> > > +       struct {
> > > +               struct xarray                           frags;
> > > +               struct net_devmem_dmabuf_binding        *binding;
> > > +       } sk_devmem_info;
> > >
> > >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> > >         struct module           *sk_owner;
> > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.=
h
> > > index e0b579a1df4f..1e5c209cb998 100644
> > > --- a/include/uapi/linux/netdev.h
> > > +++ b/include/uapi/linux/netdev.h
> > > @@ -207,6 +207,7 @@ enum {
> > >         NETDEV_A_DMABUF_QUEUES,
> > >         NETDEV_A_DMABUF_FD,
> > >         NETDEV_A_DMABUF_ID,
> > > +       NETDEV_A_DMABUF_AUTORELEASE,
> > >
> > >         __NETDEV_A_DMABUF_MAX,
> > >         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 05a9a9e7abb9..05c16df657c7 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/genalloc.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/netdevice.h>
> > > +#include <linux/skbuff_ref.h>
> > >  #include <linux/types.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <net/netdev_rx_queue.h>
> > > @@ -28,6 +29,19 @@
> > >
> > >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLO=
C1);
> > >
> > > +/* If the user unbinds before releasing all tokens, the static key m=
ust not
> > > + * change until all tokens have been released (to avoid calling the =
wrong
> > > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key=
 changes
> > > + * and binding alloc/free atomic with regards to each other, using t=
he
> > > + * devmem_ar_lock. This works because binding free does not occur un=
til all of
> > > + * the outstanding token's references on the binding are dropped.
> > > + */
> > > +static DEFINE_MUTEX(devmem_ar_lock);
> > > +
> > > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > > +static int net_devmem_dmabuf_rx_bindings_count;
> > > +
> > >  static const struct memory_provider_ops dmabuf_devmem_ops;
> > >
> > >  bool net_is_devmem_iov(struct net_iov *niov)
> > > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_=
struct *wq)
> > >
> > >         size_t size, avail;
> > >
> > > +       if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> > > +               mutex_lock(&devmem_ar_lock);
> > > +               net_devmem_dmabuf_rx_bindings_count--;
> > > +               if (net_devmem_dmabuf_rx_bindings_count =3D=3D 0)
> > > +                       static_branch_disable(&tcp_devmem_ar_key);
> > > +               mutex_unlock(&devmem_ar_lock);
> > > +       }
> > > +
> >
> > I find this loging with devmem_ar_lock and
> > net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
> > can do another simplification here? Can we have it such that the first
> > binding sets the system in autorelease on or autorelease off mode, and
> > all future bindings maintain this state? We already don't support
> > autorelease on/off mix.
>
> I think that would greatly simplify things. We would still need a lock
> to make the static branch change and first release mode setting atomic WR=
T
> each other, but the other parts (like the one above) can be
> removed.
>
> >
> >
> > >         gen_pool_for_each_chunk(binding->chunk_pool,
> > >                                 net_devmem_dmabuf_free_chunk_owner, N=
ULL);
> > >
> > > @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov=
)
> > >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> > >  }
> > >
> > > +static void
> > > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding=
 *binding)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > > +               struct net_iov *niov;
> > > +               netmem_ref netmem;
> > > +
> > > +               niov =3D binding->vec[i];
> > > +               netmem =3D net_iov_to_netmem(niov);
> > > +
> > > +               /* Multiple urefs map to only a single netmem ref. */
> > > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > > +       }
> > > +}
> > > +
> > >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *bind=
ing)
> > >  {
> > >         struct netdev_rx_queue *rxq;
> > > @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_d=
mabuf_binding *binding)
> > >                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params)=
;
> > >         }
> > >
> > > +       net_devmem_dmabuf_binding_put_urefs(binding);
> >
> > Sigh, I think what you're trying to do here is very complicated. You
> > need to think about this scenario:
> >
> > 1. user binds dmabuf and opens a autorelease=3Doff socket.
> > 2. Data arrives on these sockets, and sits in the receive queues,
> > recvmsg has not been called yet by the user.
> > 3. User unbinds the dma-buff, netmems are still in the receive queues.
> > 4. User calls recvmsg on one of these sockets, which obtains a uref on
> > the netmems in the receive queues.
> > 5. user closes the socket.
> >
> > With autorelease=3Don, this works, because the binding remains alive
> > until step 5 (even though it's unbound from the queue,
> > ..._binding_free has not been called yet) and step 5 cleans up all
> > references, even if the binding is unbound but alive, and
> >
> > calling net_devmem_dmabuf_binding_put_urefs here is weird.
> > Autorelease=3Doff implies the user must clean their urefs themselves,
> > but we have this here in the unbind path, and it doesn't even
> > guarantee that the urefs are free at this point because it may race
> > with a recvmsg.
> >
> > Should we delete this uref cleanup here, and enforce that
> > autorelease=3Doff means that the user cleans up the references (the
> > kernel never cleans them up on unbind or socket close)? The dontneed
> > path needs to work whether the binding is active or unbound.
> >
>
> I agree, I think we can do away with the "unbind drops references" idea.
> A counter argument could be that it introduces the ability for one
> process to interfere with another, but in fact that is already possible
> with autorelease=3Don by not issuing dontneed and starving the other of
> tokens.
>

On second thought I don't think we can remove the references drop
completely. AFAIU if the userspace misbehaves and doens't dontneed the
netmems in this setup, then the binding will leak forever, which is
really not great.

I think what may work is having a refcount on the binding for each
rxqueue it's bound to and each socket that's using it. Once that
refcount drops to 0, then we can be sure that the urefs in the binding
are not in use anymore, and we can drop the urefs, which should make
the binding refcount to hit 0 and the _binding_free() function to be
called.

--=20
Thanks,
Mina

