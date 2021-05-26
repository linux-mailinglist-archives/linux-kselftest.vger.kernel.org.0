Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77CC391320
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhEZI6R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhEZI6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 04:58:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E39C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:56:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so219326wrw.8
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7NpCLx+T+/qw2b60MwQ3OuH59+WPyv7Tip9lK6qz9o=;
        b=qqGXkkpBz7nj1ca0VVu0jlluSyMwQnx3aBzbc+KdOnJZLNUISBuqhPMQInApwuHcwJ
         rgVTY1NHQvBwGz5/jtZovYuGT0y9PLUxjckxRieKGxb1XVVNROS4izcXAMVIIsKaJAzt
         ZskdnZA3cklB7Uo1nH/xpyA5f66I1EAHDuo3QMtScSYN81sfOtwxZTNq8vM7UtlcUqIS
         ACUfLhO0DCqhTIIB0zvvl8VvJ+Hx7K96mCUgJ/CKMUUN0R2OecyLuPD3jcc+xXNCV31N
         m4LK+oHu6ZkJakBTF4+xqmFb9DIgWjeEaFLTGTNB6vx8MbNqtSXNSMnwjyaoNjb7Erih
         zoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7NpCLx+T+/qw2b60MwQ3OuH59+WPyv7Tip9lK6qz9o=;
        b=getEsKCT3GRK9ZXd7Y9LuVxJdKKVTnt04WxdIWxj9/gC3cBPRU1nZxHSzcq72WMu4+
         dXiuq/ALEKx4ZnoqzPMRd3bknEnqOZFKKiDFKApLeU7ZInOHkumOfrfWITIDaYeiggev
         uQUl1U49Whj81+ZjclDj5qHRAXwtTgqq4X91Fj/YVuxDENSu6OBDztOv5qy62/eESmcB
         FM1YQbvJSMPWba7u5+qyD47fY5cTPqqCysdjRjNORJMSQiJVUCh0WsBy4vTtK5BmwhY6
         ODzodpB60kIv/6RDOuxJiMQRdWNHOdephxykuFikas2XU4tnTizhtnjfb5ozJT/XuG7G
         bhCA==
X-Gm-Message-State: AOAM532LUz6ckYuAQPpgIxtA6UbrnT5VM2kATJnChQb9sOFGfNTYnfSQ
        ZHzlKpuRZyxOdxxEZ6RWeTcmSA==
X-Google-Smtp-Source: ABdhPJwftkFqIr2HchtCbJPxZMNNZjAtGNzdX3FM8N4HFhwh22bc/9T9CDev6qiyeU/TEmiTQQrUTw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr31472403wrt.88.1622019404659;
        Wed, 26 May 2021 01:56:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:cd98:de82:208c:cbdb])
        by smtp.gmail.com with ESMTPSA id f1sm21876645wrr.63.2021.05.26.01.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:56:44 -0700 (PDT)
Date:   Wed, 26 May 2021 10:56:38 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
Message-ID: <YK4NRlyrYJ8ktsWQ@elver.google.com>
References: <20210526081112.3652290-1-davidgow@google.com>
 <20210526081112.3652290-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526081112.3652290-3-davidgow@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> Add a new KUnit test suite which contains tests which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
> 
> Because these tests do not pass (they're skipped), they are not enabled
> by default, or by the KUNIT_ALL_TESTS config option: they must be
> enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> a .config or .kunitconfig file.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/Kconfig                   | 15 +++++++++
>  lib/kunit/Makefile                  |  2 ++
>  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/kunit/kunit-example-skip-test.c

I don't know if this test is useful for a user of KUnit. Given it's not
testing KUnit functionality (I see you added tests that the feature
works in patch 1/3), but rather a demonstration and therefore dead code.
I don't think the feature is difficult to understand from the API doc
text.

Instead, would it be more helpful to add something to
Documentation/dev-tools/kunit? Or perhaps just add something to
lib/kunit/kunit-example-test.c? It'd avoid introducing more Kconfig
options at least.

Thanks,
-- Marco
