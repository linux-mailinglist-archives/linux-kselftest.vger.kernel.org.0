Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40F2683D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 06:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgINEz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 00:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgINEz4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 00:55:56 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F03C061787
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Sep 2020 21:55:55 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c8so16212631edv.5
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Sep 2020 21:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqosAhHP3STLWVtUuWjjxJ+4eGQNxDJjeZrpAkO58v0=;
        b=muv0Ut2UkVw+ItAZDtJuT8zITwLsU/+6hHQm1L7BfHshCr1TEDqZYhyPZHyNVuBh5a
         pEkQvhuMjJOH8qUlOT4Ak3+FLdYGkDaAIHPC6f47Ds4b9Ymaq+fQnMzKG3B0poHo0sQu
         sm6UDwUcErskdLLhsEC6/P4j6nRwDMu1rK3aj9nKuBGh6j23eiAQS5IAj7fYHsFjUJ4R
         qNpIOUdkopTWg4a0ZylwjPM4VZG0oS6q7og80mkqJTBunoHhQYAdTLjLmq8fUfd1vkE2
         +T2F1Q7wVbfpXHaA2zTpqrEc/9BZhiPu939bq/waR1bSOw9MZdKhD/qFIVR21eWujUBV
         iyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqosAhHP3STLWVtUuWjjxJ+4eGQNxDJjeZrpAkO58v0=;
        b=q6CSOyqUiJUPYhLd40xJxFrdYBQ1LCxu1VNNNRsu9ZyOGVYj2QdS+iLCMDrVwAI9lC
         opl6JkrnnJsLAvyjP5O5Bnta6aS90Xs+nDTrCHSpx4XlBymg/V8UdyaQ3SzrfenM13vc
         ebrAOcFdBn+1n3htJ+Uzi6OnXas4KMGTtQNgRN/P8Y67J0Yi2hp8rduGWQkIqm3QnTwn
         hb9jlcAWlzjxEAeaUMtCcngi2hrV0gXG27ceNVcndkXJhe+uVnDCZ6lYo+yE9bejOjGq
         i0lAcsg9IBfS703uIpiwUDpBq59yrS2yO/hPz6JiIdUdmF5QTJr1AzyJEsjqWIfQq79G
         Anwg==
X-Gm-Message-State: AOAM533djrZdgmAjGklo/H2lNIqC3EX4XDUyIun6vi5QMy1oKw9PavgR
        5hqJoqe4zkbKNXRT0V0t86IWT9G925eCHRFTcdc0bA==
X-Google-Smtp-Source: ABdhPJzEQXRLlS/igm2uxo39YYlMLCtYbj2f/9WEL7F+mvOHhK/aO9TCw/1+qsVvkDf82HPzVOKkhfi6QQda6Cu7EmY=
X-Received: by 2002:a05:6402:1acf:: with SMTP id ba15mr12641299edb.305.1600059353876;
 Sun, 13 Sep 2020 21:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200903223332.881541-1-haoluo@google.com> <20200903223332.881541-2-haoluo@google.com>
 <CAEf4BzZSPb0qWc5_FxsrzykUJa245VgkX-U6xstDM7Durh50gw@mail.gmail.com>
In-Reply-To: <CAEf4BzZSPb0qWc5_FxsrzykUJa245VgkX-U6xstDM7Durh50gw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sun, 13 Sep 2020 21:55:42 -0700
Message-ID: <CA+khW7hTiaBXUQjhU8a-9icZbaiX_zpN93-07b4r51aJ4XwcPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce pseudo_btf_id
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii,

Sorry for the late reply. Your suggestions are concrete and helpful. I
can apply them in v3.

Thanks!
Hao

