Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7743E34
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfFMPsM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:48:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38027 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfFMPsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 11:48:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so15477949lfa.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=HwzQ0rH3HntP0X1Ut+3aziFTUNyu7eZWshFffAcbuEQadz4P6sC2snoDJGp4KSyvu2
         Kig7hRqtroYC7jNl67KKgqHxE423RPSnEeZfbHsd+gLto0eo7V3yt/GGwc+21qgO0c3A
         GIH+62EGfN0eHFV/TMnqz5oJqV2MDDVZaYpN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=PwmerCdqyKzLZCSWEWskPsKObfz78p4wJt3eCnQfEyGCZ9i94yvIP+/2jXT3XPEF7/
         JwumKcwFgjSQg1Wb6v97CM71mYhCUt41a535rQqxvMTstwJq/9OqVCOvcJ3OafjoaRce
         zau2qaNOSFnYN2gngHwB8tadOnyYwKOiboq1bwo0yGQABg4R6Oy1KxTPBEBpk3UmXfp1
         nQ5vCzVHQzVmWbhdWpx7MynNiVrLXuPlOGC8BmC8cpSXAyKP5XVmEnvGFkCzBaht08Hd
         6OAeSlOtdlJAEvR7rZ6xWjSgoLRcYquhPxA+vRV0Bl8hUflI+2VSQnMGByJK+mr7UBwN
         rmrQ==
X-Gm-Message-State: APjAAAWRNvFbtitJngFYqUrXuN7TEOeJXCY94ofNeTYJdvoa3aCfxcKj
        sz7wJbnQ3xEVhwwocpcNtJvYh1qDjv5rEH+QkCKljg==
X-Google-Smtp-Source: APXvYqzrRigc/QwtHv0h+SK0yPrIqLoP/sTRt4T7cb0mR/3kmBMhY1s0fNVfrmh2vHW4vI1uCiYqipwR2/fMUdkpn8I=
X-Received: by 2002:a19:c383:: with SMTP id t125mr38852030lff.89.1560440880394;
 Thu, 13 Jun 2019 08:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190613112709.7215-1-afabre@cloudflare.com> <20190613154152.GA9636@mini-arch>
In-Reply-To: <20190613154152.GA9636@mini-arch>
From:   Arthur Fabre <afabre@cloudflare.com>
Date:   Thu, 13 Jun 2019 16:47:49 +0100
Message-ID: <CAOn4ftu8dv4rOei=Janw8bRMGLM5bganNGjp3nLUof82Z9vSiQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: Fix warning in flow_dissector
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ah yes good catch. I guess it hasn't made it into bpf-next yet.

On Thu, Jun 13, 2019 at 4:41 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/13, Arthur Fabre wrote:
> > Building the userspace part of the flow_dissector resulted in:
> >
> > prog_tests/flow_dissector.c: In function =E2=80=98tx_tap=E2=80=99:
> > prog_tests/flow_dissector.c:176:9: warning: implicit declaration
> > of function =E2=80=98writev=E2=80=99; did you mean =E2=80=98write=E2=80=
=99? [-Wimplicit-function-declaration]
> >   return writev(fd, iov, ARRAY_SIZE(iov));
> >          ^~~~~~
> >          write
> >
> > Include <sys/uio.h> to fix this.
> Wasn't it fixed already?
>
> See
> https://lore.kernel.org/netdev/20190528190218.GA6950@ip-172-31-44-144.us-=
west-2.compute.internal/
>
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/=
tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > index fbd1d88a6095..c938283ac232 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > @@ -3,6 +3,7 @@
> >  #include <error.h>
> >  #include <linux/if.h>
> >  #include <linux/if_tun.h>
> > +#include <sys/uio.h>
> >
> >  #define CHECK_FLOW_KEYS(desc, got, expected)                         \
> >       CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) !=3D 0,          =
 \
> > --
> > 2.20.1
> >
