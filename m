Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAF3D79E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhG0Pfa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 11:35:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3504 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbhG0PfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 11:35:23 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZ0pj0j1Zz6B9sL;
        Tue, 27 Jul 2021 23:20:13 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 17:35:16 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 27 Jul 2021 17:35:16 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Topic: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Index: AQHXgjyicwJtnSjv/UmZEg8zsJLYTqtWxYuAgAAn86A=
Date:   Tue, 27 Jul 2021 15:35:16 +0000
Message-ID: <e87ba6f452254067a5eb6d58937d65d1@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
 <20210726163700.2092768-3-roberto.sassu@huawei.com>
 <YQAblc+UuMq68jxu@kroah.com>
In-Reply-To: <YQAblc+UuMq68jxu@kroah.com>
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
> Sent: Tuesday, July 27, 2021 4:44 PM
> On Mon, Jul 26, 2021 at 06:36:50PM +0200, Roberto Sassu wrote:
> > --- /dev/null
> > +++ b/include/uapi/linux/diglim.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * DIGLIM definitions exported to user space, useful for generating digest
> > + * lists.
> > + */
> > +
> > +#ifndef _UAPI__LINUX_DIGLIM_H
> > +#define _UAPI__LINUX_DIGLIM_H
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
> > +/**
> > + * struct compact_list_hdr - header of the following concatenated digests
> > + * @version: version of the digest list
> > + * @_reserved: field reserved for future use
> > + * @type: type of digest list among enum compact_types
> > + * @modifiers: additional attributes among (1 << enum compact_modifiers)
> 
> I do not understand this description, what does it mean?

Hi Greg

yes, it is not very clear.

@modifiers is a bitmask where each bit corresponds to a different
attribute. enum compact_modifiers defines which bit position is
assigned to each attribute.

> > + * @algo: digest algorithm
> 
> Is this also a #define or an enum?  Where is the list of them?

@algo is an enum defined in include/uapi/linux/hash_info.h.

> > + * @count: number of digests
> > + * @datalen: length of concatenated digests
> 
> Where does this count and length come into play as nothing else is in
> this structure?

Each digest list must begin with this structure. From it, the parser knows
how much data it should expect afterwards. After the data, there could be
another or more blocks of this structure and following data.

There is an example in the 'Compact Digest List Example' subsection,
in Documentation/security/diglim/implementation.rst.

> > + *
> > + * A digest list is a set of blocks composed by struct compact_list_hdr and
> > + * the following concatenated digests.
> > + */
> > +struct compact_list_hdr {
> > +	__u8 version;
> > +	__u8 _reserved;
> 
> You MUST check this for 0 today, and document it above.  If not, you can
> never use it in the future.

Ok, yes. I will add it.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> > +	__le16 type;
> > +	__le16 modifiers;
> > +	__le16 algo;
> > +	__le32 count;
> > +	__le32 datalen;
> > +} __packed;
> > +#endif /*_UAPI__LINUX_DIGLIM_H*/
> > --
> > 2.25.1
> >
