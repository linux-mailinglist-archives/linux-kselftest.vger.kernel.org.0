Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD3781E77
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjHTPO5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHTPOy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 11:14:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D533E7E;
        Sun, 20 Aug 2023 08:10:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4106b6aa94bso18099001cf.3;
        Sun, 20 Aug 2023 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692544234; x=1693149034;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PYlfXntXcRmI25j0ASkJL4cIGa95ibyMQikoaQtS0w=;
        b=PTUghERm0z9Kru2noqJAjcsws+7KJ7/G77coMBTUtmwnGulFBKynGVpCwHtQt00ds1
         9wKHz4VRVqPu4O8/of0KIyVHBZqHFAMJYbtgTPKHDGms/r9QMEugVBR2erBHIl1fKcX0
         Dl/ha7voh1SYJXopaDJhUNklkoUvcnp7vUIPF+c7yXe50jneiw25WvPZq+yl+0PSKo4L
         eGfpLUWWm75zNfaMa19fZJy38FO1c4o9XGWN5V6i6CIzNmP02TysYc6EKUSFHYP92gxx
         /YuA4cKZNEkZ7GMbSLR0fYdfk6B/1iY9iBfVtU/DbRjUfn1VpaT1VqN/nhFp9hDzBAA3
         R1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544234; x=1693149034;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/PYlfXntXcRmI25j0ASkJL4cIGa95ibyMQikoaQtS0w=;
        b=RqvaH4xHqYahM2uqi3BUiv3hyNzsK+M1R3R2Wsh0J2iRcD7KwVC2IAXFoM5m876vba
         JA/w7Y75K1qOxhOqd4Dcsq6nPbIKvZQflai5XyCvzJqOGBcJJVLRV3mVsspyU8fMPHYa
         ZkIxoUeBOixcvkfSmxXBbY+Buo3NDi5ksSON0fodxfcbuYZxORgy58dVLeU1RNjjRsok
         394u3xMJ8idO4O3IUc5cgds18PCGPIRbtd8YEiIMe61vi4FXAh5HZMRuyQTBzqIJjiIi
         0YozBCPQ51650CuZcjvMcb7STIDOjna5SwbGOWLnqxXABgZyO4a95Syas66x7Eu7Jmlt
         xIKA==
X-Gm-Message-State: AOJu0Ywdr392psnCp3I2deYDMl/7tyOUE5LI7Xm0BbssI+Q/N/drHgZa
        IF/S4L4bqsx6FfXywbfQY4Y=
X-Google-Smtp-Source: AGHT+IGoodQGXQnMlCl9Eys/HA+oeTgQM0W0xeD3x+7ZT9Zl78Uwukum6SL9eZ/kZVN7m2BkspSRWQ==
X-Received: by 2002:ac8:57d3:0:b0:410:959f:d7c4 with SMTP id w19-20020ac857d3000000b00410959fd7c4mr2442356qta.61.1692544234461;
        Sun, 20 Aug 2023 08:10:34 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id j19-20020ac874d3000000b0040fcf8c0aaasm1772762qtr.54.2023.08.20.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:10:33 -0700 (PDT)
Date:   Sun, 20 Aug 2023 11:10:33 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Message-ID: <64e22ce99cfa6_35801629446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230819195005.99387-3-mahmoudmatook.mm@gmail.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-3-mahmoudmatook.mm@gmail.com>
Subject: Re: [PATCH 2/2] selftests/net: replace ternary operator with
 min()/max()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mahmoud Maatuq wrote:
> Fix the following coccicheck warning:
> tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportunity for min()
> tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportunity for min()
> tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity for max()
> tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for max()
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          | 2 ++
>  tools/testing/selftests/net/so_txtime.c       | 7 ++++---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 7f3ab2a93ed6..a06cc25489f9 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -3,6 +3,8 @@
>  
>  CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
>  CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
> +# Additional include paths needed by kselftest.h
> +CFLAGS += -I../

Why this, instead of the existing include with relative path?
  
