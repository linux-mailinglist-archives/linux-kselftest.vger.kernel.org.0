Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9696ED2CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDXQp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjDXQp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 12:45:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AD444B1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Apr 2023 09:45:55 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-552a6357d02so54943727b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Apr 2023 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682354755; x=1684946755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cogHEMsVVgTDAgj3gPVUEVuPljtJmFM5khAyIfbROPI=;
        b=IBOU6rK79gND4DciwLkfyHJXLICK+nm1hfqmlYcnXaImIV8xf915qrkhfvrtFQ1bD9
         8Z+ZDwfy6VoKjQweFXwu2Ekk2xB4sANXClY8YQV834aQDs+/FEV0pbYJdQjAAZN9rs34
         f57BlCx+WuwQCSpj22oE82Xg3qgAyLXwOjmFBUce3BRWppaPMfsXHqc33YIYcz+3VNi4
         XAZAp7pRNW06LclNSKJAgnoHgP+fH1wRI4+4eovVUts+kprnZi5lybCwL9Zgev3v81H7
         MVICvn7IiG51PLSmT4j4PcXlaBgIbQc7j8zZ0ZG9H7yZWRSpCFId5KXjqGEfZQLGW0Na
         Tk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354755; x=1684946755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cogHEMsVVgTDAgj3gPVUEVuPljtJmFM5khAyIfbROPI=;
        b=kGXYep+0+Smjh8eE6yNs5yaJY/VrPiWCH39NbkNcaJaaSYtH3fBumZxI6J7hjcRMsK
         5MlHtDDuVW/jlDBDb8kwD/2WkB/N8k3YT4I3I0QnoQ1mGr8Kl1/uzOKUQ6gwlo0TerMR
         lNwXYIa6CW+EH8yaIR2Xqn+lP0tYLocfqg/5AA/SDqoxUFNe71gNDgkzpNPGBfR+tuCW
         2BiA8XRWWvqhl0SxA5l83OHG3DrphWWHOeVKEbz1WtwLEQfstyDQnWw3ECPFw3yfsrre
         K+Kg8mJFQmjAmDq0RZn1zFpKyKpjN1PMKCvSHNlICAKjrUF9WNXCiam7x5ra35GGrgdp
         Z1GA==
X-Gm-Message-State: AAQBX9etCOE+/1o0E3DOK7MLK0KSFVVY1jeOgAErxxSaMathtsZCJgUC
        Y05a9ZN14+J6Hp9Sg7F+cVCeTekFNTho61TwmErImg==
X-Google-Smtp-Source: AKy350bUMi1vCT3z4Q+q+kn/632Ww3gn+vAsPs+FHaqynFi9cqF64KYbnuQ/xodFFgeBsnoDvd5keBpYNYydhUX/nUI=
X-Received: by 2002:a0d:ccd0:0:b0:541:8735:171e with SMTP id
 o199-20020a0dccd0000000b005418735171emr9340453ywd.11.1682354754795; Mon, 24
 Apr 2023 09:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230421165305.804301-8-vipinsh@google.com> <202304220315.bpwbgH5n-lkp@intel.com>
In-Reply-To: <202304220315.bpwbgH5n-lkp@intel.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 24 Apr 2023 09:45:18 -0700
Message-ID: <CAHVum0cp=wfDmuK87jq7+2t5FnK09v1LownwqgS41EisT4Gc1g@mail.gmail.com>
Subject: Re: [PATCH 7/9] KVM: mmu: Move mmu lock/unlock to arch code for clear
 dirty log
To:     kernel test robot <lkp@intel.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com,
        oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 21, 2023 at 12:43=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Vipin,
>
> All warnings (new ones prefixed by >>):
>
>    arch/riscv/kvm/mmu.c: In function 'kvm_arch_mmu_enable_log_dirty_pt_ma=
sked':
> >> arch/riscv/kvm/mmu.c:399:9: warning: ISO C90 forbids mixed declaration=
s and code [-Wdeclaration-after-statement]
>      399 |         phys_addr_t base_gfn =3D slot->base_gfn + gfn_offset;
>          |         ^~~~~~~~~~~
>
>

I will fix it in v2.
