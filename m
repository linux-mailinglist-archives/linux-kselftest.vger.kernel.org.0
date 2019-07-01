Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE75C244
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfGARs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 13:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbfGARs6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 13:48:58 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99877206A3
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Jul 2019 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562003337;
        bh=DpgKa1i7tOhFQEDq7WvpHneYcU01MzTAnLCFVqYQtdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OoB0vhsKs6Zj87uAi0D/ETlqrHWhTFCurZJaLaeEnxLjbYTxJbgjfPkAXWW/ENFDW
         qt/bDim23ndMFWDLC+Ppr+yp233RXTh51d7+7uxzEoZ5jfGcTQSxURn8l8K78Gk4Gj
         d9cR+48KFMn6KA2fC5sBntvLIJRQnsFBD1dXD5og=
Received: by mail-wm1-f44.google.com with SMTP id a15so363374wmj.5
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 10:48:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWiECUZfDUj7sHX2+vXrI6Ae+yFyDL94wvtzE9GzZvJabmoQNjg
        jFBRftaE4tJFU5Vtm1LJkqM2Ptb35+tzulMvCBRmfA==
X-Google-Smtp-Source: APXvYqxTxD+tbmWI8DDbgP1qRuOhOFZCyJpHtcWfExGkFueDWRgYQFeF2QdtV2fezesSAyKVfpALCUEHhZcbxv+JodQ=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr232583wme.173.1562003336233;
 Mon, 01 Jul 2019 10:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190701130431.13391-1-colin.king@canonical.com>
In-Reply-To: <20190701130431.13391-1-colin.king@canonical.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jul 2019 10:48:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
Message-ID: <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" -> "FAIL"
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 1, 2019 at 6:04 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an spelling mistake in an a test error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 4602326b8f5b..a4f4d4cf22c3 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>                 printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
>                        segv_err);
>         } else {
> -               printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
> +               printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
>                        segv_err);
>                 return 1;
>         }
> --
> 2.20.1
>

Acked-by: Andy Lutomirski <luto@kernel.org>
