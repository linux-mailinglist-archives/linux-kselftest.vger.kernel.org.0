Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB53B1432C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 21:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATULF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 15:11:05 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41168 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATULF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 15:11:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id k188so322227vsc.8;
        Mon, 20 Jan 2020 12:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xth3EtgYEr9cCam2cDoUD6NpryWMK2e99S9bi1lbry4=;
        b=nC5rqrrGQY7gR35JCs85zmytLqp7mTIA8CXBWjiEMxj1q/LFM5V2voZ5QYoV8YJGug
         l5TXoKeqUwKcTXW5CTbd/uNLGdpMNwN/wbu2wbo7LdNKTysGpfQCfAPonncIqepjsZ3L
         v0RkT+0iDS2SEuZHcs9W+oUBr4DPCl9D5O94dglZw7e2ea79zatANATUQo/b3PkOH1PC
         S6kTRo/DvOkXvFp2IkwlMiifZKlYliuiufs6MyjnE6XVumkQN6fbEX4fE6JuZ89fBL+K
         x3V/mp97wctD6qEVjXbOPJdU2U2X3pVinhu802Om2Cz/r0nYthZKa8EhK7ADOSAIo+1z
         x50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xth3EtgYEr9cCam2cDoUD6NpryWMK2e99S9bi1lbry4=;
        b=klZF7ZYl5xLoSmfaG6vgCN+JoXlL9hMCtDbqq2jGFP2ZJkVMaNw+HeX+qgcO3ADMnO
         v6yCVa+2JvBJne3j4NIDFnujadnJradKOLcNA45or4xEzp2t5yJEUme0p1GYTfXFtSxr
         dgJgN2shXuc19buZ6XCt9bE0bqWJDNw69Nbt1joT5qHcV6yKgb8i+VVszzn3y9lsbRc5
         KcXTpQj+txZnk7Eqtp2rfRCeBZslgCzWA4HfC2dTdT7g/t7Bd1ZK5JmJfz/yE1hvxwoA
         ro933qutnZAbOWUah6BkV+23pDBmLzX4L1D+XAIZEVXw1J5x/Dm+mdIlU4SgjxyFTjaS
         i+dQ==
X-Gm-Message-State: APjAAAUfTDTUz+TRGwpvpVB5ukIk9okgbkNaXkuVZRWB/v6x8axmRcdZ
        zTKkaNHdUEEgY8m9MXuaawrlzvFQIM/sYL6zdfY=
X-Google-Smtp-Source: APXvYqyfYRympPtR5ILUdmMjLkXO2qJbPP2AezExUv7W/qEpvcyKMvF1opAI4cYYpkjcE36jLHuRGRnmmuuzyvYAezc=
X-Received: by 2002:a67:15c7:: with SMTP id 190mr655163vsv.178.1579551063426;
 Mon, 20 Jan 2020 12:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20200118000128.15746-1-matthew.cover@stackpath.com>
 <5e23c773d7a67_13602b2359ea05b824@john-XPS-13-9370.notmuch> <CAGyo_hrUXWzui9FNiZpNGXjsphSreLEYYm4K7xkp+H+de=QKSA@mail.gmail.com>
In-Reply-To: <CAGyo_hrUXWzui9FNiZpNGXjsphSreLEYYm4K7xkp+H+de=QKSA@mail.gmail.com>
From:   Matt Cover <werekraken@gmail.com>
Date:   Mon, 20 Jan 2020 13:10:51 -0700
Message-ID: <CAGyo_hpcO-f9uxQFDfKZNz=1t6Yux+LzxN1qLHKf6PXMAtWQ-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add bpf_ct_lookup_{tcp,udp}() helpers
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Matthew Cover <matthew.cover@stackpath.com>,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jiong Wang <jiong.wang@netronome.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 20, 2020 at 11:11 AM Matt Cover <werekraken@gmail.com> wrote:
>
> On Sat, Jan 18, 2020 at 8:05 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Matthew Cover wrote:
> > > Allow looking up an nf_conn. This allows eBPF programs to leverage
> > > nf_conntrack state for similar purposes to socket state use cases,
> > > as provided by the socket lookup helpers. This is particularly
> > > useful when nf_conntrack state is locally available, but socket
> > > state is not.
> > >
> > > Signed-off-by: Matthew Cover <matthew.cover@stackpath.com>
> > > ---
> >
> > Couple coding comments below. Also looks like a couple build errors
> > so fix those up. I'm still thinking over this though.
>
> Thank you for taking the time to look this over. I will be looking
> into the build issues.

Looks like I missed static inline on a couple functions when
nf_conntrack isn't builtin. I'll include the fix in v2.

