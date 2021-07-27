Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAF3D7A0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhG0PoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 11:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhG0PoO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 11:44:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8269761B5F;
        Tue, 27 Jul 2021 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627400653;
        bh=SyRlNQA0ZEXJJkLYmMvc251S8UFPcO3XgOuG7qQOfow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fn4gr2faYUHWCYqF6AQ/+ImWjX/zNl1Nptzte5I/GH7CxAS06+hVlUHP4WMl544ck
         J7h2BAygRwT/JRFHpJxQwfXtxIkj/MUehzk2Yi9MtXX5qqVYcPtWnNTOBqkVKxs5fC
         2udTiFRtMa8vhuo8iA+lgR2pzf6kBYlsQuULTyI0=
Date:   Tue, 27 Jul 2021 17:44:10 +0200
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
Message-ID: <YQApyqP7J/8GpItS@kroah.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
 <20210726163700.2092768-3-roberto.sassu@huawei.com>
 <YQAblc+UuMq68jxu@kroah.com>
 <e87ba6f452254067a5eb6d58937d65d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87ba6f452254067a5eb6d58937d65d1@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 03:35:16PM +0000, Roberto Sassu wrote:
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, July 27, 2021 4:44 PM
> > On Mon, Jul 26, 2021 at 06:36:50PM +0200, Roberto Sassu wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/linux/diglim.h
> > > @@ -0,0 +1,51 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/*
> > > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > > + *
> > > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > + *
> > > + * DIGLIM definitions exported to user space, useful for generating digest
> > > + * lists.
> > > + */
> > > +
> > > +#ifndef _UAPI__LINUX_DIGLIM_H
> > > +#define _UAPI__LINUX_DIGLIM_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/hash_info.h>
> > > +
> > > +enum compact_types { COMPACT_KEY, COMPACT_PARSER,
> > COMPACT_FILE,
> > > +		     COMPACT_METADATA, COMPACT_DIGEST_LIST,
> > COMPACT__LAST };
> > > +
> > > +enum compact_modifiers { COMPACT_MOD_IMMUTABLE,
> > COMPACT_MOD__LAST };
> > > +
> > > +enum compact_actions { COMPACT_ACTION_IMA_MEASURED,
> > > +		       COMPACT_ACTION_IMA_APPRAISED,
> > > +		       COMPACT_ACTION_IMA_APPRAISED_DIGSIG,
> > > +		       COMPACT_ACTION__LAST };
> > > +
> > > +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
> > > +
> > > +/**
> > > + * struct compact_list_hdr - header of the following concatenated digests
> > > + * @version: version of the digest list
> > > + * @_reserved: field reserved for future use
> > > + * @type: type of digest list among enum compact_types
> > > + * @modifiers: additional attributes among (1 << enum compact_modifiers)
> > 
> > I do not understand this description, what does it mean?
> 
> Hi Greg
> 
> yes, it is not very clear.
> 
> @modifiers is a bitmask where each bit corresponds to a different
> attribute. enum compact_modifiers defines which bit position is
> assigned to each attribute.

Watch out with endian issues and bitmasks...  Anyway, please document
this.

> 
> > > + * @algo: digest algorithm
> > 
> > Is this also a #define or an enum?  Where is the list of them?
> 
> @algo is an enum defined in include/uapi/linux/hash_info.h.

Please say that.

> > > + * @count: number of digests
> > > + * @datalen: length of concatenated digests
> > 
> > Where does this count and length come into play as nothing else is in
> > this structure?
> 
> Each digest list must begin with this structure. From it, the parser knows
> how much data it should expect afterwards. After the data, there could be
> another or more blocks of this structure and following data.

Ah, that was not obvious at all :)

Why do you not have a __u8 data[]; type field as the last one here for
that memory so you can access it easier?

thanks,

greg k-h
