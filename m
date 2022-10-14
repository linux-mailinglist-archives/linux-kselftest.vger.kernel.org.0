Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7635FF0F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJNPRR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJNPRP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 11:17:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAE1CD6BC
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 08:17:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d6so7676119lfs.10
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwxuOfQonPyZlcMVaIzYc888hy9RbTZz1aHvp61ggEE=;
        b=MmLd+LMxFfVeOrhyNp7/ihG+a72N/cL5j49yO4JMkaHDP1TF8wQk1BchzbxHuC+eLC
         YOC+pZWkaCNgVlifQqHSZd3gkPf97jeYkCK/4PDxN2za/cT2V7nvzmCvsvNZri5AxQOv
         kGDS7oo4ExmqnfhNXElEdEo6vrysQ9/8TDjUIbTBV/Twd901K5Esu+la7R6cpKLIkFAP
         fNP1qBsI40rgX1JGnakDIAthxT3Lrh3CYlz3Vbwf9q4NY4f+pFI7mt9jQ3YlX+AolXfC
         kRlOfUj907z2e03cfJABK27BCI9WyjIA6C8W/sTSSb8KJ08Sly9XqYotsagilHydQXl6
         3zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwxuOfQonPyZlcMVaIzYc888hy9RbTZz1aHvp61ggEE=;
        b=VEHsTcQ4O8z3ZIUA9S4dXQLCtRcuVaMoDvNtXS7StdrZ8XdbBbm3hFpcOyWOCHpiCO
         TsrB3UQ569OKO8TGmA/dwsIslOfOOzp+lUBnE5V1Kk4RRF2LSJjYpkt1gC0Lp9OuddML
         IJ0xG67lGkd4U5alxKXUPhghr3mik7nHvklaF5/ObfdX8BImJyieDdNVj7WQRmsiJRpk
         9VCXO0C33NOOwYgWZkmhNBF612XcrF8hdM49E/w5LXr+I1ZVtZhQqIdtMgWlc5rGWNMb
         x6D/uPU58jSaED0T8rkGRbJYlKJGYHDbbYdiAcpFNdV35vljdyvKVrkYzskrF/cMaK9X
         Oj9g==
X-Gm-Message-State: ACrzQf3lWl33T3qn65vZcDq6VMF/obnIX3Ie/7qrEeJjuA7cviio/Jqd
        skACOGABhqxSiRk/AnFLD5VjiJ2DDY2ddZptBjrb+A==
X-Google-Smtp-Source: AMsMyM7GA56OYnmfotbnpWCG+IXiPGMM+flkKnNgBV599ZwkwAmwY0SVoIcIWJpRHEKaZA7bpldirYRCjPi1azt20Do=
X-Received: by 2002:a05:6512:4019:b0:4a2:f25:4214 with SMTP id
 br25-20020a056512401900b004a20f254214mr1869456lfb.94.1665760632270; Fri, 14
 Oct 2022 08:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <Y0kt1aCTHO4r2CmL@kili>
In-Reply-To: <Y0kt1aCTHO4r2CmL@kili>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 14 Oct 2022 08:17:01 -0700
Message-ID: <CAGS_qxphzSn+ixxhnb2hEhVVye9hD6qSxdJV0vC-d2pGkERhTQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: update NULL vs IS_ERR() tests
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 14, 2022 at 2:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The alloc_string_stream() functions were changed from returning NULL on
> error to returning error pointers so these caller needs to be updated
> as well.
>
> Fixes: 78b1c6584fce ("kunit: string-stream: Simplify resource use")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for catching this.
This patch seems like it updates the only (direct) callsite for each
of the funcs, so I think we're good once it goes in.

I also tested alloc_string_stream() failing, and the output looks good:
Could not allocate stream to print failed assertion in
lib/kunit/kunit-example-test.c:29
...
---[ end trace 0000000000000000 ]---
    not ok 1 - example_simple_test
    # example_skip_test: initializing
    # example_skip_test: You should not see a line below.
