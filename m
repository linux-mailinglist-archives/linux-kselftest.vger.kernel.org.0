Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E04ACD72
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiBHBG0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiBHAOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:14:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94067C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:14:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f17so16679826edd.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrCYi30ISfoaw5otXa8VwSe20OUFBnQiOpbcWlrhJEs=;
        b=U9EOQvYRo+lmK4lJ3YXM5ZqvZ+H7z1H47vtbLQiUvhU6W/hprnGK3N9dEbtOBZfNia
         xcKdWdJJcWG5ic/UP69hdWDpRqDpg5z0gFGO/yCt8ABsI1mP5EPAPWn8XASgHeZHPNK8
         YqWhBaFBfWbIX40VqkZtnyhqrpjIy7/4BKjEU3VJFULCrdmhqqxRfg4ShNLINr3cjHQS
         iDyNlEt9s52JU2/yaE+duuU2slBn3P5XjxhPC3/F3am8WFKki4STtSWqAN0aq0y4bjtb
         FBSC7JkSTUKxbMb32DUnciW/TyfmkQaCx+Lv6Lls8cMDt69bTt4vIsxHhGOs+i4NPMdN
         NC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrCYi30ISfoaw5otXa8VwSe20OUFBnQiOpbcWlrhJEs=;
        b=ErvbMvlNhaJu4ncNdOfNlsLy44g9wW6fbpReleXsqSIgqo+GWiDP/NPaqZELofng1F
         /jh0TrpnlHSUMGpNRlrR2kliSWivVuTOZ+tfub4I7eowMSXMXOWwnsOaX+jl1rr6Ha8Z
         AwiYxops1m2wmSA1MdAYgAj/2q+7ejMTAbn9Cml6YQ9eMb3CWBL2e31RegyPPetUOErI
         AFjmupgrSjrolnl6A9ilYXa5lsdbQvayRy3rHZ/VwXYl4IdjZUGSWO0fnyocH0qJfSox
         ZVnZh1CPLK+LUIKgTJMOe0RHpnTQlIstEOiS7I/DeoqJWUw1l+GZETXjCv9OHht6X3UC
         2I/A==
X-Gm-Message-State: AOAM533MYfbixZhOzer4dj118VC10OSufmfNCAH6z5Upa3Fw6sIdKWR8
        +7KjMVbV7XpjQQVfkbs1glo5Sn45YwHcDFDTLsatsA==
X-Google-Smtp-Source: ABdhPJyIUyi6qCPG45ctw1NHKkQ1twyPOHUkOYFs7wbgYKHxGnOqLlPyELtdtRKKRHfUtxZfvFsiRwKj+TIrIwWoKhA=
X-Received: by 2002:aa7:d297:: with SMTP id w23mr1877801edq.313.1644279241995;
 Mon, 07 Feb 2022 16:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org> <20220207211144.1948690-3-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-3-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 16:13:50 -0800
Message-ID: <CAGS_qxptS8OaM=S0rHgbYi8_B4dXC4UssOCPaAZRg_oOEXneog@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] thunderbolt: test: use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 7, 2022 at 1:11 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the NULL checks with the more specific and idiomatic NULL macros.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

Saw one typo down below

> ---
>  drivers/thunderbolt/test.c | 130 ++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> index 1f69bab236ee..b8c9dc7cc02f 100644
> --- a/drivers/thunderbolt/test.c
> +++ b/drivers/thunderbolt/test.c

<snip>

> @@ -2584,10 +2584,10 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
>         int n1, n2, i;
>
>         if (d1->uuid) {
> -               KUNIT_ASSERT_TRUE(test, d2->uuid != NULL);
> +               KUNIT_ASSERT_NOT_NULL(test, d2->uuid);
>                 KUNIT_ASSERT_TRUE(test, uuid_equal(d1->uuid, d2->uuid));
>         } else {
> -               KUNIT_ASSERT_TRUE(test, d2->uuid == NULL);
> +               KUNIT_ASSERT_NOT_NULL(test, d2->uuid);

Looks like this one should be
KUNIT_ASSERT_NULL(test, d2->uuid)
