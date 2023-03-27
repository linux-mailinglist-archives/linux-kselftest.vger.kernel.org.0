Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98EA6C9AE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjC0FhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0FhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 01:37:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8FE46B2;
        Sun, 26 Mar 2023 22:37:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7so6589952pjg.5;
        Sun, 26 Mar 2023 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679895426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17Q/a21Os9cWbwFfTki+6MWnuazyiTsoGrnUzugftcM=;
        b=kqNkyOSYtZsQHUhi1pt/Z4KNbxb3vB9SHFzZfpp5ePq/Ub35SEI8QIxzHLyeT8482v
         oQLYlEf73bHN6MKar+RzYF19mokBCVxIKD4SEfiSB/IqTZKbXv2HCMnk4KZ0D5G20fce
         1U/66F+kRH/eQJxEtVtGUcXL7rO6HIJv5jRP4PMn0oBN+OtJAe9hytHoCX2vrZvFJdz9
         /lC/PX1bit6UQRoFHXdSe3dcG++UyDupmzRPViHbSeEbPp35uDAR9FKp62IwaSf0r+rF
         OCKnTTD7DY4LiqjqHJIREyXUYkmKNApNXUSNN5A4hasNaCUd+QL1jxyNU7Nyb/eSKMHD
         4SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679895426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=17Q/a21Os9cWbwFfTki+6MWnuazyiTsoGrnUzugftcM=;
        b=g9OMG0hD3wxT2IyZbVS+9FxsPIEz9XpiYBZ+NESE7zM4sUi62pDoX41F9m6a9Q8Mrb
         Gi+wZvtIGE9UFPUeS+hcB1py3pfDSlNNJurqrSsixMzpcHOWi4GVl6dFeV6anPAf1Onz
         +B+Eg9FH2eEY0FTA6D5QP7Rm44FmOaNo16vFkO+vT6XdWyNKbQjihmwgf3J+h0Ss0o4H
         PHBzf5L8T66POqKVF6dJ2Mij4wo0mZeHSh7vkL/fxNe3YvsjunWHj5pz3jtm6GEoTiYw
         P4tRHT9CKx6MAp0wtu3DCsrt9nLtO1unf4pRtrMVGIhgbHuqij22KU6gGGvhwm3Eo/FH
         2Q8Q==
X-Gm-Message-State: AAQBX9fpa9CvfKy6Fxlc5+HNBeEYg9cDWyBWXLQ9/HWfXGWSWmhm/CIh
        U6yMublRE+EUjBPdnkrnjLw=
X-Google-Smtp-Source: AKy350Z6qEGELiKG+AyJP6kIcW+nh20RYN/4nrLns4ecVRm0Rw4pe5XPau2d4P+tCuf3230odCSb9w==
X-Received: by 2002:a17:902:f389:b0:19d:7a4:4063 with SMTP id f9-20020a170902f38900b0019d07a44063mr8547082ple.46.1679895426138;
        Sun, 26 Mar 2023 22:37:06 -0700 (PDT)
Received: from localhost ([203.221.180.225])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b0019f1264c7d7sm18220275plb.103.2023.03.26.22.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 22:37:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Mar 2023 15:37:00 +1000
Message-Id: <CRGX867PJCBF.1MV46YLYXMBYZ@bobo>
Cc:     "Paolo Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/2] KVM: PPC: support kvm selftests
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Sean Christopherson" <seanjc@google.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.13.0
References: <20230316031732.3591455-1-npiggin@gmail.com>
 <87ilf0nc95.fsf@mpe.ellerman.id.au> <ZBs9tGkI5OQqtIqs@google.com>
In-Reply-To: <ZBs9tGkI5OQqtIqs@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu Mar 23, 2023 at 3:41 AM AEST, Sean Christopherson wrote:
> On Thu, Mar 16, 2023, Michael Ellerman wrote:
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > > Hi,
> > >
> > > This series adds initial KVM selftests support for powerpc
> > > (64-bit, BookS).
> >=20
> > Awesome.
> > =20
> > > It spans 3 maintainers but it does not really
> > > affect arch/powerpc, and it is well contained in selftests
> > > code, just touches some makefiles and a tiny bit headers so
> > > conflicts should be unlikely and trivial.
> > >
> > > I guess Paolo is the best point to merge these, if no comments
> > > or objections?
> >=20
> > Yeah. If it helps:
> >=20
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> What is the long term plan for KVM PPC maintenance?  I was under the impr=
ession
> that KVM PPC was trending toward "bug fixes only", but the addition of se=
lftests
> support suggests otherwise.

We plan to continue maintaining it. New support and features has been a
bit low in the past couple of years, hopefully that will pick up a bit
though.

> I ask primarily because routing KVM PPC patches through the PPC tree is g=
oing to
> be problematic if KVM PPC sees signficiant development.  The current situ=
ation is
> ok because the volume of patches is low and KVM PPC isn't trying to drive=
 anything
> substantial into common KVM code, but if that changes...=20

Michael has done KVM topic branches to pull from a few times when such
conflicts came up (at smaller scale). If we end up with larger changes
or regular conflicts we might start up a kvm-ppc tree again I guess.

> My other concern is that for selftests specifically, us KVM folks are tak=
ing on
> more maintenance burden by supporting PPC.  AFAIK, none of the people tha=
t focus
> on KVM selftests in any meaningful capacity have access to PPC hardware, =
let alone
> know enough about the architecture to make intelligent code changes.
>
> Don't get me wrong, I'm very much in favor of more testing, I just don't =
want KVM
> to get left holding the bag.

Understood. I'll be happy to maintain powerpc part of kvm selftests and
do any fixes that are needed for core code changes.If support fell away
you could leave it broken (or rm -rf it if you prefer) -- I wouldn't ask
anybody to work on archs they don't know or aren't paid to.

Not sure if anything more can be done to help your process or ease your
mind. It (KVM and kvm-selftests) can run in QEMU at least.

Thanks,
Nick
