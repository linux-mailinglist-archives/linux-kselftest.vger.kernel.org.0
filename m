Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE31E4069
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgE0Ltd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgE0Lta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 07:49:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE57C03E97B
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 04:49:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so14270133lfc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=dZ2EO3LdRXmW0rb/PbGBy5/ATbLPpBSpne2iHWL8g4cHa5pFCH5GCbOAD7jC3Kzi3S
         MISYPGpgS2exm9jQV0gLr3s2v7seE3tyMVMGbhwvcq5KWBC2lbp4WRogLsHJmD56dSoF
         SaGqBkdQFcT/Q8+h09FriRhyy32nZ8Qbam2ia6qehADmirwsw9FzofuUIssUXiEf/O1M
         PNKyMGSEEuXIahADQmZbrbIFZkk9iuRkEcQbQIaG2M4cssRD0uw+ZxOkNkqohemuxYe7
         g5KMFqDZR/29AuHUIPPzijSDWnAEbdNVWRVRrdnecAjUZPqBYLoGLUucygRKxHZITQJs
         lRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=DTB+3oKwZjiVgW69HqaRXcUNKX2Go6R+nLs7tdoNqL1+jTrBGDMnAYzxlED7L5XpQM
         klYIRkitTX06mdUzakn2CWEHeSQik7/bEXBuouizzIA2OwH6+HWr+uAlyjeiG8KGny0c
         JGVwlU53E6u8IjTES3NKABd24pzvfn1SvjzlGHFDujqWaXNGVCmkE++GP3xHC79URn5o
         DkfWSC/wQtyThgDYE65aZ9CW2KIQ009lgjmFZpYRAmzbHNFtLYn9NyQG4J5wOTJq7H9X
         Gzj3cELc7mVBY0YhtzqnVVt/wIZqt56nIMTT5b9Tp4+52UYTo2kbMzHKtBzGAcIoIKz0
         zD+g==
X-Gm-Message-State: AOAM533k+3egmbf6Lr9wnvzPRaKs0sDgUuhVL6F0eYHV1WWSZ6D0KzXH
        qiis3qIh2D1S0bzUpFOzRFWEUnAjY6TXlVIVuaDiew==
X-Google-Smtp-Source: ABdhPJxtfHGgD1x+0sGWQDtxJJeB9uCl6Feg/5utDqmnhP3TYYxI7kATndRbmt63ldid6mOZbKhfx/ZSXQlPvqovUXQ=
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr2908078lfb.206.1590580167403;
 Wed, 27 May 2020 04:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131350.29638-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 27 May 2020 13:49:16 +0200
Message-ID: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Friendly ping: who can take this?

Cheers,
Anders

On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi,
>
> This patchset will try to enable as many KUnit test fragments as
> possible for the current .config file.
> This will make it easier for both developers that tests their specific
> feature and also for test-systems that would like to get as much as
> possible for their current .config file.
>
> I will send a separate KCSAN KUnit patch after this patchset since that
> isn't in mainline yet.
>
> Since v2:
> Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> suggested a great help text.
>
> Since v1:
> Marco commented to split up the patches, and change a "." to a ",".
>
>
> Cheers,
> Anders
>
> Anders Roxell (6):
>   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
>   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
>
>  drivers/base/Kconfig      |  3 ++-
>  drivers/base/test/Kconfig |  3 ++-
>  fs/ext4/Kconfig           |  3 ++-
>  lib/Kconfig.debug         |  6 ++++--
>  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
>  security/apparmor/Kconfig |  3 ++-
>  6 files changed, 32 insertions(+), 9 deletions(-)
>
> --
> 2.20.1
>
