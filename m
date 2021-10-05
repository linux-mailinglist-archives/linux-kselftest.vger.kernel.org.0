Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85CC422DC8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhJEQXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhJEQXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 12:23:11 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E464C06174E
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 09:21:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j2so9976228ilo.10
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsPMAPw99iWd0WhV63c7spsKiJkbce1Wl9V5bVSV9pg=;
        b=spnTz/2AVm9ssDQTJRW4Zj0xMkfyc4oc4QYOcMnAfAf/K2+P+mOa868KMUc143wSAk
         FqDLdioJSXFbCbpPScDOZEBjcsQPlMz9HC5rMYQWAQKhDqE1CI9U9h0OEJxE1DlTemKD
         u2UupU3hBe96JEChCHLg61acTr5z9NWtfv+N0/p4rlUrTYwg88PfQP0z651JzaePaKkE
         G5IY5HpE67Y+OzHEti9VII1jaWlsg7K7Iqk0eV5O9+Ekjg+cpGzy9irVTeaPpxEweFJw
         NIlrOmdKUXev6er/IUAWJYPAlQwnTTs9jwpSKOc2iyaIigKs1vExz8Y/IyL7/PddW3jS
         /5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsPMAPw99iWd0WhV63c7spsKiJkbce1Wl9V5bVSV9pg=;
        b=0+OVoxPOQ6Ym193tgao1ksA1bNnCr7Ts1aiIUCqcNhtVzZWID6E9GVtbnouGcutD9E
         Y7aA7zp0LwlXrJOzHRrJHUhFQi+UNGCe01va8nag08anTNVtu7tUc3XSjD0qWFJ2YN3s
         mO6SmXSQJlwH0I3uSX+UWvKi1rvICnktJvo6MqufhuSOKh7VUV6Y/3Pk/J6/o1OGTRje
         8gLHyKeIvHb4Cp3wXjRvFZfBAdjB19onar+M/xYOwT9aLLrkHB961jOKBlmi6a/qa4ty
         8ze5NsRzM4Y6yLBqsfF3zHfoPH7OsR7vUDKZy/GviKZtykdVzDhT5ecbI+WlakCv4fCV
         xxTw==
X-Gm-Message-State: AOAM533fHSKky2cNl0U/gEE6NEeIdC7/WQXLUolFT9Bhj+/gCv66zDJi
        fr2WggtpBJZZ3eJHFn00ZvVEJnkGAJxKm86oLC+v1lCb0gs=
X-Google-Smtp-Source: ABdhPJxjnIt9fxcA7gsYZJBGPC7mrhjXzYlWAlc8dHZJsqIJ9d8TEQJ9LJ7pZryrjritrPfKbbUCiFfe10v/G+AmnSw=
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr3648443iln.293.1633450879811;
 Tue, 05 Oct 2021 09:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211005053019.26284-1-rdunlap@infradead.org>
In-Reply-To: <20211005053019.26284-1-rdunlap@infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 5 Oct 2021 09:21:08 -0700
Message-ID: <CAGS_qxqRQ+1DmKQwyw-=Yud5LTeZ9LzPQfh-ooOrFuQFN1V3Dg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix kernel-doc warnings in doc. build
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 4, 2021 at 10:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix documentation build warnings in <kunit/test.h>:
>
> ../include/kunit/test.h:616: warning: Function parameter or member 'flags' not described in 'kunit_kmalloc_array'
> ../include/kunit/test.h:616: warning: Excess function parameter 'gfp' description in 'kunit_kmalloc_array'
> ../include/kunit/test.h:661: warning: Function parameter or member 'flags' not described in 'kunit_kcalloc'
> ../include/kunit/test.h:661: warning: Excess function parameter 'gfp' description in 'kunit_kcalloc'
>
> Fixes: 0a756853586c ("kunit: test: add test resource management API")
> Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  include/kunit/test.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-515-rc4.orig/include/kunit/test.h
> +++ lnx-515-rc4/include/kunit/test.h
> @@ -607,7 +607,7 @@ void kunit_remove_resource(struct kunit
>   * @test: The test context object.
>   * @n: number of elements.
>   * @size: The size in bytes of the desired memory.
> - * @gfp: flags passed to underlying kmalloc().
> + * @flags: gfp flags passed to underlying kmalloc().

Thanks for catching this.
But can we instead rename the parameters?
I can send out a patch for that if you'd prefer.

The other funcs here use `gfp_t gfp`, which is why this copy-pasted
comment does too.
In test.c, kmalloc_array() actually calls the parameter `gfp` as well.

>   *
>   * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
>   * and is automatically cleaned up after the test case concludes. See &struct
> @@ -653,7 +653,7 @@ static inline void *kunit_kzalloc(struct
>   * @test: The test context object.
>   * @n: number of elements.
>   * @size: The size in bytes of the desired memory.
> - * @gfp: flags passed to underlying kmalloc().
> + * @flags: gfp flags passed to underlying kmalloc().
>   *
>   * See kcalloc() and kunit_kmalloc_array() for more information.
>   */
