Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3D49ED66
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiA0Vbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 16:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiA0Vbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 16:31:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27DDC061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:31:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i186so1550037pfe.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz/ww4Xxf9AhheuMjmzrqQdGjfk6TtqnXV/Ka043oaI=;
        b=JpsiDFIsg0tbXVWMBeY2nkKSacqRssUJMUlALByJKU5fMapNPnSugV2/objCHt/097
         gTYT2kLmoA3QTqhBXmJzNYpKPbrWrgtlV9KlAWCB14IM9VHbVrxF367sGMSjkz7iNBAT
         q+bwmeE3/OzO19oj6goop+rlUIQ35bx61SSpxPTzxtUni2LqxwZbMqsNW6nTNTNRPBJN
         LKJNukfHYp1K1Ji/PFjiXS4E/VhYKmK2v1BZaYDTK/6wH4DWq3yKyjdnFKn47X0k3T6f
         drtHqYcbeXgYN1tu99ByreTSqJCm3YYtHAjr47KPOd9tsytbHU4fFE0OIXXjhyMZKvdf
         M+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz/ww4Xxf9AhheuMjmzrqQdGjfk6TtqnXV/Ka043oaI=;
        b=k8ZU7NEvSvuZZ5FEm5zP252SVuVgvWUpmxUvErpM3m7IZE4KWMxM/i1y/076aEwjjx
         aQYs4zgxcDFOAnrWl3J2Ly9xSsrs3bAfw3XZRW5Ngs6d2QyiK0e3KOGlH68B7fXhxU9D
         0LF6rXXJ5MWtllz21ltkG5zm1UF2Atvpvgix3THL/Kl04IQ/20oTOWqz0cYfQai2Eoso
         UdYwCL6SC/nXtVFxoqoXzMkAVeOSU7YY7P+jMhLvqVqDQia/eCN2SZ+ug5Eqsdo6fvlg
         YiVq2ixhFdW+2xajf7UPWvYm3RgSw+DJsxS6tDCjVCzXXvb+r1twBf9LousliWglILBc
         bbSQ==
X-Gm-Message-State: AOAM533qUd6yj4m3bgBpoYkn5xScEJiNsKQzEcJWbvUZn4CDlJmHamg/
        V8f8EdrQVNSu8pvHNFAl+GBEPTteR4WQPp2Bk3ET6g==
X-Google-Smtp-Source: ABdhPJxNqZSQoL7BZ8o8r/TPw366SyH3dmL+SQpyYDu7DxkNm8kbQ1NWikP78APW/PSg3HqugFMx7XdbSc7YfWgk29c=
X-Received: by 2002:a63:184a:: with SMTP id 10mr4053594pgy.609.1643319091140;
 Thu, 27 Jan 2022 13:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-3-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Jan 2022 16:31:19 -0500
Message-ID: <CAFd5g46jxy96NdTJwrBdydaLvzFNP4tvCQVMLmTkt=+VjDiciQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 25, 2022 at 4:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We currently have 2 other versions of KUNIT_INIT_BINARY_ASSERT_STRUCT.
> The only differences are that
> * the format funcition they pass is different
> * the types of left_val/right_val should be different (integral,
> pointer, string).
>
> The latter doesn't actually matter since these macros are just plumbing
> them along to KUNIT_ASSERTION where they will get type checked.
>
> So combine them all into a single KUNIT_INIT_BINARY_ASSERT_STRUCT that
> now also takes the format function as a parameter.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
