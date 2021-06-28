Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C863B6983
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhF1UNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbhF1UNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 16:13:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082BC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 13:10:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b1so3086540pls.5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HY/GsEHwNtsixKBYmNS8ME4RAx608QOmYPU33bjYZvg=;
        b=XOeFjz35rDbu8g14AdYO1sHi5KROWGiXdYnqTyAfIy27JCvjTq/LH9FzzT+oC/y4ul
         2G3hkeQRubvRGc2r5J2N+Wm4G49jvPPE9XbQpB8e7bJvPSeDEi7ia7IOsEKpIfceI+So
         a6qUz+TLFmyic2EOZnj5LpgCWKIypkvDu0zs2eVZwkAnvGhL2FApntH+YBbDMvumf2Vf
         eb/vhzbRYwfDTUDPzJK8xRL3c7kI1hW7DuvP6M6JJIuJjNwSS5jARE4D1WEYQ4E45GoE
         RVL8d6Je6v/OEvLZ1pFXlT3wjYkk6W8GToAO5Uk5laekCqN/n0RkxeGt8Nlx8db4lCe8
         hFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HY/GsEHwNtsixKBYmNS8ME4RAx608QOmYPU33bjYZvg=;
        b=EmywaDmCSzGOTf+wq7BJWkVxE2kx7ix5rDBygXWfVIEx7C8d6jQxU0XUpVB8npverr
         6t+0cnqQHn/hjx/nxteYvT5FfaiemBMmAn00efTo2LN9GsjQiPD6XcHwt/1xjfIsaKxi
         f6lnyc6R+rezJNoA9ABOtUZ3McNDeRJc2PrpfqCzJtSXwGEUeLiguDhpZeSXbBmJCQar
         FIY5J3M444kSwzhnSJm7kenYqOc6kbHERNXV36jIwjvAVbeXl/l1jQ5qLLrf/pjzIGoJ
         kohsrxHPN87K9YaFB7O2GIqxqf5W6ow8dSNmqyjg8ZRHCNoYSglDBruCkkQWbrvE7TdX
         8qkg==
X-Gm-Message-State: AOAM533EtsK/yoiA6FiLWIdOuYdGCiQ+LxMtWHYkKEqH83RW1ZtY+IAu
        K8mFo3sulz4Dj2g6pQxKGztjYH0UmmjVtMK9jjPgWw==
X-Google-Smtp-Source: ABdhPJxB8A0caP/EEeIPyL/nf0K6BKR08uAKbl6ViJHfHwWD/BPa5fP4/ozZuAYQ/lhyq464KVFb5xRX/O1213D3joo=
X-Received: by 2002:a17:902:6bc8:b029:117:6a8a:f7af with SMTP id
 m8-20020a1709026bc8b02901176a8af7afmr24419786plt.51.1624911034263; Mon, 28
 Jun 2021 13:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210623201721.980348-1-dlatypov@google.com>
In-Reply-To: <20210623201721.980348-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 13:10:23 -0700
Message-ID: <CAFd5g46pkO6JsMVU-79aDbmswSPs1Zx4U0DW9PhKR4SoUBq5EA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: drop obsolete note about uml_abort
 for coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 23, 2021 at 1:17 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit b6d5799b0b58 ("kunit: Add 'kunit_shutdown' option") changes KUnit
> to call kernel_halt() by default when done testing.
>
> This fixes the issue with not having .gcda files due to not calling
> atexit() handlers, and therefore we can stop recommending people
> manually tweak UML code.
>
> The need to use older versions of GCC (<=6) remains however, due to
> linktime issues, same as before. Note: There also might still be issues
> with .gcda files as well in newer versions.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
