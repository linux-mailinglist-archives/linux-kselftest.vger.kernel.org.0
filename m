Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD0B705A8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEPWYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEPWYY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 18:24:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E659E0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:24:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so1613a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684275861; x=1686867861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU+G8+xjWKVQ5QpMo/ZQtkQQPbKk/ob+AkurzetYB3A=;
        b=I+12tB8k6cmWXNu4K8IeyT6yX//Q7Lt11e1U3ivqkeeNZeBZsEkMyNEb257HXDCD/2
         PIc8KE7K+G3HfXqeTtrQkxcylFnF/5nD16KKO7uUQseU9uhkiM3IOhP6SCc+F1aiSGF1
         It+znTfuWuEtYPBXDJOi6/4iyA12Ty+0Puwk6l9QPMWjarCK5iqt0Fu+nr2+yFa1KLIJ
         z4LiEzTYlGNUBPhjuD6IMeJApIbg/QQMMOEGIRtIEJPAx3GLRnyGc+ZBOWrMAZblt0gX
         kfIk249OUMEGX3hdhtiR6QOY4uHtIbwdJ2mm+8Dqb109gAESymSqAXrAvsrF4sSSRZSf
         Od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275861; x=1686867861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU+G8+xjWKVQ5QpMo/ZQtkQQPbKk/ob+AkurzetYB3A=;
        b=kbC8flbGALCqDTJcQQSbed0x4v9Y1E0cH7Mlh5NIBhtdTulqIHoTRTbMJPTiY0iiQo
         gPtER4mSQ30ck/xeFDH3pqI1GkRbg0JB39bIf4HZ/Ri9GeEuN61RFHh8/hELUn9is+H5
         V8NCZ1OkQNaf1rsI6JmWOCmOJl2HMtlmIYn6wpDIqYtvHuTd15oAQjRcIZIyFjU0Pm5h
         Q0yIQAXGGNLfSq+naQXIZh/fKGKaoFoVFzmDLf68SoOqsGL3cSK4UrdwX5xJBz+k/Ro3
         /2SN994BMJUpuB8HvOvb5ZAsY9GRbRYkhXm5haPso8arhs30rPxmRHyDd66oLVmK+MNB
         YyLQ==
X-Gm-Message-State: AC+VfDy/1OAxm5akUIPhU8C7e5jX0xikdSDlj8w+Zo/zI+XVYzqDTpc0
        Htbsm13G7yXTuMdsH158tCm1+Q63JZhgnhMyqqNH3Q==
X-Google-Smtp-Source: ACHHUZ6I9F6ZxW6AR0PAmznGKdrruOuCBaUN+XoRqAFbHSGQ20hvl27t0+Ehm201A6rGO8XrNf3S3AD1GrFz6zCTvtE=
X-Received: by 2002:a50:99d3:0:b0:505:863:d85f with SMTP id
 n19-20020a5099d3000000b005050863d85fmr43123edb.4.1684275861049; Tue, 16 May
 2023 15:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-4-jeffxu@chromium.org>
 <202305161307.77B29D261@keescook>
In-Reply-To: <202305161307.77B29D261@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 15:23:44 -0700
Message-ID: <CALmYWFujMVFLWDMMkdvWDDpXm+Z=b2vXapX1-2g1qe-qePMyhg@mail.gmail.com>
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 1:07=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 15, 2023 at 01:05:49PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patch enables PKEY_ENFORCE_API for the mprotect and
> > mprotect_pkey syscalls.
>
> All callers are from userspace -- this change looks like a no-op?
>
Yes. All callers are from user space now.
I am thinking about the future when someone adds a caller in kernel
code and may miss the check.
This is also consistent with munmap and other syscalls I plan to change.
There are comments on do_mprotect_pkey() to describe how this flag is used.


> -Kees
>
> --
> Kees Cook
