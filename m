Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDA798438
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjIHIiz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjIHIiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 04:38:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838FE1BDA;
        Fri,  8 Sep 2023 01:38:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so30007601fa.2;
        Fri, 08 Sep 2023 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694162330; x=1694767130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9vQxH9onfrK28u+5WMZD0gRjyvlyYYJRT4b/G78oIk=;
        b=LoWvFkP4asUfffVRTP3XzK+2OU/AaA6lXWNHyfhgUi+fg1O28eqBbd2d8874Ai+nTm
         BXwPJFCEouWWhVhc3jy6f1p9L7vVA3Vtjx1VYOyh4S2FLKU+H/l0LImKfkDovg6W0eT8
         f8J654kqtbAsBBaoUcHCIoZRGCG64xOLvXAjnuJfptkd9DTnNhKvOgKRkKwTUcUq8IJ8
         HDloKD1+3t/yzd0s/Ub+gzvSmUFOYzvf9+TF0eI6PBqmv5aCAaqwvAUeGxOWzVyBW7mm
         NR7ikvW4+h/vLfPATJ3D94L+tRBxyeIdUZMSyLhx1MYBD1l1S6uacrwYMfzRVhJN43Br
         ZB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162330; x=1694767130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9vQxH9onfrK28u+5WMZD0gRjyvlyYYJRT4b/G78oIk=;
        b=mLHIGHs2aR3wCnPJnHAOSGYuasMaqCQSBf3pmlsOifZfQ59wMaKDot7c8417tMXuZW
         rdF0zjEkgQ6hO14I0WmZJ6C58jyXjHOb6wbBXJwPtN0q89SKp+BUBfu87Oh8wmUCUDw/
         tYFmJJ2mD1AEyu7y1Fe9835WA4YT+L/BS7mNGCjgudStgpQEylr7IWU/so/Q9O+tUnXW
         nkSuXVNIw7SSSy39gpuNCmOuTQd2YY/6/OM/G70zFcgR4vvLcdMNjyia9f00FXtzQrQN
         jU3bnSo+f5Od7j8T7dmB0oDut10/YDFtNqAGwrji+z3jpXwSc74BvSU850xE8cNqKXjl
         6q0w==
X-Gm-Message-State: AOJu0YzmvryWOnA+mSM0omRKqEhgvJb3BdauOy7F/uX+jZpjAPTGyE4U
        4YD/AXTLbfnAh1rd50+jHWrz94wGxdvjePBiWxU=
X-Google-Smtp-Source: AGHT+IGpH71w1Ptr0GPFey4E1y9nxun4YjgFpDhb8bCi3gerZxMynKXdYk7q9SdRFK68afc8YsHN2wmbT6lnRUzklUs=
X-Received: by 2002:a2e:8917:0:b0:2bc:b75e:b8b with SMTP id
 d23-20020a2e8917000000b002bcb75e0b8bmr1480266lji.38.1694162329437; Fri, 08
 Sep 2023 01:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-10-puranjay12@gmail.com> <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
In-Reply-To: <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 8 Sep 2023 10:38:38 +0200
Message-ID: <CANk7y0jU1TheJ_=9R02WOJ_r1MoVzTUMGCZtkjAPfSpGaDm+BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 10:37=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Sep 07, 2023 at 11:05:50PM +0000, Puranjay Mohan wrote:
> > As Shubham has been inactive since 2017, Add myself for ARM32 BPF JIT.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  MAINTAINERS | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 612d6d1dbf36..c241856819bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3602,9 +3602,10 @@ F:     Documentation/devicetree/bindings/iio/acc=
el/bosch,bma400.yaml
> >  F:   drivers/iio/accel/bma400*
> >
> >  BPF JIT for ARM
> > -M:   Shubham Bansal <illusionist.neo@gmail.com>
> > +M:   Puranjay Mohan <puranjay12@gmail.com>
> > +R:   Shubham Bansal <illusionist.neo@gmail.com>
>
> Don't forget that I also want to review the changes, but I guess my
> arch/arm entry will cover this too.
>

Yes,
arch/arm automatically adds you for all patches.

Thanks,
Puranjay
