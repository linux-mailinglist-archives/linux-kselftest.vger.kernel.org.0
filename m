Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19F2357585
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 22:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349135AbhDGUIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355925AbhDGUIR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 16:08:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE916C061761
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 13:08:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bg21so7348881pjb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSd/S+8tc7IcQcSS/RpGMSx73CsARnvQdtoCEBJh4RE=;
        b=kdegvuLLfLm5o78sb3liPn/fXrlCsdbIKwWtIdW5f+cxv+zThPjVXprrQ7NbmPmOi3
         cFRU83hgkL/FLRMjgr6eNLao39YBnyr35OHA2RE1zjohqTdUvbV2bsDduBEOf4VxShM+
         TPgYbzkjuEIcQlKz1S+TiOv2wFamsk4RE38gpSUces43Jr7q3/36LXlRXcErMVVhm6Ri
         6Sz5rfJkdtQEBjOOhxhekCVRiYdg8GIHClJsDP1BzDgMRXjl2WVLhb8qA57M03dYZbBq
         vfqG+7CRlsaA2MuHX6hy0z1xUV/GNi1sB6GazNRRc592zKl1PzykqXHlcE0ZDcWGYk4+
         3K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSd/S+8tc7IcQcSS/RpGMSx73CsARnvQdtoCEBJh4RE=;
        b=o5OLIlTS+R/SPbYlTotQMMO15ssOnMmTUB3nNI+pa54qyuLQBQ1Tq6O5fqvwaRwMde
         hlpBFcuZN+QQTvWyNlLw6RlzuVQo+d6bFIcXzmID4IjCeKtOVRjkJfI8p5G2EXBzBsYa
         PuW/DgytaHLEMPZD0FkI5ORU2CtNLpVENVmaz7rdQ95g337OkCbuTe0MxklzChbp4YVq
         Ed+akjRm65+o6V7EHJZ07L//VpPAIFf6ILBD0dBy/o63xUPAtcnXovtQ0Ye682giiO+j
         MLVfyJqgA4LhK4PXufzDL95CK89szcuO+mJ8hPWAu5s1EdnfgVFnsk6lsS30i7EM8KDQ
         9I6w==
X-Gm-Message-State: AOAM533k9K8ip2SjTghCmk2MD+LOw1j8888O5RioHymOEAQFWPklaRGN
        qlbtgX+8mZFa3QtQ6b9ZXhLycvYkjvayEqVMVAxxgA==
X-Google-Smtp-Source: ABdhPJyyoL7VJ+OqLRPUux+V1NXnU4wvbvky0xki0Lfi2+ZBdBzpwZ+xJbPVPFD/Wd8/DCQHt2XFgpqgMrubjtjKf3c=
X-Received: by 2002:a17:902:b482:b029:e8:c21a:6ad2 with SMTP id
 y2-20020a170902b482b02900e8c21a6ad2mr4490815plr.51.1617826086092; Wed, 07 Apr
 2021 13:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210406225100.1883967-1-dlatypov@google.com>
In-Reply-To: <20210406225100.1883967-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 7 Apr 2021 13:07:54 -0700
Message-ID: <CAFd5g47EE3J5V9ofZ4r3H+3+16u41-yqa+uwFYVgpVCg4CKOwg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: add tips for using current->kunit_test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 6, 2021 at 3:51 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> As of commit 359a376081d4 ("kunit: support failure from dynamic analysis
> tools"), we can use current->kunit_test to find the current kunit test.
>
> Mention this in tips.rst and give an example of how this can be used in
> conjunction with `test->priv` to pass around state and specifically
> implement something like mocking.
> There's a lot more we could go into on that topic, but given that
> example is already longer than every other "tip" on this page, we just
> point to the API docs and leave filling in the blanks as an exercise to
> the reader.
>
> Also give an example of kunit_fail_current_test().
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
