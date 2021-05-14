Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F23380437
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhENH2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhENH2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 03:28:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD729C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 14 May 2021 00:27:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso920575wmh.4
        for <linux-kselftest@vger.kernel.org>; Fri, 14 May 2021 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9tnZ9evfnbV2gxFSdDXTY64rXupCRZyW/vv9n4TlN8=;
        b=MIurMscQNGv4VZ6tzwhpDr7DzPbE1lxnX7hhE2XtuM82IE4cR8QJXBCMMNNDnVDg8X
         XCS/Gx3si6HBXuRHCaCL9DThQ3tLSYbQIoDtBdkHtYmCbZyQvr27pkzhdTLOYJHHWkj6
         sqChVKqmNRVjlg/aRd/mMpdqIhS/Ar4iBRJ7ttcdBl0S5tBPC1cmJD4+tgoeWJ0k8B0g
         xAV6We96t22fmldVwUewaB70BvG5j6kUV0SeRgmail60uzMXgK1e6EaSkNJo1OMKX209
         jufk+n4zf2jGz9a4wr9qhPc4WBjVGCLeGppkVo633TCrxHwu5FmBFqjoLMGDzkcDowSl
         rFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9tnZ9evfnbV2gxFSdDXTY64rXupCRZyW/vv9n4TlN8=;
        b=tM/HoOaimNp4o1rGfVc24AVM0gxBdfyHJ0qQoKVj4hTEng1BEplrxn4/5bCkRYXjJY
         MuhW0hcoyrxILIphqn7L1nTWvqU2GgY7TreREFQ4Ugzlkyf4Vd1XFTlULDwXXutAugTJ
         sdeYvtPfUt6aGk9fulmI7B6CqDNVFljp7/HwBBZez6UaTFezKbgWER9dz0citQl64MV/
         U0u11bzoczePkZkGRgxSMSgjGaXkXXrzUldNRrO3plZcfe/OdGmnQKCWdE/eZRkitLTu
         FFmtURkl10DQSb1uKITHx7RkYcQ5KNWOrcUUnCGAFX4JLhuvSUCJSXYtbhCz3GP7VGi9
         MMAA==
X-Gm-Message-State: AOAM532xgdlyA/jheuFG8ZXRkGiScPLYhYwuSRlitxVW3iosMWv6nFhK
        8rsUTHf+2YfxGsHO54UYLS2VgQ5g//h6K8a/e+Ebtw==
X-Google-Smtp-Source: ABdhPJwHjh48zkpYoAZ/2nORJLb3FRq5J0iYy27VTbDg3XN6mubKDH/X9sIK+VlaB4FVW8C1KS+Fwp0PX8EDvKtjQtA=
X-Received: by 2002:a05:600c:2315:: with SMTP id 21mr47477543wmo.39.1620977238261;
 Fri, 14 May 2021 00:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-7-davidgow@google.com>
 <20210514060618.GA3511397@lahna.fi.intel.com>
In-Reply-To: <20210514060618.GA3511397@lahna.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 14 May 2021 15:27:07 +0800
Message-ID: <CABVgOS=Zt8-dHPKTjjQ_C+jZ8ySZejjXyQYSN-hRF95cqCLYmw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] thunderbolt: test: Remove sone casts which are
 no longer required
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 14, 2021 at 2:08 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, May 13, 2021 at 12:32:01PM -0700, David Gow wrote:
> > With some of the stricter type checking in KUnit's EXPECT macros
> > removed, several casts in the thunderbolt KUnit tests are no longer
> > required.
> >
> > Remove the unnecessary casts, making the conditions clearer.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Looks good.
>
> Does this go through KUnit tree or you want me to take it? In case of
> the former feel free to add:
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>

Thanks. I think it's probably easier for this to go in via the KUnit
tree, unless Brendan or Shuah have any objections.

Cheers,
-- David
