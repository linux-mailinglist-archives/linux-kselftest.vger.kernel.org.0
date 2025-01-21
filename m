Return-Path: <linux-kselftest+bounces-24871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1309A17ECF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8524F7A3BFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30F31F2396;
	Tue, 21 Jan 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UovvOZw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED01F193C;
	Tue, 21 Jan 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466163; cv=none; b=E7+j3ImrGRHS7HPrUgoTzVLVklyyy+thzWNRP2glFQD20hk29gRxhSbZxoOnqN1m/FliQkWcxSUKkJQrHtf6+foUFYrtkFlcYV7BIrn83ZYSm/guOigt18CnFANWhPWaVprC+bteP0ew1Ry3WgnZ7+X/Ynjady7z5yovNA8QQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466163; c=relaxed/simple;
	bh=9Q6yHTklC/n7S2+KGzlqYY9DqTQl9fDlBHLIvs1gGy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e96AlqAsMEEA9+SKtF13jwWWVoeRM5ls7wZaGGiPtdPkBuY8StXthjx3x+oA8KP36/EUDUARaUxd9NyWsK21y14gwybctJzMkhEr3d9mvAFL1+/3eS0YnKx/XCv5c7TuXQtlD5KhFPLLxyoHQqMV3iRWe06q+l7WROT2hm0GDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UovvOZw6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737466157;
	bh=9Q6yHTklC/n7S2+KGzlqYY9DqTQl9fDlBHLIvs1gGy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UovvOZw6FldbKmDHz8lTw5ToS/fBZthSGFNzP3dn33rQ6RrMSZFMoV2m3IILLXsgH
	 EkNKX3qJuWZF0lDMR1Lf4MqKfStjzc38o9eGzkLC1Y7XgrfoGu1sCszZOEUqaUtcf9
	 1khXCDCx/uux89PHHWc1d9YorIhVa+S4nkpRwo1E=
Date: Tue, 21 Jan 2025 14:29:17 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, corbet@lwn.net, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, akpm@linux-foundation.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com, pbrobinson@gmail.com, 
	zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, 
	jannh@google.com, dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com, 
	ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, kgold@linux.ibm.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 01/15] lib: Add TLV parser
Message-ID: <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>

Hi Robert,

On 2024-11-19 11:49:08+0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a parser of a generic Type-Length-Value (TLV) format:
> 
> +--------------+--+---------+--------+---------+
> | field1 (u16) | len1 (u32) | value1 (u8 len1) |
> +--------------+------------+------------------+
> |     ...      |    ...     |        ...       |
> +--------------+------------+------------------+
> | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> +--------------+------------+------------------+

Should mention that its big endian.

> Each adopter can define its own fields. The TLV parser does not need to be
> aware of those, but lets the adopter obtain the data and decide how to

"adopter" -> "user".

> continue.
> 
> After processing a TLV entry, call the callback function also with the
> callback data provided by the adopter. The latter can decide how to
> interpret the TLV entry depending on the field ID.
> 
> Nesting TLVs is also possible, the callback function can call tlv_parse()
> to parse the inner structure.

Given that we already have the netlink data structures, helpers and
infrastructure, what is the advantage over those?

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  MAINTAINERS                     |  8 +++
>  include/linux/tlv_parser.h      | 32 ++++++++++++
>  include/uapi/linux/tlv_parser.h | 41 ++++++++++++++++
>  lib/Kconfig                     |  3 ++
>  lib/Makefile                    |  2 +
>  lib/tlv_parser.c                | 87 +++++++++++++++++++++++++++++++++
>  lib/tlv_parser.h                | 18 +++++++
>  7 files changed, 191 insertions(+)
>  create mode 100644 include/linux/tlv_parser.h
>  create mode 100644 include/uapi/linux/tlv_parser.h
>  create mode 100644 lib/tlv_parser.c
>  create mode 100644 lib/tlv_parser.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a097afd76ded..1f7ffa1c9dbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23388,6 +23388,14 @@ W:	http://sourceforge.net/projects/tlan/
>  F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
>  F:	drivers/net/ethernet/ti/tlan.*
>  
> +TLV PARSER
> +M:	Roberto Sassu <roberto.sassu@huawei.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	include/linux/tlv_parser.h
> +F:	include/uapi/linux/tlv_parser.h
> +F:	lib/tlv_parser.*
> +
>  TMIO/SDHI MMC DRIVER
>  M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
>  L:	linux-mmc@vger.kernel.org
> diff --git a/include/linux/tlv_parser.h b/include/linux/tlv_parser.h
> new file mode 100644
> index 000000000000..0c72742af548
> --- /dev/null
> +++ b/include/linux/tlv_parser.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Header file of TLV parser.
> + */
> +
> +#ifndef _LINUX_TLV_PARSER_H
> +#define _LINUX_TLV_PARSER_H
> +
> +#include <uapi/linux/tlv_parser.h>
> +
> +/**
> + * typedef callback - Callback after parsing TLV entry
> + * @callback_data: Opaque data to supply to the callback function
> + * @field: Field identifier
> + * @field_data: Field data
> + * @field_len: Length of @field_data
> + *
> + * This callback is invoked after a TLV entry is parsed.
> + *
> + * Return: Zero on success, a negative value on error.

It's not explained what happens on error.

> + */
> +typedef int (*callback)(void *callback_data, __u16 field,
> +			const __u8 *field_data, __u32 field_len);

No need for __underscore types in kernel-only signatures.

> +
> +int tlv_parse(callback callback, void *callback_data, const __u8 *data,
> +	      size_t data_len, const char **fields, __u32 num_fields);
> +
> +#endif /* _LINUX_TLV_PARSER_H */
> diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
> new file mode 100644
> index 000000000000..171d0cfd2c4c
> --- /dev/null
> +++ b/include/uapi/linux/tlv_parser.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement the user space interface for the TLV parser.
> + */

