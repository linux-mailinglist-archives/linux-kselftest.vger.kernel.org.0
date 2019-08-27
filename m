Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB79EFC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfH0QJ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 12:09:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44551 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfH0QJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 12:09:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so12937017pgl.11
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+ewofGgqXwwrEKyd3RnPtDD4SWAWjoyL/KF4JyMz0k=;
        b=im8IgKyU7PApob9zdI2bKkHvClM5tT3ZrZYAP9rmDDUg2jlCUrhIR7L7c0BfEDnHpO
         83ImifBo2cwuBUYl0UrPcB7CsJhC4+RrnVCamMHsdTui6dclTm5U19ArrKd8yJoxlQ7t
         c3tKw01vr0xikmjsHQ+RmpVXSfKJPDY2IXJ99aAd+gvVVMdibijXDdCXNuumogny6Rdc
         hq1Uao85EHQuS0GacD1QPj9OpkXEqnkLKbKkiOuM8YUifp1Q723saPkLh1zDASOy6TDZ
         m1baB002Y+CIWihR71yHbuQzHwiHYbvlkv9Gj4f89a/+tfj7GF6yucTl9PeicbkqwJEy
         iP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+ewofGgqXwwrEKyd3RnPtDD4SWAWjoyL/KF4JyMz0k=;
        b=ubKp0Fy9NSpontT6V7wbe5EY84kuQaKgFad/Nn5iN7gGCXhQq1eQR87Rs2SD26yIen
         oPZzmUQI19ag/ehDsFFdfXWrOIfn0F0r1prKWbHny/XUMP0MFy3sVujdC/8Qf3unMHn6
         vRIRzxJ1ruYN/9tQIuZ1WSH4am5BOc5qhdx2SkMKaXcBcHT6IS8EnEAoI4BTVM6JUW+8
         yfhXgdK95CXFtGo94rMjeFE+/3kUopfCeGxhgDpg5PX9FJ4h6MtDVMR1omerH0rZokR0
         OaXuM/tlRLENYLllECbskypylrqLAYRxz8kqcaZbY8QdZYcxccD+7yt2HiUHscjZbghr
         x5xw==
X-Gm-Message-State: APjAAAXgR/SXZKj32XX40gZTFyTdw/VJLxLy/04Nh74gH3W/rkk54muB
        xODmy04lgT5LJMxGaSGoY+OJWoT0DsOIIcrGSsbJqQ==
X-Google-Smtp-Source: APXvYqzquXmLYJxp8UUmLZGf/BqLEQu+rHsFlpty6Ng28rMacp102hu83XiIbg/DHK3ZGZb0KgfDfSnGw/9w/JHxBWg=
X-Received: by 2002:a17:90a:25ea:: with SMTP id k97mr26573759pje.131.1566922194974;
 Tue, 27 Aug 2019 09:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190827190526.6f27e763@canb.auug.org.au> <c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org>
In-Reply-To: <c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 09:09:43 -0700
Message-ID: <CAFd5g452baXuwL1hDyX+U53_p6XGppTf5p1qMwRsGK-wjzJ8Lg@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 27 (kunit)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 27, 2019 at 8:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/27/19 2:05 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190826:
> >
>
> on i386:
> # CONFIG_PRINTK is not set
>
>
> ../kunit/test.c: In function =E2=80=98kunit_vprintk_emit=E2=80=99:
> ../kunit/test.c:21:9: error: implicit declaration of function =E2=80=98vp=
rintk_emit=E2=80=99; did you mean =E2=80=98vprintk=E2=80=99? [-Werror=3Dimp=
licit-function-declaration]
>   return vprintk_emit(0, level, NULL, 0, fmt, args);
>          ^~~~~~~~~~~~
>          vprintk

Ooops, it never occurred to me to test the situation where I wouldn't
be able to see test results :-)

It seems to me that the right thing to do here is to do what
dev_printk and friends do and to ifdef this out if CONFIG_PRINTK is
unavailable. Does that seem reasonable?

Also, do you want me to resend my patches with the fix or do you want
me to send a new patch with this fix? (Sorry for the newbie question.)

Thanks!
