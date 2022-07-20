Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9257AFF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGTEZX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGTEZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 00:25:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349D641C
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 21:25:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31e67c46ba2so14330307b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkYDyFApRGQex0ZGx5gncItb501asypq46h3RmdML00=;
        b=yTP48Cdyx9REosxjEcxnAKh9vjZWIFjHLtjMQW9g2yz0yKG3wcI+qD+cb9j6cP0Bsr
         ce6X0cTDyZbG4qW8/pIyypZE4kBP83Vy5f+DRiAFzTm1Cnaqz/RMipGLpZzuucO1PEO2
         z0il+Sb7qg22G1CIENUx0WPzAzVXditgpoRx5Xsbl/PF6EYooKs+gRiKkgMBthjmoSu/
         Pc4Q0Ny4rfgBAvEGE7/UgRWo5bOkeNJLVOAMQifR3wiyEKpfw/6alVkFMc1NZpGOuZXL
         4tv52SpQU43zDC71Kn/KyOVlNPEiK5T6M5KIuPrI4wUThGDPOuzY/virnbom4iNNYp0y
         nQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkYDyFApRGQex0ZGx5gncItb501asypq46h3RmdML00=;
        b=yJNc8Hcao0KIsq/9enkZxhV2ZmphqcNE6bstxE1yyseZyibunh6YsZYEn+sQLtrRPg
         /udLvEOx+wT3rNW8PMgKybIB0Yvc2trYbilvBWRN6a4RWy3ec16Inm6enijP5DAZiNgc
         3hfWJrkRSh+Mp7tWQyfcqXBURgVolpuckU5laWRMVWHSQzage38UPnvCTFXSzzIgs3lz
         NpjCEA1GUcuLon+WDviI594sI/1J2UyJDXix2xXjf8nq4Nfr7jq1P2fsO4HHbVlAdAvB
         N+QzCtR9PRLxO6r3xUDrC13ALL9fneUM+84SXiQ4qQpvsH2Eqy/ddmrCoTDuh7MDlIoh
         D2Nw==
X-Gm-Message-State: AJIora86C/kJZVw5f1zRnfWyozk+/Dzl52e2VG1NYZXeZe9hyx4WTff4
        8vT6zWFstezC5swxHjphEMYKuQg29ViNUCr3DfFRUg==
X-Google-Smtp-Source: AGRyM1vpMAAQFL4POhS1KPw0y4CE3dxVfTmOxVhuZGCS+Fa0qEToit9M5yEt2djrBoc5d38TThx4J5GqiDE12PI+XwE=
X-Received: by 2002:a81:89c6:0:b0:31e:43d1:5ba8 with SMTP id
 z189-20020a8189c6000000b0031e43d15ba8mr11554306ywf.31.1658291121416; Tue, 19
 Jul 2022 21:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <YtZzjvHXVXMXxpXO@kili>
In-Reply-To: <YtZzjvHXVXMXxpXO@kili>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 20 Jul 2022 12:24:44 +0800
Message-ID: <CAMZfGtWKXdxWMP7fxZnTEGHHxEXfZvDbBFFP7hE8sUZLP44H1A@mail.gmail.com>
Subject: Re: [PATCH] selftest/vm: uninitialized variable in main()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 5:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Initialize "length" to zero by default.
>
> Fixes: ff712a627f72 ("selftests/vm: cleanup hugetlb file after mremap test")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