Can you explain in the commit message where this will be exposed to
userspace as binary?

> +
> +#ifndef _UAPI_LINUX_TLV_PARSER_H
> +#define _UAPI_LINUX_TLV_PARSER_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * TLV format:
> + *
> + * +--------------+--+---------+--------+---------+
> + * | field1 (u16) | len1 (u32) | value1 (u8 len1) |
> + * +--------------+------------+------------------+
> + * |     ...      |    ...     |        ...       |
> + * +--------------+------------+------------------+
> + * | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> + * +--------------+------------+------------------+
> + */
> +
> +/**
> + * struct tlv_entry - Entry of TLV format
> + * @field: Field identifier
> + * @length: Data length
> + * @data: Data
> + *
> + * This structure represents an entry of the TLV format.
> + */
> +struct tlv_entry {
> +	__u16 field;
> +	__u32 length;

Use __be16 and __be32 here.

> +	__u8 data[];

__counted_by()?
Not sure how this interacts with __be.

> +} __attribute__((packed));
> +
> +#endif /* _UAPI_LINUX_TLV_PARSER_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b38849af6f13..9141dcfc1704 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -777,3 +777,6 @@ config POLYNOMIAL
>  
>  config FIRMWARE_TABLE
>  	bool
> +
> +config TLV_PARSER
> +	bool
> diff --git a/lib/Makefile b/lib/Makefile
> index 773adf88af41..630de494eab5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -393,5 +393,7 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>  
>  obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
> +obj-$(CONFIG_TLV_PARSER) += tlv_parser.o
> +CFLAGS_tlv_parser.o += -I lib

Does this work with out of tree builds?

>  
>  subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
> diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
> new file mode 100644
> index 000000000000..dbbe08018b4d
> --- /dev/null
> +++ b/lib/tlv_parser.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement the TLV parser.
> + */
> +
> +#define pr_fmt(fmt) "tlv_parser: "fmt
> +#include <tlv_parser.h>

This should be "tlv_parser.h",
but the header files looks unnecessary in the first place.

> +
> +/**
> + * tlv_parse - Parse TLV data
> + * @callback: Callback function to call to parse the entries
> + * @callback_data: Opaque data to supply to the callback function
> + * @data: Data to parse
> + * @data_len: Length of @data
> + * @fields: Array of field strings
> + * @num_fields: Number of elements of @fields
> + *
> + * Parse the TLV data format and call the supplied callback function for each
> + * entry, passing also the opaque data pointer.
> + *
> + * The callback function decides how to process data depending on the field.

Mention that a callback return an error will abort the whole parsing.

> + *
> + * Return: Zero on success, a negative value on error.
> + */
> +int tlv_parse(callback callback, void *callback_data, const __u8 *data,
> +	      size_t data_len, const char **fields, __u32 num_fields)

No need for __underscore types in kernel-only functions.

"num_fields" and "fields" are accessed without checking for validity.

"fields" is only every used for debug logging, so can be removed.
"num_fields" probably, too.

> +{
> +	const __u8 *data_ptr = data;
> +	struct tlv_entry *entry;

This comes from the input data, should also be const.

> +	__u16 parsed_field;
> +	__u32 len;

field_len

> +	int ret;
> +
> +	if (data_len > U32_MAX) {
> +		pr_debug("Data too big, size: %zd\n", data_len);
> +		return -E2BIG;
> +	}
> +
> +	while (data_len) {
> +		if (data_len < sizeof(*entry))
> +			return -EBADMSG;
> +
> +		entry = (struct tlv_entry *)data_ptr;
> +		data_ptr += sizeof(*entry);
> +		data_len -= sizeof(*entry);
> +
> +		parsed_field = __be16_to_cpu(entry->field);

This doesn't seem to handle invalid alignment, some architectures will
trap unaligned accesses.
Depending on the size and usage patterns it may make sense to document
some alignment recommendations/requirements.
(Not sure how big of a performance difference it would make)

> +		if (parsed_field >= num_fields) {
> +			pr_debug("Invalid field %u, max: %u\n",
> +				 parsed_field, num_fields - 1);
> +			return -EBADMSG;
> +		}
> +
> +		len = __be32_to_cpu(entry->length);
> +
> +		if (data_len < len)
> +			return -EBADMSG;
> +
> +		pr_debug("Data: field: %s, len: %u\n", fields[parsed_field],
> +			 len);
> +
> +		if (!len)
> +			continue;

Empty fields are discarded silently, is this intentional?
It should be documented. Those fields could be useful for flag data.

> +
> +		ret = callback(callback_data, parsed_field, data_ptr, len);
> +		if (ret < 0) {
> +			pr_debug("Parsing of field %s failed, ret: %d\n",
> +				 fields[parsed_field], ret);
> +			return ret;
> +		}
> +
> +		data_ptr += len;
> +		data_len -= len;
> +	}
> +
> +	if (data_len) {

Can this ever happen?
The check at the beginning of the loop should have caught it already.

> +		pr_debug("Excess data: %zu bytes\n", data_len);
> +		return -EBADMSG;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tlv_parse);

Some kunit tests would be great.

> diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
> new file mode 100644
> index 000000000000..e663966deac5
> --- /dev/null
> +++ b/lib/tlv_parser.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Header file of TLV parser.
> + */
> +
> +#ifndef _LIB_TLV_PARSER_H
> +#define _LIB_TLV_PARSER_H
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/limits.h>
> +#include <linux/tlv_parser.h>

The #includes should move to the .c file and the header be removed.

> +
> +#endif /* _LIB_TLV_PARSER_H */
> -- 
> 2.47.0.118.gfd3785337b
> 

