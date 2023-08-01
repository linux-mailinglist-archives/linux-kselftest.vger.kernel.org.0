Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC376A7EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHAEkU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 00:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHAEkT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 00:40:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA552E5C;
        Mon, 31 Jul 2023 21:40:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so2705811fa.1;
        Mon, 31 Jul 2023 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690864816; x=1691469616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbIA8vliJmfA3NgQumGKPdzxvNnSpJGzTRLMaSERhw8=;
        b=BLYU6nDu116IjNKE4R0tDcCjuT/X/215Szl/gh+3/qXxHG4DverRcHEH2jN1A+Niz3
         8pvoLYC6wEzzP6Z4dfJT4sWhp52+QKVFlGepeASofKLAOWa/oDULSuhsHrAkE4oxeCAL
         gpNRwIXRh/7Tf2oamZH9BVFeazuFuXDnpAr1W98uZ0FByAY0rDCuO95yGkr+XshtITNB
         6EiS/tWQ9wkQi+uWp0zdLRAPfVUIRs8ne5VScGP+7iG2xjJuUGdaYKh1UpoJxxKzc0MP
         civHhp8n9Ay3iufs3pjfuRTBfuP++OFTaGQ5QDV7gjSAwniEXpciUk8WtjKSq+JKjd6b
         Kf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690864816; x=1691469616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbIA8vliJmfA3NgQumGKPdzxvNnSpJGzTRLMaSERhw8=;
        b=gqvzUMW+NTtUG1kctmgi4aL4dTtvcbcdy7nVZ3XAgr39SB2Q2go7x23OAWGjMJTf+4
         xgNU2er2F4FHeK4Dg7fC6Wt1ugmhL38t1HmjjnbZKlIKPvugXwYChUBspJQtMOeAtW1j
         Yp/YH4aaIDvPYJwQao4lYuEf2eiPu8N4NTEYtASSzNglEJYvtTGF53yzcgJf+GlVwuqo
         VdbwWOyQBwkPJ6nOgKhxXqW0iYcMJaNeWW78rq3nPbG8ZrVU7aH3Cvb/qxsevokQKa60
         XaHeYQRgj4J6B/100zX/dDga9u5scTZZt15o+RMHYwH7DHp9ToBtRDRUdLfHQzZDzaI0
         Pp6g==
X-Gm-Message-State: ABy/qLZ0ztHHtYhvGXMafNAY6ScuNdTNJAFLjNRI5fXDja8QMUNN1748
        V+G9T/oLHGGWjaYzwyBwGUuYueGMBzzpeSM8X80=
X-Google-Smtp-Source: APBJJlGB2th5I+Ybcc9W2KRFmQVl+cCnJA9FxRkNdK8Hav2e8+sgSREFvtO0ftu/GXUGmcuVM+eOymuA+4PmscYT5/0=
X-Received: by 2002:a2e:8813:0:b0:2b9:575e:5298 with SMTP id
 x19-20020a2e8813000000b002b9575e5298mr1420567ljh.13.1690864815883; Mon, 31
 Jul 2023 21:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230801034624.3412175-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801034624.3412175-1-ruanjinjie@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 31 Jul 2023 21:40:04 -0700
Message-ID: <CAADnVQKc-JVYVaszVJRY-5=6S5sXbPER9KwE-_eCtQbw5J2tkg@mail.gmail.com>
Subject: Re: [PATCH -next] selftests/bpf: Use fallthrough pseudo-keyword
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     Alexei Starovoitov <Ast@kernel.org>,
        Daniel Borkmann <Daniel@iogearbox.net>,
        Andrii Nakryiko <Andrii@kernel.org>,
        Martin KaFai Lau <Martin.lau@linux.dev>,
        Song Liu <Song@kernel.org>,
        Yonghong Song <Yonghong.song@linux.dev>,
        John Fastabend <John.fastabend@gmail.com>,
        KP Singh <Kpsingh@kernel.org>,
        Stanislav Fomichev <Sdf@google.com>,
        Hao Luo <Haoluo@google.com>, Jiri Olsa <Jolsa@kernel.org>,
        Mykola Lysenko <Mykolal@fb.com>, Shuah Khan <Shuah@kernel.org>,
        Benjamin Tissoires <Benjamin.tissoires@redhat.com>,
        Artem Savkov <Asavkov@redhat.com>,
        Kumar Kartikeya Dwivedi <Memxor@gmail.com>,
        Ilya Leoshkevich <Iii@linux.ibm.com>, Colin.i.king@gmail.com,
        Awkrail01@gmail.com, Randy Dunlap <Rdunlap@infradead.org>,
        Joanne Koong <Joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

On Mon, Jul 31, 2023 at 8:47=E2=80=AFPM Ruan Jinjie <ruanjinjie@huawei.com>=
 wrote:
>
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
>
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highligh=
t=3Dfallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Pls resubmit with the proper subject.
RTFM
