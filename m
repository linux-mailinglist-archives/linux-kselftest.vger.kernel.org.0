Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97029FBC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 03:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ3C4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3C4x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 22:56:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC64C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 19:56:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 141so5985433lfn.5
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNrjvpFPaX9JCWeFeLDSXzKsBxzsshfaWxjSi4R0YJE=;
        b=l7V7a2JZ5f5Ll9BkcTvfCw3Ze4NfgNrzqAclKAQ9mrY+28c0npcACExmNe+awRn10g
         CKUSpgtbHRGHEgmr/SPnTV3wPM1BGYDwJ+qMKQwAK14UP7R+0gxkofs+60XaGJahvSTT
         IxXmxMeYmgfSeYpC/XqvJZmxILLphVUDVdOo23j85h3/E2bP/etL7Jf6NWGo/hs51jUG
         GSHtcVlW3PLs9VztSlhCpGXh+WQywXEi78KpLXkqAe2UshIhUXkbL7HS2WPF6BLeIW0/
         kY5HQ6hMlBJ5VMOn6lNzauzwrsgDYCPJWrb1oPaAAksFJGUNQCAGa7f4S6pVmjDfOOW3
         gcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNrjvpFPaX9JCWeFeLDSXzKsBxzsshfaWxjSi4R0YJE=;
        b=epI5YpFL+DLCcg4ilBUczP1L6OwqJ3p3FaWStR52H8+bymeeuX2weVeHGTVt1mFBUQ
         vkUyom74q+lqEPMU+2AbUCsbKuTJBDpLN/zfyzD6ouE0FjZafkNMVLXs3fDDttozf5Cu
         WbAkfnT4XZeMOunS7ah9HU+q7Y2bfXNqNf40QN1wdF28b6XO25daPVx8sop3gCSF4x2E
         dg7bKZ0ZKjj3hSbnq8oJHJV2dIRPrWCWe911vZdaOpJ57exwFiSg7YP7iR49P14/JNLz
         DnOfgYlGN//wESqOlUUIENP82bRT5Czwp1E5PY2+s3o0Zsx9G1631z3zUMlvoSBOFxwO
         +P8A==
X-Gm-Message-State: AOAM532qWdXKMB8H6DTnVK4QK5wQLi8iNiVhOHcbdjvS3SAutGkXm9jO
        h4gathWFzh1eVFuZaLrddE8QBj5aZf4KlCmrlUZx5LAk9dBAzg==
X-Google-Smtp-Source: ABdhPJz5z53oDU2lPKOJzPSZ4eud7lY18GzRAczMHNhnmRIzIjfdDld7+F+wWMWRazlqCLIqnataaNw1Mg8baIrsuXA=
X-Received: by 2002:a19:6001:: with SMTP id u1mr23985lfb.277.1604026611155;
 Thu, 29 Oct 2020 19:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201021220752.418832-1-dlatypov@google.com>
In-Reply-To: <20201021220752.418832-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Oct 2020 10:56:39 +0800
Message-ID: <CABVgOSkXfWihPN5-1dPn2BstpJ7eiG1Qj=cg5EL2oEhv=YHj4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix pre-existing python type annotation errors
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 6:08 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The code uses annotations, but they aren't accurate.
> Note that type checking in python is a separate process, running
> `kunit.py run` will not check and complain about invalid types at
> runtime.
>
> Fix pre-existing issues found by running a type checker
> $ mypy *.py
>
> All but one of these were returning `None` without denoting this
> properly (via `Optional[Type]`).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I'm not going to pretend to really understand python annotations
completely, but this all seems correct from what I know of the code,
and I was able to install mypy and verify the issues were fixed.

Clearly, if we're going to have type annotations here, we should be
verifying the code against them. Is there a way we could get python
itself to verify this code when the script runs, rather than have to
use mypy as a tool to verify it separately? Otherwise, maybe we can
run it automatically from the kunit_tool_test.py unit tests or
something similar?

Regardless, this is

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
