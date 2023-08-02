Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654076C278
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 03:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHBBt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHBBt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 21:49:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF4F1;
        Tue,  1 Aug 2023 18:49:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso96645671fa.1;
        Tue, 01 Aug 2023 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690940993; x=1691545793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osh2QzFqlR35dfQcM6kbuTsPkPVP7EKWxGwqrnyTeuE=;
        b=luv5rojCzLMutf0EdY5ggrtpaKLCla7/HLXFzwmgg3epBqLg6krc55npCFOJDq8J7s
         yS7NIP+SSgtkSVgvF2FahyaUXKiualiR5vAE3BaRNdCuezwhebQoxJCervRgsKwfh8jk
         CpHMcqLqfG65PEHWSr+bfGRZ/K5vAE8ao7j9Gb1L8zAWqSZpGsJuRDuem0/YjMq90sZJ
         9wGc6I3HTxKJfl9EjjXjx9n0AhOKn9PuBzpkZMXEoBnRV8gyib4QuF/K094s61wjMrLi
         izjX+FffITTKOghS7+L3eLUoVWjsuXJQArk/FrrwLOdXsZbwqYOW0gHj2qlDrXqEbjiv
         Htgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690940993; x=1691545793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osh2QzFqlR35dfQcM6kbuTsPkPVP7EKWxGwqrnyTeuE=;
        b=ge5li8OL7sT2kXGvDM8hy8Skwo5C43SuZZUva9L34Xpk+60yn+aOhfoR/Olgxjo8gK
         4sGTA8a4MvbaGfJau54YNGSMi9xxVRlltL1Q/l5C5QDthHEUcRfjOtGb4vGEs1x26u2g
         vyy3StJRJXcrJ3Vq3geYfTtoCmw13ZqYC+cKYWEXcr23Q1Av1xKyARkBOXytuPmn9wdA
         mFp9gyBoLpBlNyaQLLsBCDaik6pjGvYaPH7FHA7ohrj2zmBS04iGnr90gHt5X3wQRDSu
         o8mBrmSG0ADzio9Ye2U2kiRnN5w0S1yppVkbA1VlYdgsz7ES14Y5Ugu56tl/xRB+OYhG
         r68g==
X-Gm-Message-State: ABy/qLaRb8KApyjCuFXXj5/POMLGYAkYJda0I63zCuSQ427TjqcunpTN
        JauOpKbqDwcxr/Au7Taunah1R6AHDgq+vXNSEUQ=
X-Google-Smtp-Source: APBJJlFPZxnrL0coWXV1wozSrGT9QV8qKhr1NGYaGxC33NM0EtZXQ7yT6tiSIfNED9fNzjzTa7o0vUY+Rf6umhSOp/U=
X-Received: by 2002:a2e:9457:0:b0:2b9:ea87:7448 with SMTP id
 o23-20020a2e9457000000b002b9ea877448mr3562252ljh.49.1690940993017; Tue, 01
 Aug 2023 18:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <7e9d2d5518375083f10c92a3d1acd98914f69fd8.1690364259.git.haibo1.xu@intel.com>
 <20230728-21d0e3ecb0d8916fd9d9bceb@orel> <ZMPR56RVgzI6s6Ik@google.com>
In-Reply-To: <ZMPR56RVgzI6s6Ik@google.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 2 Aug 2023 09:49:41 +0800
Message-ID: <CAJve8o=FO6hHmu=zthUDdyM7y2RN2VPRanCrBHuBJZeTPxV10Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: riscv: selftests: Add exception handling support
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Colton Lewis <coltonlewis@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 11:53=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Jul 28, 2023, Andrew Jones wrote:
> > On Thu, Jul 27, 2023 at 03:20:06PM +0800, Haibo Xu wrote:
> > > +void vm_init_trap_vector_tables(struct kvm_vm *vm);
> > > +void vcpu_init_trap_vector_tables(struct kvm_vcpu *vcpu);
> >
> > I think we should use a common name for these prototypes that the other
> > architectures agree to and then put them in a common header. My vote fo=
r
> > the naming is,
>
> Just allocate the tables in kvm_arch_vm_post_create().  I've been meaning=
 to
> convert x86 and ARM, but keep getting distracted/waylaid by other things.
>
> https://lore.kernel.org/all/Y8hCBOndYMD9zsDL@google.com
>
> >   void vm_init_vector_tables(struct kvm_vm *vm);
> >   void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
> >
> > > +
> > > +typedef void(*handler_fn)(struct ex_regs *);
> > > +void vm_install_exception_handler(struct kvm_vm *vm, int ec, handler=
_fn handler);
> >
> > I'd also put this typedef
>
> And rename it to (*exception_handler_fn).
>
> > and prototype in a common header (with s/ec/vector/ to what you have he=
re)
>
> Hmm, yeah, I think it makes sense to let vm_install_exception_handler() b=
e used
> from common code.  the vector to be installed is inherently arch specific=
, but
> it would be easy enough for a test to use #ifdeffery to define the correc=
t vector.

Thanks for the suggestion. I'll have a try to consolidate these codes in v2=
.
