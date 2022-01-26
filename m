Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B049D4A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 22:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiAZVkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 16:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiAZVkO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 16:40:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03666C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 13:40:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso5586053pjh.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 13:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjuEqo/szNdkE8sJZ2LmIS7aoI8q/3oLCqQgzbdOm7w=;
        b=fUylDgRiw2zN+9lqWMjcGPilZXXqjxp5P3NMNG1XyAusP3/ipIkjL+BLrlzOOvcIYM
         WLXU/UV/c1bOo6tCz6BAClGoSjGm5gqo8CvWFSxm8V0OEQEhQ811Ot6NvTUIouytBpnG
         /Ovfg1Kpp0Fs0khSxWGc7iRKIhh8jxBNEFATLHARHGrc8+fdAWyeAVJwSQcYcTIlJBt9
         /TfqrXFWvnSH3J83P9U0iptSjZRY2pDBJB9rQgPA32IEu5bWAQVmiN7AgnGj4JKTywEM
         tcDSSXnkV1fUeyhCOxhTckEXzIkbTZrQyY18ng4FIF2PurEo/s6i7TAIhl+GpPVUy3r7
         0ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjuEqo/szNdkE8sJZ2LmIS7aoI8q/3oLCqQgzbdOm7w=;
        b=35rWxmfdHo04Yflv37/TNJYLxsErgY66+86ZU6CgLthV5D/+hEEyg31W7qVZGM5vYg
         +tTQ030BUhV5+ddRpzgh0/tJAgoBvF6+MTgzlxmUBViGUcuu11sFqb215ZfwSWnNjQCz
         PHV0/Vwfo3leXtXvg7Ad7xaQcxLFQowqvO65avrYEP6iGtOWOPtGmc30pBbNLku0FFO/
         PGk4TaF5pyKEt8L3UbZFIi1MRjpdFtRMIj4eyb+yqltDn9VkwJBBA1tQV0YLebY/jO40
         gLSiUIUJy/7aJztrSxHlTkKw/X2j8IbI02qtdG21z5QxrOIhy4W/qR7bV/wpF/BSL7Yu
         bGXQ==
X-Gm-Message-State: AOAM531eiQ0d9Du1NKFAJuglyGmrVIpwSZ2DGeEI8PAFnTNtnPumyKfw
        NXLT8g/LbNn5i2Fl2aOMJ34OU6jThnRswpipAjXYow==
X-Google-Smtp-Source: ABdhPJx2RWLLzW0RcrplifZ11QPGpoZ7QxkwFy8BUYZQx99cxeLipwasrmPWrgb1LiI7eQh/g0xYSBVrkEfY+RtHLOI=
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr10841971pjb.198.1643233213353;
 Wed, 26 Jan 2022 13:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jan 2022 16:40:02 -0500
Message-ID: <CAFd5g45on3tNX2YyaE9caTyxY1sXAwgZMNQUq2E5h3DMVt2DdA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 2:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This field is only used to pass along the parsed Test object from
> parse_tests().
> Everywhere else the `result` field is ignored.
>
> Instead make parse_tests() explicitly return a KunitResult and Test so
> we can retire the `result` field.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
