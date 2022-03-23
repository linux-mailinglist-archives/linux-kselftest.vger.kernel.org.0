Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F64E5A11
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiCWUr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbiCWUr7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 16:47:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9268CCC3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 13:46:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t1so3301641edc.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WH60uTSBbbOblHqK28xy9BTYXyukYPb7J6N0+vdiNIg=;
        b=V+aiWhUweR0uDl/dkvdsvI2w069p2RxAa2gDCtul9NOQOypsbChwl5HeM48HJoMX/J
         Y8ffKwIkmFoAIWRdFFKKzjBYZnPA9gvI8+U5SuXTQsPz4rg7Mg1klnAoAjKQaR7hsz7N
         yq1CPq+Ezu4xRXwn8uMjypx2yGY8iWx0H/MsH3Q6DA0crd9T8RQiX6y1igswnhAOpVOZ
         4W+q45BkXoNGMrBinkYQY7+Kl4/6/AXy9DRA/iCk3zuqgOqdFlAlCdq6ot5NqyUs97xg
         XatSI8ykI1t1D/pSf4dAJfCOISyh+Nd5TYlvxr1CtRLDQuyd4REgeOYH+2MjlBNSps3T
         8Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WH60uTSBbbOblHqK28xy9BTYXyukYPb7J6N0+vdiNIg=;
        b=T9vmXa1ZFis3c453D1hTWyg66N/eAgkEyjOjPtrYvwQFZ1zR+pO6TzFVipEDkwNR8Z
         90P7bYWko67LjpurFxk31QGfr5/ZhFUmIzK0FUALtihNyMml9coVl2YvBlHItY3j+w26
         dU50G/XJ4lWSnY01jUfqjWDSqYA0bM/WEyR3+onbcqIqZSQndN7MUBBLnYbTtWgF58Rf
         LOjJfGueDl2OJCsSuH6EbP+e8RvapLKroBgg2rDK5dflVWQ5skj6REXDgjtCsL0/fpHw
         HBqzABtwpduTqaDk+1QdIreb/pW9JxjRDRJFHSMOrv0dPCiFobExoRHruMXtmRz0r4I8
         tsqA==
X-Gm-Message-State: AOAM532rG2So3n0TJrS0HvFgXn9gS3m4XLS+tFpaZ/kn0K+ZGxY5SyKs
        sFdghvyOjPY8VnROgLHrCFwOvbCQkgvVoaVLZQsrej3Ddd5h8Q==
X-Google-Smtp-Source: ABdhPJy77sNORI3m8k2PJgQY3pDKoHxiiTbX9XZazuPm54n83EGDgu7uSzqSespg9TStnSHPWUj8ALumLBYLVEvv730=
X-Received: by 2002:a05:6402:4388:b0:419:443d:b4e9 with SMTP id
 o8-20020a056402438800b00419443db4e9mr2571260edc.149.1648068386447; Wed, 23
 Mar 2022 13:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-3-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 16:46:15 -0400
Message-ID: <CAFd5g45gOMb4URpgiS4RKmWsoN7auvejM7gfTY2MrpVidKkbyA@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: tool: drop unused KernelDirectoryPath var
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 2:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit be886ba90cce ("kunit: run kunit_tool from any directory")
> introduced this variable, but it was unused even in that commit.
>
> Since it's still unused now and callers can instead use
> get_kernel_root_path(), delete this var.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
