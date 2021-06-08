Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8BF3A05A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhFHVXF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 17:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFHVXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 17:23:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22AC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Jun 2021 14:21:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x73so16731332pfc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChJ13ljAgJ7EfOQLhGTX+mefIlqGvrgq/460yvmHsUo=;
        b=vbi5ZvwtNN7j7ucceP3obD1w/oR6xaF+NwRZquvQQQQ3Jh1W3ks3S9VPlFU0COwlpS
         3whTXOCEkotNXuX/GD+Y2CH+dP/Uv9GYPidtKGblkm8sS8zhZ+9iEnV0YUUjzTKcZAAW
         VaRJdsCayP233AOCgE4baSd1s9Zs3ZPWJHZcKU9FxdU7rXQkrW3aKutKWOt62N6i+tXC
         1We4hn9bHJQHkI1CQaCAWA7EgVErD5dwi0zeXO5f2V7M90JUSZKZcpPY/d4Jgin37l+W
         9f0uXxOiub7rUYv8NWLPP2W1++2mwR6e1R+p22nNlzHPRfstRN6DQujuchO5OlAjaNSh
         2peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChJ13ljAgJ7EfOQLhGTX+mefIlqGvrgq/460yvmHsUo=;
        b=ZMBLPzZoAdT5SQZWC1a+uwW1KD1kwvT+U1dz6GCtdlmhsg3Q5kTr3IOv2GCeTP07bU
         EYWfHlPtX2QphV3ERQfVObFq6LB0UFv0wws74a4XH4lV/Ii+/pLJPfN3IjP6AcLgF6K6
         NSW2qjoNx6xv1aNauAnipklPtfyKZ5D/Q3oxJrAotqRqQLvWY4GA8zQpVt7OhV74ssPQ
         zynlFoqm1WWwL3/h0s5A4/GIcQ09OlZlTGVUZQohWQWR1tI5/eoDG+DPTXVkW+9VnCWm
         q/rUcB56nk6D6FHpvUh04+R2Sc5wThWxcjs5nU45DB30v0X6G8vuaFIKACwvUuip2eAH
         oCvA==
X-Gm-Message-State: AOAM532SQTg16qJtgvZbBlivAUacf+3BxG3KkyYi+nLdAT/E51qeEVyz
        zAF7CR9RawXazat6vPmiQedfFbsHE/ooIPq+a0kBDw==
X-Google-Smtp-Source: ABdhPJylDuSbv9eyffAheNsnE8iu3Ox3RijJ+OgB1Xwm6rdvtnlS1PUiuxRbpKznR38A/8NuQ/PCwWHtPURgN3HJfiU=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr213662pgl.384.1623187271280;
 Tue, 08 Jun 2021 14:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com> <20210608065052.610009-1-davidgow@google.com>
In-Reply-To: <20210608065052.610009-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Jun 2021 14:21:00 -0700
Message-ID: <CAFd5g47iZTc2opF7umkFWN9Zczw_FUXec1oAgLwMS_GMfYNV=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] kunit: tool: Support skipped tests in kunit_tool
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 7, 2021 at 11:50 PM David Gow <davidgow@google.com> wrote:
>
> Add support for the SKIP directive to kunit_tool's TAP parser.
>
> Skipped tests now show up as such in the printed summary. The number of
> skipped tests is counted, and if all tests in a suite are skipped, the
> suite is also marked as skipped. Otherwise, skipped tests do affect the
> suite result.
>
> Example output:
> [00:22:34] ======== [SKIPPED] example_skip ========
> [00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
> [00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
> [00:22:34] ============================================================
> [00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
