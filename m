Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B597D575D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJXQG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJXQG0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:06:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A8183;
        Tue, 24 Oct 2023 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698163581; bh=lgCmm4pAlZIdjfyCEORLh4I3sgHZhY4//gOUm6MGfDo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QciqZc1x0JuSI43jAIa5a+RYt7QQqoEfZHTT45m8buUn4zNcJjSPc65/93kpgMumY
         E4C+4DFh699S0I4n/Vaw8VZx2Qv8HfFAorvgK0OnVd4yl0zMukc+O69gbDC4QhoGkW
         w7KlO5EW8QUfvxTihcFCm+w5RF7D28EiW8mchtMc=
Date:   Tue, 24 Oct 2023 18:06:11 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <74f121c7-5356-4e58-87ca-e93fe48ccc39@t-8ch.de>
In-Reply-To: <20231022092046.GC2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net> <20231010-nolibc-out-of-tree-v1-2-b6a263859596@weissschuh.net> <20231022092046.GC2669@1wt.eu>
Subject: Re: [PATCH 2/5] selftests/nolibc: use EFI -bios for LoongArch qemu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <74f121c7-5356-4e58-87ca-e93fe48ccc39@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Oct 22, 2023 11:21:16 Willy Tarreau <w@1wt.eu>:

> On Tue, Oct 10, 2023 at 02:33:57PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> qemu for LoongArch does not work properly with direct kernel boot.
>> The kernel will panic during initialization and hang without any output.
>>
>> When booting in EFI mode everything work correctly.
>>
>> While users most likely don't have the LoongArch EFI binary installed at
>> least an explicit error about 'file not found' is better than a hanging
>> test without output that can never succeed.
>
> Agreed. Let's hope at least users will be able to figure what's
> missing depending on the message. There's one thing, though, you
> hard-coded the path to the file system, and it's unlikely to be
> located at the same place for everyone:
>
> =C2=A0=C2=A0 -bios /usr/share/edk2/loongarch64/OVMF_CODE.fd
>
> Sure, it's also possible to force QEMU_ARGS but it's becoming complicated
> due to the numerous arguments. Maybe use a QEMU_BIOS_loongarch variable
> for this ? This way if this starts to generalize to other archs, we can
> later simplify it and automatically append -bios when needed.

My hope was for it to be a purely temporary bandaid.
But you are right, let's do it properly from the beginning.

>> Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6=
e06a@t-8ch.de/
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>
>> ---
>> Note: I'm wondering how this worked for anybody else.
>
> Not much surprised. As I mentioned, my qemu currently doesn't support
> loongarch so I didn't boot that one. Maybe Zhangjin had this one as
> part of his other patches.
>
> Overall, on the principle, Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
