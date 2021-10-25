Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3DB43A5D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhJYV3N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhJYV27 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B3C061745
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 14:26:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q187so11985933pgq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKq2jb5/3JE7fNMhMAROX1b14m7uUaxWDnNmF54psuc=;
        b=fMajqLIbFXGo6lfFZJpr+3FhWBvfEyPg7nhATu486MiDFFsDTZXL4CpTl4ITO3tVj5
         nOpIXXX27ba621rMo8ep4Eeffph8d6hke3AGXnIozvXTmek0cZuwXK5BLKZD6+2Fxtlv
         FnoNEECto+hU34xw07QHvk9hf63FnV/C1s/OIjmbTZmqR6rAPmhw3RgkRoJ3AKrU4Pm8
         kHDKwd01rnhAekLmuaG7PuPwbb/wceFGmQhNqG48UmnrdzS6XJHdw09sTRKltsupyEpX
         6kPjcCRCayE1o5LrkfUUkofWylqoyR0xMoZtPVm2a9xPSNpXtBjXZ7SQL60ynMxyC4AL
         J5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKq2jb5/3JE7fNMhMAROX1b14m7uUaxWDnNmF54psuc=;
        b=TkCtZ2RllEUyGiCm8tfg+9NfmTMP8CW0nLWYzrJZTR+99BE5/oec2EZi/a/Lb9+X62
         Ok6+GFNw40uascALXHBdIpjRIflhIHoQBPPK6VLd/yiZqLnwG830AuztZKZTQhKaOihk
         Dpi7TcU0Qcy7jS1EUnYKIkyRjephiB3wO9IGPkzbZUL8QQIOn7tlP0a5QAlrvNODugTO
         Jh8h+pc96NglBeaNWoEtwDrAwuNdjP2qleqQRDXzYImA3U1rR910gcFy9k0SnRzI7W+1
         rCM57T4++M+MvvhSOKSBbqCmxgimBYQNNi0HiPLoPpICSSirQoVXWPRI5WZ8O4phKIhT
         uPVQ==
X-Gm-Message-State: AOAM5309yOaKKNMPYrkBVRjJEd18SjYWW5eTMw9vujcBjqjvJxZJLPKn
        VttUQttIAH7g3biSDvdpujQAKXPGVmWo6PcOz808tS06jKaf5A==
X-Google-Smtp-Source: ABdhPJyEgIVc4e1tQNeh5sAq/rMfXwyGnQpIDPzSMBmXDFnZFAWapmfLyaNLjvvprvwqbcVomB0jAzM9/vj1yF195Tk=
X-Received: by 2002:a05:6a00:2296:b0:44d:e2f7:4d1c with SMTP id
 f22-20020a056a00229600b0044de2f74d1cmr21034943pfe.63.1635197196182; Mon, 25
 Oct 2021 14:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211022004936.2049804-1-dlatypov@google.com>
In-Reply-To: <20211022004936.2049804-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Oct 2021 14:26:25 -0700
Message-ID: <CAFd5g46+SisBC6msW_vNLgcv_NSPq6gnEA=KC4TUjE4A+Nrbpw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix typecheck errors about loading qemu configs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 5:49 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Currently, we have these errors:
> $ mypy ./tools/testing/kunit/*.py
> tools/testing/kunit/kunit_kernel.py:213: error: Item "_Loader" of "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:213: error: Item "None" of "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:214: error: Module has no attribute "QEMU_ARCH"
> tools/testing/kunit/kunit_kernel.py:215: error: Module has no attribute "QEMU_ARCH"
>
> exec_module
> ===========
>
> pytype currently reports no errors, but that's because there's a comment
> disabling it on 213.
>
> This is due to https://github.com/python/typeshed/pull/2626.
> The fix is to assert the loaded module implements the ABC
> (abstract base class) we want which has exec_module support.
>
> QEMU_ARCH
> =========
>
> pytype is fine with this, but mypy is not:
> https://github.com/python/mypy/issues/5059
>
> Add a check that the loaded module does indeed have QEMU_ARCH.
> Note: this is not enough to appease mypy, so we also add a comment to
> squash the warning.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Thanks! I could not figure out how to make this work for both type
checkers on my own.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
