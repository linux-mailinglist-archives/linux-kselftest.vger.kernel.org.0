Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17D94A4F66
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359639AbiAaTZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 14:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbiAaTZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 14:25:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E7C06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 11:25:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g2so13129657pgo.9
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXGf5WCTdRujs8c3iA+q8x9yw63xl/p7dIlJ18j1g0k=;
        b=ViXsl44S7dZb5JWKzVTj8IGlfi04XDzigxkaEgZXxp0J1OA6KHZAH4XcM+XtwbQUv7
         IhLtdQ2eDQmm67OwyiJNE3ndCZIKWV+lXNQcdNyDH5jQ9/MFI+TXWQUHFv5v8eL/PHlW
         6kIL2/4tXvMtyQS7HPfovb5wBAUE061JG/E8gnHwCPLRzgOG8G2uDGGkZn8tI475nECo
         5z4MtIjG8/TkTg17A625vsqxlNSbwmBf01dUfnu3jX3doz0l1kFNfflZcK9UJITMzjno
         BwZf9ai7avQe2WTDzCHwSf13n3qTjTLbhBTs1VcSyicyzB9jiA+7K3+KSNH7AXb63SFH
         0R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXGf5WCTdRujs8c3iA+q8x9yw63xl/p7dIlJ18j1g0k=;
        b=PwNQrjV979mDFSi3aNdCzi7azcTLIzAj5ob9iIcp6gBz2v8z522LpfF5XzUNKi3s08
         gLJTd+QmElUDqXOEfNYyjl9T+2zs9UsMT1PmmpxsiW2zrh9mvC1LaK5MRaPPrJMhYG5o
         +QE+YTJ2weOf2IxI+Ddma6OblbP6EwB/k3EiFSZV2w/qNYGHZPdeJ6/tDsSSScqeHOBT
         Zq8C/4zpEIwbmwGSJIe1fZTCC/5G80XOlTEWyykrcIe6u6kpGXBGMhd49Rv/hc+0ire6
         3FCp+eHDcORmGupno8o8Myu0CgkJEt8fqcNrawnxg1uzXSg6cEFUx2C1+yU01+jVN2Te
         ptLw==
X-Gm-Message-State: AOAM532s9fLO+yl5ktL8tU+HxD/D5hB5THnf3hRIa2nLLfkgg4PmD2qt
        ddIZx8rroh5/6k7NDgcr1zIUZgVfaT+T6HPk42plGw==
X-Google-Smtp-Source: ABdhPJw1vhNusZ1GU768T+2P42NMgdzvrqkQF9yGWmPGojl/h4JYNENm9wG9shwRx4UMfimo1130MnYsuRfSPPVeWfw=
X-Received: by 2002:aa7:8a14:: with SMTP id m20mr21629811pfa.63.1643657145867;
 Mon, 31 Jan 2022 11:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20220127221710.165733-1-dlatypov@google.com>
In-Reply-To: <20220127221710.165733-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 31 Jan 2022 14:25:34 -0500
Message-ID: <CAFd5g45gQ=05eRTGGbVsd2kA1iMKuUahPL6u-8zrOXpyNgSF9w@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix missing f in f-string in run_checks.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 5:17 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We're missing the `f` prefix to have python do string interpolation, so
> we'd never end up printing what the actual "unexpected" error is.
>
> Fixes: ee92ed38364e ("kunit: add run_checks.py script to validate kunit changes")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
