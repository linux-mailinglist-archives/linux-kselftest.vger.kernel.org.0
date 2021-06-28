Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A23B696F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhF1UGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhF1UGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 16:06:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E041C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 13:03:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ce18-20020a17090aff12b0290170a3e3eb07so842130pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAWuikIHuzv+BXmOwJRKib9PQUJFOjgkmKn9FbpyuzU=;
        b=rgdOu2AR9V328GiMlQnErYgYIckoGTJ7mCqMZHQzfWpJSZZ/E3zAYX1Zpk1UIbQMug
         us8tk8Uj72DW/G7aWm0uvDlh7mCNP5J9jSfn/iBoBrhM5LDiHqQyqruVY5mvxk4ZT7kl
         jY28piDx6EUlRD1Z782N/zXQ/ZN1alXejf5yP3Hxdk/+Td11FJ+jGMoF8JsGPw4e96+b
         9UZYxpbqzTuPKNityp687gFqYJNSdSf9/v84F51u0SH3qOmNoSTNsBQHh0WkNeqGTjFq
         JTvCv50e94UC+TnmK5Uq6+feEVHO9LQOz2lX5OibHrYXYPI55hthu1dBb0GTTHZvEsYE
         /usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAWuikIHuzv+BXmOwJRKib9PQUJFOjgkmKn9FbpyuzU=;
        b=fLJ7EwUCG8JGv0bH+wJNR4AYuSA1aU3tgR7uVY5ySPjR+P8QsPzc52IakGEuOY93Pg
         4pXKM2eEIFf4ivUwY2glvixPyoKNTL9NqAo6sUsUFIFsapMsJMaTaDdgwaG4agbjLXyk
         +S05ayk720wKULAU0wh9LAV7AEtIBUXxgQOm0Ej2mm8a07cJw+Bh4X98FHs5iVEl7OA4
         j0ntI4WRq0QxVuceGDh7MjMjAHuZC/H5t5IEw9RaK+jK4KSnTqXrTLnugunLyE/pl93k
         xNeHhDUw5PlnQUfPIvsWYG2Tij5TYxPtfIHELcBlCBbBcYqbqlMdBjs4yaX8/DUH76Ys
         3hHw==
X-Gm-Message-State: AOAM533OovE6ie12A+h8/Exp1Y+ueELTrRk4OLlrhet/rMFK/ccv256p
        nfAK17td18ZsktkCmBHlIpLyEYRfQG9hmBu3JmHFNA==
X-Google-Smtp-Source: ABdhPJzui40i4XtrMXZqeWOZSRSr1w1ZjjG7SBl7I97neYOsFdLY8f4yY9APoHkrGTrobdIJG4wu3YVGNdnJmtGpU6A=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr39877768pjh.217.1624910616389;
 Mon, 28 Jun 2021 13:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210623190919.956814-1-dlatypov@google.com>
In-Reply-To: <20210623190919.956814-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 13:03:25 -0700
Message-ID: <CAFd5g44BfjEiMUesKaTRpjmKTyMSaOKdg+i2mx8koP5hxXtLcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: remove unnecessary "annotations" import
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 23, 2021 at 12:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The import was working around the fact "tuple[T]" was used instead of
> typing.Tuple[T].
>
> Convert it to use type.Tuple to be consistent with how the rest of the
> code is anotated.

nit: s/anotated/annotated

>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
