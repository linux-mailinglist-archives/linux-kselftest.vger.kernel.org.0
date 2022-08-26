Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85D35A1FF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 06:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiHZEo1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiHZEo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 00:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095ACD7BF;
        Thu, 25 Aug 2022 21:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A58861213;
        Fri, 26 Aug 2022 04:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8352DC43470;
        Fri, 26 Aug 2022 04:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661489064;
        bh=4N8fPCLRY0UexBXJAqFPSEHIzy69pdn6c8F8jMvXR9Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cXInsFTHRfzVz1wHf0VyPiqittp9vsH83QQSStSF8IxS1wR+u+eJrlOs7O13at2JB
         m0ykf227jYkk9zaC2jCRocxYYkZNbsrcLWGHEu95l4/BS4qbcJUHsKFs6NrL+BCt7r
         BlkBXoR3JQOdJWg4mupd2lqEu0bV6SBU2P3wtw9qVkpyIHZFGHNucodxR5vKWlk6DP
         iVdX+lUDLz+fJGzcjni+voh58TZXBmGIZgB9pffcrbBXrQHRjfWvhl+O9/kGMQtmhl
         80JmZKwIFhSIN9x62nom1huzVG1F6tjwrASxDeFP3lTE3NkDjNAJGkN48LNo/una8k
         bfNy/h6GPrO5Q==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-33da3a391d8so9093737b3.2;
        Thu, 25 Aug 2022 21:44:24 -0700 (PDT)
X-Gm-Message-State: ACgBeo1EoNOz/JhG/6DCl/PAo2JBKx1hRcWqwS7bJUXQepDimYFCIqRW
        xVVtYvGY1sNFvSkZ7SmlPwdq/vUlGGkid5CY15Y=
X-Google-Smtp-Source: AA6agR4MDZmrsC5Uxn3zRbjFxQlt07AElD6GVU1pkSWFqAbJ95iB+LZEJu60nircguFmmJ/14u22E/A0G5sTSnfzHkQ=
X-Received: by 2002:a25:6003:0:b0:68c:870b:2405 with SMTP id
 u3-20020a256003000000b0068c870b2405mr6043270ybb.9.1661489063554; Thu, 25 Aug
 2022 21:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220826035141.737919-1-james.hilliard1@gmail.com>
In-Reply-To: <20220826035141.737919-1-james.hilliard1@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Aug 2022 21:44:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5vg=ea6kvteCGdZAvrkpBvXp6s+Wga+fhG-Bm_ybTsqg@mail.gmail.com>
Message-ID: <CAPhsuW5vg=ea6kvteCGdZAvrkpBvXp6s+Wga+fhG-Bm_ybTsqg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: declare subprog_noise as static in tailcall_bpf2bpf4
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 8:52 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Due to bpf_map_lookup_elem being declared static we need to also
> declare subprog_noise as static.
>
> Fixes the following error:
> progs/tailcall_bpf2bpf4.c:26:9: error: 'bpf_map_lookup_elem' is static but used in inline function 'subprog_noise' which is not static [-Werror]
>    26 |         bpf_map_lookup_elem(&nop_table, &key);
>       |         ^~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Acked-by: Song Liu <song@kernel.org>

> ---
>  tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
> index b67e8022d500..a017d6b2f1dd 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
> @@ -19,7 +19,7 @@ struct {
>  int count = 0;
>  int noise = 0;
>
> -__always_inline int subprog_noise(void)
> +static __always_inline int subprog_noise(void)
>  {
>         __u32 key = 0;
>
> --
> 2.34.1
>
