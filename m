Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D635A8809
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 23:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiHaVZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiHaVZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 17:25:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90512758
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 14:25:11 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-12243fcaa67so4582373fac.8
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g+LFT64nKjvFQ9xBs3ga17iSDMJNzcQHBlCbx79FOAA=;
        b=Z4r+al+4Pp7+eTwrj0gkK1wBO8Z0CpU7HFRAFrfv4p86LXjVXcvfALv60ZlKgJxda2
         buOcRK5++YP6s/L3n6ZjEeHdba/BWIXiWTp14xU9HOBtdXk9gdNeo41fD9jm9u8oeOTS
         b3odhDl+/3OiWnz7H6fJQC/oFftOplAIsblpfHfw7/WhNrze0wGyl0bKOBU0PaM3u0mC
         v2snYeD51HdMQUR0pqB99AA++xapBHElVIVCuQeBwR0/Gzc5Ag66WSfDLcshMKsLntyq
         5SDsbDX2/7vIlG6ILnLQtms7Fy8OlV8fh9x6Th6J9i95F76zXuGnq8FlvbFEYFxjx+Sc
         CB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g+LFT64nKjvFQ9xBs3ga17iSDMJNzcQHBlCbx79FOAA=;
        b=JcHxXNZ2aLXu8aWLY1p/19x8zsh5I3JScXtb8vrmYm+kHV82c0f/QK0T1U+XvRZzgg
         yc2EVvk41CaOUMGNkS3jxi9SXeSr2tS1GXJL4nvmzZMc94Dq+cFS8nnxMOQQ7ZKtbALN
         063MpvtiSD70IeDKB5sKlgHyq0Iz3SeLad1LkSxFs5weMgsPEwNnoq/tpXnUFYjxf7Ql
         LHSXEz0XoQogjNygWa05q4oRoRLoQLG0Sg8pjwODu/iK2GSKc4XTf6INQpwsqMy+iCZK
         NKVurkjdSIUYtvNZ7layVK091MTkzOtzA7x1aULztotI70D/By5Y+WVck9lo+ZEr5mjD
         WxUA==
X-Gm-Message-State: ACgBeo2XZY6/dd6OKPplZTJfRxC9dpVv8kohssG3aNl645voUq2D8V7i
        LwLOEG041XpnYMCUCKpadyFTa9ZNRQUw6pd74cAyNg==
X-Google-Smtp-Source: AA6agR4N+yQXPnOGxaJMFenO1Wz9ePQE4H8Up8oiR4Fnc6irTFXk/fUy8f1Iwrt05kWPuLi9Qce/XHeXKrUoHCdbHkg=
X-Received: by 2002:a05:6870:4308:b0:10b:8cbe:c945 with SMTP id
 w8-20020a056870430800b0010b8cbec945mr2401759oah.220.1661981110841; Wed, 31
 Aug 2022 14:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220831211526.2743216-1-axelrasmussen@google.com>
In-Reply-To: <20220831211526.2743216-1-axelrasmussen@google.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 31 Aug 2022 14:24:34 -0700
Message-ID: <CAAa6QmRy3N9cO14AVz2g0dA_MOSatwzufQxO1PwH35J4mYPbmQ@mail.gmail.com>
Subject: Re: [PATCH] selftest: vm: remove orphaned references to local_config.{h,mk}
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org,
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

On Wed, Aug 31, 2022 at 2:16 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Note: this commit is intended to apply to mm-unstable, the commit being
> fixed only exists in that branch for now.
>
> Commit b4efb234e53cc60ccdc855190be9f35918687412 ("Kselftests: remove
> support of libhugetlbfs from kselftests") removed the rule describing
> how to build local_config.{h,mk}, but it left two references to these
> files lingering around. The result is, none of the selftests could be
> built due to dependencies with no rule for how to build them.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index b52f2cc51482..4ae879f70f4c 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -1,9 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for vm selftests
>
> -LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
> -
> -include local_config.mk
> +LOCAL_HDRS += $(top_srcdir)/mm/gup_test.h
>
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
> --
> 2.37.2.789.g6183377224-goog
>

Thanks Axel! Works here on latest mm-unstable

Tested-by: Zach O'Keefe <zokeefe@google.com>
