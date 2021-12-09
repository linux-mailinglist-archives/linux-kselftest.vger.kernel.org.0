Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAD46DFCF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 01:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbhLIA6R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 19:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbhLIA6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 19:58:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185AC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 16:54:44 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so4583582otj.7
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 16:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oayw19YcubpFrAM2rcGj+T1Oq/bzfF0MfoBjvEgDhvY=;
        b=DrC9twi4Lta/weWbKj7I1tdRFQUzvZcDA4bRPMXw/xdzUC5w/r7G4HputChGNvDqDi
         H761KnA9rgUpg32HJOuMzcbMRLV3n/Dl0ekGuVRBniHdYULujTaZ7DtTn9Y6F5AUZ4cU
         XPTEIPo7Nssr618Oxgciyvxi1LGYYHvWGJ3yPZR1yvp4aQWx8wm8pn5O6RwwRY/oePTH
         lUdzs4Xoq+plOyFsgXSXHQv0Ef6BRemc4znW09nkfnZQLRCmX8miDDZQJ0N1XcXXddQM
         iFY9ss/q7GfZe1N+dB7WdlAS37UecYu5sCRGWGCEM/b7/f3plB8jTT2oK86tWZVGStmA
         Tb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oayw19YcubpFrAM2rcGj+T1Oq/bzfF0MfoBjvEgDhvY=;
        b=peeQNDUfITSgl582iWtoh0YvdSFD6I7+nLUzL+z1eQKo/MIZKqM1VWY02slkq46G9O
         y2SlChV/NjbyN4mCe7DT+02QdvmUvUcom93XcPwBbxX2e5xZt4NBeJCZbvFEBfXBe5Gv
         asdZlU2TEFRYLnnGv8sENJT/jgBK3DHKocvXcoYPRVASVmJFnuMTmqH8rhZXq9JkdMxX
         C6z8gJqfNkulSquIZv3nFh4eUoqdGaJiTaDbmxW+ZQ7yXTk7pVt67MKCb+rCCU5OGXCL
         4m4gsOmTMfbxM5RmfBlddO3IfRT014UkdFfn7f6Qmty7WaddYJd8rJ7hz0GU6gJya6Za
         +U9g==
X-Gm-Message-State: AOAM5316Uvr7bkW7RYLznhPVNrYrGVKIOs8oWJPc20fcoG2Vk9Po+Psb
        OCvkRCqrJUqAky649smFk9C6Y5ogk/8uL2As6D7Enw==
X-Google-Smtp-Source: ABdhPJzGomSzkekQE828bfIUo/WHIX1ZFsfqM14FCi2GjwhNdEgjuJeCXj0n+HSC4lxJQZf70dA/USaOLKrkkQOCskw=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr2615930otl.237.1639011283934;
 Wed, 08 Dec 2021 16:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20211207093412.27833-1-brgl@bgdev.pl>
In-Reply-To: <20211207093412.27833-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Dec 2021 01:54:32 +0100
Message-ID: <CACRpkdbAs+ZpU_uQziXmz2inPG7VHD=746MmjmR8iY3szfy9+w@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] gpio-sim: configfs-based GPIO simulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 7, 2021 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Hopefully this will be the last iteration of this series. Just some
> minor changes requested by Andy in this one.
>
> Tested both with configfs as well as device-tree.

This patch set:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your perseverance!!

Yours,
Linus Walleij
