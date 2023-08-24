Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BE787B98
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbjHXWnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjHXWnJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 18:43:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CED1BF7
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 15:43:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso13545e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916985; x=1693521785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYY7zeS6H0LscRj1UYTAyR5LbxEggzxBKjCvWYSphbU=;
        b=P0l+Iqb8/QF2i3GPACES8JGrjBGsLdBALscrrNHD7cmRWuHDjaOXyYQMujUDZr1nCd
         dKN4HYrB7IqH0wmmB4EGULkdOFzf68NCUTf3J+FIAPpqP3cCiS9kMk3KxLttt5iahuvW
         7spsLofp4FOqEDmKE3pHh19orJLw8t9KBX+ainqy+DputmqhbuDENh8pZWaDaAEi8nIq
         DqIiFmsxWsRvVA2ag9+a/mXTS0G60T8wKby7kJYT8k8PUVq51Bx/EaXkEuNOfbV3HSza
         SKxCwgmGEO6eN7pW5L42Fd+gAFW9SRnUW/IiDKPUNqFF4zM8MrQ//8sLvm7u75ydn/1M
         1HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916985; x=1693521785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYY7zeS6H0LscRj1UYTAyR5LbxEggzxBKjCvWYSphbU=;
        b=CA8un5KFFB6ctxvIwE+de0YF7+Ou4ywIOAWPHgTv+86EOXSMwiAXsMvpXlSRAw2qrW
         MpIGYYmvJxyNPcq3PEToNffCk0YVeVhuE5vlvoL4APh/CkICh4jkAm+8M+nvBIjbSc6d
         rQoK+pArXtvHYh1HqOccYxF+wH+CeRt6tdlariWiDLorBCONxsTOy5qhTpxjMAmGjM+L
         YyVOlQPU1/tLnjWR3k615LnVHEA2pyndFc6a2Lezvmj/HoGS513BRQ1x/jTZ/+N/OvUE
         /2fOUaF6bN5P5sYMwTreDD9HNRsEHKYHvSXxcJfi9a23RTHQIlDUeoPSsUnUBEzcbp0q
         uAIQ==
X-Gm-Message-State: AOJu0YyUNQCbSYRyywUmzaOjx0D9baTpjizUPmjH1u8FRvHoKoDEUjkA
        iUGZrTlxVZP3zeI57SpMj1DmG1nAFctPriSG1/G8pg==
X-Google-Smtp-Source: AGHT+IENQ0J+O9MZQ1uKDf3m+oG2k+/EUkGyMzbdhYbKXTTbzl1j0pYJBXe1lg/1ZH8NhyY5LoWG5ewbOtz5W5oU7V8=
X-Received: by 2002:a05:600c:600b:b0:3f6:f4b:d4a6 with SMTP id
 az11-20020a05600c600b00b003f60f4bd4a6mr42207wmb.7.1692916985130; Thu, 24 Aug
 2023 15:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-2-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-2-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 24 Aug 2023 18:42:53 -0400
Message-ID: <CA+GJov5QG=nRU_e6LSG0rXNcigTXP6zP19ZOm5aPt7Q4GsYMtw@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] kunit: string-stream: Don't create a fragment
 for empty strings
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Thu, Aug 24, 2023 at 10:32=E2=80=AFAM 'Richard Fitzgerald' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> If the result of the formatted string is an empty string just return
> instead of creating an empty fragment.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

This looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/string-stream.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index cc32743c1171..ed24d86af9f5 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -50,11 +50,17 @@ int string_stream_vadd(struct string_stream *stream,
>         /* Make a copy because `vsnprintf` could change it */
>         va_copy(args_for_counting, args);
>
> -       /* Need space for null byte. */
> -       len =3D vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> +       /* Evaluate length of formatted string */
> +       len =3D vsnprintf(NULL, 0, fmt, args_for_counting);
>
>         va_end(args_for_counting);
>
> +       if (len =3D=3D 0)
> +               return 0;
> +
> +       /* Need space for null byte. */
> +       len++;
> +
>         frag_container =3D alloc_string_stream_fragment(stream->test,
>                                                       len,
>                                                       stream->gfp);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230824143129.1957914-2-rf%40opensource.cirrus.com.
