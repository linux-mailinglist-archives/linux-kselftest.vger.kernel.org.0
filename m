Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628C39CBF7
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFFA50 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Jun 2021 20:57:26 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:43776 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFA50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Jun 2021 20:57:26 -0400
Received: by mail-wm1-f41.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso7761183wmj.2
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Jun 2021 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3DxaiNSkw+eA+wXHpN2KP+oFrvWPJdQHdeQTKj9QQeM=;
        b=lUQyRaiq4AaXZaYWlH94S6Gn12mM38lNqlot8GXQItBQd53hfwyniIc3wxruyGl52c
         qPJLxMg+MoWiZ5jxmbF5hdBJ0Wvgggv/tFbZ+2Fn4ANbufSO58IbuYYcDgbbe4vDDX2P
         kbnBXtL3XwrbRdOHZJ8gHyqoVnMFfhcrCBGcPNdw/n8FjfvikX4oKWGwKskfOUwe8WBe
         eY4ffJ10mJ1mC6rgIn2BQTY+jdFPgpnyGZQWMUXuIdqBH1ZwekIsaGPm6I/c2ARSmmIZ
         4dV9ZkZ4E37cKxXXaN+tJdcdKMDDzKGC8Qadioa+J6X17wG7PJv+GhknTR8sHhSoIzcO
         GPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3DxaiNSkw+eA+wXHpN2KP+oFrvWPJdQHdeQTKj9QQeM=;
        b=n5zPQW839BMLbCDI2aoXiBprrvAr150Q9n3lVi1SXl7mF3EO95Hft5f6L6aOfeYCoJ
         HmGHfP9ESpFehGfoVQ0eNZ222SeabZxpfiMRJ+07HLxJ6U7HF4LtH5F7tYAz9jMXBDpt
         3dTbiroO0UMkZ8VmCdozrJndjUA0cBBqy33uuvyzysD7oLebxHo5LU04zZMc0zy90LPH
         gt0x3E1ijAKuA+UnFwGwLODeAKwx1TVwojPXY0sonTc7Om/isy/SLVRkMpPAa7ni/lk9
         qnYgo6D3rQiEEyyOvxSfYJQwLSSX5Ox7u2sGFKhA44/EFpkJN26/UUOR/Wrejc0Ur8Ze
         /N2w==
X-Gm-Message-State: AOAM532iYQUk5ZIQ4OWa4BDPLhMMuR70Yik2eDlAZMjM2RYkeQXMjUBS
        HB/6MBlu7tLKun6VO1gqZ8Jread5UDtarlNI/ybdxA==
X-Google-Smtp-Source: ABdhPJxW3B5oI9ev63JTOffeqEWrYZWrYU5sFyNrebXusVFcqbrVZAViyfqSDs3CtmbFkC5ZdBVCMuWtumEoQzrBCjQ=
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr10268090wmi.151.1622940864731;
 Sat, 05 Jun 2021 17:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605215215.171165-1-andrealmeid@collabora.com>
In-Reply-To: <20210605215215.171165-1-andrealmeid@collabora.com>
From:   David Gow <davidgow@google.com>
Date:   Sun, 6 Jun 2021 08:54:13 +0800
Message-ID: <CABVgOS=QMTjFEPqgBab27sTRdnW6PLG_bcD20ui_nC2wK_GAPA@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 6, 2021 at 5:52 AM Andr=C3=A9 Almeida <andrealmeid@collabora.co=
m> wrote:
>
> Remove custom functions for testing and use KUnit framework. Test cases
> and test data remains the same.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---

Thanks! It's always exciting to see more tests using KUnit.

Note that the names here (filename, suite name, and Kconfig entry
name) don't match what we usually recommend for KUnit tests:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html

Given that this is an existing test, it is definitely okay to keep the
old names if you think it'd break something, but if there's no issue
it may be worth renaming them. The test suite name (which is new
anyway) ideally shouldn't end in "-test": just "uuid" is best.

I know there are quite a few existing tests which don't adhere to
these perfectly yet, but ideally new ones will if it's convenient.

Otherwise, this looks great. I've run it here, and it worked well and
picked up on any deliberate errors I introduced.

So this is
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
