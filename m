Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C81FFC1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgFRT7y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgFRT7w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 15:59:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0BC0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 12:59:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so3025261pju.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3QGsT97pDvvMvvKXcBgwyDJ7+zbhoAH55hk1yJyQBg=;
        b=kDfdoao3jkV76yu/0HQcS3EdiHt3zKaFYqcTf17EemKjFtUc8coz/vWxbiHhGjx7UE
         4qr1wV3n/HPnsU6f94HAma3Bav2YpG8RYXjlFrN4Cy6aAXixK/rHNLa8qacKRWJgVYvv
         9B5xci1yRjZO38wdAorzOdAl92gM+bj9VtlO9KPmnq2L1UzWVlJae4ntR8G0lL4nX5Cj
         FQouYMXp9h/bHz02yvkFfqyURyShCumixKXeqHUKEZrGZ5V8wH+JOMWyySrTbp6O9azN
         4FUofGkpJg+/jin7yR9UTjFF4F0YZJKQrxqesr1LVb6DKtYu4CLewdIyQpTSNTi4ongi
         u/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3QGsT97pDvvMvvKXcBgwyDJ7+zbhoAH55hk1yJyQBg=;
        b=HvaTsw2dojm5aTiNO4+62M4gqLpFrRNdmgZ6RiB20B5T2Ew1QceGWEr/hcbO8CJBP2
         HdQHtHv5texzd+K46ZaO+vBedNRrZ1mazL/gy88OJKk1+GX/FwFzptzm0t1ra5ntu2vP
         U5GI0UppF+oYSnF9ljgUwwYr87Dc9bpePBINUrYnTVDVQUosY9XlyLXTN8L/aOHfg509
         mkkhGsTIHO189A24X+j5LhU3zGzA2jLQ4skNKvUCvTJJR3QY3NQt9eQfhMg0pdw4em5O
         ABBCusWdZ4hv9s8P323wjyekAgCmXj2xftXT+h2RG85JNm5s/PoDfKsXc5Yb2a5rm/p8
         WxsQ==
X-Gm-Message-State: AOAM530KwwgP+dG0fOOooDG3be6NEfLqJxd0N+1C4HshQlAV9QGfCi6r
        CTxu/OgD/B0SFPL/Q3k7KbELPPJxeSNAFTr1I0ptY9p3Q1s=
X-Google-Smtp-Source: ABdhPJyVCjvMmGy+J9LEg5lcRDKDvsw8LvlLWpJqVH2+6OGAJF76y8MYaaNzBmYqJ0LtUvWFUmZP28zjVCgPZgcgvYc=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr29183pjb.20.1592510390785;
 Thu, 18 Jun 2020 12:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200616064730.123871-1-davidgow@google.com>
In-Reply-To: <20200616064730.123871-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 12:59:39 -0700
Message-ID: <CAFd5g45M-Kzexz9_BRguh7AMP+pP1gijvdjYvTyS=cTk8ZpCdg@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_tool: Fix invalid result when build fails
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 15, 2020 at 11:47 PM David Gow <davidgow@google.com> wrote:
>
> When separating out different phases of running tests[1]
> (build/exec/parse/etc), the format of the KunitResult tuple changed
> (adding an elapsed_time variable). This is not populated during a build
> failure, causing kunit.py to crash.
>
> This fixes [1] to probably populate the result variable, causing a
> failing build to be reported properly.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ba7a893ad89114e773b3dc32f6431354c465d6
>
> Signed-off-by: David Gow <davidgow@google.com>

Oh wow! This is an old issue.

Nice work!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
