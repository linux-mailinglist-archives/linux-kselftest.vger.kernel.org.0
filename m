Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81651ACFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbiEDSjv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376981AbiEDSjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 14:39:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5215FCE
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 11:32:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r1so2041173oie.4
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65qkexODXFqidEs+0JxzFuC9AWtFII/iXZ/G5z0aLFA=;
        b=pmy4b5BdwF5P0xy1c6YQkSK9RZEc7k6jqmxKwQM5QVcv4HvuygB6hXFJXUjKTGyApv
         51RKL/y6n2mg2BlVELLf6GHyBeN3734UIHtn8KOYShwg/wBH+2gZL4Ez94APSxZVChAg
         WCDhKYyQ046imtjMYGWv/dgW9ncuBq10xVLaHhA7oumDkmO6aYUx9tgQ5FeFW+QIMv6K
         xIXLo2aJdX/xOWZBgplgCR58ApNdEydSEvDVFXMBltgsoLWR+He6PVpL/h1tZ8x3ThcO
         uAjI78jU3ts2fn7mr9beCVqQkMg8+DOG8QHp4KDOArNWroVhLCazBh9gMndGwVSqgGiN
         5syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65qkexODXFqidEs+0JxzFuC9AWtFII/iXZ/G5z0aLFA=;
        b=GRf5yAYbK/DHjSM3706GiVTZz3fJKG+shCQ8eDfiSBMRWXlKGxLYmCJAIDfFUMzLko
         vRUaMfVl3HHsocjHMz2l4vQz1wPkV/2xDGdZ/vgSSoYW24lIMIqKbMLkiLVTCbTINIHK
         +BMxMZRXoLCyEEbnG2utIzvoCRZNAhb9AGOlzWkB3XlehJKBJGfHTsFnu/bAZ1zSJ4el
         ndbJfjBooz0Zdv9s0bxiTrA0VflcvidJv+3Uvc94q1LeJU708jwyLoTCNBw6HYLVtozV
         q1erLqlcEIrz2MZwOldCLPu+XrtV7fyttcpgMh1RxWnWPgzjd3cXYm35sNT18gwOSVna
         cJpA==
X-Gm-Message-State: AOAM531XZUmTOrRRWVO1lJUYTqH3Z+xRXDADgOxuQJt4UF+Ukvb5LSv+
        P2UnMMp6hlI4hXeRRsuYe5AetxK/uf+Dz4TZOOw6/aU9jhA=
X-Google-Smtp-Source: ABdhPJwL5H8DpOf06AYB4JVxtydmEfrTSCJx1VjV/OLy8Vc1ROWpY4ICRTPPZlPPmbhLIc8rk56WEI8yilKJg0U1lXc=
X-Received: by 2002:a05:6808:577:b0:325:8089:eb8b with SMTP id
 j23-20020a056808057700b003258089eb8bmr417081oig.126.1651689157543; Wed, 04
 May 2022 11:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220504001153.119485-1-sj@kernel.org> <20220504182908.1322874-1-yuanchu@google.com>
In-Reply-To: <20220504182908.1322874-1-yuanchu@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 4 May 2022 11:32:26 -0700
Message-ID: <CAJj2-QE4ee=N9wYXVQc6gyZYC3zgAsWVwWJ7DMaS2B9q2WqBHw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi SeongJae,

Instead of adding the exception to the Makefile, these two pragmas can
be added to the offending c file instead. Although it is fairly minor and
either one works but I think this is cleaner.

Thanks,
Yuanchu
