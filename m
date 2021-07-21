Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017533D1769
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jul 2021 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbhGUTMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jul 2021 15:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhGUTM2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jul 2021 15:12:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F00C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jul 2021 12:53:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h1so1624532plf.6
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jul 2021 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NRbb2WhKrno0rg5XVu8dJTfW7QbPPoDT9nWYWG2fU04=;
        b=Zzrk729wAqGilC6KYU+4BZArciy7pZDSM7C98suRTP+rY1Alunx9WnXRn1ijGDQ4qr
         ORSJ7IVuNgMtRsVkn04q55/yvSTa7X01QoLAWnpIJpg8dfg+lE5QCkLBhIqXTRXv+BtA
         SzPMcvWsnCsHNt0YZrk+Q93X7z49RBVnGOY2fkMVZvRxdfdOX2k5fPDoIqkq8xYagxjI
         C54roWj4UlWVOXdGMYAsZXKG+PxU7cJqVYKu11pJ6mUyB4M9xQXYjz0Gc1lp38PBUhtq
         ZRR8g4ICOc1Eb6j+hzuFH8Dww/4DhZHjQ4RriyZHvAnQLpcc0nrO//XZ/pxl0g7D4sic
         U7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRbb2WhKrno0rg5XVu8dJTfW7QbPPoDT9nWYWG2fU04=;
        b=eW4Oy8mIwBnWVUiEbtWuW9HyrK3Zwrx21Hql+5+3OJJMaq7y0QzBBJmr9NLqmzq8KA
         LJCETIICy+J/zvWgBt7oLC1qcCuNUg/1g1fOiz6E1QA9+PL0Z3Uc/FVyjxAB24tAcKeb
         98QUbz7btcrLkbfgrRPg8yTtmoTnpIIqep0TysGZk48ZDr3sDsleZvwbXNpYjFHtvChN
         uwlAAVMKk+yCi2E+2a3PsvpVDiYnN9RcVgSv4J/B8zvTxY3UGk42h80R6Ecy12EFgf0Q
         6GhDDCDObWwB6x0OGk4DWZ1uS12HAomWAl1jYlirtnho180LjskKSSVgMJJ8mqY6m+Im
         JWTw==
X-Gm-Message-State: AOAM531+QYf4q+bJCXRqZ21Lh7cMxDo1PfktsNuFeH8vqXqqRecWKlqr
        sRf+n1CmkStlJykegTMksEO5GCo6wjzrV/xh2nHHxw==
X-Google-Smtp-Source: ABdhPJzH4d3B0PuFlBwcr6uSCwfZe56uh2y9B0upxapM08pQm8+CliBNhuJMlpm2Fa1l2Iaihfu25JZva1y+Y9BG7ng=
X-Received: by 2002:a65:6a01:: with SMTP id m1mr38108609pgu.201.1626897183577;
 Wed, 21 Jul 2021 12:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210717234758.46598-1-andrealmeid@collabora.com> <20210717234758.46598-2-andrealmeid@collabora.com>
In-Reply-To: <20210717234758.46598-2-andrealmeid@collabora.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Jul 2021 12:52:52 -0700
Message-ID: <CAFd5g47nOfQ506ZyivLy2U1FkrnNhuDxUr0wUyN=F700mw+N8A@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Shuah Khan <shuah@kernel.org>,
        ~lkcamp/patches@lists.sr.ht, nfraprado@collabora.com,
        leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 17, 2021 at 4:48 PM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Remove custom functions for testing and use KUnit framework. Keep the
> tested functions and test data the same.
>
> Current test threat (g/u)uid_parse and (g/u)uid_equal as different test
> cases. Make both functions being part of the same test case, given the
> dependency regarding their results. This reduces the tests cases from 6
> cases to 4, while keeping the test coverage the same. Given that we have
> 3 strings for each test case, current test output notifies 18 tests
> results, and the KUnit output announces 12 results.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

I don't think I have anything to add that hasn't already been said.
Nevertheless, this looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
