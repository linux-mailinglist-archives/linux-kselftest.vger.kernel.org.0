Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF25078B26B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjH1OA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjH1OAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 10:00:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000EF1;
        Mon, 28 Aug 2023 07:00:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34b0f3b792dso12188245ab.3;
        Mon, 28 Aug 2023 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693231239; x=1693836039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ZjYInOLZfLCJ2rqNlLw1AWAIzZa8U1nQs8Z12ar1I=;
        b=VpaK78loG20c+SLJ+GOeGHVwA41coT9y4LuJG4Wh6v6fmtTszx6Zp0q+8SjbCsrZtE
         t82U+jJZIOX2qXxiKvFNiZl3X2isQINMeGgVlXhfbe6FTjMHY+QZgEF+vfESF7rKxY4O
         +w9c7l6xM+5EM9xECiaKdsZH+NG9vYwmZfVf9ajd8/sGzY2pNix2hC6Y1ZK9MZtHX1CC
         lSpjIn3stX1wjRQgAn3n3pfRh3vDXwBvkN5TcN39nKiau04x35riQHgVUiSKLKdAHzoX
         4zWWFefqkCETOLCMI9iKrjYLrWkk4uzV5UkQiC+AQJBMPCLvtAp19mbOBhTVscmuXTSJ
         w9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231239; x=1693836039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1ZjYInOLZfLCJ2rqNlLw1AWAIzZa8U1nQs8Z12ar1I=;
        b=EaQ7Gn+AUX+0oaxYR1k/Tj+Ihl6VcLwkSK7LSjJh/hNm4AO5sDRnOyItA/2CZOYJfc
         Ij0fTSErMjczCy3113KZ9bZFW4g7Bj0XhqPM1RXXXsSxvdckGE7j2W0iCFzfrHJswD+9
         jT+Kv1WrCnu6ITgcd3J+ziMHxuNVt+Zyaj+eB8Yraa/58lRuY6H2Ot8WjesxYy9zHOuK
         rHaJGbO3IbTvhNdIJMeWasyWjRHgzfZE1F4tkuZDeRdnVrk3WMo+moHixCsuBK2lds+X
         vRO2OOqXZw1FnEGJcRG8DgLKJFKRR7OgshwlytIElk+QpZo89vTXjNvadj7kdNSc6wlN
         5OmA==
X-Gm-Message-State: AOJu0Yzhl3tuB+QbR9LgN19Chi33SQ5Cmtpe2HdF0S7TiktZedTxEsb7
        J8Nn9i+7m9Z6DfpDPPx5N/4RK96bAKQQ6vG0WFRMJbkJ
X-Google-Smtp-Source: AGHT+IHBbWKvoCsoAWsBsb8FJc28TavkJak5o68tpykf+H0mKP9cBCYzcQgKx0spSr9vQVyliKo/Ml0rF9Px9VxXofk=
X-Received: by 2002:a05:6e02:dca:b0:34c:abcb:97e8 with SMTP id
 l10-20020a056e020dca00b0034cabcb97e8mr16520973ilj.24.1693231239587; Mon, 28
 Aug 2023 07:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com> <8417dcd7ebdc464d12850873d6c48f95293e673c.1693216959.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <8417dcd7ebdc464d12850873d6c48f95293e673c.1693216959.git.maciej.wieczor-retman@intel.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 28 Aug 2023 10:00:28 -0400
Message-ID: <CAKEwX=NnDCjNQDQUt4x8Lw16uUf_NoOw24dXzQvBCTmc4czxuQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] selftests/cachestat: Fix print_cachestat format
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, ilpo.jarvinen@linux.intel.com,
        reinette.chatre@intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 6:50=E2=80=AFAM Wieczor-Retman, Maciej
<maciej.wieczor-retman@intel.com> wrote:
>
> The format specifier in printf() call expects long int variables and
> received long long int.
>
> Change format specifiers to long long int so they match passed
> variables.
>
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 77620e7ecf56..a7adf42afb20 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -25,7 +25,7 @@ static const char * const dev_files[] =3D {
>  void print_cachestat(struct cachestat *cs)
>  {
>         ksft_print_msg(
> -       "Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicte=
d: %lu, Recently Evicted: %lu\n",
> +       "Using cachestat: Cached: %llu, Dirty: %llu, Writeback: %llu, Evi=
cted: %llu, Recently Evicted: %llu\n",
The fields of struct cachestat should all be unsigned longs,
Is there a compiler warning that prompt this change?
>         cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
>         cs->nr_evicted, cs->nr_recently_evicted);
>  }
> --
> 2.42.0
>