On Fri, Sep 4, 2020 at 12:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 3:34 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Pseudo_btf_id is a type of ld_imm insn that associates a btf_id to a
> > ksym so that further dereferences on the ksym can use the BTF info
> > to validate accesses. Internally, when seeing a pseudo_btf_id ld insn,
> > the verifier reads the btf_id stored in the insn[0]'s imm field and
> > marks the dst_reg as PTR_TO_BTF_ID. The btf_id points to a VAR_KIND,
> > which is encoded in btf_vminux by pahole. If the VAR is not of a struct
> > type, the dst reg will be marked as PTR_TO_MEM instead of PTR_TO_BTF_ID
> > and the mem_size is resolved to the size of the VAR's type.
> >
> > From the VAR btf_id, the verifier can also read the address of the
> > ksym's corresponding kernel var from kallsyms and use that to fill
> > dst_reg.
> >
> > Therefore, the proper functionality of pseudo_btf_id depends on (1)
> > kallsyms and (2) the encoding of kernel global VARs in pahole, which
> > should be available since pahole v1.18.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
>
> Logic looks correct, but I have a few suggestions for naming things
> and verifier logs. Please see below.
>
> >  include/linux/bpf_verifier.h   |   4 ++
> >  include/linux/btf.h            |  15 +++++
> >  include/uapi/linux/bpf.h       |  38 ++++++++---
> >  kernel/bpf/btf.c               |  15 -----
> >  kernel/bpf/verifier.c          | 112 ++++++++++++++++++++++++++++++---
> >  tools/include/uapi/linux/bpf.h |  38 ++++++++---
> >  6 files changed, 182 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 53c7bd568c5d..a14063f64d96 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -308,6 +308,10 @@ struct bpf_insn_aux_data {
> >                         u32 map_index;          /* index into used_maps[] */
> >                         u32 map_off;            /* offset from value base address */
> >                 };
> > +               struct {
> > +                       u32 pseudo_btf_id_type; /* type of pseudo_btf_id */
> > +                       u32 pseudo_btf_id_meta; /* memsize or btf_id */
>
> a bit misleading names, not clear at all in the code what's in there.
> This section is for ldimm64 insns that are loading BTF variables,
> right? so how about this:
>
> struct {
>     u32 reg_type;
>     union {
>         u32 btf_id;
>         u32 memsize;
>     };
> } btf_var;
>
> In case someone hates non-anonymous structs, I'd still go with
> btf_var_reg_type, btf_var_btf_id and btf_var_memsize.
>
> > +               };
> >         };
> >         u64 map_key_state; /* constant (32 bit) key tracking for maps */
> >         int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index a9af5e7a7ece..592373d359b9 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -106,6 +106,21 @@ static inline bool btf_type_is_func_proto(const struct btf_type *t)
> >         return BTF_INFO_KIND(t->info) == BTF_KIND_FUNC_PROTO;
> >  }
> >
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b4e9c56b8b32..3b382c080cfd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7398,6 +7398,24 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >                 return 0;
> >         }
> >
> > +       if (insn->src_reg == BPF_PSEUDO_BTF_ID) {
> > +               u32 type = aux->pseudo_btf_id_type;
> > +               u32 meta = aux->pseudo_btf_id_meta;
> > +
> > +               mark_reg_known_zero(env, regs, insn->dst_reg);
> > +
> > +               regs[insn->dst_reg].type = type;
> > +               if (type == PTR_TO_MEM) {
> > +                       regs[insn->dst_reg].mem_size = meta;
> > +               } else if (type == PTR_TO_BTF_ID) {
> > +                       regs[insn->dst_reg].btf_id = meta;
>
> nit: probably worthwhile to introduce a local variable (dst_reg) to
> capture pointer to regs[insn->dst_reg] in this entire function. Then
> no reall need for type and meta local vars above, everything is going
> to be short and sweet.
>
> > +               } else {
> > +                       verbose(env, "bpf verifier is misconfigured\n");
> > +                       return -EFAULT;
> > +               }
> > +               return 0;
> > +       }
> > +
> >         map = env->used_maps[aux->map_index];
> >         mark_reg_known_zero(env, regs, insn->dst_reg);
> >         regs[insn->dst_reg].map_ptr = map;
> > @@ -9284,6 +9302,74 @@ static int do_check(struct bpf_verifier_env *env)
> >         return 0;
> >  }
> >
> > +/* replace pseudo btf_id with kernel symbol address */
> > +static int check_pseudo_btf_id(struct bpf_verifier_env *env,
> > +                              struct bpf_insn *insn,
> > +                              struct bpf_insn_aux_data *aux)
> > +{
> > +       u32 type, id = insn->imm;
> > +       const struct btf_type *t;
> > +       const char *sym_name;
> > +       u64 addr;
> > +
> > +       if (!btf_vmlinux) {
> > +               verbose(env, "%s: btf not available. verifier misconfigured.\n",
> > +                       __func__);
>
> verifier logs so far hasn't used __func__ and it's not all that
> meaningful to users and might change due to later refactorings.
>
> Also, in this particular case, it's not a verifier misconfiguration,
> but rather that the kernel doesn't have a built-in BTF, so suggest
> enabling CONFIG_DEBUG_INFO_BTF=y.
>
> "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified
> in Kconfig"
>
> > +               return -EINVAL;
> > +       }
> > +
> > +       t = btf_type_by_id(btf_vmlinux, id);
> > +       if (!t) {
> > +               verbose(env, "%s: invalid btf_id %d\n", __func__, id);
>
> "ldimm64 insn specifies invalid btf_id %d"? add similar context below
>
> > +               return -ENOENT;
> > +       }
> > +
> > +       if (insn[1].imm != 0) {
> > +               verbose(env, "%s: BPF_PSEUDO_BTF_ID uses reserved fields\n",
> > +                       __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!btf_type_is_var(t)) {
> > +               verbose(env, "%s: btf_id %d isn't KIND_VAR\n", __func__, id);
> > +               return -EINVAL;
> > +       }
> > +
> > +       sym_name = btf_name_by_offset(btf_vmlinux, t->name_off);
> > +       addr = kallsyms_lookup_name(sym_name);
> > +       if (!addr) {
> > +               verbose(env, "%s: failed to find the address of symbol '%s'.\n",
> > +                       __func__, sym_name);
> > +               return -ENOENT;
> > +       }
> > +
>
> [...]
>
> > @@ -9394,10 +9480,14 @@ static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
> >                 map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> >  }
> >
> > -/* look for pseudo eBPF instructions that access map FDs and
> > - * replace them with actual map pointers
> > +/* find and rewrite pseudo imm in ld_imm64 instructions:
> > + *
> > + * 1. if it accesses map FD, replace it with actual map pointer.
> > + * 2. if it accesses btf_id of a VAR, replace it with pointer to the var.
> > + *
> > + * NOTE: btf_vmlinux is required for converting pseudo btf_id.
> >   */
> > -static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
> > +static int replace_pseudo_imm_with_ptr(struct bpf_verifier_env *env)
>
> nit: I'd call this something like "resolve_pseudo_ldimm64" instead.
> ptr here is an implementation detail of map pointers ldimm64 and
> doesn't even match what we are doing for pseudo_btf_id
>
> >  {
> >         struct bpf_insn *insn = env->prog->insnsi;
> >         int insn_cnt = env->prog->len;
> > @@ -9438,6 +9528,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
> >                                 /* valid generic load 64-bit imm */
> >                                 goto next_insn;
> >
> > +                       if (insn[0].src_reg == BPF_PSEUDO_BTF_ID) {
> > +                               aux = &env->insn_aux_data[i];
> > +                               err = check_pseudo_btf_id(env, insn, aux);
> > +                               if (err)
> > +                                       return err;
> > +                               goto next_insn;
> > +                       }
> > +
> >                         /* In final convert_pseudo_ld_imm64() step, this is
> >                          * converted into regular 64-bit imm load insn.
> >                          */
>
> [...]
