Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4C734EA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFSIx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjFSIxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 04:53:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9D1987;
        Mon, 19 Jun 2023 01:52:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-30fcda210cfso2884983f8f.3;
        Mon, 19 Jun 2023 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687164728; x=1689756728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBEZFKfyfFh7Lx6RyyuflCIxHFiXm98adeAgy3n5TSc=;
        b=AaBhLhhg61OBKlARK2zycZbvlLMQhyhSwO/xGIjyxOC1cFkmc3rrVzTxwQKmvLOjGx
         hEdzbdEbq19wPg4JYymfmbv0EReojIEiDubFP/Law9/MOZq3Z5aFsUMHf2P7Fvun3QmS
         WeRpm7kZuSj0ljHOZX2LJVuZ9SGcoLo6QdKaVYriD3PT+bjfWf6EJ3Gab78BiVtlEbpH
         3inNXolHZywUckCFMfKd9ztFpucG9shp2/XCpNHHkpvuqTI5fGyicC3Zp0WEFlltoOSN
         MwUtW4OHM607kWzdw7VYCzyHx+Ic+4hmUvyS0f44oUtBYJ/V30k2xRc8YKWpaIcuvurE
         MnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164728; x=1689756728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBEZFKfyfFh7Lx6RyyuflCIxHFiXm98adeAgy3n5TSc=;
        b=DcQmp9zHaBwqZr8MAvdiNysWBDB0P0ULyBmwng38KrFhQf0rpADch7u8feXThJyp8Z
         BpE/detFVw6b75ox1lpZMeHd5yqGD89HORUsRv6ve7EQDZqs5npgWZwNzLhZCV4K1G2H
         v9fw+52J2F+G9oQP4YMJ1WmInmGvgmserncZ4KI6lTfY0bELzciV9yzuNH2MC+srvuqF
         qNvmNfKrrYpXPAv55EzhLytfMBvLrOpbNwV3qzyqzeWD7o4D9SAZk1SalYlXQqiLumnb
         7zozMYCXndgA3Xcgi98FJw1sYKCWSNGVLpwFbOrQIZggkhkPG2XHSCURF2EnaIItiUOu
         4Aig==
X-Gm-Message-State: AC+VfDywJZKkhtpYPsbiMbX2WxAe5+u0RkbjVrkD3cODm5zbyITpNjBo
        LX07N/hef81yq47PJ7NQvzgSVXmu/FGfRZotAZHY6weSxpG8
X-Google-Smtp-Source: ACHHUZ43WkXQAAGZFkQ4ZSL/gsUvjznIJocOX5L7/QQJoORw4wNJjZ94ATGxo1vuA9Inm4faX0YYZFyfGnfzZyaTzYw=
X-Received: by 2002:adf:d0c8:0:b0:2ee:f77f:3d02 with SMTP id
 z8-20020adfd0c8000000b002eef77f3d02mr6453841wrh.0.1687164727869; Mon, 19 Jun
 2023 01:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
 <20230609030302.1278716-2-sunliming@kylinos.cn> <20230616160845.GA88@W11-BEAU-MD.localdomain>
In-Reply-To: <20230616160845.GA88@W11-BEAU-MD.localdomain>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Mon, 19 Jun 2023 16:51:56 +0800
Message-ID: <CAJncD7Sfasoe4-hKZP4c3bPZ892S2Kk5JaMo-aca6eBDwLjLNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disabled
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

Beau Belgrave <beaub@linux.microsoft.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=881=
7=E6=97=A5=E5=91=A8=E5=85=AD 00:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 09, 2023 at 11:03:00AM +0800, sunliming wrote:
> > The writing operation return the count of writes whether events are
> > enabled or disabled. This is incorrect when events are disabled. Fix
> > this by just return -ENOENT when events are disabled.
> >
>
> When testing this patch locally I found that we would occasionally get
> -ENOENT when events were enabled, but then become disabled, since writes
> do not have any locking around the tracepoint checks for performance
> reasons.
>
> I've asked a few peers of mine their thoughts on this, whether an error
> should result when there are no enabled events. The consensus I've heard
> back is that they would not consider this case an actual error, just as
> writing to /dev/null does not actually return an error.
>
> However, if you feel strongly we need this and have a good use case, it
> seems better to enable this logic behind a flag instead of having it
> default based on my conversations with others.
>
> Thanks,
> -Beau



There is indeed a problem. Once enabled, perform the write operation
immediately.

Now=EF=BC=8Cwhen the event is disabled, the trace record appears to be lost=
.
In some situations
where data timing is sensitive, it may cause confusion. In this case,
not returning an
error (as mentioned in your reply, it is not considered this case an
actual error) and
returning 0 ( meaning that the number of data to be written is 0) may
be a good way
to handle it?
Thanks,
-Sunliming

>
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > ---
> >  kernel/trace/trace_events_user.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_even=
ts_user.c
> > index 1ac5ba5685ed..92204bbe79da 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file=
 *file, struct iov_iter *i)
> >
> >               if (unlikely(faulted))
> >                       return -EFAULT;
> > -     }
> > +     } else
> > +             return -ENOENT;
> >
> >       return ret;
> >  }
> > --
> > 2.25.1
