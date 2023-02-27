Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0412E6A4D21
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjB0VZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 16:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjB0VZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 16:25:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756014EB1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 13:25:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id da10so31547271edb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+o0pueVZ861PFNaPrYiHg3vpUPtRa7x51nOh+6VPgio=;
        b=O+DW/abiqE8z4YZl36fMZTGAz/Lj7u9E0Bzt5eg3a2mlQDhc9Alkgc1dLhRNqQ3OeX
         TejbetlpJjspldFMLGQdz1BBEgsks6HENBSRBBswV+gv06fp7EfZPQsSRu8wAcI9rdri
         iSVnmVgz/q0j5RBiQ3sGvb0MzLVBJbIuqekhUgo0y3Wc5Yb2DIjsjsdaoltdVcIdFXJr
         DKMiayRMkZvdogje62ZJX4lGZM+McfDGhWPMWN1YwhTTJzgHsZMCJJIwMeYnyMAlRdwf
         iDTk2lNPsPXMNNKaleSqhWpw0K/+PpzfC88maLG9yygiIn1WNxDshhsebSm8EYwKacuV
         pwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+o0pueVZ861PFNaPrYiHg3vpUPtRa7x51nOh+6VPgio=;
        b=Vy6Qy7OuR4DSQCAGW7qOETZEIJ3yotLDyWQHzFvUwxkHYKk/LRcJJq/REOzO8P8CL+
         ACePloOoo0DXbxcpvub9Nj4X+0QkYRcPjC5SrIYvNj22cpbj+K841rzrrbR3sJuPctw8
         aUrhGqPTWOvvEG85eaEy4mznF/MteT+NJJUf4iaY6PJ0IFfw51r2fxH1IIEygWgUmXyp
         3uG9CqxK3rvCQrPSrR+mXk2L/UZkejpLQtNN9KvYBSNgYscN99HMydcdV2uoyEewKqU1
         lsiw+Z/38Kn5mAs7ZG0ieJaibmLqib+VyUngPHW72ysKxD4klj462HfIIcKOaQk2f3Fn
         zZKw==
X-Gm-Message-State: AO0yUKWUxu44ONKPX/iJT4n5WPL9B315rHaipKk7VrwCUk3vxdBwrvE8
        438AZzf6BCHLZiH69bANp1oWDFU3LFhtXvNU7J92Kg==
X-Google-Smtp-Source: AK7set/GWx//9aZEijFPoTVfWw9sKvwUTfvj0kgyHagHyHFEJyc4e8pb0A3QvVkheCxX6hn4K4vAs5HkjbXhWO8nQCs=
X-Received: by 2002:a17:906:3586:b0:8ab:b606:9728 with SMTP id
 o6-20020a170906358600b008abb6069728mr77255ejb.5.1677533120740; Mon, 27 Feb
 2023 13:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20230225014529.2259752-1-davidgow@google.com>
In-Reply-To: <20230225014529.2259752-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Feb 2023 16:25:09 -0500
Message-ID: <CAFd5g46DFJayFnjJ4JGEUwvVDc-n=msHkMOR7SNd7Uverd6g+Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix 'hooks.o' build by recursing into kunit
To:     David Gow <davidgow@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 8:45 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KUnit's 'hooks.o' file need to be built-in whenever KUnit is enabled
> (even if CONFIG_KUNIT=m). We'd previously attemtped to do this by adding
> 'kunit/hooks.o' to obj-y in lib/Makefile, but this caused hooks.c to be
> rebuilt even when it was unchanged.
>
> Instead, always recurse into lib/kunit using obj-y when KUnit is
> enabled, and add the hooks there.
>
> Fixes: 7170b7ed6acb ("kunit: Add "hooks" to call into KUnit when it's built as a module").
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-kselftest/CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com/
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
