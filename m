Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000317E468C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 18:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjKGRKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 12:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKGRKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 12:10:22 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C85DF
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 09:10:20 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so2093113241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699377019; x=1699981819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5B3xt+TAu4pFRHAyTC3xHUtVUIvM518CKJZsirqrIvg=;
        b=FDre5BUWMbluRkS5PkIPLL+JrLHjIUeMrJFUVMo6z/CCVU30QDCrUw7xrhA7ZPzZut
         8LxyAUEVihd9pKqBzTCVPDCt+G7SDUc3zk2p2QqkWGpZ1ycQiP7uy8uSF27sPOJ0uQtp
         1Jzb/woBSUrOmw/5LJuKHXCa+Vj5nfqd/axC3MXeLII+Zp3NmUu9Kalig4BclxvDwa6T
         SYJ3f+Y2J1uusbLuzbKSEA1Yiy3VORp5ynBPursCqI/ru/uHQn7qFTWgxo9poaE0ox3n
         N8ShfbHGxDzySfe11U75moThrad619mb1HQ/J3kccwyVVmgxuwd2kYlnrkALmQDoeHBC
         8Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377019; x=1699981819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B3xt+TAu4pFRHAyTC3xHUtVUIvM518CKJZsirqrIvg=;
        b=dMV0QVGxDlBecetbkYD08XWuBQm/a/nE5CJxjK3YSQYtGok2VD8I7qIVrp/vVV8R9g
         lVGWiYfIiupJt5TQTwjjGRPwGGN10kjV+wrkYjVcrZK7hIH5BsDxgUiFDBtSwDgmkwX3
         rv7pmcGI+e3C4p4oiV0XkcbBpFtgbCTg7lPHf1MPa5y6hqIjs7s7FZp6MC0xDFrg2+kh
         uFPyNqEyfKafNZJiA8i5zN4TrXwBYQySZ7OGgm6E2wagE0jDarpgTr9rz2+Xa37chdR3
         m8Frz1QGW91XXzRP/ADhQUQcxdThi7x4fV6BM1Awna0MXDF09rC+jxAaXXZ13vba8e2t
         +wUg==
X-Gm-Message-State: AOJu0Yxajz4w8DeW/ubL37Sy1ldSLAhswRHSAiNLwxqpj15TfkfzFNtu
        rtzLcLGNQMUQ6nVpyMbiBOKUK/S9aGCgnJnVAtLjJQ==
X-Google-Smtp-Source: AGHT+IHHLjLZNx461l95CH5j88c0qIdP29a5XEHIywb0uRZjCTZu8h74GPpAYdKJVoKlL7K3lvtZ3zUex753wv62pcc=
X-Received: by 2002:a05:6102:20cc:b0:45f:8ceb:ce13 with SMTP id
 i12-20020a05610220cc00b0045f8cebce13mr1344535vsr.5.1699377019563; Tue, 07 Nov
 2023 09:10:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsrLTbFkz-LJmAY9efDyEr-8bHcxivBDPToPjBxjStoDg@mail.gmail.com>
 <ZUpH0FNTYAl9Z+L6@finisterre.sirena.org.uk> <CA+G9fYta5cUpFArGfON3R+HUGxJRyEsc9zdTwwk5Un+wHqLN8g@mail.gmail.com>
 <ZUpgZ65SYqKVeQoo@finisterre.sirena.org.uk>
In-Reply-To: <ZUpgZ65SYqKVeQoo@finisterre.sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 22:40:07 +0530
Message-ID: <CA+G9fYu=9qH+9f1bv0NqUTi-VTTzhBNUYiWjwSmrdDtuhAo69w@mail.gmail.com>
Subject: Re: selftests: arm64: fp-stress: Unable to handle kernel paging
 request at virtual address
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On Tue, 7 Nov 2023 at 21:37, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 07, 2023 at 08:14:59PM +0530, Naresh Kamboju wrote:
> > On Tue, 7 Nov 2023 at 19:51, Mark Brown <broonie@kernel.org> wrote:
>
> > > This all seems very surprising, especially given that AFAICT there are
> > > no changes in stable-6.6-rc for arch/arm64.
>
> > We do not see on the mainline and next.
> > Is this reported problems on stable-rc 6.6 and 6.5 are due to running
> > latest kselftest on older kernels ?
>
> There's also no backports I can see in the selftests (at all, never mind
> just arm64).  There were a small number of selftest changes for arm64
> went in during the merge window but nothing that looks super relevant.

The Qemu version got updated from v8.0 to v8.1 and started getting these
test failures.

- Naresh
