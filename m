Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B5CC0DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJDQe5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 12:34:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJDQe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 12:34:57 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so14889875ioc.6
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2019 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SGqM+3yKbVJmLVuUUp3b6/LD0hJ2CQ/5lAjad49oZfs=;
        b=Hiq3KnxjgCoa7fM42jZ/eJ7L6fmoeIQsqkBW32bReVdq+5p5AMheZkYySQREJ130YM
         LytbMVn1ZAdjZ3CuzAT0xI1zwzWOI89rXTaH35Mc+JeVZLc6go+PkppN7must3ymhVNX
         GYpAciN94+YbJawhB0Tww6XV4OLTpb/ZhVdm4TBlRlTD0reAzbIWhLZxCqQKV6rxhpc4
         cVrG+DB9/grXkk2CIUbarQ5uizb2Je7f1k2d4vyGfN3lepxarBArpurz/GG7GsSd7izP
         W2QiXOrRhPizCd0rZ9MnDhLG6w2uRZacUV7NJ3vtE+FZzakXWjBloxwHtTlj6FeapZpA
         rRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SGqM+3yKbVJmLVuUUp3b6/LD0hJ2CQ/5lAjad49oZfs=;
        b=hO0yJzS48Jm1y8Ib0ybmlRloFG1bbsDKrcWkLqP2s8rPlCi7UZsTwtQmiKPM4cVGWM
         1jHgoAIjyxjFfC/kGGP5Qoyf0itTsSV0/j8vzxNFdi1ikNU8boikdx1tCH7u1wawNvHk
         TLSTj8bNY5qdidZKxuX3b9r2v6HKlKr0vk7yGyCpVSkMw/4jFjcwYiA+PTH6AcQus16w
         R59V972LGRdEnA5WAeXehFx0tclYhQ74d5V2qXLof0bD8nDbyIhxU0upecHyBUnF3g1v
         mhxVyeP7c34xpdfb6RXz3oFIe+vJERDCwqjiC+dHaPMXnFgr8kjzKiWcySXKIlBQEDSK
         5JXQ==
X-Gm-Message-State: APjAAAXnJR8hUDRDwVvwPwwCs4oNKJ1h7e+kMMFdWIStmmq5LiVPY/Vg
        Na/W+rs5FSQuJpDPBYxhROjwJhXfDLUufUJozVg5d58n/CI=
X-Google-Smtp-Source: APXvYqy3ZAxCYueRwp6jwND+zik8W1OIH/2S/kqrX3mVWekZw9RcfVxwvG/7PBgjpCQlVTEiRlJTLW5rN4egcQgQXUU=
X-Received: by 2002:a92:cd45:: with SMTP id v5mr17338504ilq.197.1570206896657;
 Fri, 04 Oct 2019 09:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <157016600217.8022.346317009413291058.stgit@devnote2>
In-Reply-To: <157016600217.8022.346317009413291058.stgit@devnote2>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 4 Oct 2019 11:34:45 -0500
Message-ID: <CAJe_Zhdq4sFGgv-CJf12_qJzFq+oASTmsD8xReX877V1NYSCBw@mail.gmail.com>
Subject: Re: [BUGFIX PATCH] selftests: Use real temporary working directory
 for archiving
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 4 Oct 2019 at 00:13, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Use real temporary working directory for generating kselftest
> archive.
>
> tools/testing/selftests/kselftest directory has been used for
> the temporary working directory for making a tar archive from
> gen_kselftest_tar.sh, and it removes the directory for cleanup.
>
> However, since the kselftest directory became a part of the
> repository, it must not be used as a working dir.
>
> Introduce mktemp to prepare a temporary working directory
> for archiving kselftests.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/gen_kselftest_tar.sh |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing=
/selftests/gen_kselftest_tar.sh
> index a27e2eec3586..eba1e9987ffc 100755
> --- a/tools/testing/selftests/gen_kselftest_tar.sh
> +++ b/tools/testing/selftests/gen_kselftest_tar.sh
> @@ -38,16 +38,16 @@ main()
>         esac
>         fi
>
> -       install_dir=3D./kselftest
> +       tmpdir=3D`mktemp -d ./install-XXXXXX` || exit 1
>
>  # Run install using INSTALL_KSFT_PATH override to generate install
>  # directory
> -./kselftest_install.sh
> -tar $copts kselftest${ext} $install_dir
> +./kselftest_install.sh $tmpdir
> +tar $copts kselftest${ext} -C $tmpdir kselftest
>  echo "Kselftest archive kselftest${ext} created!"
>
>  # clean up install directory
> -rm -rf kselftest
> +rm -rf $tmpdir
>  }
>
>  main "$@"
>
FWIW,  Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
