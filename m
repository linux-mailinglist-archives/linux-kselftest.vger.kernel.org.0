Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED7F89AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbfKLH1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 02:27:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38419 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLH1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 02:27:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so16581232ljh.5
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2019 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4PBC6XASGOKS4JAF6qAY3nfg+656mf5Ffbsp2SjMOU=;
        b=huzbkS+lweY6CWt6g74Pcr8qGst6v0knwvUw3PlvRXbWDrZJjG00zTvIpdBw/HEfNK
         /Q9qG0Xe53I4vyhIQrQSxfyp9cwHiTVbUFGOtuR0m79ccrcyhqrNoy1bt393gXB6lSSw
         AGBx8KfNaFrMvD6a7IZI9Tu/SvTpjkrllxUnsPpS6EMQtLmHl9UcxC8rTiEzdBbxHgqm
         FkmbrQTaLetlUqbwjFxlXkpkwO73ZxGe7fKg4wKySyENfxQP+CFsVbCeqx6P9YXazcCb
         G35ca/AQ5mKGzU5jbXfhZoMJ+0a1baLTfGZz5zCeSGauOj8nAfLXt7PiucV7Q9jK95+m
         t7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4PBC6XASGOKS4JAF6qAY3nfg+656mf5Ffbsp2SjMOU=;
        b=bFbg2Q0qoNyvVISwobaeQ/1Sx9MzLHn7JjTCQgfNQleJ4fFyLRKhxJ8zGQ+yxQasq8
         qv02chI0HZ0xs09OJAQN9T5lfun2h7nPMeMElFio6zakrtdeckHoTV6UgMzEk5wxZY0P
         J4snwHW6Aw0mEMX/IUCJBmnGP7WzRtoeejEbnBUUY+ReQo8BB58a6VCCnGgRJtGHxSPn
         6mBp7CrTLeDAt8dPan1XQzqTJlFF5bEiMFu4qtGJRC8DZ3Un2NOrrVfHYyIUHcFGyL1T
         jOGb26CI51LcFVJHvxiKIBAtiBlNWm6P6VGpIhl9g4AeU1NIUatEm8a9vb+8JkDsC/ks
         W9dg==
X-Gm-Message-State: APjAAAW549Lh3yjCJCN4D6QrPObBGNPIFtY+dcU2M1yf5bm94I0bR2k+
        jXPRSAFDO4EVFLvhkrSFIPHujv9GdByeI13QJqMELA==
X-Google-Smtp-Source: APXvYqwLYytt2T33G4K61Iai/NezRd71YPs7Z4MOUgQBlMexOGDjpoWKL4uuX0lRjlNJutRysjEUqzVXInQX8+/FI8E=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr11252951ljq.20.1573543658646;
 Mon, 11 Nov 2019 23:27:38 -0800 (PST)
MIME-Version: 1.0
References: <201910301244.9C3CABCA0@keescook>
In-Reply-To: <201910301244.9C3CABCA0@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 12:57:27 +0530
Message-ID: <CA+G9fYvcD=rNmkQn_bsBO0RUVwhQA=TtzP1AeqLqwfKjorLWXg@mail.gmail.com>
Subject: Re: [PATCH] selftests: Move kselftest_module.sh into kselftest/
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

Thanks for the fix patch.

On Thu, 31 Oct 2019 at 01:15, Kees Cook <keescook@chromium.org> wrote:
>
> The kselftest_module.sh file was not being installed by the Makefile
> "install" target, rendering the lib/*.sh tests nonfunction. This fixes
> that and takes the opportunity to move it into the kselftest/ subdirectory
> which is where the kselftest infrastructure bits are collecting.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com
> Fixes: d3460527706e ("kselftest: Add test runner creation script")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Now this patch merged into linux next tree.
Following tests getting pass.
 kselftest:
    * lib/bitmap.sh
    * lib/printf.sh
    * lib/strscpy.sh

Thank you.

Best regards
Naresh Kamboju
