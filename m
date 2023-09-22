Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B87ABC67
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Sep 2023 01:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIVXjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 19:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjIVXjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 19:39:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612919E
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 16:39:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41513d2cca7so137241cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695425975; x=1696030775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Im+zOMVypPEia8MVs6KRCiMY7tEGPMADLH1faEZpG8=;
        b=GVjK1JuHmXaLO6w3JhyU+SYpIZ4Lf6lAiXdAj1bfSaSCnPcx7tLyoXazDRTDS9wW17
         xLvQdHm4N+LCzjvtySDWSujmnSwrYNgVsKp1KFspqeHESICFqZ2I/+SWsSoSsh0IQIER
         spxN9guLw/UtwvybFSwfWgHyANOC572eJHWxfCpRTuDhY/Gaz2iomM2D9jSu86WnCux5
         RDz8NKFEyOV+jc1u09f7aFeqJAb+Bsny71k+EdlLNPYO+4M1vSso3hQyURJSHVN4vGFw
         fbfo3DmQORQN5rlzYUqybh1Fy3SpYmr6AJXeWxGAIlh8NQb+iT5tJlaoMr1hNUX47HAI
         VMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695425975; x=1696030775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Im+zOMVypPEia8MVs6KRCiMY7tEGPMADLH1faEZpG8=;
        b=Zfx7U6n9pXC9c0S5vJClbMRswy+NHi4FYIp8EZg3fYMiZTpb0NHHNvPvDfupFErZr7
         /f3Az+esdDxix99Q0gx53qHtyAfi3XtxN83fDwM2xeiV94hwJyb8N+4TDnnK15KLh4DU
         2/ozjtU/MPIsuqWmieurzbeR3JbQxUESENNZl8cwdoodfiM9KlYftLbMyJgK3vqyda3i
         XQp1QRa6i5slvLA9q0PZR9Qwf1DVR7Ep78c6LsLBg7MwLBkN+mSCyGDhA3/PE9+n3p+u
         TUzBG972ZJEwwf88w8FN96IR4ZFjb7yZEafHI/Z2oHUPjARJL/p2z8TCp5H4Oi/h614a
         uzfQ==
X-Gm-Message-State: AOJu0YzNEe/iKYrCNJnb1If0b7sU81Yce7ccTDes55tkddtAo21OmCnB
        VEu03eofMt3J1seS7HqRDgByXf7TwmFjKVTltaVCzg==
X-Google-Smtp-Source: AGHT+IFVZjVuHQd8Fqrz/Pbsl23SeiMNn6a2XOn/teOInfmWdqwud/8Hv9MwItGOLmgG2jBGD5mVG4k0cwESNTNIz+U=
X-Received: by 2002:a05:622a:307:b0:418:4db:afab with SMTP id
 q7-20020a05622a030700b0041804dbafabmr50047qtw.9.1695425975627; Fri, 22 Sep
 2023 16:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230922113923.3621959-1-make_ruc2021@163.com>
In-Reply-To: <20230922113923.3621959-1-make_ruc2021@163.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 22 Sep 2023 16:39:23 -0700
Message-ID: <CAGS_qxqGFP5nWmvGmUJYDWXTndyq_HCVZDpYeNr9UFTk3zJ_DA@mail.gmail.com>
Subject: Re: [PATCH v2] list: test: potential dereference of null pointer
To:     Ma Ke <make_ruc2021@163.com>
Cc:     davidgow@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 22, 2023 at 4:40=E2=80=AFAM Ma Ke <make_ruc2021@163.com> wrote:
>
> To avoid the failure of alloc, we could check the return value of
> kmalloc() and kzalloc().

Thanks, that's a good point, some suggestions below.
And also a question for David Gow whenever he sees this.

>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  lib/list-test.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 0cc27de9cec8..70e898976dbf 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -27,9 +27,18 @@ static void list_test_list_init(struct kunit *test)
>         INIT_LIST_HEAD(&list2);
>
>         list4 =3D kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
> +       if (!list4) {
> +               KUNIT_FAIL(test, "Initialising list4 failed.\n");
> +               return;
> +       }

Note: we can replace this with a one-liner
  KUNIT_ASSERT_NOT_NULL(test, list4);

>         INIT_LIST_HEAD(list4);
>
>         list5 =3D kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
> +       if (!list5) {
> +               kfree(list4);

We can also replace this check with the one-liner
  KUNIT_ASSERT_NOT_NULL(test, list5);

But we'd need to migrate the kzalloc() call to use kunit_kzalloc():
  kunit_kzalloc(test, sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
that way we don't have to manually free list4.

I'm not sure why the original version didn't use the kunit helpers to
begin with.
Perhaps David would remember.

A quick lazy ^F over the original patch didn't find anything afaict,
https://lore.kernel.org/linux-kselftest/a127aeaa-e5ba-2d8d-0894-936e0563750=
8@kernel.org/T/#u


> +               KUNIT_FAIL(test, "Initialising list5 failed.\n");
> +               return;
> +       }

Daniel
