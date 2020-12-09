Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9765C2D4ED8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 00:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgLIXgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 18:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgLIXgx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 18:36:53 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA6C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Dec 2020 15:36:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x23so4545094lji.7
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Dec 2020 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pTo7jsl561EArpZkOZylyDUIsb2DdRBwjmNyDxX906g=;
        b=NuoCM3w040xBkq1NFSpB15nz67UGhYKJ63x/OjXgYWaOAD5v3yyBQcz0dmPTa5dR0v
         eM28u+P90+dGqIzf4UXOU3cm/Z9o7CCqlscXVQpLEWyu5husd1c6a0jYTPq3bhkkmmT/
         pp0LlGbDO4LnKDdhBvg68eYmKK/u6RxETzsK2y0uiC+RRfjFBjQfYnKht6XrpbZTXBxT
         afs9KH9Ftq8H4jKC+IYoDIlSsYladyNZ+xwrwsosJDLaTATmBiUKtN/a205k5UGEm9zr
         CdDsbyHBI+xYIHU9QUrv0Io1yA1Vh6o9tPM8IEtJa90KhjhAUyI9qGN4hRi51efs4Zyq
         MyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pTo7jsl561EArpZkOZylyDUIsb2DdRBwjmNyDxX906g=;
        b=dzoBNlZdX88IyoiCk/C9n54i7S0x2uL6H99+d7R5vHQ6TgGXYh1XbIoOBzUMQTLD5b
         VQOK+p5TWIzLv11dFQ5Va/uvdbzgX4a2O2+2wSxi1k3i/JxFwh4VxRC4vpmILk31oOwy
         1O0NR4TiDj38nF1fex3uU6bts+zIN+Bhlf8Cy1wTqmhMRiAMaib4KS9qDDpw48vR21Uy
         EY/i2ilERYw2omuVY/qYOwrp8gZafyLflL4FzYVR+oCrubUsMupwp6nEXf8VubIUYMvz
         vRy04wqd/6OgIv8aIj7GYJ7F15dNxzLlMDRbavSPRGGxXDEdtKCTg8WzxVrcZ198bzS7
         pjJQ==
X-Gm-Message-State: AOAM533T+2yQ438zd8sqZN+8EOzbIq9jz8TAiOE7qvwpnPEGziktsz4j
        lheMuwaPrIAxewmPGn15MqTRSrrCp53Z2b1C6yOYw1cNhQdsRVf5
X-Google-Smtp-Source: ABdhPJyA5S27YppqE010dDkaeBMdPpT4X7YHzYar0Vt/7/pYjjj6JSfE2myVytF57w3hI+qaRg3TYEFmqXfA0dPR6NA=
X-Received: by 2002:a2e:a593:: with SMTP id m19mr1943857ljp.327.1607556970939;
 Wed, 09 Dec 2020 15:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 10 Dec 2020 07:35:59 +0800
Message-ID: <CABVgOSm068MCw1H2m5Gz-deHicpg_U3jcU=GfJTB0S5B-g-ZUQ@mail.gmail.com>
Subject: Re: [PATCH v1] um: Increase stack frame size threshold for signal.c
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 2:23 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The signal.c can't use heap for bit data located on stack. However,
> by default a compiler warns us about overstepping stack frame size
> threshold:
>
> arch/um/os-Linux/signal.c: In function =E2=80=98sig_handler_common=E2=80=
=99:
> arch/um/os-Linux/signal.c:51:1: warning: the frame size of 2960 bytes is =
larger than 2048 bytes [-Wframe-larger-than=3D]
>    51 | }
>       | ^
> arch/um/os-Linux/signal.c: In function =E2=80=98timer_real_alarm_handler=
=E2=80=99:
> arch/um/os-Linux/signal.c:95:1: warning: the frame size of 2960 bytes is =
larger than 2048 bytes [-Wframe-larger-than=3D]
>     95 | }
>        | ^
>
> Due to above increase stack frame size threshold explicitly for signal.c
> to avoid unnecessary warning.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
Thanks -- this has been annoying me for a while!

I've tested it -- the warning is indeed gone, and nothing else seems to bre=
ak.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
