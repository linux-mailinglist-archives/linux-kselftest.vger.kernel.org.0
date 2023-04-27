Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375376F0C6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245030AbjD0TTw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbjD0TTv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 15:19:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408B26B9;
        Thu, 27 Apr 2023 12:19:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so88850941fa.2;
        Thu, 27 Apr 2023 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623187; x=1685215187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YSyhozBUXfx9sRckvacUfEnE7Nm6Oda3ANurw926PY=;
        b=SHPgUfRBxbPmYtD8NUzgyFtOUHkte7MTlFZT9YQxcpJTZRyjGEl5E8pXXO9KXLn0J6
         s02N90no96qHxeqgwIyOZOUiPQ4xPMqvW/+rMolojy21uIwF/MSHojXykpfLGW2jwokj
         YkpUfebU3Ggq5Su2w20tQvG0rMWnMhFpb41ijnROp/MwOALfwN8Pc42RNnF7ePOXMMg5
         AzWInXC2LpCkFe01kzXk1gS/3y9y1bxbHqZB84DvErv32SbCVFMdaO+rH/xPN5YbRjiF
         FP9++kT1kMoGY4KA1cMNDzAwhYd2cT6b+zV17fggjOYcZ5lO4owD+T6o/ZwFZDqwgane
         q2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623187; x=1685215187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YSyhozBUXfx9sRckvacUfEnE7Nm6Oda3ANurw926PY=;
        b=HL9I0knPa1s1M6k+9ImzQ89dcZaGE6wpM0v0U7RHZAatrBUWawFxqX+8Sc25ulVgLK
         xcmZ65NyHMuXQ67EydydDXnG9QTPI6S0LifK4IqyDOVifwfdHj3FgYw7C9p9rpF1f7Hi
         Gh/ilHTpOnzHPBj+LLKiBLBWIHpLbaCNNL1mrhVi3GoZRw4cLw0Y5hqZKMBNq+EMIdy/
         uNZIOEUw3Bhh8qsA/fl5csTg/UV+kgO/AEUgDcjYI4oO7hNHU6UuiErqYRsGrFJYT3lV
         U0uDRBBkhFXpzWw81QB0nAF1v2loE16j7gusXM2kdWkEN9udIN9fAGCCamHf1pp62S15
         M+eA==
X-Gm-Message-State: AC+VfDxGNBXe6KyQCAPELJtfylD4Usz5wiTQ2t8c2i0oPrnmaQnu7IS+
        gjDqVPMld0rXw0wsLGlb2TU=
X-Google-Smtp-Source: ACHHUZ4XwesfERr5hks1ketneX5DI7nUDtBf+sf9pvjxD0FUe7yhokfU6ptdjclvW0Gf3qOBbTbW4w==
X-Received: by 2002:a05:651c:1032:b0:298:a840:ec65 with SMTP id w18-20020a05651c103200b00298a840ec65mr889331ljm.36.1682623187100;
        Thu, 27 Apr 2023 12:19:47 -0700 (PDT)
Received: from eg ([2a01:799:1727:1d00:3b00:1557:f6d8:9549])
        by smtp.gmail.com with ESMTPSA id r8-20020a2eb608000000b002a8b97f6bf0sm2936128ljn.100.2023.04.27.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:19:46 -0700 (PDT)
Date:   Thu, 27 Apr 2023 21:19:44 +0200
From:   Espen Grindhaug <espen.grindhaug@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
Message-ID: <ZErK0M/qAi/VS8U8@eg>
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
>
>
> On 4/23/23 11:55 AM, Espen Grindhaug wrote:
> > This change fixes the handling of versions in elf_find_func_offset.
> > In the previous implementation, we incorrectly assumed that the
>
> Could you give more explanation/example in the commit message
> what does 'incorrectly' mean here? In which situations the
> current libbpf implementation will not be correct?
>

How about something like this?


libbpf: Improve version handling when attaching uprobe

This change fixes the handling of versions in elf_find_func_offset.

For example, let's assume we are trying to attach an uprobe to pthread_create in
glibc. Prior to this commit, it would fail with an error message saying 'elf:
ambiguous match [...]', this is because there are two entries in the symbol
table with that name.

$ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
0000000000094cc0 T pthread_create@GLIBC_2.2.5
0000000000094cc0 T pthread_create@@GLIBC_2.34

So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
and this also fails, but this time with the error 'elf: failed to find symbol
[...]'. This fails because we incorrectly assumed that the version information
would be present in the string found in the string table, but there is only the
string 'pthread_create'.

This patch reworks how we compare the symbol name provided by the user if it is
qualified with a version (using @ or @@). We now look up the correct version
string in the version symbol table before constructing the full name, as also
done above by nm, before comparing.

> > version information would be present in the string found in the
> > string table.
> >
> > We now look up the correct version string in the version symbol
> > table before constructing the full name and then comparing.
> >
> > This patch adds support for both name@version and name@@version to
> > match output of the various elf parsers.
> >
> > Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
>
> [...]
