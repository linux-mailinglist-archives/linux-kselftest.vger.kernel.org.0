Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010547805E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 00:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhLPXPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 18:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbhLPXPW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 18:15:22 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB608C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 15:15:21 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A254740;
        Thu, 16 Dec 2021 23:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A254740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639696521; bh=FlCJxGsmxYNRH17rhgTDBHDYYRmcu2pB+y7gOjFT7Es=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tFMv9Ym7GPZaAy0FfW5IGPQ1m+pmQ4txtqqkyphlHXq4WZvA9ri76U9T7hJV2qRUQ
         Ut7ah15RfqiFC/aAwwJruzhX67a99lMwHr0nS7AZI8wKcovbx/vhln5IJg0tvIzCbA
         OK5n99kO08cRwjp0pIvSlPMbxQmYt4PNE/HeTbzLLZ+dz5iTLQL2m3fSGEvXjVOfEh
         oidu+f1bqs0o2MVzyzKJypQa9fWEwGrsJ6FrExtBgknU9D3XLM4xgmT9I3OFu/d5X8
         lngz+Ran6AjDMvJe8cvBHuntSisEBlc0LewgkadCuKVUT+i6GdIoR6RxOC79MFdLsA
         rYEXdGAHS9B7g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marco Elver <elver@google.com>,
        Harinder Singh <sharinder@google.com>
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com
Subject: Re: [PATCH v4 3/7] Documentation: KUnit: Added KUnit Architecture
In-Reply-To: <CANpmjNOGaVgP25xNOSGOyjcA9Lmk4uFmU=f6RrRNJBP_CMEVrQ@mail.gmail.com>
References: <20211216055958.634097-1-sharinder@google.com>
 <20211216055958.634097-4-sharinder@google.com>
 <CANpmjNOGaVgP25xNOSGOyjcA9Lmk4uFmU=f6RrRNJBP_CMEVrQ@mail.gmail.com>
Date:   Thu, 16 Dec 2021 16:15:20 -0700
Message-ID: <87czlwcfav.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Marco Elver <elver@google.com> writes:

> In response to the other email: Adding binary blobs just creates
> problems, for comparing different versions, and general bloating the
> whole repo, where better alternatives exist.
>
> I suppose an ASCII diagram is a bit primitive. :-)
>
> However, SVG files on the other hand are not binary blobs, they are
> text-markup based (XML), and e.g. diffing them often provides useful
> information about what changed. SVG also has the benefit of being
> vector graphics, and not being limited to one resolution.
>
> Looking at the diagram you added, I think this can easily be turned
> into vector graphics, and most likely will not use up 24KiB as a
> result.

I agree with all of this; we shouldn't be adding binary images to the
docs, and we've decided at other times that SVG is generally the best
compromise there.

Thanks, Marco, for pointing this out and producing an alternative.

Once this is all settled, do you want it to go through the docs tree?

jon
