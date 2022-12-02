Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7B641175
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 00:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiLBXYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiLBXYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 18:24:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A924F88AF
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 15:24:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k7so5984078pll.6
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofSHfJEl53nBxTKL7kEN4Zg0gZG24eP3ZO/twC4u+1k=;
        b=HeigGMHv29ce9DCaTPYVM3dw6G+hA6RazCRkjT3KQZLg25j/kXIJzVk1CREUf4Tnjy
         ObHsN/+LfiA+cHa5FGu5yq1n8lo5ofkI8FlaEx18YFuhsuonRWe5rGWezpeJ+mAErWcz
         bONfAWoJMb2gN0IP5FjGges9W5cH/wdhI0L3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofSHfJEl53nBxTKL7kEN4Zg0gZG24eP3ZO/twC4u+1k=;
        b=y1PbAxQqeXI6rpzbGv96m1ZGzc3HUryY0g98DborRpDTyqGHey0KPm/UNuZ5t+nyt7
         UmlBgtYXLLROwVVQdBsF/xSt6oTDLj5m74mvMrX623rKQON9bFSj8THQy34sAEogKHyK
         pdP8DAWDyCA5+LgZD6Gmf9s2RN/3B9/6QY407NjCEB0MbeTOqg0aBPlpRv30a9sATfkW
         SL7TUUTejhzAzx8qAg360dH5+judR17uqFPdpBttz8evT6qssTJXlzjC9fXgx7m5lq//
         5kuYACK5E5R2OByXBVR/s9Wjc1H47S5qIQ29CCJcqMkYhnsWGFWHRHp0HyYGaMFS25yr
         h1CQ==
X-Gm-Message-State: ANoB5pkC3fdx81Pv3JEhjR6vQMwVnIXlw9Yutb+ajIz85X1o2bibVyH0
        +m9DX75cL6suT5+Hp+6nQqObiZOsKhBXpQEB
X-Google-Smtp-Source: AA0mqf7NxkACxGmqbiPc4BfhoAomgX7wHMfQUjsVNq0Fxz8U1/KbY9Me59vCtYS9CFelUV176MPGZw==
X-Received: by 2002:a17:902:bc4a:b0:189:6795:d945 with SMTP id t10-20020a170902bc4a00b001896795d945mr38220895plz.136.1670023449405;
        Fri, 02 Dec 2022 15:24:09 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id f14-20020aa7968e000000b0056bee23a80bsm5604605pfk.137.2022.12.02.15.24.08
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:24:08 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id t17so6278496pjo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 15:24:08 -0800 (PST)
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id
 u7-20020a170902e80700b00189117cfcfemr54885077plg.124.1670023447808; Fri, 02
 Dec 2022 15:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-7-jeffxu@google.com>
In-Reply-To: <20221202013404.163143-7-jeffxu@google.com>
From:   Daniel Verkamp <dverkamp@chromium.org>
Date:   Fri, 2 Dec 2022 15:23:41 -0800
X-Gmail-Original-Message-ID: <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
Message-ID: <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: Add write seals when apply SEAL_EXEC to
 executable memfd
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        hughd@google.com, jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 1, 2022 at 5:36 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> When apply F_SEAL_EXEC to an executable memfd, add write seals also to
> prevent modification of memfd.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/memfd.c                                 |  3 +++
>  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 96dcfbfed09e..3a04c0698957 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -222,6 +222,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>                 }
>         }
>
> +       if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> +               seals |= F_ALL_SEALS;
> +
>         *file_seals |= seals;
>         error = 0;
>

Hi Jeff,

(Following up on some discussion on the original review, sorry for any
duplicate comments.)

Making F_SEAL_EXEC imply all seals (including F_SEAL_SEAL) seems a bit
confusing. This at least needs documentation to make it clear.

Rather than silently adding other seals, perhaps we could return an
error if the caller requests F_SEAL_EXEC but not the write seals, so
the other seals would have to be explicitly listed in the application
code. This would have the same net effect without making the
F_SEAL_EXEC operation too magical.

Additionally, if the goal is to enforce W^X, I don't think this
completely closes the gap. There will always be a period where it is
both writable and executable with this API:

1. memfd_create(MFD_EXEC). Can't use MFD_NOEXEC since that would seal
chmod(+x), so the memfd is W + X here.
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to !W + X.

I think one of the attack vectors involved the attacker waiting for
another process to create a memfd, pausing/delaying the victim
process, overwriting the memfd with their own code, and calling exec()
on it, which is still possible in the window between steps 1 and 3
with this design.

Thanks,
-- Daniel
