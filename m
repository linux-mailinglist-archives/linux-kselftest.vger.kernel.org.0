Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA02B3D1904
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jul 2021 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhGUUpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jul 2021 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGUUpo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jul 2021 16:45:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E392C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jul 2021 14:26:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gx2so3198465pjb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jul 2021 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEjsVifgHSYqzwvQvCUvMapsO8MK++s1d6W2dbzIIDE=;
        b=EPd3f7voYspj7pOpQ71TYngADGM4zkumVB+324J85pqfQyZDu9pKZDJ6Khpr1Mx4Ff
         EP4mMrlx/DEzSc/EU3g3GbiT6ns++Ns4JDedsyIngKKCw3FvhfNn33VAIsT7z/m4lO2x
         BSyGwyY8buELjSbt3PswgSoY0/CHAfcEUh22o7y0ytE1UsEJ7HyPtE5jQRRI7mFqz5ns
         aKJ2P3hrtbpQKKMeXnHhrG6aoqJsPx+kexnIiz9vO7qsm6YAp3zVUnj5Di+WuiqYJQIr
         2iRrLD9uHUtFnoJ1zeGkMshsC3OtK9r1AhsevrfstROv9r8kcKFayfEkD7pZzLhePbkG
         QimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEjsVifgHSYqzwvQvCUvMapsO8MK++s1d6W2dbzIIDE=;
        b=n/NbmjnF7HHlYWKjTXZSVh2rUASquQmYTCT49bAqAB1BKA6zZKneNtTu0tbxuoswX3
         LkxYzRDTMu7/mgBKAjYJLu3aaYqnRYyryN9PNY17G4DLiO8a4iprhNDAaIetDgQLUvA6
         IEGCSvP/ToS6MkLwwTPRUKMBOnwLpv0bbSnrAhlb3pvCSlWsSeIBjLTBGQXGzgMJgn8G
         sWNNL8ZA9UaCfqFXEfQmjgSbBDyUOar1di5/WhCq/txCCQfJKbnrjg+g9UC4+FuWSXF4
         +rBQln3XcL/nQcLc78jMNqTfJm5C3pBMw5cfhYzHV2fJhvwSQJluZ6zIg38zm+eWJHL2
         XTMA==
X-Gm-Message-State: AOAM530FaCb/fs4VOjwVCxn8+wvnTgWFZNtU9Y1HGdSFAWNKnkU5J5Ea
        TRu0fwqveR5FSRltUbMxpeSB5zYMQsEUZ3H3ZeJEmw==
X-Google-Smtp-Source: ABdhPJy3MsXAMRnEcWL1q7bagsI0t78QU/NDYB5tgOjO2V/5BfYCUvcI7HYmqLTZmFnXf15v15rp5xZW/sKHHJdFMpI=
X-Received: by 2002:a17:90a:6394:: with SMTP id f20mr5655745pjj.80.1626902778614;
 Wed, 21 Jul 2021 14:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210715160819.1107685-1-dlatypov@google.com>
In-Reply-To: <20210715160819.1107685-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Jul 2021 14:26:07 -0700
Message-ID: <CAFd5g46ZZiKu=qEFwMbmTB97iFkjb6PE=sOcNEphGc5X1u4Lvg@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: tool: add --kernel_args to allow setting module params
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 15, 2021 at 9:08 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> kunit.py currently does not make it possible for users to specify module
> parameters (/kernel arguments more generally) unless one directly tweaks
> the kunit.py code itself.
>
> This hasn't mattered much so far, but this would make it easier to port
> existing tests that expose module parameters over to KUnit and/or let
> current KUnit tests take advantage of them.
>
> Tested using an kunit internal parameter:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
>     --kernel_args=kunit.filter_glob=kunit_status
> ...
> Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
