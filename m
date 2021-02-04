Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCC30FD33
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbhBDTrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 14:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbhBDTry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 14:47:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C29C0613D6
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 11:47:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id j2so2880931pgl.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 11:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M71/0+4/VPdITa6DX0e4x8GpxsKtJ+qFh8ESOZeP7Dc=;
        b=jthU5IMT8bGmrxmtDYWqfxQLlMrYewykUAS8xgvJTl5tztr5hJLifwL5fcoFOcmEFA
         +la2ZcSyETWeMwUOEVSVOgmaCP3WWsjYYu/aFWKhAxeBGJQ+JAsluk3kIG+FyT56tCBa
         51C62Z1yof1LhPxJP6BsbfOtqxMhfXOwgmJdsl/cKFS3dJNpFqH5hUicpsELkhRXIV1O
         dqLG2PCUz+6NBt8NM+D2wbNjcKZicBZfhOgq+s2ARZyjmETtm6aMHy0UIiDw+D3mVUyn
         xSvmkh/tXqHT88epfAg6velP2Yx5JFHCLRey1zNkNrts4Ox3nTgrqkPx/cKTQ/sowMKM
         9Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M71/0+4/VPdITa6DX0e4x8GpxsKtJ+qFh8ESOZeP7Dc=;
        b=EwjX1sKRoEhkVXkkTUnWPcfc90m9iM6BFuvsHk5wofp1lyDDYYfuVDOGPtQQE5H+ha
         k/fv+QonXLNDIV+4B0I6Cu9oPmYcb1NylpbjAK/rC8xKn3SQV2+YcZsuvtVa/agr+7H7
         yMaSCEfJdQvSWPpc5xYB0z/j9bXHzKE1oFjcWWW3ON3nBi5HxuKBiKnIUidWiiqL9kqB
         WHwLcFYrHjWX2hJ+JEZvVX/5CnaIXZHemOItU5H/QN2siQNXQFx4dAdBxSaEpBTYD9Wz
         i57oNo4Vh5i75yAsEhoULqsBuhPqJK39005bOmSVsHpnKDzSWBUyuwD1NppzZOy5y1J+
         hzkQ==
X-Gm-Message-State: AOAM531rUGEPSDXIB7RKt7u7zoUrtUrjsaJ7A83+WqIsQvPhropa4VKO
        gec+ZV4d23plKbI2tT7FlPaha5PiA+2aJ4LcmAreAg==
X-Google-Smtp-Source: ABdhPJzVtYp2aDG4dPbYfDQH+IIb9J7pzYykY8WzxVxFBR2E4sZ627eieZqffbjTwHwQjMCu8dwASM4FIc20VRqrMgI=
X-Received: by 2002:a62:fc84:0:b029:1ba:9b85:2e92 with SMTP id
 e126-20020a62fc840000b02901ba9b852e92mr871767pfh.38.1612468033581; Thu, 04
 Feb 2021 11:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com> <20210204173045.1138504-3-dlatypov@google.com>
In-Reply-To: <20210204173045.1138504-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 4 Feb 2021 11:47:02 -0800
Message-ID: <CAFd5g45_j-uw0tLVv_i6yHXOE46RKpJ7HoXJyfDBGk8=2jxdcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: tool: add support for filtering suites by glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 4, 2021 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This allows running different subsets of tests, e.g.
>
> $ ./tools/testing/kunit/kunit.py build
> $ ./tools/testing/kunit/kunit.py exec 'list*'
> $ ./tools/testing/kunit/kunit.py exec 'kunit*'
>
> This passes the "kunit_filter.glob" commandline option to the UML
> kernel, which currently only supports filtering by suite name.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
