Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B483A8A0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFOUTO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFOUTN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:19:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC3C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:17:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso358714pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkGQnLmVwW4qA0ssOBwk6WCJvW1pndNBd0scdSFPh0I=;
        b=MruOia1n3SSDfMAy6SgZPc8gOiJ2KYRHg1TFB985qFOtyVkwkkmkCTLTgcrvX6tPYe
         LBQxQBXRaYE+gZTN63vld9MyCL6PNNcyL29jtnYOv1uq6lMc/661M6IPWOwaTX332CU4
         EcdZvHlViiMjujNmoBFX79dUIXWtOhGtgC0y5g5yMKWXYXmOErXjZlIoC0XaXhKS4ys5
         OwjCeVAymTQcae9cU/cXcHtp1HgOh6OUny8v2aXp+wPTLg5kBolbDcmScKUwpayrBOMY
         PyYpY4sQX7rUYW0CHvKXRp1yKTj+VVZI6Zo2pSwj+DnpkcMxN0tLz8bdID+ks2vS3WNo
         8/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkGQnLmVwW4qA0ssOBwk6WCJvW1pndNBd0scdSFPh0I=;
        b=WEj2tPcQmOc146JlVAEVc45SxXMlI9lyVqyLJ/16fJE2AUYZF3sO6gpoVGp6UDtac9
         mgBzmZyO/0Az4nbBla847qXVlZSuGqwbHW/VxwtdrY6KfP6wnrJpBMuDuSQUWMj7JdB6
         ZJ2zujZm5NYpwLeVd6WEiUobBxwqqXkcdy5t6kVy4gzziXFGOfWVOikH6Q6in9oJPui/
         tp6Kxx73+PY9cr1lb28bIPSd9KjmlU1wqkOUUUXET3x+iEE0ljlwG6l5+EOGZ6zt/4EM
         KEGGeagds6EoAlOj/j+AvKsOFhOjoaF5Wuy4+xJmxeyeyCnEwDSf2x3ghmXY1xIpdfL9
         UrHA==
X-Gm-Message-State: AOAM530OksGCduoRsVdFrXot56z7EiuxLXHArwXcW0kSfcrPcMtb+nG1
        lK4Sm23IWId4F+Ew6MbGOQsQPjShkJ9tMQqmzfCx6A==
X-Google-Smtp-Source: ABdhPJx9P6F6n477bRva9mz30K3tjhbcE6hC9AMxPX01zFv8+yjRUVzQJlRxqjIr9o9+vC0QlqUiP2GEn324NMHYB3Y=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr6812484pjh.217.1623788227394;
 Tue, 15 Jun 2021 13:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-6-davidgow@google.com>
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:16:56 -0700
Message-ID: <CAFd5g44OdWFTcj5T0e8uPX-HkT3Dm_X3axJV0bza1SE3BvURmg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
