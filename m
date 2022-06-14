Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019DB54B8AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 20:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiFNScM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFNScL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 14:32:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA5483A6
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 11:32:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e80so10308567iof.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfwjWoAPJaE/Pxn5sD6KXXa+nrtRrXInBtN08h/1OIY=;
        b=Wp0AuB6O0H+Ec796Ad0tvSbUlH5Gmxj6MMoJAal93Z2Ok+76eEwd+UiIIkjcypQhZB
         zeXb91MDsWiE/eukuCh+x66izUqLLKkEtk1vfUWXEgAALvUBvIk6b8NdZO66RoaevXbw
         YGRR9++nLZE5EiJjaFsuShTBD2gFXpb7liIvnDcfGf5Kri4jrfjEVpfd/4tPFNYfSuBX
         rhLPT4PY8jRfIiG+ZdS4KlnUi8p8XWYE3RyuzlHjxokXas0dB83HZfGUzZvD5mT0s209
         dLO8UCtdM1SPKhrnoCG/Avipaxr35Gtx9l92fZ7IfQcc/M+wxXEGNLhdgDMkd7s9Iwif
         AI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfwjWoAPJaE/Pxn5sD6KXXa+nrtRrXInBtN08h/1OIY=;
        b=LNdfbT6yYlAT4VKOv9BAkLwEBRT9E2nTCxq3AEXYh/miGW06vkilS1xdYq9n9Va7KY
         js17DhpyOpoIuDCsAxGBRiIJCiCG4hT70S16jjMX8vh6oaVlKSJUPr6X7jIXfuRm6gzj
         Vk7uJYI4WY/NpVLFDO2+a55V9f7VSKASPIxl8PyFpivR9GjF2bxCKc5pUcoGw+DB/Rem
         4d/5zx3k3S5VlH3fmGIcROl5aqLa1zDYSh4M8nY2b+h7SqjTf2jQ1o/1sB76l20sizpv
         nU60QDbmAL4Tn+m/kYvqfz0vzXKaY7O6dQsl2BZW4lcJN3Fw+ayU7mN0EFqy23ysDEeH
         H1Yg==
X-Gm-Message-State: AOAM532DNaJw2SQFUmeKxTnNJOfDfoRVI3ciy2hhlFBMP4UUNtdknzQM
        +meA9vIi+YBJsWHOa83VHiGbgejpchsdbS2KCNy4cA==
X-Google-Smtp-Source: ABdhPJxo3z62ssHGXQbVlv/SR8Z0ddI+cvhnz49QFcO45xlS57eFqj4GH0mZoayq8DFLrcCgF3HCjKzo8nM5QentRdA=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr3205821ior.32.1655231530072; Tue, 14 Jun
 2022 11:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220613233321.431282-1-edliaw@google.com>
In-Reply-To: <20220613233321.431282-1-edliaw@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 14 Jun 2022 11:31:33 -0700
Message-ID: <CAJHvVch5CUYkXjvzGnBiArs35tnf=zuoYJAtJNo005TZf1cK-w@mail.gmail.com>
Subject: Re: [PATCH v1] userfaultfd: selftests: infinite loop in faulting_process
To:     Edward Liaw <edliaw@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        kernel-team@android.com
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

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Mon, Jun 13, 2022 at 4:33 PM Edward Liaw <edliaw@google.com> wrote:
>
> On Android this test is getting stuck in an infinite loop due to
> indeterminate behavior:
>
> The local variables steps and signalled were being reset to 1 and 0
> respectively after every jump back to sigsetjmp by siglongjmp in the
> signal handler. The test was incrementing them and expecting them to
> retain their incremented values. The documentation for siglongjmp says:
>
> All accessible objects have values as of the time sigsetjmp() was
> called, except that the values of objects of automatic storage duration
> which are local to the function containing the invocation of the
> corresponding sigsetjmp() which do not have volatile-qualified type and
> which are changed between the sigsetjmp() invocation and siglongjmp()
> call are indeterminate.
>
> Tagging steps and signalled with volatile enabled the test to pass.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 0bdfc1955229..2b2a68722ae1 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -931,7 +931,7 @@ static int faulting_process(int signal_test)
>         unsigned long split_nr_pages;
>         unsigned long lastnr;
>         struct sigaction act;
> -       unsigned long signalled = 0;
> +       volatile unsigned long signalled = 0;
>
>         split_nr_pages = (nr_pages + 1) / 2;
>
> @@ -946,7 +946,7 @@ static int faulting_process(int signal_test)
>         }
>
>         for (nr = 0; nr < split_nr_pages; nr++) {
> -               int steps = 1;
> +               volatile int steps = 1;
>                 unsigned long offset = nr * page_size;
>
>                 if (signal_test) {
> --
> 2.36.1.476.g0c4daa206d-goog
>
