Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1F3D8CF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhG1LpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 07:45:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3512 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhG1LpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 07:45:06 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZWnK4j7lz6DJ8k;
        Wed, 28 Jul 2021 19:35:49 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 13:45:03 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 28 Jul 2021 13:45:03 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Topic: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Index: AQHXgjyicwJtnSjv/UmZEg8zsJLYTqtYIhYAgAAkorA=
Date:   Wed, 28 Jul 2021 11:45:02 +0000
Message-ID: <eb3b025820574f0d901a38a4ad088018@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-3-roberto.sassu@huawei.com>
 <20210728133102.339c7b8e@coco.lan>
In-Reply-To: <20210728133102.339c7b8e@coco.lan>
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

> From: Mauro Carvalho Chehab [mailto:mchehab+huawei@kernel.org]
> Sent: Wednesday, July 28, 2021 1:31 PM
> Em Mon, 26 Jul 2021 18:36:50 +0200
> Roberto Sassu <roberto.sassu@huawei.com> escreveu:
> 
> > Introduce the basic definitions, exported to user space, to use digest
> > lists. The definitions, added to include/uapi/linux/diglim.h, are
> > documented in Documentation/security/diglim/implementation.rst.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  .../security/diglim/implementation.rst        | 97 +++++++++++++++++++
> >  Documentation/security/diglim/index.rst       |  1 +
> >  MAINTAINERS                                   |  2 +
> >  include/uapi/linux/diglim.h                   | 51 ++++++++++
> >  4 files changed, 151 insertions(+)
> >  create mode 100644 Documentation/security/diglim/implementation.rst
> >  create mode 100644 include/uapi/linux/diglim.h
> >
> > diff --git a/Documentation/security/diglim/implementation.rst
> b/Documentation/security/diglim/implementation.rst
> > new file mode 100644
> > index 000000000000..59a180b3bb3f
> > --- /dev/null
> > +++ b/Documentation/security/diglim/implementation.rst
> > @@ -0,0 +1,97 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Implementation
> > +==============
> > +
> > +This section describes the implementation of DIGLIM.
> > +
> > +
> > +Basic Definitions
> > +-----------------
> > +
> > +This section introduces the basic definitions required to use DIGLIM.
> > +
> > +
> > +Compact Digest List Format
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: include/uapi/linux/diglim.h
> > +   :identifiers: compact_list_hdr
> > +
> > +Compact Types
> > +.............
> > +
> > +Digests can be of different types:
> > +
> > +- ``COMPACT_PARSER``: digests of executables which are given the ability
> to
> > +  parse digest lists not in the compact format and to upload to the kernel
> > +  the digest list converted to the compact format;
> > +- ``COMPACT_FILE``: digests of regular files;
> > +- ``COMPACT_METADATA``: digests of file metadata (e.g. the digest
> > +  calculated by EVM to verify a portable signature);
> > +- ``COMPACT_DIGEST_LIST``: digests of digest lists (only used internally by
> > +  the kernel).
> > +
> > +Different users of DIGLIM might query digests with different compact types.
> > +For example, IMA would be interested in COMPACT_FILE, as it deals with
> > +regular files, while EVM would be interested in COMPACT_METADATA, as it
> > +verifies file metadata.
> > +
> > +
> > +Compact Modifiers
> > +.................
> > +
> > +Digests can also have specific attributes called modifiers (bit position):
> > +
> > +- ``COMPACT_MOD_IMMUTABLE``: file content or metadata should not be
> > +  modifiable.
> > +
> > +IMA might use this information to deny open for writing, or EVM to deny
> > +setxattr operations.
> > +
> > +
> > +Actions
> > +.......
> > +
> > +This section defines a set of possible actions that have been executed on
> > +the digest lists (bit position):
> > +
> > +- ``COMPACT_ACTION_IMA_MEASURED``: the digest list has been
> measured by
> > +  IMA;
> > +- ``COMPACT_ACTION_IMA_APPRAISED``: the digest list has been
> successfully
> > +  appraised by IMA;
> > +- ``COMPACT_ACTION_IMA_APPRAISED_DIGSIG``: the digest list has been
> > +  successfully appraised by IMA by verifying a digital signature.
> > +
> > +This information might help users of DIGLIM to decide whether to use the
> > +result of a queried digest.
> > +
> > +For example, if a digest belongs to a digest list that was not measured
> > +before, IMA should ignore the result of the query, as the measurement list
> > +sent to remote verifiers would lack which digests have been uploaded to
> the
> > +kernel.
> > +
> > +
> > +Compact Digest List Example
> > +...........................
> > +
> > +::
> > +
> > + version: 1, type: 2, modifiers: 0 algo: 4, count: 3, datalen: 96
> > + <SHA256 digest1><SHA256 digest2><SHA256 digest3>
> > + version: 1, type: 3, modifiers: 1 algo: 6, count: 2, datalen: 128
> > + <SHA512 digest1><SHA512 digest2>
> > +
> > +This digest list consists of two blocks. The first block contains three
> > +SHA256 digests of regular files. The second block contains two SHA512
> > +digests of immutable metadata.
> > +
> > +
> > +Compact Digest List Operations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Finally, this section defines the possible operations that can be performed
> > +with digest lists:
> > +
> > +- ``DIGEST_LIST_ADD``: the digest list is being added;
> > +- ``DIGEST_LIST_DEL``: the digest list is being deleted.
> > diff --git a/Documentation/security/diglim/index.rst
> b/Documentation/security/diglim/index.rst
> > index 0fc5ab019bc0..4771134c2f0d 100644
> > --- a/Documentation/security/diglim/index.rst
> > +++ b/Documentation/security/diglim/index.rst
> > @@ -9,3 +9,4 @@ Digest Lists Integrity Module (DIGLIM)
> >
> >     introduction
> >     architecture
> > +   implementation
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c914dadd7e65..f61f5239468a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5458,8 +5458,10 @@ L:	linux-integrity@vger.kernel.org
> >  S:	Supported
> >  T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> >  F:	Documentation/security/diglim/architecture.rst
> > +F:	Documentation/security/diglim/implementation.rst
> >  F:	Documentation/security/diglim/index.rst
> >  F:	Documentation/security/diglim/introduction.rst
> > +F:	include/uapi/linux/diglim.h
> >
> >  DIOLAN U2C-12 I2C DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> > diff --git a/include/uapi/linux/diglim.h b/include/uapi/linux/diglim.h
> > new file mode 100644
> > index 000000000000..8a33d1f0fefb
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
> > + * @algo: digest algorithm
> > + * @count: number of digests
> > + * @datalen: length of concatenated digests
> > + *
> > + * A digest list is a set of blocks composed by struct compact_list_hdr and
> > + * the following concatenated digests.
> > + */
> > +struct compact_list_hdr {
> > +	__u8 version;
> > +	__u8 _reserved;
> > +	__le16 type;
> > +	__le16 modifiers;
> > +	__le16 algo;
> > +	__le32 count;
> > +	__le32 datalen;
> > +} __packed;
> > +#endif /*_UAPI__LINUX_DIGLIM_H*/
> 
> Besides Greg's notes, I'm wondering why to enforce a particular
> endness here. I mean, this is uAPI. I would expect it to use the
> CPU endianness instead, in order to avoid uneeded conversions.

Also Greg had the same concern. I hoped the Lifecycle section clarified
the fact that digest lists are generated by software vendors not the
local system. Should I add something more in the documentation?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> Thanks,
> Mauro
