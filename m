Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995547B649D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjJCIqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJCIqs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 04:46:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FAA9;
        Tue,  3 Oct 2023 01:46:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so109225366b.2;
        Tue, 03 Oct 2023 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696322803; x=1696927603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lot+PIl65jzy5/2JCItynBOJq7O7D8RX8LS/ww72DFQ=;
        b=fHw9fbmw+B5oQiU3XDCcpPDWmsjOYlp+YCQPpRLyQZ4UVDDVwg7JAm3/IaQnPUm9b0
         zpl+yUfhCIVvtcadGWWCaYxukQ9GH7tmkWLw027TxPrzdZiR80NGZX9YjRL8C0mjUPsJ
         GHEN+dCkrhVAel6jgqjx7+66HJjMsaXcrNHaHU5+K+w7JX+/G3L0ZOcXjLnNy6AGgxi1
         nFzZ7p5oGerqmhQBmfH1/KRNEkYqnUi2gEBK9HmYMxbV1/axynklfGlVuE0Bzd5AthRW
         nS0Ees/hZVM77qlq2xW6FWNr8x4vg4fwxNHDq9SabFs0xVvJ/VyUzqXxHNxv3ET5/vB4
         qc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322803; x=1696927603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lot+PIl65jzy5/2JCItynBOJq7O7D8RX8LS/ww72DFQ=;
        b=DGrZFNShBKDL9hfZfhDYlTHnWsSUEbiFg9Lvn0z5U4uYXBRQMOuSTrJuWyaTRajVCV
         lpzaoEE8LVyYvP24GqDoGERDQhenlVUY8inlXk/t1exzQ2XVbPM7I1u3tUzxd192qF7f
         +x+H7U11aie8HqIGCjJixpihqdi1BC/oXrpxqU27gr3Kf2ByT4jg1VglrkTBafWSJTBv
         HP42Pljx8UZ/gYnoqh8O1wpTEhFFzFThYBj4r71qEmfc3s/RhLLf8VUxQ93MWciNyNpj
         fxjxVYCbTwF3mAbnFwQPC6U8SvRpy6sAzcLPFiaDKB3k97m7WxorT09GLb6BlI6HNDRs
         W+bA==
X-Gm-Message-State: AOJu0YxG5A4QZsAtDdxewgwJwPGDgiHgEJapP2csTXfEl/1YM1YUmuFe
        iEXzbzcxb6v7qkPzXwWj5KO3lnNuxx4=
X-Google-Smtp-Source: AGHT+IHjmxpbA5fgCSzJ/WMDVijr0iafoHDsoVCHAq0NZIsv4nXKNMLHq4dyk+q4nOAXld/4/Staow==
X-Received: by 2002:a17:907:270e:b0:9b2:6db8:e0fa with SMTP id w14-20020a170907270e00b009b26db8e0famr11756939ejk.41.1696322803077;
        Tue, 03 Oct 2023 01:46:43 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906168d00b00991e2b5a27dsm684939ejd.37.2023.10.03.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:46:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 10:46:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/6] selftests: futex: remove duplicate unneeded defines
Message-ID: <ZRvU8DXRWL9sgKug@gmail.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <20230805073809.1753462-6-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805073809.1753462-6-usama.anjum@collabora.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Kselftests are kernel tests and must be build with kernel headers from
> same source version. These duplicate defines should automatically
> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
> files.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  .../selftests/futex/include/futextest.h       | 22 -------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
> index ddbcfc9b7bac4..59f66af3a6d10 100644
> --- a/tools/testing/selftests/futex/include/futextest.h
> +++ b/tools/testing/selftests/futex/include/futextest.h
> @@ -25,28 +25,6 @@
>  typedef volatile u_int32_t futex_t;
>  #define FUTEX_INITIALIZER 0
>  
> -/* Define the newer op codes if the system header file is not up to date. */
> -#ifndef FUTEX_WAIT_BITSET
> -#define FUTEX_WAIT_BITSET		9
> -#endif
> -#ifndef FUTEX_WAKE_BITSET
> -#define FUTEX_WAKE_BITSET		10
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI
> -#define FUTEX_WAIT_REQUEUE_PI		11
> -#endif
> -#ifndef FUTEX_CMP_REQUEUE_PI
> -#define FUTEX_CMP_REQUEUE_PI		12
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
> -#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif
> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
> -#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif

AFAICT I cannot really pick this up into the locking tree as-is, as this patch
relies on the KHDR_INCLUDES change in patch #1, so that all self-tests get the
kernel headers included, correct?

Thanks,

	Ingo