>
> >
> > Also I prefer the tests in their own patch. So make it a two patch
> > series.
>
> Sounds good. I will submit as a series for v2.
>
> >
> > fwiw I think we could build a native xdp lib for connection tracking
> > but maybe there are reasons to pull in core conn tracking. Seems like
> > a separate discussion.
>
> Native xdp connection tracking would be cool as well. Cilium seems to
> have ebpf conntrack; perhaps it can provide some useful insights into
> that effort.
>
> Even with native xdp connection tracking available, I see value in
> these helpers, particularly when core conntrack is already in use.
>
> >
> > > + * struct bpf_nf_conn *bpf_ct_lookup_udp(void *ctx, struct bpf_nf_conntrack_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
> > > + *   Description
> > > + *           Look for UDP nf_conntrack entry matching *tuple*, optionally in
> > > + *           a child network namespace *netns*. The return value must be
> > > + *           checked, and if non-**NULL**, released via
> > > + *           **bpf_ct_release**\ ().
> > > + *
> > > + *           The *ctx* should point to the context of the program, such as
> > > + *           the skb or xdp_md (depending on the hook in use). This is used
> > > + *           to determine the base network namespace for the lookup.
> > > + *
> > > + *           *tuple_size* must be one of:
> > > + *
> > > + *           **sizeof**\ (*tuple*\ **->ipv4**)
> > > + *                   Look for an IPv4 nf_conn.
> > > + *           **sizeof**\ (*tuple*\ **->ipv6**)
> > > + *                   Look for an IPv6 nf_conn.
> > > + *
> > > + *           If the *netns* is a negative signed 32-bit integer, then the
> > > + *           nf_conn lookup table in the netns associated with the *ctx* will
> > > + *           will be used. For the TC hooks, this is the netns of the device
> > > + *           in the skb. For XDP hooks, this is the netns of the device in
> > > + *           the xdp_md. If *netns* is any other signed 32-bit value greater
> > > + *           than or equal to zero then it specifies the ID of the netns
> > > + *           relative to the netns associated with the *ctx*. *netns* values
> > > + *           beyond the range of 32-bit integers are reserved for future
> > > + *           use.
> >
> > I find the usage of netns a bit awkward. Its being passed as a u64 and
> > then used as a signed int with the pivot depending on negative?
> >
> > How about pivot on a flag instead of the signed bit of netns here.
>
> The interface (and much of the code) is a clone of the
> bpf_sk_lookup_xxx helper functions. I figured having it match would
> both make it familiar and give this patch a better chance of being
> applied.
>
> I'd prefer not to diverge from bpf_sk_lookup_xxx helpers here. That
> is my only objection to what you propose.
>
> >
> > > + *
> > > + *           All values for *flags* are reserved for future usage, and must
> > > + *           be left at zero.
> > > + *
> > > + *           This helper is available only if the kernel was compiled with
> > > + *           **CONFIG_NF_CONNTRACK=y** configuration option.
> >
> > I suspect this should be,
> >
> > "This helper will return NULL if the kernel was compiled with ..."
> >
>
> Good idea. I'll work this into v2 for additional clarity.
>
> > Same comment for the earlier _tcp helper.
> >
> > > + *   Return
> > > + *           Pointer to **struct bpf_nf_conn**, or **NULL** in case of
> > > + *           failure.
> > > + *
> > > + * int bpf_ct_release(struct bpf_nf_conn *ct)
> > > + *   Description
> > > + *           Release the reference held by *ct*. *ct* must be a
> > > + *           non-**NULL** pointer that was returned from
> > > + *           **bpf_ct_lookup_xxx**\ ().
> > > + *   Return
> > > + *           0 on success, or a negative error in case of failure.
> > >   */
> > >  #define __BPF_FUNC_MAPPER(FN)                \
> > >       FN(unspec),                     \
> >
> > [...]
> >
> > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > >   * function eBPF program intends to call
> > > @@ -3278,6 +3363,30 @@ struct bpf_sock_tuple {
> > >       };
> > >  };
> > >
> > > +struct bpf_nf_conn {
> > > +     __u32 cpu;
> > > +     __u32 mark;
> > > +     __u32 status;
> > > +     __u32 timeout;
> > > +};
> > > +
> > > +struct bpf_nf_conntrack_tuple {
> > > +     union {
> > > +             struct {
> > > +                     __be32 saddr;
> > > +                     __be32 daddr;
> > > +                     __be16 sport;
> > > +                     __be16 dport;
> > > +             } ipv4;
> > > +             struct {
> > > +                     __be32 saddr[4];
> > > +                     __be32 daddr[4];
> > > +                     __be16 sport;
> > > +                     __be16 dport;
> > > +             } ipv6;
> > > +     };
> > > +};
> > > +
> >
> > [...]
> >
> > > +static int check_nf_ct_access(struct bpf_verifier_env *env, int insn_idx,
> > > +                          u32 regno, int off, int size,
> > > +                          enum bpf_access_type t)
> > > +{
> > > +     struct bpf_reg_state *regs = cur_regs(env);
> > > +     struct bpf_reg_state *reg = &regs[regno];
> > > +     struct bpf_insn_access_aux info = {};
> > > +     bool valid;
> > > +
> > > +     switch (reg->type) {
> > > +     case PTR_TO_NF_CONN:
> > > +             valid = bpf_nf_conn_is_valid_access(off, size, t, &info);
> > > +             break;
> > > +     default:
> > > +             valid = false;
> > > +     }
> > > +
> > > +     if (valid) {
> > > +             env->insn_aux_data[insn_idx].ctx_field_size =
> > > +                     info.ctx_field_size;
> > > +             return 0;
> > > +     }
> > > +
> > > +     verbose(env, "R%d invalid %s access off=%d size=%d\n",
> > > +             regno, reg_type_str[reg->type], off, size);
> > > +
> > > +     return -EACCES;
> >
> > nit, but this construction feels odd to me. How about,
> >
> >  if (reg->type != PTR_TO_NF_CONN) {
> >         verbose(...)
> >         return -EACCES;
> >  }
> >
> >  env-> ...
> >  return 0;
> >
> > The switch sort of implies you have some ideas on future types? What would
> > those be?
>
> Sure, I can reduce this down if desired. I was viewing it more as
> following the pattern seen in other check access functions.
>
> I do plan to introduce a "tcp_nf_conn" as another series, akin to
> "tcp_sock". When that happens this construct may make more sense.
>
> e.g.
>        case offsetof(struct bpf_tcp_nf_conn, state):
> ...
>                *insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
>                                offsetof(struct nf_conn, proto) +
>                                offsetof(union nf_conntrack_proto, tcp) +
>                                offsetof(struct ip_ct_tcp, state));
>
> >
> > > +}
> > > +
> > >  static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
> > >                            u32 regno, int off, int size,
> > >                            enum bpf_access_type t)
> > > @@ -2511,6 +2556,13 @@ static bool is_ctx_reg(struct bpf_verifier_env *env, int regno)
> > >       return reg->type == PTR_TO_CTX;
> > >  }
> >
> > [...]
> >
> >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 17de674..39ba965 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -74,6 +74,12 @@
> >
> > [...]
> >
> > > +static struct nf_conn *
> > > +__bpf_ct_lookup(struct sk_buff *skb, struct bpf_nf_conntrack_tuple *tuple, u32 len,
> > > +             struct net *caller_net, u8 proto, u64 netns_id, u64 flags)
> >
> > Why not just make netns an int instead of pulling a unsigned from the helper and
> > then converting it into an int?
>
> These three are mostly a question of if we want to diverge from
> __bpf_sk_lookup. If we choose to do so, then do we want to update
> __bpf_sk_lookup to match? I think there is benefit to having the
> uapi exposed interfaces match.
>
> >
> > > +{
> > > +     struct nf_conn *ct = NULL;
> > > +     u8 family = AF_UNSPEC;
> > > +     struct net *net;
> > > +
> > > +     if (len == sizeof(tuple->ipv4))
> > > +             family = AF_INET;
> > > +     else if (len == sizeof(tuple->ipv6))
> > > +             family = AF_INET6;
> > > +     else
> > > +             goto out;
> > > +
> > > +     if (unlikely(family == AF_UNSPEC || flags ||
> > > +                  !((s32)netns_id < 0 || netns_id <= S32_MAX)))
> >                                             ^^^^^^^^^^^^^^^^^^^^
> > If you pass an int here and use flags to set the type I think you avoid this
> > check.
>
> See previous.
>
> >
> > > +             goto out;
> > > +
> > > +     if ((s32)netns_id < 0) {
> >
> > I don't like this casting here again fallout from u64->int conversion.
>
> See previous.
>
> >
> > > +             net = caller_net;
> > > +             ct = ct_lookup(net, tuple, family, proto);
> > > +     } else {
> > > +             net = get_net_ns_by_id(caller_net, netns_id);
> > > +             if (unlikely(!net))
> > > +                     goto out;
> > > +             ct = ct_lookup(net, tuple, family, proto);
> > > +             put_net(net);
> > > +     }
> > > +
> > > +out:
> > > +     return ct;
> > > +}
> > > +
> >
> > [...]
> >
> > Thanks!
> > John
