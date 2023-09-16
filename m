Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B17A2BE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 02:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjIPAXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 20:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbjIPAW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 20:22:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DA44B9;
        Fri, 15 Sep 2023 17:19:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so29132525e9.1;
        Fri, 15 Sep 2023 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694823548; x=1695428348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9flE6dYRYbq8DBhx5GKkycXD3lGBgnPeT7V0R69zQo=;
        b=aWmezyHDC0gQyvdVa+K4eio5vDlXQQXuI0tjEx+ScKQC5ycdVE+yWuufMivTcQzTXN
         0uBmLBGvJFKr5ofuBF7yrHsP93lb81VaxRmQUcC0ArvDvD8+uDjxbCV46FhCILZJ0QKh
         ddAMPC7DObJe0BgXEn91nLX8QSxZI4eZ1iqFPH3ZbdkHU7etyuK3Snw5cRE8HpHP6Ltk
         YY9lMGt+B7jekIdiBh2bUF8hgmg+JZfG7WAoEoSio+zz5+cdY++QYwiHI4rBw+Y/orW7
         knoVCh7Ree7nlDE9ANVN/4nFxSKDz7pmSnvHkQDKZoBk2I8GYVNgIwlV/nlxP+hvGb6u
         0IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823548; x=1695428348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9flE6dYRYbq8DBhx5GKkycXD3lGBgnPeT7V0R69zQo=;
        b=AoGIiNOjm+QPzZQWiFQsklUMloYzH6TDgIgn5wEf+QBt4dZGW7+i4zUhiwKCCskMD5
         0zIti2r43CZ7K3qBKxD5Gkae1wM0DxiOqBAYcCM/DsWgZx3epF0QsZmVuPiSRUODk6S1
         aK8e/ku9xCYZBev0F49c4pkatyC2b6tRC35/f9wPfMRXrMiypIyg7hIBfeltTKJOt6t9
         LZ84HbDIHgT85n5ZVdRAHob/l60389nrljdHtLkhQZoCLryAqDkDZ/EToqgfC3e6brqj
         WMtZt/qpYFlN4m9R25Xv9O6puUm/JjFgS/iWFrY2BOKbQ+TtgiFkl+DINbRl6jqQKXz0
         i0tw==
X-Gm-Message-State: AOJu0YwyDNfxIcNR1QxBizHfQG2NLqi/cd0NvcxyDlp7RTFzOm+FH+le
        WbKVXQwM+rBhn1a3XN/+/cJmGm7vmz9zVI8UkBc=
X-Google-Smtp-Source: AGHT+IEPE6CWPA9ayILU9kIgGKupoUTtyfybCYP0bX1o30D1C/gOv6i+wOk2NCHx6iKJA0mKvgtDnM7QzusuVBVPd84=
X-Received: by 2002:a7b:cbcf:0:b0:401:cf0d:25cd with SMTP id
 n15-20020a7bcbcf000000b00401cf0d25cdmr2688762wmi.22.1694823548286; Fri, 15
 Sep 2023 17:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-10-puranjay12@gmail.com> <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
 <1a4bc20a-b7ff-3697-5859-a2bb868c575f@iogearbox.net> <CANk7y0izCD1Cwqpkf_i2Vi+QyS4ggdOEhJP0Uq_QWkLhp4zHwQ@mail.gmail.com>
In-Reply-To: <CANk7y0izCD1Cwqpkf_i2Vi+QyS4ggdOEhJP0Uq_QWkLhp4zHwQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 15 Sep 2023 17:18:56 -0700
Message-ID: <CAADnVQLBc1pc7rRb0vm-e5a-bYzdtCdL05HezEJXbfPMhqLBPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 7:50=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Fri, Sep 8, 2023 at 3:49=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
> >
> > On 9/8/23 10:37 AM, Russell King (Oracle) wrote:
> > > On Thu, Sep 07, 2023 at 11:05:50PM +0000, Puranjay Mohan wrote:
> > >> As Shubham has been inactive since 2017, Add myself for ARM32 BPF JI=
T.
> > >>
> > >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > >> ---
> > >>   MAINTAINERS | 5 +++--
> > >>   1 file changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index 612d6d1dbf36..c241856819bd 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -3602,9 +3602,10 @@ F:    Documentation/devicetree/bindings/iio/a=
ccel/bosch,bma400.yaml
> > >>   F: drivers/iio/accel/bma400*
> > >>
> > >>   BPF JIT for ARM
> > >> -M:  Shubham Bansal <illusionist.neo@gmail.com>
> > >> +M:  Puranjay Mohan <puranjay12@gmail.com>
> > >> +R:  Shubham Bansal <illusionist.neo@gmail.com>
> > >
> > > Don't forget that I also want to review the changes, but I guess my
> > > arch/arm entry will cover this too.
> >
> > If there are no objections from all parties, it would be nice/better if=
 both of
> > you (Puranjay & Russell) could be explicitly added here as maintainers.
>
> Yes, I agree with that. Russell knows more about ARM than anyone else!
>
> If I send another version for any other comments I get, I will include
> this change.
> But if this version of the series is applied, can you make this change
> while applying the patch?

I removed Shubham, since he didn't touch the code in years
and added Russell while applying.

Thanks a lot for upgrading the status of arm jit to Maintained !
This has been long overdue. We see increased use of BPF on arm32.
