Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4231F3B5A83
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhF1IdA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 04:33:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3323 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1IdA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 04:33:00 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GD0nb5BNVz6K7PF;
        Mon, 28 Jun 2021 16:16:51 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 10:30:32 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 28 Jun 2021 10:30:32 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 03/12] digest_lists: Basic definitions
Thread-Topic: [RFC][PATCH 03/12] digest_lists: Basic definitions
Thread-Index: AQHXaeMP1hrQEcpfKUiTvUrYdI7FlqsnkBuAgAGHhIA=
Date:   Mon, 28 Jun 2021 08:30:32 +0000
Message-ID: <860717cce60f47abb3c9dc3c1bd32ab7@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com>
In-Reply-To: <YNhYu3BXh7f9GkVk@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Sunday, June 27, 2021 12:54 PM
> On Fri, Jun 25, 2021 at 06:56:05PM +0200, Roberto Sassu wrote:
> > --- /dev/null
> > +++ b/include/uapi/linux/digest_lists.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation, version 2 of the
> > + * License.
> 
> As you already have the SPDX line up there, you do not need this
> paragraph.  Please remove it from all of the new files you have added in
> this series.

Ok.

> > + *
> > + * File: digest_lists.h
> 
> We know the filename, no need to have it here again.
> 
> > + *      Digest list definitions exported to user space.
> 
> Now this is what probably needs more information...

Ok. Yes, these definitions are useful to generate digest lists
in user space.

> > + */
> > +
> > +#ifndef _UAPI__LINUX_DIGEST_LISTS_H
> > +#define _UAPI__LINUX_DIGEST_LISTS_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/hash_info.h>
> > +
> > +enum compact_types { COMPACT_KEY, COMPACT_PARSER,
> COMPACT_FILE,
> > +		     COMPACT_METADATA, COMPACT_DIGEST_LIST,
> COMPACT__LAST };
> > +
> > +enum compact_modifiers { COMPACT_MOD_IMMUTABLE,
> COMPACT_MOD__LAST };
> > +
> > +enum compact_actions { COMPACT_ACTION_IMA_MEASURED,
> > +		       COMPACT_ACTION_IMA_APPRAISED,
> > +		       COMPACT_ACTION_IMA_APPRAISED_DIGSIG,
> > +		       COMPACT_ACTION__LAST };
> > +
> > +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
> > +
> 
> For enums you export to userspace, you need to specify the values so
> that all compilers get them right.
> 
> > +struct compact_list_hdr {
> > +	__u8 version;
> 
> You should never need a version, that way lies madness.

We wanted to have a way to switch to a new format, if necessary.

> > +	__u8 _reserved;
> 
> You better be testing this for 0, right?

Ok, will do.

> > +	__le16 type;
> > +	__le16 modifiers;
> > +	__le16 algo;
> > +	__le32 count;
> > +	__le32 datalen;
> 
> Why are user/kernel apis specified in little endian format?  Why would
> that matter?  Shouldn't they just be "native" endian?

I thought this would make it clear that the kernel always expects the
digest lists to be in little endian.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> greg k-h
