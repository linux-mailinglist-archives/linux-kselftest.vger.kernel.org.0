Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18FC4232D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhJEV3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhJEV3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 17:29:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC6C06174E
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 14:27:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so3018094pjw.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoiQAn46ClahFaLRpc/gAkc33WV9lEU+0xQGA/BMNT8=;
        b=EzCZBtPbGPOonc3QyLryZd/pemw8aHvTL2IBGwShTC3lXsD9+Mnb3ep4O2wdrajBCS
         AsEwP/ODKw+6Ko6E4isxRpNix0lWda/zPJd8UcU7l8+ko6KWaM3LTRsn3m1DAVhwWhW5
         0Rik3/kQrTZHzmrelEFqtGnv0BphbmnCDtAo4DwC7wFo1rSkTXwy77cqMyKEz8qUNP6S
         ML1Sm/p09bPAi6IJcYAn66RN+O/jqqizM/qCXt9PdNoC5GnfdW7lb0AlANML03SuT+Vw
         kEXMMQPFdtHGR0CxIMq9vD7E4L3U4IJpV2HafZIQB/iHzEPIiWHl12JgEjyAge8g1eU9
         McQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoiQAn46ClahFaLRpc/gAkc33WV9lEU+0xQGA/BMNT8=;
        b=iFYuYt+h0Nb0tkjCRfb7S+7cAf+cCDzCm56MukKEFmx4Ynh7gazYBP3jyuFrPim4EB
         1xpGF/96AcpeLwl3/utD6NA6bhjYuxCAntPYpf9jCirzPH5zRmWjOqp47FU6PRQcvaoZ
         P7JqWcdzJeuK63r2ZeSB/35stSpJf7xImeCs2YnpC9GepgmJxEudyGzensY+BrtR+YNE
         0AJj7LqMMuPvvn0TygEpKrcU7qJQjUefWYt12Z9n0qNt+oGXBYwAaYJCYCYyEkrVjGqc
         0c6IUpzTwvHXQlBs41Bt4yTKRB1sjyCa36yXbn+2QT9OPaEIuHk6Ri2Pk9Zto4uK9NKD
         ivQQ==
X-Gm-Message-State: AOAM532B+HEpln8KsgZasq9+P/hNxCmgtGYcYwlkFjktacWFQHrK5pyJ
        iWeEQJfv1wwSBsHpZf+RDJvbJAOPcIAdK1SO6PW2tQ==
X-Google-Smtp-Source: ABdhPJwTs+XgdJR1uVjkk1E958Cqm+tyyyNonaR58H4o1z5QfLNS1MGp/4LGU2Xvbe0XJCB394hglZ8hnsr1IbiQl9o=
X-Received: by 2002:a17:90a:9a8f:: with SMTP id e15mr6482032pjp.198.1633469277424;
 Tue, 05 Oct 2021 14:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210929232534.1433720-1-dlatypov@google.com>
In-Reply-To: <20210929232534.1433720-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Oct 2021 14:27:46 -0700
Message-ID: <CAFd5g44TTBTcPctT5m7QDa0iCSt21oBHrL-PTqmnNo4d8ejr0w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: show list of valid --arch options when invalid
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 4:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Consider this attempt to run KUnit in QEMU:
> $ ./tools/testing/kunit/kunit.py run --arch=x86
>
> Before you'd get this error message:
> kunit_kernel.ConfigError: x86 is not a valid arch
>
> After:
> kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']
>
> This should make it a bit easier for people to notice when they make
> typos, etc. Currently, one would have to dive into the python code to
> figure out what the valid set is.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Yes! Thank you for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
