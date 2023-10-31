Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4E7DC580
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 05:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjJaEmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 00:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbjJaEmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 00:42:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E311F
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 21:41:58 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 22E643F1D9
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 04:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698727315;
        bh=uv/lM9witRa5tHyiuyBCkKsQR6Hn/YYuwsXCZMESZLo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=u+ZV+oLSGJfulZo5rqIQNu1X43MqdNZgDLFivGItYEA/sp1/xwOmMTUuLfCIno1U3
         7loG0YazLLp4/5WhOf+JGYHNMMrmNnAs5lhtFH4OuKxT/00/ftIVhjnwR+xbNjZF7T
         O03vowO8gCAmEiz65T+Dm1RyzCT/qvaGdKgoO1sUT+ylgjvfV3a0MDa21E5l4dtMbw
         UdcPadp4nQju9M7KKloX1y9LIGziPu6V0EWQs7MuH5v4MIFBeJRR64TamuwCFrtOp4
         KAvnPEo1xYQaRTHTb2VBfs+ynPpW+c6oiUIyzOHmLpriweBwaq6tcz6pl+2+u6z+w/
         tLLyV9+RkQG/w==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ef4f8d294aso7954095fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 21:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727313; x=1699332113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv/lM9witRa5tHyiuyBCkKsQR6Hn/YYuwsXCZMESZLo=;
        b=iuq5uH6MdCbFS10+gytxJEAaP8Gq5dojmevTYRF8DRO+WLNZyHTc89wyjo1Y6jUUno
         wnS7Y0TF8dq6GHWQr9uQXH/9RQLjIVHAwYP0qnPxnahISczR3Jnc145wlAfDiwgMCSVx
         GmjM9mubQuYJSRWCic19l9l6a5126PNwEgRckldON99selIOXofviPPEDjF9zjJsxd0Y
         RRh/1oxylfwHrMG1BEZlgpo05WGY7tzu+A8dxu20wUQuOiBg2mEnH3lj6ox4ezQIL9YJ
         tqk86k/beoqm2hjwW2jvrGyL0m4/VyEPrh5pS2frnKAKK+ZvuUss7b3jod+3NXc3zw4U
         rj6Q==
X-Gm-Message-State: AOJu0YxVDfY466B+DbAeOPAZdNwWrzJC3/VDDbRmsqJvn/Lw0qNLniPV
        C3MsT69CJEKqwUqEgEswYrHkQ8njNuCl/m5s6Bm7FZKaOLF97dlbgFYotTnzk+9EdFXQkJSSkxJ
        KjKsM1Eo/B9uPL75Vf0u7k29EozHDRCmUjRxUtZxxxgUJ5lwwYGDggTv8wgoL
X-Received: by 2002:a05:6871:4309:b0:1e9:9537:c1a9 with SMTP id lu9-20020a056871430900b001e99537c1a9mr16749914oab.12.1698727313735;
        Mon, 30 Oct 2023 21:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbJSmYuKlbce0BSqZJOFxdZgSWDwei5lHL5IXFbYRxVoZerDOoqfteskWEqOA52Yc62D7dONA8v+uHeqbbqMs=
X-Received: by 2002:a05:6871:4309:b0:1e9:9537:c1a9 with SMTP id
 lu9-20020a056871430900b001e99537c1a9mr16749907oab.12.1698727313457; Mon, 30
 Oct 2023 21:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231031034732.3531008-1-liuhangbin@gmail.com>
In-Reply-To: <20231031034732.3531008-1-liuhangbin@gmail.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 31 Oct 2023 12:41:42 +0800
Message-ID: <CAMy_GT-kMCE1pbkSxg+O2Ev8h49KWneX6xDy4KHn30njHxK=OQ@mail.gmail.com>
Subject: Re: [PATCHv2 net] selftests: pmtu.sh: fix result checking
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

On Tue, Oct 31, 2023 at 11:47=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com>=
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
> v2: use "-eq" instead of "=3D" to make less error-prone
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index f838dd370f6a..b3b2dc5a630c 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2048,7 +2048,7 @@ run_test() {
>         case $ret in
>                 0)
>                         all_skipped=3Dfalse
> -                       [ $exitcode=3D$ksft_skip ] && exitcode=3D0
> +                       [ $exitcode -eq $ksft_skip ] && exitcode=3D0
>                 ;;
>                 $ksft_skip)
>                         [ $all_skipped =3D true ] && exitcode=3D$ksft_ski=
p
> --
> 2.41.0
>
Acked-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Looking good to me, thanks!
