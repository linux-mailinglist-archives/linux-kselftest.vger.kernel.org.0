Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2234ECF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2019 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDRaz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 13:30:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42678 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFDRaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 13:30:55 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x54HUnnO031843;
        Wed, 5 Jun 2019 02:30:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x54HUnnO031843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559669449;
        bh=Ke3jFtfR0IupnNpNkmhdXNiTmzoHjUV+JOucXec4i/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gouvuNPsRL1KPQx3usdUnyGSAtghsqRSSL1X5706V2o1jpuvlLrCB14TFpPlkGpTa
         2H/XOz+b7Ij7fRWgufOm6duIIdd4ySwdZ9KlRgzKg1NhTELMbyTy8WrL/bsOi+QaVp
         M3jTeS8HWd0hYM/ZaLT4suZERvpzgtshXAQB1gq+Fmj43UduIGiCKgFeDfcH3HFk0h
         1AFkdDBtTCMuFvNzl7GBL88TnY24CCMuyNo+dsJ350CevRFPQ5mllP8Z6GpDlYZB4L
         ejFSJTRraxGDULAoU8MoTB6GOhirynJe46vUqrrTSXSGJWrn6G/E9NPsXcE9P92hRI
         Wx0rOeGwZAbow==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id q64so4361681vsd.1;
        Tue, 04 Jun 2019 10:30:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUS1agjubygkoR54QcHdWL+al8py5iDTNHpj8r0+YmnKfPKD+YI
        sduniP9kmOGB3YzYyrWeUcFPTACIqFkORCeeVw8=
X-Google-Smtp-Source: APXvYqz3/kHIsgtyIFnnNahMh+SN4Xp6WTSHW5hu+Dg4XzzBTK/seNpmLpSrwi/yKzKncJCj/FybysBaeNlwQd7QEtw=
X-Received: by 2002:a67:f495:: with SMTP id o21mr1245218vsn.54.1559669448381;
 Tue, 04 Jun 2019 10:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190520151614.19188-1-dan.rue@linaro.org>
In-Reply-To: <20190520151614.19188-1-dan.rue@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Jun 2019 02:30:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARonAGTShZTyiDL02qtP3PUg7jyYZRHG9C-MUY+zKY22g@mail.gmail.com>
Message-ID: <CAK7LNARonAGTShZTyiDL02qtP3PUg7jyYZRHG9C-MUY+zKY22g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: teach kselftest-merge to find nested config files
To:     Dan Rue <dan.rue@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 21, 2019 at 12:19 AM Dan Rue <dan.rue@linaro.org> wrote:
>
> Current implementation of kselftest-merge only finds config files that
> are one level deep using `$(srctree)/tools/testing/selftests/*/config`.
>
> Often, config files are added in nested directories, and do not get
> picked up by kselftest-merge.
>
> Use `find` to catch all config files under
> `$(srctree)/tools/testing/selftests` instead.
>
> Signed-off-by: Dan Rue <dan.rue@linaro.org>
> ---
>  Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a45f84a7e811..e99e7f9484af 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1228,9 +1228,8 @@ kselftest-clean:
>  PHONY += kselftest-merge
>  kselftest-merge:
>         $(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> -       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -               -m $(objtree)/.config \
> -               $(srctree)/tools/testing/selftests/*/config
> +       $(Q)find $(srctree)/tools/testing/selftests -name config | \
> +               xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
>  # ---------------------------------------------------------------------------
> --
> 2.21.0
>


Applied to linux-kbuild/fixes. Thanks.




-- 
Best Regards
Masahiro Yamada
