Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F55AF3E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIFSpn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFSpl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 14:45:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC872873;
        Tue,  6 Sep 2022 11:45:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l14so1840520eja.7;
        Tue, 06 Sep 2022 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HXIZTxgstp/ZG/oRasmhftNTYtNhQYTVNhwATRK01KA=;
        b=hso5o++/iG3WRGqeXqsqlTQG4ASV62xJHp+fXx6Mo5Dj1U7EnT5tcbEfg9QrccgK/R
         tnQv5lph3g5cU66MBB5hqlTwvZMB2d6SR9PZhlHnJuaCVyHDbfh+kPRp1piNBszvmaH+
         iodyQdSbiPG6Yh2sL/zLpLHSrCoKfahUPUddoiAFnt2Wx5Eg27ht6xTB1sM8zgTv2Ns4
         vmxmJAMVSkB/Xv788V6U5A4Q0mJhGVb6z09wE126tOirCZGg0U+LCSiMaM5rcTkGh0KM
         JLCss/3rpU5dxEq5E1FltyKECYuiiVuFr2smlNleBgB0soZUBy/qKRfbrmN2dXoDaWHE
         kwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HXIZTxgstp/ZG/oRasmhftNTYtNhQYTVNhwATRK01KA=;
        b=rf28j5elNEJUPYnvqg6HiiUbC2ThlwHRORJ57TJoE1IAyy8eBZWK6Fzuh5OijS9dIT
         PO3XcFQT4IPujM6GdWLbRWYMWCAlbbONq1aaRn1RljSunZVS80AeV1g0yu8L0memVEPs
         R7AfqNdWgzDw4uNbcSWe0wdPKAr0NeopM1HtFjm39WA620rXJOHFh/P0+og/DqK41Qgq
         r3P9DPBjaEDZ9hw+xQI4IiNqwKzEpj6pu67hG9Y/q5x1GvMSuVoSo6dmVs/q1SHMRGXG
         /5YwKz6eJbvn7d0gVaVsvE9R+7ndMo10IGIENKjK0AmNowSc1Y9oJaZKW5nLsjyx16ZS
         vsFQ==
X-Gm-Message-State: ACgBeo08XGmeOj2gO45/O+aaoktbrUhhiNt5Voizw70uc92rLehW/WHl
        htov2qFhPoj9i6JGN1T8e1KzY0ieGmfUAA+/rWc=
X-Google-Smtp-Source: AA6agR4F+9Ti9v8fFFnmPvQrhjZYULAf1awN9JWkYZiJxqfPg4ByBnj54CpE5wTOzCEUch0G8xs2kRSTxhaKwuoYWS4=
X-Received: by 2002:a17:906:58d1:b0:76d:af13:5ae3 with SMTP id
 e17-20020a17090658d100b0076daf135ae3mr6734331ejs.708.1662489938725; Tue, 06
 Sep 2022 11:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-7-roberto.sassu@huaweicloud.com> <CAP01T74HKXuf9Aig4v3zsL1rwQAGRpUtTiaN2djWsMiJmaqF_A@mail.gmail.com>
 <663480e6bdfd9809c9e367bfc8df95d7a1323723.camel@huaweicloud.com>
In-Reply-To: <663480e6bdfd9809c9e367bfc8df95d7a1323723.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Sep 2022 11:45:27 -0700
Message-ID: <CAADnVQLT9nSEqprcX_hmTeAYGVA9cWupVEfvhnyPuzWwrGKHcQ@mail.gmail.com>
Subject: Re: [PATCH v16 06/12] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 6, 2022 at 1:01 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> > > +struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> > > +{
> > > +       key_ref_t key_ref;
> > > +       struct bpf_key *bkey;
> > > +
> > > +       if (flags & ~KEY_LOOKUP_ALL)
> > > +               return NULL;
> > > +
> > > +       /*
> > > +        * Permission check is deferred until the key is used, as
> > > the
> > > +        * intent of the caller is unknown here.
> > > +        */
> > > +       key_ref = lookup_user_key(serial, flags,
> > > KEY_DEFER_PERM_CHECK);
> > > +       if (IS_ERR(key_ref))
> > > +               return NULL;
> > > +
> > > +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
> >
> > Since this function (due to lookup_user_key) is sleepable, do we
> > really need GFP_ATOMIC here?
>
> Daniel suggested it for bpf_lookup_system_key(), so that the kfunc does
> not have to be sleepable.

Hold on. It has to be sleepable. Just take a look
at what lookup_user_key is doing inside.

> For symmetry, I did the same to
> bpf_lookup_user_key(). Will switch back to GFP_KERNEL.
>
> Thanks
>
> Roberto
>
