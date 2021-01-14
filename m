Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762742F63A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 16:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbhANPFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 10:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbhANPFP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 10:05:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CAC061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:04:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id by1so2235732ejc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcbbwuTIw0XOxXbx1OMAv/zQ0f55cTFOH0Nbkr3v9jQ=;
        b=yEQItAvigUbfYWEhi52aXuHAPZ6tuAT+qCXXEz38nS35ib8OcfO7+gDDF4v51PSdqO
         yK6DXZVx+k8ENzwUIBM3pCe8Qm5RXLMR99pctX2BGhzzUafnl2uPG9GR5xhVL5+iqTK6
         psk+q8hQ2VVxs1H+G6MVFLuMxpX5BkoJoyngpGmNxk6jWom4qSIxmJMywtK5LW+OehTn
         UoMfUhx+FUVFS0hHg91ARMaZMgJodjBwEVItDiQaF9Yd19jROYtqMzANthaPc1a39tmu
         C7iDgYdZ9RgcNAwyDDxoJ56VIfbn0G8cL1pEgiN0QBjCgtrB08+wDIFoHccqiGHTuDbR
         wJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcbbwuTIw0XOxXbx1OMAv/zQ0f55cTFOH0Nbkr3v9jQ=;
        b=raeZAk8gJJjz/R+tqlk+VtOQlH0g2KjidtHH4CmM38dETJhvrD1J59qlFWo1USP2LW
         7qny8MJQY7zgewrTd5NMmYy0ZLzVybu2W4nsHcoAU7u47szOywBHsWz8rpkyosPe/kXu
         eeCT4wiGCj4bwWPTgLPPD2t4s63DXEqnKdBlzH6vFaX3S8YvONpIxRGf9DKPGnc5Hp7I
         G1GcxlB8541AZ3JCKyAHOMBS135runuIgyDOFWaj2MtvkaRZAB4a/QikxOo+f6KUoQuK
         el9gjl2+FlIUn1gRNw3DcT3gYkOF7FAx0foCXS2K6fYzrdPpH7O1OtOKIorpoFmUs/H/
         KGEQ==
X-Gm-Message-State: AOAM531nVG/qk5slF3ULiUz2XiT8S7wnOuPVmAjvAySZbSv/ALBD2qTu
        IgEF8Cy/DQeUr1Oje3eQGwdEwY9x3e2PZ2SLkkicKw==
X-Google-Smtp-Source: ABdhPJzfhHY7ArHTAP1cnKCI9FVF1ePtOXIVFPGTJb4hX8UeuqKZq4J5eTmoMo9wmuacHVDMDI66XIwVLCYvcqL1JVQ=
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr5543469ejd.429.1610636673865;
 Thu, 14 Jan 2021 07:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-2-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-2-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:04:23 +0100
Message-ID: <CAMpxmJX151+boZkX8SJ7s66GFOfcRvBAvGVTs96Ce2J4ETmFpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] selftests: gpio: rework and simplify test implementation
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> The GPIO mockup selftests are overly complicated with separate
> implementations of the tests for sysfs and cdev uAPI, and with the cdev
> implementation being dependent on tools/gpio and libmount.
>
> Rework the test implementation to provide a common test suite with a
> simplified pluggable uAPI interface.  The cdev implementation utilises
> the GPIO uAPI directly to remove the dependence on tools/gpio.
> The simplified uAPI interface removes the need for any file system mount
> checks in C, and so removes the dependence on libmount.
>
> The rework also fixes the sysfs test implementation which has been broken
> since the device created in the multiple gpiochip case was split into
> separate devices.
>
> Fixes: commit 8a39f597bcfd ("gpio: mockup: rework device probing")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>


The C part looks good to me. For the shell part I would probably do a
couple things differently but since we don't really have a coding
style for shell scripts in the kernel, I don't want to block these
patches, so:

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
