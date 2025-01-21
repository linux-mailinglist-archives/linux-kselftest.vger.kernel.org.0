Return-Path: <linux-kselftest+bounces-24872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D742A17F26
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A248418827DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD281B87DF;
	Tue, 21 Jan 2025 13:48:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E81494D9;
	Tue, 21 Jan 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467332; cv=none; b=Ac138RXA+TriTezyqnyU8Tn6B5R7suY4pUWMbxlTHTXkVgfeOY1Wsx3dV/zZxiA/mK1ecteUVxHSWO8Pi6ZjhJbuFrUKCLKwuDAZ+b7xlfKXxN4oUgWemAcYPzI48bZRz/Yf7Q2g0QhePd48UX+qTDb0ZD9PJih0o3Tw+5n1osQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467332; c=relaxed/simple;
	bh=/qfGRqYRtXainFiAusz+BGIU+zLb26wsJHWgFUDsy9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WY6abSG6yAp66FDcyjUWGhBgGVXo47XHxttSVUaseuxFIy6ncY7YJoqFqDeA2S79MCp49nq4FsBjIyHCQfPxYzMwuECgcYkNQy2W7F7A8hQ7YExCcixnffoHu6yMpBIyb29J7hiXbTx/rezPJVxkiOUJAoCFTPFjF/CHezrJgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcnzS5nYcz9v7Vg;
	Tue, 21 Jan 2025 21:26:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 238CE1407AB;
	Tue, 21 Jan 2025 21:48:37 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3LeCdpY9ntzoJAQ--.43731S2;
	Tue, 21 Jan 2025 14:48:36 +0100 (CET)
Message-ID: <fa52e3654a44dd250437ebe3e8397bff95399893.camel@huaweicloud.com>
Subject: Re: [PATCH v6 01/15] lib: Add TLV parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, mcgrof@kernel.org,
 petr.pavlu@suse.com, samitolvanen@google.com,  da.gomez@samsung.com,
 akpm@linux-foundation.org, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 21 Jan 2025 14:48:09 +0100
In-Reply-To: <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
	 <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3LeCdpY9ntzoJAQ--.43731S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJw4kAF4DWFW8KFWkZw4kXrb_yoWkJFykpa
	sxGF13Gr43Jw1xCr1agr43Jr1fXr4rWF1UKF18WryFvrsayr1kGr95Kry09rWxtryvkr4q
	ya4YqF9Ikrn8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGePR1QDvAAEsK

On Tue, 2025-01-21 at 14:29 +0100, Thomas Wei=C3=9Fschuh wrote:
> Hi Robert,
>=20
> On 2024-11-19 11:49:08+0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add a parser of a generic Type-Length-Value (TLV) format:
> >=20
> > +--------------+--+---------+--------+---------+
> > > field1 (u16) | len1 (u32) | value1 (u8 len1) |
> > +--------------+------------+------------------+
> > >     ...      |    ...     |        ...       |
> > +--------------+------------+------------------+
> > > fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> > +--------------+------------+------------------+
>=20
> Should mention that its big endian.

Ok.

> > Each adopter can define its own fields. The TLV parser does not need to=
 be
> > aware of those, but lets the adopter obtain the data and decide how to
>=20
> "adopter" -> "user".

Ok.

> > continue.
> >=20
> > After processing a TLV entry, call the callback function also with the
> > callback data provided by the adopter. The latter can decide how to
> > interpret the TLV entry depending on the field ID.
> >=20
> > Nesting TLVs is also possible, the callback function can call tlv_parse=
()
> > to parse the inner structure.
>=20
> Given that we already have the netlink data structures, helpers and
> infrastructure, what is the advantage over those?

Sorry, I'm not too familiar on how netlink works, so I might not
understand your point.

I think the benefit of this data structure is the retrocompatibility.
If you add new data fields, you don't need to introduce a v2, v3 data
format.

New versions of the parser can consume the new information, while the
older can still take the ones they are able to understand.

Thanks

Roberto

> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  MAINTAINERS                     |  8 +++
> >  include/linux/tlv_parser.h      | 32 ++++++++++++
> >  include/uapi/linux/tlv_parser.h | 41 ++++++++++++++++
> >  lib/Kconfig                     |  3 ++
> >  lib/Makefile                    |  2 +
> >  lib/tlv_parser.c                | 87 +++++++++++++++++++++++++++++++++
> >  lib/tlv_parser.h                | 18 +++++++
> >  7 files changed, 191 insertions(+)
> >  create mode 100644 include/linux/tlv_parser.h
> >  create mode 100644 include/uapi/linux/tlv_parser.h
> >  create mode 100644 lib/tlv_parser.c
> >  create mode 100644 lib/tlv_parser.h
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a097afd76ded..1f7ffa1c9dbd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23388,6 +23388,14 @@ W:	http://sourceforge.net/projects/tlan/
> >  F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
> >  F:	drivers/net/ethernet/ti/tlan.*
> > =20
> > +TLV PARSER
> > +M:	Roberto Sassu <roberto.sassu@huawei.com>
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Maintained
> > +F:	include/linux/tlv_parser.h
> > +F:	include/uapi/linux/tlv_parser.h
> > +F:	lib/tlv_parser.*
> > +
> >  TMIO/SDHI MMC DRIVER
> >  M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
> >  L:	linux-mmc@vger.kernel.org
> > diff --git a/include/linux/tlv_parser.h b/include/linux/tlv_parser.h
> > new file mode 100644
> > index 000000000000..0c72742af548
> > --- /dev/null
> > +++ b/include/linux/tlv_parser.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * Header file of TLV parser.
> > + */
> > +
> > +#ifndef _LINUX_TLV_PARSER_H
> > +#define _LINUX_TLV_PARSER_H
> > +
> > +#include <uapi/linux/tlv_parser.h>
> > +
> > +/**
> > + * typedef callback - Callback after parsing TLV entry
> > + * @callback_data: Opaque data to supply to the callback function
> > + * @field: Field identifier
> > + * @field_data: Field data
> > + * @field_len: Length of @field_data
> > + *
> > + * This callback is invoked after a TLV entry is parsed.
> > + *
> > + * Return: Zero on success, a negative value on error.
>=20
> It's not explained what happens on error.
>=20
> > + */
> > +typedef int (*callback)(void *callback_data, __u16 field,
> > +			const __u8 *field_data, __u32 field_len);
>=20
> No need for __underscore types in kernel-only signatures.
>=20
> > +
> > +int tlv_parse(callback callback, void *callback_data, const __u8 *data=
,
> > +	      size_t data_len, const char **fields, __u32 num_fields);
> > +
> > +#endif /* _LINUX_TLV_PARSER_H */
> > diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_p=
arser.h
> > new file mode 100644
> > index 000000000000..171d0cfd2c4c
> > --- /dev/null
> > +++ b/include/uapi/linux/tlv_parser.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * Implement the user space interface for the TLV parser.
> > + */
>=20
> Can you explain in the commit message where this will be exposed to
> userspace as binary?
>=20
> > +
> > +#ifndef _UAPI_LINUX_TLV_PARSER_H
> > +#define _UAPI_LINUX_TLV_PARSER_H
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * TLV format:
> > + *
> > + * +--------------+--+---------+--------+---------+
> > + * | field1 (u16) | len1 (u32) | value1 (u8 len1) |
> > + * +--------------+------------+------------------+
> > + * |     ...      |    ...     |        ...       |
> > + * +--------------+------------+------------------+
> > + * | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> > + * +--------------+------------+------------------+
> > + */
> > +
> > +/**
> > + * struct tlv_entry - Entry of TLV format
> > + * @field: Field identifier
> > + * @length: Data length
> > + * @data: Data
> > + *
> > + * This structure represents an entry of the TLV format.
> > + */
> > +struct tlv_entry {
> > +	__u16 field;
> > +	__u32 length;
>=20
> Use __be16 and __be32 here.
>=20
> > +	__u8 data[];
>=20
> __counted_by()?
> Not sure how this interacts with __be.
>=20
> > +} __attribute__((packed));
> > +
> > +#endif /* _UAPI_LINUX_TLV_PARSER_H */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index b38849af6f13..9141dcfc1704 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -777,3 +777,6 @@ config POLYNOMIAL
> > =20
> >  config FIRMWARE_TABLE
> >  	bool
> > +
> > +config TLV_PARSER
> > +	bool
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 773adf88af41..630de494eab5 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -393,5 +393,7 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kun=
it.o
> >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> > =20
> >  obj-$(CONFIG_FIRMWARE_TABLE) +=3D fw_table.o
> > +obj-$(CONFIG_TLV_PARSER) +=3D tlv_parser.o
> > +CFLAGS_tlv_parser.o +=3D -I lib
>=20
> Does this work with out of tree builds?
>=20
> > =20
> >  subdir-$(CONFIG_FORTIFY_SOURCE) +=3D test_fortify
> > diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
> > new file mode 100644
> > index 000000000000..dbbe08018b4d
> > --- /dev/null
> > +++ b/lib/tlv_parser.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * Implement the TLV parser.
> > + */
> > +
> > +#define pr_fmt(fmt) "tlv_parser: "fmt
> > +#include <tlv_parser.h>
>=20
> This should be "tlv_parser.h",
> but the header files looks unnecessary in the first place.
>=20
> > +
> > +/**
> > + * tlv_parse - Parse TLV data
> > + * @callback: Callback function to call to parse the entries
> > + * @callback_data: Opaque data to supply to the callback function
> > + * @data: Data to parse
> > + * @data_len: Length of @data
> > + * @fields: Array of field strings
> > + * @num_fields: Number of elements of @fields
> > + *
> > + * Parse the TLV data format and call the supplied callback function f=
or each
> > + * entry, passing also the opaque data pointer.
> > + *
> > + * The callback function decides how to process data depending on the =
field.
>=20
> Mention that a callback return an error will abort the whole parsing.
>=20
> > + *
> > + * Return: Zero on success, a negative value on error.
> > + */
> > +int tlv_parse(callback callback, void *callback_data, const __u8 *data=
,
> > +	      size_t data_len, const char **fields, __u32 num_fields)
>=20
> No need for __underscore types in kernel-only functions.
>=20
> "num_fields" and "fields" are accessed without checking for validity.
>=20
> "fields" is only every used for debug logging, so can be removed.
> "num_fields" probably, too.
>=20
> > +{
> > +	const __u8 *data_ptr =3D data;
> > +	struct tlv_entry *entry;
>=20
> This comes from the input data, should also be const.
>=20
> > +	__u16 parsed_field;
> > +	__u32 len;
>=20
> field_len
>=20
> > +	int ret;
> > +
> > +	if (data_len > U32_MAX) {
> > +		pr_debug("Data too big, size: %zd\n", data_len);
> > +		return -E2BIG;
> > +	}
> > +
> > +	while (data_len) {
> > +		if (data_len < sizeof(*entry))
> > +			return -EBADMSG;
> > +
> > +		entry =3D (struct tlv_entry *)data_ptr;
> > +		data_ptr +=3D sizeof(*entry);
> > +		data_len -=3D sizeof(*entry);
> > +
> > +		parsed_field =3D __be16_to_cpu(entry->field);
>=20
> This doesn't seem to handle invalid alignment, some architectures will
> trap unaligned accesses.
> Depending on the size and usage patterns it may make sense to document
> some alignment recommendations/requirements.
> (Not sure how big of a performance difference it would make)
>=20
> > +		if (parsed_field >=3D num_fields) {
> > +			pr_debug("Invalid field %u, max: %u\n",
> > +				 parsed_field, num_fields - 1);
> > +			return -EBADMSG;
> > +		}
> > +
> > +		len =3D __be32_to_cpu(entry->length);
> > +
> > +		if (data_len < len)
> > +			return -EBADMSG;
> > +
> > +		pr_debug("Data: field: %s, len: %u\n", fields[parsed_field],
> > +			 len);
> > +
> > +		if (!len)
> > +			continue;
>=20
> Empty fields are discarded silently, is this intentional?
> It should be documented. Those fields could be useful for flag data.
>=20
> > +
> > +		ret =3D callback(callback_data, parsed_field, data_ptr, len);
> > +		if (ret < 0) {
> > +			pr_debug("Parsing of field %s failed, ret: %d\n",
> > +				 fields[parsed_field], ret);
> > +			return ret;
> > +		}
> > +
> > +		data_ptr +=3D len;
> > +		data_len -=3D len;
> > +	}
> > +
> > +	if (data_len) {
>=20
> Can this ever happen?
> The check at the beginning of the loop should have caught it already.
>=20
> > +		pr_debug("Excess data: %zu bytes\n", data_len);
> > +		return -EBADMSG;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tlv_parse);
>=20
> Some kunit tests would be great.
>=20
> > diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
> > new file mode 100644
> > index 000000000000..e663966deac5
> > --- /dev/null
> > +++ b/lib/tlv_parser.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * Header file of TLV parser.
> > + */
> > +
> > +#ifndef _LIB_TLV_PARSER_H
> > +#define _LIB_TLV_PARSER_H
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/err.h>
> > +#include <linux/limits.h>
> > +#include <linux/tlv_parser.h>
>=20
> The #includes should move to the .c file and the header be removed.
>=20
> > +
> > +#endif /* _LIB_TLV_PARSER_H */
> > --=20
> > 2.47.0.118.gfd3785337b
> >=20


