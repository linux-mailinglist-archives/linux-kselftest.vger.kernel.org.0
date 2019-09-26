Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0CBEAD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 05:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfIZDZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 23:25:27 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38035 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfIZDZ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 23:25:26 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x8Q3PHOj027377;
        Thu, 26 Sep 2019 12:25:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8Q3PHOj027377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569468318;
        bh=Xc9AZqmoajha0VuwXoxsUg6PKLg6RASYXKitm94bwH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lF/KeIrNoNCRlUtTOKLABr7qQmVAQVYvc38q5JRKYJZaKCRcNGrQbai4cnnXfEFxa
         J1StlIBDt7cnuw03QeSezEMcA5D7qcPjRFC6xAnVssbkqI8dlq7zk0OTsaZXTvy6BT
         XrFvMPBAaHlSws1XY08LxNcZw2W7SrBjMV/BwzwYHYbcEnGg09DJZBWcvAIAAwum+2
         Mm/L8fB65v+vvF5J4pAdQ4aiu0fU00rQRcclWlzkEjW/TRVCvYqyzbW58qp9R/aTN4
         qK6kKQidCkzddSTESeZ2E6P7Vcoe9O6j88uYc7cw/jGDfEZBKsXoxlsRZgd/ZbXsu8
         6v5vorpoxxtGw==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id j21so129632vki.11;
        Wed, 25 Sep 2019 20:25:18 -0700 (PDT)
X-Gm-Message-State: APjAAAXuV7G0Ft5eDNOXNOwecnA/weAxudu0AiARNqulSTsyCx5DCvjS
        Rs2B38kLJNSKDL10L2Z25asdBQ24bWE9OvdtYL8=
X-Google-Smtp-Source: APXvYqzT2N9dXQezYT/CGbUaF6nq6YPuz5Z6u/5wSx5Q/hagShT1nbR/LFTHK50Pho6GqFvdOXK9LmvQbbsCTZEUrss=
X-Received: by 2002:ac5:cc63:: with SMTP id w3mr605734vkm.34.1569468317002;
 Wed, 25 Sep 2019 20:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569452305.git.skhan@linuxfoundation.org> <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
In-Reply-To: <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 12:24:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
Message-ID: <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: Add kselftest_install target to main Makefile
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,



On Thu, Sep 26, 2019 at 8:05 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Add kselftest_install target to install tests from the top level
> Makefile. This is to simplify kselftest use-cases for CI and
> distributions where build and test systems are different.
>
> This change addresses requests from developers and testers to add
> support for installing kselftest from the main Makefile.
>
> In addition, make the install directory the same when install is
> run using "make kselftest_install" or by running kselftest_install.sh.
> Also fix the INSTALL_PATH variable conflict between main Makefile.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

So, if these two patches were applied, we would see the following:


PHONY += kselftest_build
kselftest_build:
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all

PHONY += kselftest
kselftest:
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests

PHONY += kselftest_install
kselftest_install:
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests install

PHONY += kselftest-clean
kselftest-clean:
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean


I do not want to see this endless crap addition just for
changing the working directory to $(srctree)/tools/testing/selftests



Why don't you use pattern rule?
Those will be reduced into the two rules.



PHONY += kselftest
kselftest:
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests

kselftest-%: FORCE
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*



This also avoids your inconsistency about
"kselftest-" vs "kselftest_".


Given the existing "kselftest-clean" and "kselftest-merge",
"kselftest_build" and "kselftest_install"
(using an underscore instead of n hyphen)
would add needless confusion.


-- 
Best Regards
Masahiro Yamada
