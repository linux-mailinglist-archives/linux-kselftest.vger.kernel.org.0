Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7A2F6FBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbhAOAwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbhAOAwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:52:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD2C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:51:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p15so4003965pjv.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/td70cr+yDErqlpQZSN0xSXqF6ggiQpM1ujSGmXKino=;
        b=i/N5cWKJMXR9btra/mDwceUyegdLU1QW5FEaQo0CjdYVdBB9TZvuR9iqkQ1eRJRVI0
         lXuUAI7SzLYPjlhoLqHpHh6VCT2GltZ68W6UyKIBmoliHySInQzKXXIRQ5ep/LL4y82J
         KT14p6G0C4UXnNzB79Kejka9hHfn9R2ldxvsXcLvDjOy33V9H6Y/NToBD8UufmfpRZIw
         79PeUhWP/p53KrniAUqZTyMypIKrA3z4quawrTn/MXHPOiu5ZLjMqv3fp87OkXm7Fnpc
         snC2Xo//XlOQo+qCL6dluFthhzQuPkPlt1oayeJC4ZKP4/eo+itEW2+SAu1qzuOGAMaO
         PrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/td70cr+yDErqlpQZSN0xSXqF6ggiQpM1ujSGmXKino=;
        b=IWz6OcGTCQZuTYcq+iKpiaYKvWHh39lHuz9Y25yidxfmQWQRKnMEjYYSEMYgFZrR7J
         qjg+2Dc4WsIR+o/rd/85LxjZXU2N0qMZCMdqiz/aOpsM480+HwAYRHIewso19Iu4M8w5
         H+hrUavPOQKhirUqlKZHQe2+HlE7FRl9hB9U9lVu3pm6KojElpl/9teP9J2K0h4neLYh
         OGUemY/5wt7KXEWjd1r5oalAn+FpSaBqYs/jeRW6iZnFzHJHxYpqzzTLLAPhIyYgOxTS
         ZllcHgso2V2h4lrwWGjFHDL9abDR3wlVlD1D6bIW+Rq/kEOGyUueklacD4YOJnf6qvuo
         GLPg==
X-Gm-Message-State: AOAM532CmigX5Fk3wZ0U42g+m78TxnnPlPHz2s01Bqs3evAhbiOvtrkV
        5leipEjOv53TXISoko1kPGeBomL4sQ+WkQvm9wc+zg==
X-Google-Smtp-Source: ABdhPJxAML1u8IxFbY1gxIAH5Aa6MyIJaIP6JgpWhERW096CY/AcAT5FGNdKal4w+kp3PtdZ/WM4GZIU5k1kg6FPRGQ=
X-Received: by 2002:a17:90a:de03:: with SMTP id m3mr8009830pjv.20.1610671914862;
 Thu, 14 Jan 2021 16:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20210115003913.1406896-1-dlatypov@google.com>
In-Reply-To: <20210115003913.1406896-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:51:44 -0800
Message-ID: <CAFd5g44=5LDpoFiy_Z0mnLe=4h2P=c9TMPNS5Rj6R=WEbo5K9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kunit: tool: surface and address more typing issues
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

On Thu, Jan 14, 2021 at 4:39 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The authors of this tool were more familiar with a different
> type-checker, https://github.com/google/pytype.
>
> That's open source, but mypy seems more prevalent (and runs faster).
> And unlike pytype, mypy doesn't try to infer types so it doesn't check
> unanotated functions.
>
> So annotate ~all functions in kunit tool to increase type-checking
> coverage.
> Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
> be annotated as `-> None`.
>
> Doing so makes mypy discover a number of new violations.
> Exclude main() since we reuse `request` for the different types of
> requests, which mypy isn't happy about.
>
> This commit fixes all but one error, where `TestSuite.status` might be
> None.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
