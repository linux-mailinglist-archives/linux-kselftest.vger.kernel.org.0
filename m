Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F3F0B18
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 01:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfKFAff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34543 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfKFAff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so5719659pff.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2019 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=iwk05Z47ymun6qVZ2ZqvWQVrNbyrFI4pKJaqVPuEkPVoeZ8TkgQOMYeUjohJyfTxHy
         i35BEo94zplaDsUpCIniLT2yVpRSn0rD/LIMZNRRDFvwzV2sw5aV+CntsHEXnIS5QRWU
         credwKAD1iKpgmUDD//nXU9d/JxDgA1iEl62DNLFnu4wvD4qkNgQ8PPueRPgDYOLgbG/
         wRQ40/pTEPmrga86TUsN55Q89f3ccHt/vgpMxsPdm95ao3HIHGPXqJhoiqMN+sz2D0kx
         L5TvL5vphZGSYA4WnzDDvIMRkLoCjBCDf84EfTVmSdk0cpkisx4MeLqnP8yYmbqeUxse
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=m49GDHr2DH0zeXLyIiMtVJu+t7d00Godk5jx0/ugAuYCe1OqzxzbIc8qenucuEap8e
         XLThoSv4k0iKqCtq/j1e+A0YVOLHrxcDnDOIOrKUJjOdw8sL0YPe51XkTii4aVJr+sIe
         36ddu6QFDY4zB6xKSk/F/lx5uVEQZb15VFzqrq0hgElMZLCFYrmcIOzK4aSXYlc4hYYq
         MlSwXwAO/crUeXZwzFIywSPtnZzqP1B/6hxbFS5UJ7UwscPDCX/A+J6f2iiogVoZuykX
         Ab/k4uniU7777xfNvua5qWHRflSoPrh2XQV/aFD8baA4tU1EOZlXnvb2ryc40G3G+9Ee
         UCxQ==
X-Gm-Message-State: APjAAAXZ+zzi/PUJUJ6Cg/8NuXrWGVl5a3dBByKWXyS36yNgm7ZiNomJ
        PD3CCENcu1b4SHva29dBB58hNthfwXzEH/mHGXhrBQ==
X-Google-Smtp-Source: APXvYqxx7uF9ghHiBuV0xbVds7C5n9sNEWRuLJWVo2JcGIMQ4ueurVpCMm+qC8uxe/bJIIoWwyQx/y3NuBylgqCZee4=
X-Received: by 2002:a63:234c:: with SMTP id u12mr38258741pgm.384.1573000534052;
 Tue, 05 Nov 2019 16:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com> <201910301157.58D0CE4D3@keescook>
In-Reply-To: <201910301157.58D0CE4D3@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 16:35:22 -0800
Message-ID: <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> > On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> >
> > > +config SECURITY_APPARMOR_TEST
> > > +       bool "Build KUnit tests for policy_unpack.c"
> > > +       default n
>
> New options already already default n, this can be left off.
>
> > > +       depends on KUNIT && SECURITY_APPARMOR
> > > +       help
> > >
> > select SECURITY_APPARMOR ?
>
> "select" doesn't enforce dependencies, so just a "depends ..." is
> correct.
>
> > > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > > +       KUNIT_EXPECT_TRUE(test,
> > > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> > otherwise there could be a buffer overflow in memcmp. All tests that
> > follow such pattern
>
> Agreed.
>
> > are suspect. Also, not sure about your stylistic preference for
> > KUNIT_EXPECT_TRUE(test,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > vs
> > KUNIT_EXPECT_EQ(test,
> >                0,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
>
> I like == 0.

Oh, I almost missed this. I think the *_EQ(...) is better than the
*_TRUE(...) because the EQ is able to provide more debug information
if the test fails (otherwise there would really be no point in
providing all these variants).

Any objections?

Thanks for the catch Iurii!
