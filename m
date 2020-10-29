Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F8629E0FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 02:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJ2BrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgJ2BrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 21:47:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721CC0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 18:47:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so1226983lfa.13
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVBXOPloV3MHyOZJNF7ZS6bMYegt4BS5YsZsFXz0L7o=;
        b=fZFWZa57uJkj88i0gMBcrwcPQbIDa05ne59E5oeTlZ0Fatsxx6VTjO6FBmGEStfHoG
         CzBcwnj3hmzMpC/y6jQeaKzy5uOjci7CnqFDbHHaJYe6FWdcpQ8ilctvIZ7E/BhQQySM
         +fB16HB8EPjqHjcMS6hh9cvoL87JZUHR7zZCDrtH0B+BrPwDveoFpyYtbP4/y132rtFj
         B8W647wCwWOOlKjNKDnL66w+xtlzgf9EI8Mz1l9kasvXW/EANkMeUQclBkee9aOUZY6M
         66X3K+Y1QBMlK4WlKZk3JQ55Au+YYwQpOeQPJ5mSAP5KORcbvsEQFr6ABa6ZW1D29Gg0
         XT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVBXOPloV3MHyOZJNF7ZS6bMYegt4BS5YsZsFXz0L7o=;
        b=hqg4Ef0wrf0OS2odVjyIqe1PVCdeyGdFuAo/ncwTMMyTm015OdIbZB6TKbrBU7nypQ
         AyHqR1uTGMbQwAdhkHZxbBSICAWHWE5bsLZvujtTX0ONK8bbRBI1jHtT95OyhbdET38d
         f6NP/2tCjxTwNtUxQ/eR1KPlelf7XvY7Dk69VQfMW99tvG4ixNjwD5xr2VX0dRgouRzg
         cDWno7cae/LqJqmOKmaHR39gSXms4Ckc52BrphM45Pd450OPs6FsBKrO76++wIRztvjS
         S+yvgVRpg3Op70iEdI12rdLsHfSrNHpIoKiUf8tfgXvmJklH6/4v84P+9t+6FLjP5lia
         NuUg==
X-Gm-Message-State: AOAM5300V5zUKEpynzUB2AW4qQW9bPrHI8roj+mBADiu3fae6cRxtF7/
        rN7zXuw8fhkoVN12CUXt6+UPgImJO9RRgLXlXd09rg==
X-Google-Smtp-Source: ABdhPJyOm9LOgfKhOx0dfZcPKFbvflj3nvUGX+9YGJhueQKiIToPbzjO53CHytPzuJjOQkv9L8QNx9yAxt63pLS+UWw=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr711096lfc.436.1603936029275;
 Wed, 28 Oct 2020 18:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174319.11817-1-rdunlap@infradead.org>
In-Reply-To: <20201028174319.11817-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Oct 2020 09:46:58 +0800
Message-ID: <CABVgOSn6o0r71PPa69kGvBUU9iQojQaQo+vHv96J-iN6Qjrcow@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: usage: wording fixes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 29, 2020 at 1:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix minor grammar and punctutation glitches.
> Hyphenate "architecture-specific" instances.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

These all look sensible: thanks for catching them!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
