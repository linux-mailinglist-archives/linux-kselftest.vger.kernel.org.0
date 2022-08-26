Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89055A203B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiHZFQa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:16:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C76A4B4;
        Thu, 25 Aug 2022 22:16:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w19so1082512ejc.7;
        Thu, 25 Aug 2022 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lK9A6HApSBZz4Q8ytvV3N4o8vcU6tZHo4HuclO+ZHvs=;
        b=L0/cvHT0Ml5scIBeMcDx9EkRPSLMkAQcp1Vo3CWs/Ru1P55rSqeddvraugU4IWQ3TY
         Ot/C98VePC/bofOrq9SE6zqxw8fHEWvbcpGD3mIts5vrkqH2muvr6JdpSWK7ei3mKjaR
         W2/XpsCmZ4pqTtSF9KYdOHuj6OgUlx2aAAPpDNszBRlcoIOOlFw9QcCLT7XnRB7RRZ3b
         rIV9a0H+K0QT5WyeeCivIz+DZSXOyIr+V7DSIPiqb9k9BopCZyC37QPyesNTCit0PL3X
         kfL81CLlSr5VmLQ2PJ9lwjzNVHkn6bLIEBZS4hEcnEAJAZ36Dik5WUhc/vdXxLzfQuBH
         i2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lK9A6HApSBZz4Q8ytvV3N4o8vcU6tZHo4HuclO+ZHvs=;
        b=kVvlc89MSBUs/hj8ayfgOQC0yUOroi3TDs+6nj8+Mn/Vppnl4KxtBHAmIq5a0JXM6C
         8CrruD+IGBYhtliHP9Ve5L3aCZAVLA/1xFA8l97c7PvogtKv08o4pHfTVQTLIRwyJGTz
         eRCfz8SGmvY0jxAj21XByFKxF4wiW7kYbCSJhwuNnPeFihkE3NYhcdXR85u5Gt5EvF0x
         IvKPf0+d1f5rkkHnkwQ+sdDaR0/06421mrN/fcejBjYYq90KdfW/QWOCzSqCLv4/q85V
         EMSSgWxO5mRQPr7P9vnBD/6m4ETu7LtKZEX8KnjzIDKqXYbcYxDsk+wJPEiAC0yxLEBi
         WkDA==
X-Gm-Message-State: ACgBeo0KgyM3/fafRGyx0Nz33jkQSqm48hF+0CDysOjwb7FszdZ59cZz
        EyHe8DuvRu/DDYClREyxcd68SrNwSSm/6gmISwg=
X-Google-Smtp-Source: AA6agR7glaQ8aAClz71uXqYoxJoS3u5VVPWthMELBdpN4xlGkOx6c6XDVcwzkRfCixx9/UBtx2rpsPL5pQzztn3jk+M=
X-Received: by 2002:a17:906:ef90:b0:730:9cd8:56d7 with SMTP id
 ze16-20020a170906ef9000b007309cd856d7mr4157955ejb.94.1661490986121; Thu, 25
 Aug 2022 22:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-3-roberto.sassu@huaweicloud.com> <YwhSCE0H+JfUe4Ew@kernel.org>
In-Reply-To: <YwhSCE0H+JfUe4Ew@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Aug 2022 22:16:14 -0700
Message-ID: <CAADnVQJbTzfe28ife1+vg+ByLfyLBTCoEZW_eg8TEw838JGaog@mail.gmail.com>
Subject: Re: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in kfuncs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     roberto.sassu@huaweicloud.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Aug 25, 2022 at 9:54 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > -                                  enum bpf_arg_type arg_type)
> > +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                           enum bpf_arg_type arg_type)
> >  {
> >       struct bpf_func_state *state = func(env, reg);
> >       int spi = get_spi(reg->off);
> > --
> > 2.25.1
> >
>
> Might be niticking but generally I'd consider splitting
> exports as commits of their own.

-static bool
+bool

into a separate commit?

I guess it makes sense for people whose salary depends on
number of commits.
We don't play these games.
