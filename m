Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB59F7DBCA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjJ3Pe3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJ3Pe2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 11:34:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB7DA
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 08:34:25 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A12633FAD3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698680062;
        bh=U+HzRWWfe445TTBhBAgXB/2ejF+ftXkNxDYm8dN+cP8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JzRPOzxD3MpT9BssCx1o/eTfKvZ2Taw1DO8koFSPQ4/3L5cBuBS/dFM2DnUY+39Wq
         /QsXUFQnv6yfqu6inMjLVTfw3xEytxmvUGmLxHDPJ5Zh/xMNLcWDoUJkr2dGf5U8ax
         fUy68P6qsqtK8cBcYXNQtv0G/he+r0CyqRwSqxJppIoFRnYxoKxgVZFlSl7jsCOHG8
         fvjPX8gfyUn84iFJE+KjZ+sM4jWSe2i5+e+2Avh2mwbYJyelrM6x2PNPwk9utfBf6d
         XmrqwaK1FWewdxU45vPLu7GjaaClSLgjTorMdCzYAF3OdboIZ1ageHh0FhZZnhxg8F
         mCvgJWNx1G+MA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ea1bc5d50dso5271976fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680061; x=1699284861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+HzRWWfe445TTBhBAgXB/2ejF+ftXkNxDYm8dN+cP8=;
        b=Wj/SaBMAiHCVe1nlxUmYoc3K1AqScyEOGIKFBmYg5HcG5JBVh1mpwPvI7KqJUBXy6i
         7X7nlCCO70wT8Tw2ZtG6UEHkHtMothi3sxnn5uLM9M7rkxZlXDPL6pXMS58atnS1aNl2
         XZQet0ThMroX00lNnKn9bj0RQWikw+EW8Y/+NX6JrCmVUTgNIWKTio0XFW/yrXGknAY7
         zEYqbq5um+M2KrPl/Gu2ogjKVfXFxxmDbEwVibngvM9oBkQ0gPV3bgx2LSnPImik/7xs
         3P+1DksZVWZt4IpoNULKl99NJi5akW+yGUx1qJ3ZTtCYKolXxQadu4lnK23O0dVFuVP4
         JOgg==
X-Gm-Message-State: AOJu0YyqRmc+g2wM5jg8kisK3PlTNCBLx0aAnMme4MVCYZL+uBpTjeU+
        tRJP5zQ5XsJkwTaJ712IK7V2YoptgaYkq0DmHJndnYSntu7xjzZioJ9uYLONIBBtRUL9wAl6ANo
        MF5i/c9CxwY6iq1OfenKVCtb+TrvEajUdNBmaPC37X27JRJpl4lr6uUqJH6P/
X-Received: by 2002:a05:6870:d914:b0:1ef:bae0:4bb8 with SMTP id gq20-20020a056870d91400b001efbae04bb8mr4656729oab.29.1698680060901;
        Mon, 30 Oct 2023 08:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLmaoGBFAeuxipughz1BuzObURNyX+TjwBCwyAeiZQHdITLI4GtggdgVl6tKynDeG2pL6pFJ40Rp0BudyOPSQ=
X-Received: by 2002:a05:6870:d914:b0:1ef:bae0:4bb8 with SMTP id
 gq20-20020a056870d91400b001efbae04bb8mr4656716oab.29.1698680060568; Mon, 30
 Oct 2023 08:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231030094555.3333551-1-liuhangbin@gmail.com>
In-Reply-To: <20231030094555.3333551-1-liuhangbin@gmail.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 30 Oct 2023 23:34:09 +0800
Message-ID: <CAMy_GT-8fKJ1+y9Dgi5R2kuPiRJfC4gg-K0GW5NWL_vDbuTALA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: pmtu.sh: fix result checking
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 30, 2023 at 5:46=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> In the PMTU test, when all previous tests are skipped and the new test
> passes, the exit code is set to 0. However, the current check mistakenly
> treats this as an assignment, causing the check to pass every time.
>
> Consequently, regardless of how many tests have failed, if the latest tes=
t
> passes, the PMTU test will report a pass.
>
> Fixes: 2a9d3716b810 ("selftests: pmtu.sh: improve the test result process=
ing")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index f838dd370f6a..b9648da4c371 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2048,7 +2048,7 @@ run_test() {
>         case $ret in
>                 0)
>                         all_skipped=3Dfalse
> -                       [ $exitcode=3D$ksft_skip ] && exitcode=3D0
> +                       [ $exitcode =3D $ksft_skip ] && exitcode=3D0
Perhaps replacing "=3D" with -eq here will be less error-prone?
Thanks for catching this!

>                 ;;
>                 $ksft_skip)
>                         [ $all_skipped =3D true ] && exitcode=3D$ksft_ski=
p
> --
> 2.41.0
>
