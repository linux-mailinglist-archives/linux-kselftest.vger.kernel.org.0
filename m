Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3785EB5BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 01:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIZX1p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIZX1o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 19:27:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FE6EF29
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:27:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f193so7944299pgc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R4uQtEJE5e59CjrqKVswdXws/gcA7psIs8btH21+MPI=;
        b=GgFgwZi+ddAl59t5WyglkquklNhracaGBrF6jU0NtDfgG0IgyUN+puhncM4Se+w3hN
         3ew+w2WAJPxrfTMHOqMoH5NrrG6IkW5+egKVHdTceHhmZygy1KIcyJjeClsgKVlkj5ex
         oneWUpdx17BO4/PyBE6g+cJ8tE6d/72orSPDJT/z2Dn5cNhJcTxeiz73K/6cipRmQmPg
         5WSDE+Crbf2mdPFXkZYYQykqzOJxfF2M7gXPNUdqAk6rST36q6aTR2pVw3SdsdUcI5Zd
         7j5360faOwyI019TWu9zwCPdBHpnL9pJ3m2PtS+Z9jLoDEfpk2kTstRnVY5XOIb1KKxO
         K6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R4uQtEJE5e59CjrqKVswdXws/gcA7psIs8btH21+MPI=;
        b=VfURu4+Z+y7FViDrjCQ/0D3tAUmucK5ngVjVbV5hZhYlP8z0RLoHB08Nyuy8PyqV6m
         Pnrr+sIcrn11ew85014ecfbPLj2LFbOBYHjNQHXPj1Q8aJvz64r4FbBX/uQwF3Z6pDF8
         dwAVWWZUpW1r4MyNZh5atCkOtyH6ao3TMSaY/dv20/ExgTJwpb1vE1Fta4lH5UUVYgFS
         mge3Oxxke1TuxabpLnKln7wEcANh+lgLS4sQLetunDu6qWrOzPn51vKPAz61ut+MIu5p
         NTJLaO3y3zWo9faAnSViuVYDqyEP2solpa9KuB9H9DdOnKoVPzPuW6QdEfVzCGl4bcyc
         w2+Q==
X-Gm-Message-State: ACrzQf02kry7QhtoJJhu2rLs2b1I8p5l+jR3PWkUOMZpAuo8eUKgdrgS
        H64eiRiN0/uXPqlr8YlTpvVDOMm7DkCSeQo+pRM3g3fS3Vc=
X-Google-Smtp-Source: AMsMyM4Y0+nAEAfTHn3/Q+IPC10tZSPdNyafhAmVC2i9miBgZKk8ZEBtq5Y706fIgaHIfrIlYaLC0/EtPvVCFzYpGnY=
X-Received: by 2002:a63:1a51:0:b0:43b:e496:f2f4 with SMTP id
 a17-20020a631a51000000b0043be496f2f4mr22517497pgm.99.1664234861996; Mon, 26
 Sep 2022 16:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-5-vannapurve@google.com> <Yyt/xgPkHfbOE3vH@google.com>
In-Reply-To: <Yyt/xgPkHfbOE3vH@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:27:31 -0700
Message-ID: <CAGtprH-4nRyA81wock_OVwL-xA+LgNfqZFhJeE7T4iUyEscJKg@mail.gmail.com>
Subject: Re: [V2 PATCH 4/8] KVM: selftests: x86: Precompute the result for is_{intel,amd}_cpu()
To:     David Matlack <dmatlack@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 21, 2022 at 2:19 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:44AM +0000, Vishal Annapurve wrote:
> > Cache the vendor CPU type in a global variable so that multiple calls
> > to is_intel_cpu() do not need to re-execute CPUID.
> >
> > Add cpu vendor check in kvm_hypercall() so that it executes correct
> > vmcall/vmmcall instruction when running on Intel/AMD hosts. This avoids
> > exit to KVM which anyway tries to patch the instruction according to
> > the cpu type.
>
> The commit shortlog makes no mention (nor even implies) that this commit
> adds AMD support to kvm_hypercall(). Please break this commit up into 2.
> One to precompute the result of is_{intel,amd}_cpu() and one to add AMD
> support to kvm_hypercall().
>
> If you really want to keep this as one commit (I don't know what the
> benefit would be), please change the shortlog and commit message to
> focus on the kvm_hypercall() change, as that is the real goal of this
> commit. The precomputation is arguably and implementation detail. e.g.
>

is_amd_cpu is used by guest code within fix_hypercall_test.c, just
caching the result will break the guest code execution. I have clubbed
these two changes together in order to ensure that is_amd_cpu works
fine for both host userspace and guest vm logic.

>   KVM: selftest: Add support for AMD to kvm_hypercall()
>
>   Make it possible to use kvm_hypercall() on AMD by checking if running
>   on an AMD CPU and, if so, using vmmcall instead of vmcall. In order to
>   avoid executing CPUID in the guest on every call t kvm_hypercall()
>   (which would be slow), pre-compute the result of is_{intel,amd}_cpu()
>   as part of kvm_selftest_arch_init() and sync it into the guest
>   after loading the ELF image.
>
> But again, it'd be cleaner just to split it up. Caching the result of
> is_{intel,amd}_cpu() is useful in its own right, independent of the
> kvm_hypercall() change.
>
> >
> > ...
> >
> > @@ -1314,8 +1321,10 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
> >
> >  void kvm_selftest_arch_init(void)
> >  {
> > +     is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
> >  }
> >
> >  void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> >  {
> > +     sync_global_to_guest(vm, is_cpu_amd);
> >  }
> > --
> > 2.37.2.789.g6183377224-goog
> >
