Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121E429CB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 06:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhJLEk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 00:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhJLEkz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 00:40:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C8C061570
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 21:38:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so62730039wrc.10
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 21:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7rTryP4vcvwiDtwKDXkhIPEiG4Hr4DzoT/xadUmcvM=;
        b=GNfzN6C254mVqPtbDgtAmfxRijdE6RyX1YCf2AZwRTbYZZS4dRXLWRe+c8Ockrgxk0
         vdcePSKhJsaB2pDW30PBmXtkTFAOSe8iFDjATD58nnwFh9zVNZc+5NjEny8qc/0EEBDd
         I1oaoWCtkv9duQlHt8FM44Z3VhhQBYjhT2JYXSVlLEYai/JHvDlbERIeBjJy5Jrj9H8l
         5EAkB/I6qk/IOphVsbevnxkgwh8nMxZA07GZ8P1z0T8xRvgGDo4rp2r1xCI4TKjUdU5s
         QHXDglVbvTnlCrr6qjaiHp5oWW8PIbT5MeRncum6jiPQ3XRUIQwaZPzmzrjCVio22U/e
         mVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7rTryP4vcvwiDtwKDXkhIPEiG4Hr4DzoT/xadUmcvM=;
        b=oac5wqhpCdhvJgWCWag5vENet48MOuFQD55MnPxPpy4zXcSKXGLFs4Ks5U3dyEfPuF
         NaoKFO0V5hTnkJFA5Htt7MPZUpif8NX8oZ7XtjWPthCXiGOeeimTmLRhGIYfvk+BfAYB
         iXcUXCh0zTT61IkUNICmsyMYUHMKRftYlfAsfZKp7pXRe5uHGn0SMSlgP0Q2J2JUSvjg
         nyeKWreuvK1VYrOMlk04H4Oq9wWy+JmYNLXiYQOz6qoO+d+V2UipZNl+bXTrjMUqkG5Y
         U5vbRgm8gCvwYCx/r8dtJmIiObqHbevQ+ab6scfjGGiaau6shSEasCngX/CEBFGQqNMR
         TcRw==
X-Gm-Message-State: AOAM532qDKz0BvROrQ8zxuzXVekCdMMK86KTa83mSQf2R/IPB5qB3QUA
        aM7icN2wpx8DbLr59ZdVmGn06a0vhQOxzLz1AbvRGw==
X-Google-Smtp-Source: ABdhPJz1b8TLG7VPqwLKxaslZtx4r380JAZPn0QrPsMDMTUSisrIa3/RAph4GeEGWc21hXfOVs1vhtKUFU/At/nBxes=
X-Received: by 2002:a05:600c:410e:: with SMTP id j14mr3160501wmi.49.1634013533117;
 Mon, 11 Oct 2021 21:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com> <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au>
In-Reply-To: <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au>
From:   David Gow <davidgow@google.com>
Date:   Tue, 12 Oct 2021 12:38:41 +0800
Message-ID: <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 10:10 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi David,
>
> > In any case, thanks a lot -- this is awesome.
>
> Oh neat, glad it's useful!
>
> I'm happy to keep hacking on this if it's in a direction that makes
> sense for kunit in general. As an approximate plan, I can fix the UML
> breakages, then work on some resulting simplifications for tree-wide
> initialisers (we'd no longer need the null-terminated arrays of suites
> everywhere, for example).
>
+dlatypov, +kunit-dev

Yeah, we think this would be a much better direction for KUnit to go
for modules. If you're happy to work on it, that'd be great! Brendan,
Daniel (CCed), and I would be more than willing to help out with
questions, reviews, etc, as well.

On the other hand, if you're really busy and you'd rather we pick this
up, improved module support has been on the to-do list for ages, so we
could bump it up the list a bit and finish it off.

The UML breakages were mostly pretty simple: our default config
doesn't require module support at all, so the various functions should
just need to go behind the appropriate #ifdefs. A quick way to test it
is just to run './tools/testing/kunit/kunit.py run' from the kernel
source directory, which will configure, build, and run everything in
the .kunit builddir.

Cheers,
-- David
