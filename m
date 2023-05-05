Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0D6F893A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjEETBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 15:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjEETBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 15:01:47 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E522699;
        Fri,  5 May 2023 12:01:42 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-619ca08c166so10856026d6.1;
        Fri, 05 May 2023 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683313302; x=1685905302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utzjw63SBeUo2l6wme7ZDttQA5cHTz0UiDYP6i+9Li8=;
        b=f55euq4Jf/X8DPxhk26pDBq0q+QwdKPSYAR/vPS+iyO0Em8rZ1cFauM2Jd5wFHCB49
         TcKDQlwSChaWETlEQhO0nr6EcXxPOtoKMZbsd52LI8w2n4HasMK07UzmHVU3JgrGsEVK
         i39zstorAARUTDeL9045h+dzxOiCUVEdF+iHqO3/qaSE9PWd/7Av4arBLcCLLfkNCEmE
         8DdmNX9usjgd3V150r6ch1y510OMXJYijfr5PSka75RGIWVtT9OaahTnDoeIpJb8sBQH
         +a2uMFvWpy3UwxBsCiqsHWDZremvMTxpvKf/qdO8G380UZGNBSUE+OOD5h/BNY8Tq9gD
         DV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313302; x=1685905302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utzjw63SBeUo2l6wme7ZDttQA5cHTz0UiDYP6i+9Li8=;
        b=cYyfXMD8W1XevVFN7GCIeziq5ETU4rvpEgGxigKuxIp5dBJzY2lAE5OSxB71cvgIpu
         m4uENcWm4AbfDHCDiekeiq9/RbgQAEhUQ9my6bf7AXjmL+3Th8NayqZ7BeMdjwgyIuVS
         Ec+iQaV4cQvUh4q50DHP4LnBTA5ue37/zhLOoY7ThC3VHNxNWzVuUNokwm6b124PtSh+
         qtl4cdotlJboAOzIxYFo8vP5fze2Id4IrQolBZVusOov8vSDJjqjpCwxetvRWk6xAbQe
         AAvD+91HzJ5PwsOWWgle8/POGQemI7mPLrRGfr8DD9ANdeoLrmCn+JQsDclEwxcdLjBQ
         2DlA==
X-Gm-Message-State: AC+VfDxkzno/E7FK4giSeYixdt2cMV4/rZOCEfTJKBWpv0kisV3EW73p
        Zoa42u2zRCO/K4Bffo4oZfY6vDVN1gqdOhHeUfA=
X-Google-Smtp-Source: ACHHUZ4xQUk11W2pL4jRbxt4jurLZwJ+givNPytNvNSQomnEJRk79G4+EgqdjMQfQOn61EuN3rpjB9ipOmwXCQL8Vh8=
X-Received: by 2002:a05:6214:400e:b0:5ef:9b22:dc88 with SMTP id
 kd14-20020a056214400e00b005ef9b22dc88mr3417840qvb.0.1683313301839; Fri, 05
 May 2023 12:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230505110855.2493457-1-colin.i.king@gmail.com>
In-Reply-To: <20230505110855.2493457-1-colin.i.king@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 5 May 2023 12:01:31 -0700
Message-ID: <CAKEwX=M8gL=XocVdDuo4NmFgv8_SRu-wvSZqcwxradVqS5kBZg@mail.gmail.com>
Subject: Re: [PATCH][next] selftests: Fix spelling mistake "trucate" -> "truncate"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 5, 2023 at 4:08=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There is a spelling mistake in a message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index c3823b809c25..9be2262e5c17 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -191,7 +191,7 @@ bool test_cachestat_shmem(void)
>         }
>
>         if (ftruncate(fd, filesize)) {
> -               ksft_print_msg("Unable to trucate shmem file.\n");
> +               ksft_print_msg("Unable to truncate shmem file.\n");
>                 ret =3D false;
>                 goto close_fd;
>         }
> --
> 2.30.2
>

Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks, Colin! I'm forwarding this to Andrew.
Andrew, could you fold this misspelling fix into the patch
as well? I think it's this commit in mm-unstable:

f2277ac105b4 selftests: add selftests for cachestat
