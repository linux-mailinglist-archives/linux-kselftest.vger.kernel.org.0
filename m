Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4ED7131F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 04:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjE0C1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE0C1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 22:27:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192AEC9;
        Fri, 26 May 2023 19:27:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b011cffef2so11925005ad.3;
        Fri, 26 May 2023 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685154421; x=1687746421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGd3VhznQ2I/NQDk+4roFWXHVSOBmaxtJ+oHTP+UbGk=;
        b=n7sDEKh6jt4tjfPVQPZjuftdEuC76pajkpfPSZEdFb7ieTmVQ5SpkxQNB5yMcm06QN
         isB+1LbRGBHRIUuoBTXYa6Y702+fLmeOCqWjOutS3GZWlk7ZHJbef/Kcn2GDtcXt7Di5
         B0F10QB32YuiJwlAvNLeESVDkmplddaavJBcbyNa2aP2XC3bQ0hI5yR8F/Yxwe5RODhi
         Wb72xgb9IQXkByEhjLGwZbvv1kua9AC/H/Pkq96DLHrfA9rxhbQVjVHhbgkQ1B/bXkAB
         aHgoCQgsq+/XaBn2ddmY+9Iwi18VcA5IRBqMr6/eWKC+vitweWJ0fDlo+tr2j1vcbrHE
         eJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685154421; x=1687746421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGd3VhznQ2I/NQDk+4roFWXHVSOBmaxtJ+oHTP+UbGk=;
        b=RoreXIaO1cV//+dZ4Q5L7Jg8UBM/HBLCa8SGfk0qWsX6EpTCSaah62Kf8vj4rKnmOz
         F+QKuNJw6QlmNm69UdiIQikMgE7PzRI5xYT8lpZhIiaktHgPPWISFYPvd7LvwJH405Wn
         FdU5w7JqWPYTRX761kwzbeQQAkaswj1zjDADp5btEthHTwx4LMoeLx+kkuh+1xk6dPJI
         MQj1c9cj+efcvUTZRq/Lu03rO4uHlym77QxuVpLFK7JIKbFqOHQtWcke7wAEHltSR2a2
         YE4ydo0wZTNXA02Y4ZJ+CFbPkxKrpT1YQ8ZfdFEkmWgybqm6OOA0FPK1D4pYDeqNxDWc
         mHnw==
X-Gm-Message-State: AC+VfDyFEUPFdw8jQwcWdV8TZ5sTRBzMqHgTP5Xo0DbqyTScn/26JJAU
        JFm3VKkeVBK2NBrhsA3wnhVBq40hgo4GOOI/xvg=
X-Google-Smtp-Source: ACHHUZ6aAeSR4JF6rBXm5cC75wX5zCQJnq/3rFEcZQpE51VFfD85Rkd+KHCNiQAQXbtR9I84BTrFBx+V7cy+Ct2ere0=
X-Received: by 2002:a17:903:2345:b0:1af:f4f5:6fae with SMTP id
 c5-20020a170903234500b001aff4f56faemr5778765plh.54.1685154421346; Fri, 26 May
 2023 19:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684999824.git.haibo1.xu@intel.com> <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
 <20230525-705ddcbcd43aa63e3fd356c8@orel> <CAJve8onF9MFuaVsThFnhjWr6ZomB0Lhr9WXGvMiJDt5vrjeKLg@mail.gmail.com>
 <20230526-d8d768a23cd6bdc274bc165c@orel>
In-Reply-To: <20230526-d8d768a23cd6bdc274bc165c@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sat, 27 May 2023 10:26:51 +0800
Message-ID: <CAJve8on=5NtnzR=iAQs2D4B2Ly=KFXF-0ZDtkXFuz-SdxTGGmA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] KVM: riscv: selftests: Make check_supported arch specific
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 4:44=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, May 26, 2023 at 03:50:32PM +0800, Haibo Xu wrote:
> > On Fri, May 26, 2023 at 12:40=E2=80=AFAM Andrew Jones <ajones@ventanami=
cro.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 03:38:33PM +0800, Haibo Xu wrote:
> > > > check_supported() was used to verify whether a feature/extension wa=
s
> > > > supported in a guest in the get-reg-list test. Currently this info
> > > > can be retrieved through the KVM_CAP_ARM_* API in aarch64, but in
> > > > riscv, this info was only exposed through the KVM_GET_ONE_REG on
> > > > KVM_REG_RISCV_ISA_EXT pseudo registers.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/get-reg-list.c | 32 +++++++++++-------=
----
> > > >  1 file changed, 16 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/tes=
ting/selftests/kvm/get-reg-list.c
> > > > index f6ad7991a812..f1fc113e9719 100644
> > > > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > > > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > > > @@ -99,6 +99,20 @@ void __weak print_reg(const char *prefix, __u64 =
id)
> > > >  }
> > > >
> > > >  #ifdef __aarch64__
> > > > +static void check_supported(struct vcpu_reg_list *c)
> > > > +{
> > > > +     struct vcpu_reg_sublist *s;
> > > > +
> > > > +     for_each_sublist(c, s) {
> > > > +             if (!s->capability)
> > > > +                     continue;
> > >
> > > I was going to say that making this function aarch64 shouldn't be
> > > necessary, since riscv leaves capability set to zero and this functio=
n
> > > doesn't do anything, but then looking ahead I see riscv is abusing
> > > capability by putting isa extensions in it. IMO, capability should
> > > only be set to KVM_CAP_* values. Since riscv doesn't use it, then it
> > > should be left zero.
> > >
> > > If we're going to abuse something, then I'd rather abuse the 'feature=
'
> > > member, but since it's only an int (not an unsigned long), then let's
> > > just add an 'unsigned long extension' member.
> > >
> >
> > Good idea!
> >
> > For the new 'extension' member in riscv, I think its use case should be
> > identical to the 'feature' member in aarch64(KVM_RISCV_ISA_EXT_F
> > was similar to KVM_ARM_VCPU_SVE)? If so, I think we can just reuse
> > the 'feature' member since the data type was not a big deal.
>
> You're right. An int is fine for the isa extension index, which is all we
> need to represent.
>
> Thanks,
> drew

Thanks for the suggestion! I will include the change in v3 soon.
