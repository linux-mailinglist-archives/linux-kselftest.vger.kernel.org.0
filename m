Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFF2A9496
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKFKlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 05:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgKFKlR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 05:41:17 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E4B20702;
        Fri,  6 Nov 2020 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659276;
        bh=FZPOUxbRLfnd+t8CdYEkeO2TCpAs4UT0oND2nvpDiDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIIV1fyeLOQP3xvdO35mmMUbH6AnHfV2gll+R4VQt/8JMCXFuKE+oywvx2kFEpXkE
         gK9egVH44hTJgnK8pv+jk9SQW8DrJnh4b5t3AxKaEMb6J0KStHwH9K2Rf+6O5saVIu
         OnhkH6hhV8fuxh0NK96fZtx0Y7QPMV5DCTmJm3Cs=
Date:   Fri, 6 Nov 2020 11:42:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        alexandre.belloni@bootlin.com, rdunlap@infradead.org,
        idryomov@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
Message-ID: <20201106104203.GC2784089@kroah.com>
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com>
 <20201103160728.GQ20201@alley>
 <57976ff4-7845-d721-ced1-1fe439000a9b@rasmusvillemoes.dk>
 <b24a8200-b456-ecab-cc60-6f4ff10baa5d@gmail.com>
 <1b452380-53a5-f396-bf2f-97736db28afb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b452380-53a5-f396-bf2f-97736db28afb@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 06, 2020 at 11:31:43AM +0100, Rasmus Villemoes wrote:
> On 06/11/2020 05.04, Arpitha Raghunandan wrote:
> > 
> > The total number of "atoms" can be printed by maintaining a static variable
> > total_count that can be incremented as is in the original test_printf test.
> > But, the reporting of the random seed currently is done in kselftest and so
> > will not show up with KUnit. I am not really sure which is better in this case.
> 
> So my real questions are: Why do we have both kselftest and kunit?

One is testing code within the kernel image testing it within
kernelspace, and one is outside the kernel testing it from userspace.

thanks,

greg k-h
