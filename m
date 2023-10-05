Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C267B9F76
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjJEOYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjJEOWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:22:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294A27B1C;
        Thu,  5 Oct 2023 06:38:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b64b98656bso180272266b.0;
        Thu, 05 Oct 2023 06:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513123; x=1697117923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Typac5B7OWpGgMVQT5CpmSBuv29OUVSxeeOBcTx4oyI=;
        b=ZctPJkBRQmDPaOn3Zr5OGfwYd9joLCDVJ5qtyYEmB2D7SWtoxP3q1lwakTrLItg8Bu
         CuMOJVqeVacvlJHSp+S1IqtTW1NxT7ZqAutjRlesMyR2l2vngkxCg3hN7QIU0GR4i7cM
         E1FiFBj28S/wvrKl40Uc/KBM5l8BXNL9y9EuhIBNKzqosOZQLBcWBbmG4mhSnsYMx/aX
         0HOW9eveTkU5FbVE6XxCKv15ilKWCWu4/1JYZxzcCsOo0qKL8dgQppYYB+M3suY6iQeM
         cx0VP+99IEW8zEOLus8QZFG+9Fvy8zlJ+8BlZ6Haj/P2A0C8WtnxN8fujo92WTYZqEdB
         fGwQ==
X-Gm-Message-State: AOJu0Yx/sqe8M8tnyFSDBP6Mnt8VBcFbizRSu8kRdD5s05Td6HPwmItm
        EEVtLZQvzM14E3NDtlicrUM=
X-Google-Smtp-Source: AGHT+IFDc8GOq/vFfcLWVdGllmnI1Bgm7f2sRPgc5/yJuIMcEh102ROZ7TT4kAIBKHdm8jzKkU79tw==
X-Received: by 2002:a17:906:3012:b0:9a2:225a:8d01 with SMTP id 18-20020a170906301200b009a2225a8d01mr4581177ejz.7.1696513122856;
        Thu, 05 Oct 2023 06:38:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id kb4-20020a1709070f8400b009adc81bb544sm1210966ejc.106.2023.10.05.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:38:42 -0700 (PDT)
Date:   Thu, 5 Oct 2023 06:38:40 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/mm: Add a new test for madv and hugetlb
Message-ID: <ZR68YM1ImrAGy+ZJ@gmail.com>
References: <20231004171127.106056-1-leitao@debian.org>
 <20231004171127.106056-2-leitao@debian.org>
 <026a75f627bc7ffa45ead3fd6ecb9da7b5bc2692.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <026a75f627bc7ffa45ead3fd6ecb9da7b5bc2692.camel@surriel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 04, 2023 at 08:22:08PM -0400, Rik van Riel wrote:
> On Wed, 2023-10-04 at 10:11 -0700, Breno Leitao wrote:
> > 
> > +char *huge_ptr;
> > +
> > +/* Touch the memory while it is being madvised() */
> > +void *touch(void *unused)
> > +{
> > +       char *ptr = (char *)huge_ptr;
> > +
> > +       if (!ptr) {
> > +               fprintf(stderr, "Failed to allocate memory\n");
> > +               perror("");
> > +       }
> 
> I'm not sure this error message makes a lot of sense
> away from where the huge page gets allocated.

Right. I think I don't need this whole "if" clause at all. Let me remove
it.

> > 
> > +       while (max--) {
> > +               huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ |
> > PROT_WRITE,
> > +                               MAP_PRIVATE | MAP_ANONYMOUS |
> > MAP_HUGETLB, -1, 0);
> > +
> > +               if ((unsigned long)huge_ptr == -1) {
> > +                       perror("Failed to allocate\n");
> > +                       continue;
> > +               }
> 
> Should the test case just exit with an error here, when
> the allocation fails?

Yes, probably skip the test if we are not able to allocate the memory.
I just found I can use something as `ksft_exit_skip()` for this purpose.

Thanks for the great feedbacks!
