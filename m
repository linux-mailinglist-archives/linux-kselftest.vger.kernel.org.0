Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDC5F1BB5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJAKGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJAKGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 06:06:21 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CC1C130;
        Sat,  1 Oct 2022 03:06:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a2so3302236iln.13;
        Sat, 01 Oct 2022 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nKYnJjLy8PuaQvgYvfd2vav0nJef10RxvaOWAoDkork=;
        b=KIh3bsTzQdPpeEw18SBbYhJ0jPlZjPHihzLvM6x5klQQ3Bdv/Z940reLFUxngkRJo8
         U+GoAJ3w38yI6qPX95+XVIzZlNVybxNoQ5DWM/UwK41l19lRh8789SgeFHCi/bLUSVZ3
         Tq1Wd/kzi8ydeOmN2++lmzwMirFbDIXCzrnCcTpbFImHsltSEo15xMCBWLMKwDrplWQ2
         36UAH8+W5ZBWR6WDOkVxIV6oTocGz32hC5mBlaeIFlGmrlMD5SXehZw1J7eyd30UiyUB
         UO9jql7QGOoTsxL4PHoWpNEGweo3be1GcZ1/5A40KEGpWfLSiuiybBVSZaEBaThDDIqt
         rbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nKYnJjLy8PuaQvgYvfd2vav0nJef10RxvaOWAoDkork=;
        b=VRfQVaOIXhaof80IjeHAHi/zicSuEoC4XNHylo4TdY56lQrVLwHDMg7332g2DWq226
         yFMid0dFs4Zle+o2oes+PUH2JIUCPgrNSskV8jUkYxYfD1uqy6+U2Tv2H2MhZhZzqGdR
         Tig43/6SSnDDXHgpau/0Z/mDOQvUin5MDT1KvEO//VsGf19ddkCsZQKEo3qNZFdCehDv
         f5dVlf9tt4MFetaBOtP45hBd4kHiNj3KL0ibHHgnxCkd2gQpuFqtKwtTLi44dHc1OvNf
         uM3eCVNlX49ifnLQORFBmoSVLU768YnAvZXLVlbA0590mBAPHYgPocax5qq3Xdy2zW1t
         YaxQ==
X-Gm-Message-State: ACrzQf1qsnAC74/vg8FZveTrZspmSJKTbOVWj48+L7lWkhtHRgU4PJ6E
        162MRNYvlr+ZK/4z/NPWfD5MN5MBG5jOZ6wHhTZvH5APwbpNfA==
X-Google-Smtp-Source: AMsMyM4dGmTwbbEDD4v3K5Md40WByQnLJ727ChTBKhiL0cJpw9l3RAlEA11BYXTWNnGfZ8eh4pUFQk8OICSVgPO2nH4=
X-Received: by 2002:a05:6e02:152a:b0:2f6:58ae:ff0c with SMTP id
 i10-20020a056e02152a00b002f658aeff0cmr6218972ilu.237.1664618780219; Sat, 01
 Oct 2022 03:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-5-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-5-dlatypov@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Oct 2022 12:06:09 +0200
Message-ID: <CANiq72nZ9eSNWBWpSWM3XB-PHyWaAvfYsjeR6CLcrpd61PDB_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: declare kunit_assert structs as const
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 1, 2022 at 2:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Everywhere we use the assert structs now takes them via const*, as of
> commit 7466886b400b ("kunit: take `kunit_assert` as `const`").
>
> So now let's properly declare the structs as const as well.

Always good to be `const`-correct :)

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
