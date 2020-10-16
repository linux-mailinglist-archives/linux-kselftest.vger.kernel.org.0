Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A84290B82
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392652AbgJPSnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392649AbgJPSnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 14:43:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807AC0613D4
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 11:43:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g16so1845125pjv.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjRKy8tO5H1NSt7xRwAUjhGx8gjnMiijuNFC6gYdpEA=;
        b=FBMgfdEtiuH+n3MckO2cPuq8hiivcKlHUIcdLMp53dZWHQkk6nvsQw0rVct60lMfH4
         c/54Acv3xGvkzZ1x+3Z0O9Z1TGlDgjOyDtfqqZLDA3wrSExjUvaQ9E0Er+guOixo+7Hl
         0+7vJVdDlXY5SCMd39MeVN6Zy3613f4WqjGwrkOBpic+m4I0BgvRFZJBFlgxNYTRbCqB
         k8BpDky767pD+q9YLxUeEbpVYZLI2WciS5VM4aJvZPUkny3CJI6OWNpoCZT1luF9PQF+
         YufXWNdZ111G6XsMoZ1cOjxIJ0SFjiBxIw3UBKrUf0CDnmZ+axp8k5QRmkTzzDm+2jDz
         /jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjRKy8tO5H1NSt7xRwAUjhGx8gjnMiijuNFC6gYdpEA=;
        b=M7cwlFI1UMK0jpIKDWYljsMm9s9CBTyntjMeOkaPdD/akCnH/uP1lbeY44wM48bXPA
         3tO49GJj7bhhSMFYBTMBtnkQW2Reg4Wz+twOfwsGx9VPami+sRHx+Z/60JmDggPEG6Qt
         Lj4qfcDASz6vvQKXLhdYhA/0sfOFQwHB3PdNMEpTibLSw/GvajUofKkes7EKmHgH0YY3
         moPDq2fi/ZloXrGFD9apcDu0IRMTlvNvqDvsR8jBg81NCAJhwKkb+UGn2D8b4zx0kqjs
         l77H6qxrwuqw95lOctd33cUZA5JBKOrF7iq7DD71b4IfI0bTVWUwwYFTrfaoWRIDdq0c
         Di7Q==
X-Gm-Message-State: AOAM530JivWmt/Y+U6xIFrUfectdKZE02tPdAaIwY3AP5b4r6mXJeUkb
        0FgovTP2mLUpq03ONKX9+sitQoJDWi7Kk63wdVME4A==
X-Google-Smtp-Source: ABdhPJwyvQ5xXL2zCtmyVQTUGHb7XZMa4r4xeRyRSJIhBEbQFS7Kf3Z6/cngFdrb3ZqYasfzimwcKr7T4ug9kQk82nc=
X-Received: by 2002:a17:902:7003:b029:d4:e2c6:948f with SMTP id
 y3-20020a1709027003b02900d4e2c6948fmr5428154plk.65.1602873789432; Fri, 16 Oct
 2020 11:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201015120851.229242-1-vitor@massaru.org>
In-Reply-To: <20201015120851.229242-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 16 Oct 2020 11:42:58 -0700
Message-ID: <CAFd5g46TfFSTDO+SeYVrtJU8b+jYv_U9GWYhcGxGD4r1KHnxtw@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: Fix compilation test when using TEST_BIT_FIELD_COMPILE
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 5:08 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> A build condition was missing around a compilation test, this compilation
> test comes from the original test_bitfield code.
>
> And removed unnecessary code for this test.
>
> Fixes: d2585f5164c2 ("lib: kunit: add bitfield test conversion to KUnit")
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/linux-next/20201015163056.56fcc835@canb.auug.org.au/

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this so quickly!
