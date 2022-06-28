Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3E55D4F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiF1CtX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbiF1CtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614EBF53;
        Mon, 27 Jun 2022 19:48:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id q18-20020a9d7c92000000b00616b27cda7cso7184065otn.9;
        Mon, 27 Jun 2022 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usCkRdXf4pF8GtV9Go9XY9gf7B4+CG1st3i2aL1zG08=;
        b=EJtbzcc+iJdFX4QvDis+iyoN2fXmhGk+4UNwqMtzqMu0mzmByvNekmLBazHHiG4mHJ
         EEiyih7wjn8lK1ocoPkPLJQuLkZDAD+UVkaLvZX9pVg73Y9ZP1Efj4zU0B956oFjCF/Z
         hyYUmfIb0lE/GqlO3iGZUc8G/XHkjqzJp+K5piDkWOZGpQ5MvSnjkezPelZQkP9Eh0FP
         eDV/N0V/44lbTmVcpSUW6RTLkCgfMenpGFg1zxL0D0GQBzaq6Pg3LJtknaRqKX3zko2a
         ndCqBLKNhT7qSvocjdJyPuK661ZxOK7p3Y7mPk+njyVS88Icto1Nt6Uebm44dRGaPnOX
         WLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usCkRdXf4pF8GtV9Go9XY9gf7B4+CG1st3i2aL1zG08=;
        b=MMGy+YqM7f9aM5OabN6ad1UiqmcFJmpy8/WLxMPxNSWurBrddE5uK+cJQypOoQcuBV
         Z1xgxoUkTP2vBHuGKoCk5B1fakV9t0Dd+zD7Sf/u6jcPOFdBDwCDtX/jeydWzA3DKelZ
         mobvU2Slf3VJtkL5pAD667qMMAKsk9gMOCd7u6zFznhhsSrqSMDK/7v4pJyVQbn50anf
         /wmkSgcOcV+GXFYnWmVw+VW74GE9rgvqFS06TOwEN5bBXKA9RygbIOW782QGmHTRLzjI
         HFBupTbJoU5AQfDqsMLeKoGaJ7rVOX1pPU2/QioUQyAt13dYV6V9njU2bVq7o29nITjQ
         cWYQ==
X-Gm-Message-State: AJIora8v0OPTmM4eST1GyxwLjNSzviMQUkgBayK5MOdytP5/MGPMfNsq
        3YnjCPhppQ0c2/f4UkxtCPlz+yLiXkmmE+zkOVM=
X-Google-Smtp-Source: AGRyM1vdOXWNWtIdhquzZmnJbakBnosd+n1KkNb990VnB6nhPnzBuB7HDDy1ycenIPcxMDR9zJ8fT9NxWilnzPpf/kM=
X-Received: by 2002:a05:6830:1111:b0:616:c261:390d with SMTP id
 w17-20020a056830111100b00616c261390dmr5216420otq.15.1656384531715; Mon, 27
 Jun 2022 19:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220626025604.277413-1-xiehuan09@gmail.com> <20220626025604.277413-5-xiehuan09@gmail.com>
 <YrkSkuluNhGcMyOu@debian.me> <CAEr6+EAesikgaZGCfgB4LQLkD=7rQ-LckRpNoXYq31QZ4pL9sA@mail.gmail.com>
 <CAEr6+ECTFauRPzVAH+znERX=K4fxOyB23E=6yX6avCt8LS9MoA@mail.gmail.com> <add4c89c-f774-f241-6108-2051e9d69a0e@gmail.com>
In-Reply-To: <add4c89c-f774-f241-6108-2051e9d69a0e@gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 28 Jun 2022 10:48:40 +0800
Message-ID: <CAEr6+EACT5du2S7OiJ91Ljkb_Cqxi=W+bPP9ci1vE0bo-ft-aA@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Song Chen <chensong_2000@189.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 28, 2022 at 10:31 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 6/28/22 08:37, Jeff Xie wrote:
> > Hi Masami,
> >
> > I would like to ask if I change the document like "Bagas Sanjaya"
> > rewording in the next version.
> > I don't know if I can add your Reviewed-by again, I don't know the
> > rules very well ;-)
> >
>
> In the next version roll, just mention the feedback in the patch
> changelog (but not in the patch message as would appear on git log).

Okay, thank you for your reply ;-)

> --
> An old man doll... just what I always wanted! - Clara

Thanks,
JeffXie
