Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5459CB90
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiHVWh0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiHVWfo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:35:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EF49B52;
        Mon, 22 Aug 2022 15:35:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y4so11218937plb.2;
        Mon, 22 Aug 2022 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rc8cqsRTnzKVbLe+4u6IWFZMkSB429i95/8w404EPWQ=;
        b=C9v0gcH+pAAKJmwtYaqbnICUJYXbyTsyvrR12OkhjV4dbsR/0oMzSGfRQAzlxpm1d8
         Dmt+3HiGMbFxWEgfCd4fmFmgmrWK289mInmUWOOtmwxFE5+SwFQaH9NGGzt0w3OKGPdz
         vXUUa43CJw3kKrecXIuAdjW8geC38bKhsMKbMX+PAj0vrK1xs2bgo7csnE7t+6sLjqZM
         3fjGEhN6KVqUNE6N/GIzYrx/IudpcjXaXLf0wC/yDhocqOb72GAxXgwqtZdnwK6dKkW5
         gk17ITwOQ6A1PSbon1LNEZGOspF1B5qbnzbqcSl6qQGMltIPNTenTa5fepz8S7TAywWA
         ZNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rc8cqsRTnzKVbLe+4u6IWFZMkSB429i95/8w404EPWQ=;
        b=C8rFEW14t78ssZduBIqSDCYMHxqXUqiseOLeQ9yIwKqY9oQeDHPltAWypA7ndXxlOq
         JqANVFx3ZEIX5ihA+r6LB70MnqAQ++5kxgm6QH91JFdR5qfNf4gh/evDtVjQW3GwRjoo
         6c29xPypiDLFSVpCV9WnIS6jeVgvTGFqQYSDAI3aoYawpMpsWrcaq/lNBnNt0JlotiD8
         Gxcc75WnYb/+a8/IquovNUD2xLq2Cq/+jhxb46pzyDUXNBNSUXb+XP2PAMG7CbzakvBR
         cmmKeh8Sa1R4tyBA4dvEKhu1Pr+0lf4l+34GdRC+g1uW7rtXgKi6s0xc3IxbuyxGypSb
         jfVw==
X-Gm-Message-State: ACgBeo0eWyJe63AEcKDkFMRVlDQ8sKBuG6fPDjW+vYY9rX8Dk1IJZ8oF
        1qHNJ06CzQ2MxPkxv+JpnEsNBpUE5pr/DzPVpKM=
X-Google-Smtp-Source: AA6agR5HQON0R7kHz0tjqUr3jcPfNDAdt1YPSjPZbJ/N0mc3Tn1gnc6CqsodKcvGv2aZcAX8MHRXQddoHGGfn2Gv2s0=
X-Received: by 2002:a17:902:ce8e:b0:16d:cebc:e92e with SMTP id
 f14-20020a170902ce8e00b0016dcebce92emr22024945plg.85.1661207743072; Mon, 22
 Aug 2022 15:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com> <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
In-Reply-To: <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
From:   Tales <tales.aparecida@gmail.com>
Date:   Mon, 22 Aug 2022 19:35:06 -0300
Message-ID: <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>,
        Magali Lemes <magalilemes00@gmail.com>,
        linux-hardening@vger.kernel.org
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

Hi Daniel,

Em seg., 22 de ago. de 2022 =C3=A0s 17:09, Daniel Latypov
<dlatypov@google.com> escreveu:
>
> On Thu, Aug 18, 2022 at 10:33 PM Tales Aparecida
> <tales.aparecida@gmail.com> wrote:
> >
> > Replace URL with an updated path to the full Documentation page
> >
> > Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> > ---
> >  lib/overflow_kunit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> > index 7e3e43679b73..78075106c0df 100644
> > --- a/lib/overflow_kunit.c
> > +++ b/lib/overflow_kunit.c
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> >  /*
> >   * Test cases for arithmetic overflow checks. See:
> > - * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.h=
tml#configuring-building-and-running-tests
> > + * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/st=
art.rst
>
> Oh, I thought I had sent a patch out for this.
> The rewritten version of the patch is
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.html
> That's what I was intending to rewrite this line to point to.
>
> But if people like a Documentation/ path to start.rst instead, that also =
works.
>
> Daniel

You are absolutely right! You did send and I wasn't aware, sorry.
https://lore.kernel.org/all/20220603195626.121922-1-dlatypov@google.com/
I guess it stalled after that discussion about *where* it should be applied=
,
I got a green flag in IRC and didn't do my due diligence carefully,
just tried to find pending patches at linux-kselftest which wasn't
CC'd

Now, about the change, either way is fine by me.

Kind regards,
Tales
