Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B886798936
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjIHOuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbjIHOuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 10:50:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6B1BF9;
        Fri,  8 Sep 2023 07:50:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500c7796d8eso3615175e87.1;
        Fri, 08 Sep 2023 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694184607; x=1694789407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkXpaqnjNB3MgoeN751DpK68gZT03o5yCj8DA/y5H7A=;
        b=o6c0WpbVBnvM7aBUGrytTaB7PeBA7UAKRsLybXqcUodQ3k3FhLN4JVwKEsW9ACTJPF
         WhlxYqlLKPPBpM0ZkqXNOyoLXQ/mrfa6rTQvVwifYt7Yqge8rQ1URCmYCgfE4SbaXLd6
         cPEnjEr55q91d+eL3G6aTZX4k/+/VsZb8JkathBi5MrniHV6jmO3VLqSDXh9yRSSgtcJ
         1t9OItP9A2bMNSDgp57/V1HGV7fiq4uQWNzLkmRdctl8EZi0NCWFph6+EmaI+BycCHAT
         1K9aCHCV7RHUIu4ATgtlSlGTs7zUwGUZZ4BWISTta9YMHWeB/gCfvdWaj2ly0A4UILYV
         BVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184607; x=1694789407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkXpaqnjNB3MgoeN751DpK68gZT03o5yCj8DA/y5H7A=;
        b=LA+cTpIYWscDR9DwPFpD8nQAu9LghpXdkzU6Zf05pObSoCLFWyH/YufC1FbuYNDrFt
         bdbNJU6gkvPb2f3cneLRNmLMSUHyCytL6n3r9/m6csdjwu0EkTqYeC9rjdr1Hi/4QWjc
         xncivhLR2V1KBGlxC9iV3xM/GSsJAsuumE9zFgMToe6Bd+YpLReYp3tpguYdpyCyTuig
         FkIN+OGV49QGbt+PLj0axjlsOLDT9wfx5tD0PeTIrU7iG2aDfmNUbdrW1R6nd3VHjEbr
         /1CKvK9IbSvCWoA8vxh1d6T8bDgSd/wmCSHHic1+Vovlb8C/okKNN052zu/Z18dzFWKq
         pAwg==
X-Gm-Message-State: AOJu0YxRTHjOmMukB+hygPpW8cCC1Hh5SuU/qOaU0q7iP5mUPuleRuwi
        ozqx/KEqWjSSvUTKuGF4VsBVK5xKpusp/y7RZHU=
X-Google-Smtp-Source: AGHT+IGjut71Cuf1/3pmiqmLb02iNPUrU25uVCWP3M7RvsHnz8LT9ZQ55XWw9sho3xxF+7tpfhEqQEs2hgIUqnclj2A=
X-Received: by 2002:a19:691c:0:b0:500:9f85:6e84 with SMTP id
 e28-20020a19691c000000b005009f856e84mr1757538lfc.3.1694184606718; Fri, 08 Sep
 2023 07:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-10-puranjay12@gmail.com> <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
 <1a4bc20a-b7ff-3697-5859-a2bb868c575f@iogearbox.net>
In-Reply-To: <1a4bc20a-b7ff-3697-5859-a2bb868c575f@iogearbox.net>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri, 8 Sep 2023 16:49:55 +0200
Message-ID: <CANk7y0izCD1Cwqpkf_i2Vi+QyS4ggdOEhJP0Uq_QWkLhp4zHwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 3:49=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 9/8/23 10:37 AM, Russell King (Oracle) wrote:
> > On Thu, Sep 07, 2023 at 11:05:50PM +0000, Puranjay Mohan wrote:
> >> As Shubham has been inactive since 2017, Add myself for ARM32 BPF JIT.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> ---
> >>   MAINTAINERS | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 612d6d1dbf36..c241856819bd 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -3602,9 +3602,10 @@ F:    Documentation/devicetree/bindings/iio/acc=
el/bosch,bma400.yaml
> >>   F: drivers/iio/accel/bma400*
> >>
> >>   BPF JIT for ARM
> >> -M:  Shubham Bansal <illusionist.neo@gmail.com>
> >> +M:  Puranjay Mohan <puranjay12@gmail.com>
> >> +R:  Shubham Bansal <illusionist.neo@gmail.com>
> >
> > Don't forget that I also want to review the changes, but I guess my
> > arch/arm entry will cover this too.
>
> If there are no objections from all parties, it would be nice/better if b=
oth of
> you (Puranjay & Russell) could be explicitly added here as maintainers.

Yes, I agree with that. Russell knows more about ARM than anyone else!

If I send another version for any other comments I get, I will include
this change.
But if this version of the series is applied, can you make this change
while applying the patch?

>
> Thanks,
> Daniel

Thanks,
Puranjay
