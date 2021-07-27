Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30BE3D7AA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhG0QNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 12:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QNa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 12:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D253461B5F;
        Tue, 27 Jul 2021 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627402410;
        bh=cSvv7h1KI4rEs+b/XRGdLLHF0kCjqbmt0F4Q4/KmUFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xv8/cedoNSRYzYwwcD6vrJcRh3eIMNt6B53Peuj8Gwi0QgaQ6tAEW78TP+cnpeHcY
         0yVj5udDCtA9i9ywyVsTIw4JkuljUGSwzmxkwlDZ23Mmi+l0coIWNE93O7FOVkOK+k
         fIj/uoRdVYi40WTN0E1zZgzvAQA+Kk9KkhDMwqiI=
Date:   Tue, 27 Jul 2021 18:13:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 02/12] diglim: Basic definitions
Message-ID: <YQAwqGOEkmDzZ9MJ@kroah.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
 <20210726163700.2092768-3-roberto.sassu@huawei.com>
 <YQAblc+UuMq68jxu@kroah.com>
 <e87ba6f452254067a5eb6d58937d65d1@huawei.com>
 <YQApyqP7J/8GpItS@kroah.com>
 <4746947088404edaa31594fb095a6e46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4746947088404edaa31594fb095a6e46@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 04:09:37PM +0000, Roberto Sassu wrote:
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, July 27, 2021 5:44 PM
> > On Tue, Jul 27, 2021 at 03:35:16PM +0000, Roberto Sassu wrote:
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Tuesday, July 27, 2021 4:44 PM
> > > > On Mon, Jul 26, 2021 at 06:36:50PM +0200, Roberto Sassu wrote:
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/linux/diglim.h
> > > > > @@ -0,0 +1,51 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > +/*
> > > > > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > > > > + *
> > > > > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > + *
> > > > > + * DIGLIM definitions exported to user space, useful for generating
> > digest
> > > > > + * lists.
> > > > > + */
> > > > > +
> > > > > +#ifndef _UAPI__LINUX_DIGLIM_H
> > > > > +#define _UAPI__LINUX_DIGLIM_H
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/hash_info.h>
> > > > > +
> > > > > +enum compact_types { COMPACT_KEY, COMPACT_PARSER,
> > > > COMPACT_FILE,
> > > > > +		     COMPACT_METADATA, COMPACT_DIGEST_LIST,
> > > > COMPACT__LAST };
> > > > > +
> > > > > +enum compact_modifiers { COMPACT_MOD_IMMUTABLE,
> > > > COMPACT_MOD__LAST };
> > > > > +
> > > > > +enum compact_actions { COMPACT_ACTION_IMA_MEASURED,
> > > > > +		       COMPACT_ACTION_IMA_APPRAISED,
> > > > > +		       COMPACT_ACTION_IMA_APPRAISED_DIGSIG,
> > > > > +		       COMPACT_ACTION__LAST };
> > > > > +
> > > > > +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL,
> > DIGEST_LIST_OP__LAST };
> > > > > +
> > > > > +/**
> > > > > + * struct compact_list_hdr - header of the following concatenated
> > digests
> > > > > + * @version: version of the digest list
> > > > > + * @_reserved: field reserved for future use
> > > > > + * @type: type of digest list among enum compact_types
> > > > > + * @modifiers: additional attributes among (1 << enum
> > compact_modifiers)
> > > >
> > > > I do not understand this description, what does it mean?
> > >
> > > Hi Greg
> > >
> > > yes, it is not very clear.
> > >
> > > @modifiers is a bitmask where each bit corresponds to a different
> > > attribute. enum compact_modifiers defines which bit position is
> > > assigned to each attribute.
> > 
> > Watch out with endian issues and bitmasks...  Anyway, please document
> > this.
> > 
> > >
> > > > > + * @algo: digest algorithm
> > > >
> > > > Is this also a #define or an enum?  Where is the list of them?
> > >
> > > @algo is an enum defined in include/uapi/linux/hash_info.h.
> > 
> > Please say that.
> > 
> > > > > + * @count: number of digests
> > > > > + * @datalen: length of concatenated digests
> > > >
> > > > Where does this count and length come into play as nothing else is in
> > > > this structure?
> > >
> > > Each digest list must begin with this structure. From it, the parser knows
> > > how much data it should expect afterwards. After the data, there could be
> > > another or more blocks of this structure and following data.
> > 
> > Ah, that was not obvious at all :)
> > 
> > Why do you not have a __u8 data[]; type field as the last one here for
> > that memory so you can access it easier?
> 
> After the digest list is parsed, I'm accessing the digest with the offset from
> the beginning of the digest list. If the offset was relative to the header, it could
> have been useful. I could add the new field, but I'm afraid of the incompatibility
> with existing tools that we have.

What tools?  This isn't a feature in the kernel yet, so we have no
legacy to support, right?

thanks,

greg k-h
