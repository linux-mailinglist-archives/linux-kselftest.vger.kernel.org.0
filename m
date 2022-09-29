Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE525EF2F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiI2KCg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiI2KCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 06:02:33 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759B13FB70
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 03:02:32 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 63so965972vse.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s5OrniKzl4rmm8uJE8QHztsHv1KOZNfgmUrLh5SNgvA=;
        b=EwjW1C7nLHlmLOHmx2r+kWE3CmfvAv4iXfmeeZu6EDuWYBgbur0dbdtycfgIGlznm3
         27zzu40FLq4EGcNcQ/rh1N/MAS85afAB7x8FamLKkyVM4pnDKvATEV2ZT0qHeqxu+GyX
         XWHSifuCZLnXV/SBx85xsLyP9MMCMrXtnOLiU9H4ozh4XUcMcMarPn+//3yr7Rb0Ekq4
         fZvoPy2z95uHHHOusbEIa8Ui8wu3UODlBKD6jovIP2uAke4ZmceM137VQNy+isCdf6vn
         SibGAB/395Ta/nKUxC/VNITcWoirNuS1YpZIqroBn56rwHuJjjcmLFCsoWn7uShMABju
         B/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s5OrniKzl4rmm8uJE8QHztsHv1KOZNfgmUrLh5SNgvA=;
        b=xtwGqubqyT68Rr4CJ0aeGNTXyHDVaXq3UrkRtVcUQ3oQMaMSTGPaogVs6AGBqag9t3
         EJAgwTQXTI33f0a2buirl/8hOaN8+RsoSwTtqDDduyHdWtUO0N9rxnNQ88TFt4ny6rlX
         f+I2beEjchPDx9bJnlrAHO+okHb0EJPK9kHK5K+SYVWTObJ8d5o+TNgM5gOqXlaPQq75
         b6dY6bUSdoBe/L4DXiq6SGPVm9uC0R/jSOyJEEH1HrJpbvwBHsrwRouw5eZYU5nQXNbz
         Ltbay5RuARGqAq5iKJI4DTthdob0WnUuWwtYrCK4BJXgbkI1trsbMWJSPjBHUTB/SCKh
         NWFg==
X-Gm-Message-State: ACrzQf2jRL8Wa3rR1Tc5oDkSWr73X4oR+9LsEtZTjxYOHhcgl5rZ24U4
        lTPYCOwNMjzkA4+0pkx0pFyewW12VlJ1H0P9pzEDVw==
X-Google-Smtp-Source: AMsMyM5Xe8KnmTyLzcTapEvLYjfXlTWFegc470kap8tnWEU8YGbLGL1Ovy0RU1mLDUUA6VfQeyTefbgEnXvk194lQu0=
X-Received: by 2002:a67:c891:0:b0:398:a7ff:e0f0 with SMTP id
 v17-20020a67c891000000b00398a7ffe0f0mr880016vsk.22.1664445751374; Thu, 29 Sep
 2022 03:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220902202248.3061262-1-dlatypov@google.com>
In-Reply-To: <20220902202248.3061262-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Sep 2022 18:02:19 +0800
Message-ID: <CABVgOSkiddQwHAD+QagKdOB9RkDF_hUFGKtoYt82cDKEZgdvkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: remove UML specific options from all_tests_uml.config
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Sat, Sep 3, 2022 at 4:22 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> made it so we enable these options by default for UML.
> Specifying them here is now redundant.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/configs/all_tests_uml.config | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
> index bdee36bef4a3..f990cbb73250 100644
> --- a/tools/testing/kunit/configs/all_tests_uml.config
> +++ b/tools/testing/kunit/configs/all_tests_uml.config
> @@ -16,8 +16,6 @@ CONFIG_EXT4_FS=y
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
>
> -CONFIG_VIRTIO_UML=y
> -CONFIG_UML_PCI_OVER_VIRTIO=y
>  CONFIG_PCI=y
>  CONFIG_USB4=y
>
>
> base-commit: 0b3acd1cc0222953035d18176b1e4aa06624fd6e
> --
> 2.37.2.789.g6183377224-goog
>
