Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD4705A78
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEPWRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPWRt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 18:17:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16B59FA
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:17:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso1615a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684275467; x=1686867467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFM3fAYlTPBxQGmteO/2uHFhqAyi1JN0aT26xTBpePY=;
        b=o2yls/45s0xkZRgXdYp9Llp5QvwSiw2Yins46NJBQ93VxSzpcVos6BkD9ZuzWFA6zU
         OLiA/M6Ocvy+P4BEWoZdomhusGCoMMqAFW61552mNjMRB4VeIol0mTshVg5jouXKuObl
         Qj7ybH1dkgrkD5EEkwaYEi3zN4P4l5qGIq5z9AwQNzUOGmyRuM62BwnbBdj6zPnZ0v4B
         gdKf2Eq2CjxCfpZB1geOeSvb6FtBgiO4ynAq+LDyuAWeuAucwu30IDaI3JRef9OAg43t
         m+dXn+w3YLkbCgdi1d7j3HJbtKxXGw15d65FITdPhLK6pSsk9JI6fdnBe39mHtctSmcS
         Shgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275467; x=1686867467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFM3fAYlTPBxQGmteO/2uHFhqAyi1JN0aT26xTBpePY=;
        b=jDAHKxpAh4t98jU0pj6bANWq/nQEsM9ho3gUp9NojIrW9dIK3UgJst9wh21L/CSRC4
         XasN+N8hH+0H+qwlRK/DCBLv8WnJnqhJ1/pbi5MjEmWY4Km+FNZw4wMlRIpSZpRX5lY3
         aTAIa5sm3+2JGhLU0HtoZnD9uF0dNGrIwOL6SvyX4oSILzUNsV1GghOIg00c13tYlvM3
         N6VjoO0c3ALS5wSEFT/foYF1EQenGQsapF6woiDdlG9egB+Zmgkso6ZGZ2n9rz9MOqxx
         qCdvY+gLIlK+qMySn/h1ewD1dOpYP52rViNqqCZUWOtEt99bBEJSNgM9W4cKcmt1bBpV
         2biw==
X-Gm-Message-State: AC+VfDwZj6VzVwQjEVF2DGYD2IdAFi64C1EBeAB5lEQIvwTiR/+B0x0T
        aJb8R5ailZCmZRyYqwGdodnKwTxkqZ4n9/v/O+Z9gA==
X-Google-Smtp-Source: ACHHUZ4kIdAG/+KEv1wYdz2uXbEvowoCYDRdQ98dgmPo2TYOqhB/KFXxkuuo4dMNQNDQo21ejrglf36AsKWL2Iuky8U=
X-Received: by 2002:a50:aadd:0:b0:50b:f6ce:2f3d with SMTP id
 r29-20020a50aadd000000b0050bf6ce2f3dmr51714edc.0.1684275466605; Tue, 16 May
 2023 15:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <202305161307.4A16BB6A47@keescook>
In-Reply-To: <202305161307.4A16BB6A47@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 15:17:09 -0700
Message-ID: <CALmYWFteCd+h+tn+LmgTpN9Ld5=qAMMQ34=b1KCoE3OSBun+DQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 1:08=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 15, 2023 at 01:05:46PM +0000, jeffxu@chromium.org wrote:
> > This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
> > function. When a PKEY is created with this flag, it is enforced that an=
y
> > thread that wants to make changes to the memory mapping (such as mprote=
ct)
> > of the memory must have write access to the PKEY. PKEYs created without
> > this flag will continue to work as they do now, for backwards
> > compatibility.
> >
> > Only PKEY created from user space can have the new flag set, the PKEY
> > allocated by the kernel internally will not have it. In other words,
> > ARCH_DEFAULT_PKEY(0) and execute_only_pkey won=E2=80=99t have this flag=
 set,
> > and continue work as today.
>
> Cool! Yeah, this looks like it could become quite useful. I assume
> V8 folks are on board with this API, etc?
>
> > This set of patch covers mprotect/munmap, I plan to work on other
> > syscalls after this.
>
> Which ones are on your list currently?
>
mprotect/mprotect_pkey/munmap
mmap/mremap
madvice,brk,sbrk

Thanks!
-Jeff Xu

> --
> Kees Cook
