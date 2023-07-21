Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994575CD6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjGUQLE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjGUQKx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:53 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F030F2;
        Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5703cb4bcb4so24898247b3.3;
        Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955847; x=1690560647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw+Jy1w/Rjf6qsPkl6FP5i8cv3/KZj4rUJ/QrJgsoJ4=;
        b=aArCFIgo+wz5cxrqIRSfqq0Vs+MH1lxuC0ozjckkyIGQXkDKLHv0DSAMDYeXQOIj/0
         rhziUz+GHpJ0Hx8vfTKF3fGrIpsEdDUA5qpXb6OykqASGHvDyw9+I8XX+be8KPgT5zPl
         mglSYzcWkW+epT3B9WR38hEBaVFK2RtgdLJNwPPfoifhXCV+cHukUSGr36XHJWQ82qJP
         WMiHa+Hlj8NjhsBkCCNUQjycMgQ80C49nA6rrTSeG73bCVf6FneRmkLVPMKVGSZEUMbU
         1aBTZBCKCU3fPiNev0Q44dTq7He/lsq8vyhr86sh/zBQ038GX0WnDCVLRVDXMgR2UyFQ
         /tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955847; x=1690560647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw+Jy1w/Rjf6qsPkl6FP5i8cv3/KZj4rUJ/QrJgsoJ4=;
        b=iXFgz6M9jiaOoL9etFoCS0SGfQzQtAPbQiM5DsGF7DeYRXcRQPJIDXYfX4IMl24F6f
         Dll7wMv2KlsJeSy/4ET6jtboCUHtcrq8KqFUekwV+3kBsRI+ut+Z5whek3qXEXxlqMRG
         8mixhMNx6ZXNhDQjPpQMtZi2MAZ06jD4GtSxZdjdhd1UKK5XtanuEIkfvd7oMO5PCrjJ
         /n98GJVDvUTLJseDLwWvHUsxT8ppoJx7HrRAaI5XfwNlOQb3ARqRavwo6d6nyY7Lirmt
         py7YsabQOSQVio2yirA6tGoYNAFgtzpcSYRPdlMFC59zNT4ejG0Ln7RoUjJPrYO3Ogl6
         lmyw==
X-Gm-Message-State: ABy/qLaCMqvOmJ1aRCBxbi58dHzLlBapUg87ypDN8lkQx46wsVqw9Hnd
        Qkt8wYnS5Yovp1tXEMZwjZOIXoLGs/Wgd110WSk=
X-Google-Smtp-Source: APBJJlEPoqqc9mWISEofrA+wSZKVD6nGVs2rA5lmOJxKWBjepzXM4MuTOb+OfihNTVxxL71cjm0dEGTT0e47RWZx898=
X-Received: by 2002:a25:4dc4:0:b0:c4e:e8b9:1d1b with SMTP id
 a187-20020a254dc4000000b00c4ee8b91d1bmr1842354ybb.29.1689955846797; Fri, 21
 Jul 2023 09:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230720062939.2411889-1-davidgow@google.com> <d3aa8c48-9f47-cead-aaa7-3ea796b91810@gmail.com>
In-Reply-To: <d3aa8c48-9f47-cead-aaa7-3ea796b91810@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 21 Jul 2023 18:10:35 +0200
Message-ID: <CANiq72m-nd6vgH9XROMTC_Xf8__e26uPceFALu-_fAhnPnDYBg@mail.gmail.com>
Subject: Re: [PATCH] rust: doctests: Use tabs for indentation in generated C code
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 21, 2023 at 2:27=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> I find it weird to mix indentations in one file, but if it leaves a
> good result then I'll hold my tongue.

In general I would agree, but I guess we can consider these as "data"
since they are part of a literal, and thus we could consider it is not
mixing indentations in that sense (for the Rust code).

It could potentially confuse a script or tool that does not know about
the language and make it report an inconsistency. But there is always
going to be a corner case or similar that you need to skip/ignore in a
tool like that. And, in other cases, like the analysis that was done
for the potential `.editorconfig` file, it would just be noise since
we don't do this kind of generation often within `.rs` files.

Either way is fine for me: I don't mind the status quo, because it is
just a generated file, so I don't expect many readers; and I don't
mind the file having the proper tabs for its file extension either,
and I guess perhaps having those tabs helps avoid some other tool
complaining about the file if it is run when the file exists.

Cheers,
Miguel
