Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091743A89FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFOUOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhFOUOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:14:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38EC06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:12:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2378582pjx.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJpltfx/a56QUhVgKubqHz/HzmJzoc4/jhS4am6AsFk=;
        b=CDAdqPMb73aYyytTCgeboChEjDbwQKkFccAdYShDWK8OLLVwDxaN/Nrpdno91Hp74n
         5Oe8k5ShUJ6MuBWbjJCxynCYRaTkDjyUJev5B61rpzYyTTQBqcTUXUkbWRRozjmhgPQC
         7nXZh8iP/9lzYNZxx25LFBJ4mY8B2VY+hvVL8Bnr5EZ8Iv7e6uF7MuNzUDbhVeEj/ohx
         9EFU3gxzP4CcGQuS0o7zJZQS9NBlW4RVeJWo++ZrZyVtA4xzd0P2gnyQdf5iHEfLUc8u
         2AnsS6oWxkAAHvgUYMl7Q6fjEFQJm/ybz/+morezb/bfEwu8/OJHRf5p4kc91M1i7jSm
         /o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJpltfx/a56QUhVgKubqHz/HzmJzoc4/jhS4am6AsFk=;
        b=fOcjQzOeZ2W7zXh/FE++3E7dIF1zyuxKaZ1UNsUXOyLUZtfgv9vN2KMjxzbrzkjNuq
         0zaaIYTprkK357xCvT2DyTZq6H7zaYoag/Mms7xzx8DTRBKPB9zXD/NJh8EGJdqKtLWT
         HYcFqdP63tNqfnxcbIonRDHtAhGgYLMBdLIHMwwSR+slE1VcAPsdo5aVVTqz/9WyFnlu
         TbcJNNEj9iWBSEhXLpSYWzGIhQTwQ+eYT7GNuhWHx6sQxfyvwpb7vl/WyiqriiV4MtKc
         2Y6t+PEu5x6Siul1Knt2v8SSRdLGtmW8RW+OHpd09mglvis4ZD66nYlHx5McX5CKGT1L
         CONw==
X-Gm-Message-State: AOAM5318MiOfJOdEUMM7zX9ssjSMmp/sojufhC7jHJ4ePMJvyfzkWZ+V
        LZhMNhrbsTmZnuquP0IrfeIcKG+U0n2Z2/kalnuOgg==
X-Google-Smtp-Source: ABdhPJynm5DnZNZNPGIOabS0G8oz+1ZovR++p0dCfniOlqWhT9aUYnJ73vKE9pWyCu6eCRQLkSFuzQAideiSMBr+ELc=
X-Received: by 2002:a17:902:6bc8:b029:117:6a8a:f7af with SMTP id
 m8-20020a1709026bc8b02901176a8af7afmr5902760plt.51.1623787962978; Tue, 15 Jun
 2021 13:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-4-davidgow@google.com>
In-Reply-To: <20210513193204.816681-4-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:12:32 -0700
Message-ID: <CAFd5g44Pa4wwXYBSHReEMKtDgNQiNjuARiwz++1y=+FVESW8KQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] device property: Remove some casts in property-entry-test
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in property-entry-test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
