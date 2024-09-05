Return-Path: <linux-kselftest+bounces-17306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF996E11D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFD81C208F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C21A0717;
	Thu,  5 Sep 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvNIksMK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACC1494D9;
	Thu,  5 Sep 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557462; cv=none; b=RLM7lU38pZfOCXJ/w2cZ7c1Rju4aeks8PEZ2HgkyvoK28/a2QtSHQu5j9RVupl1UwJGaSuwZU5Gj+aHo27a7swt6noLjV72HQRgdU3Auyko4b6JQVGujENLvjyVj1GTy+s2KRV3G8p4U/1CHeV4h7KtM2LJNdqSTT2hhFNg2Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557462; c=relaxed/simple;
	bh=HPIB2NOZ2cj0QcyIJQRClO072T/yHAEBz3a0VdO5Uoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZZmypf9/I6MRq8ur2ltFZqeESgSlRpIfZ71cpt917vVkKxq0lK/fmNF2utYudrdv/6cuKeaCij9qucP0uIAmTXaTNQo2QXf75uDlIiQ7Q0JdMN/RXtq20/26ELqrPkZJyTEziI+JzLbkf8xyQuYgFjGJuqjbXjUtzlZ7CVrJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvNIksMK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725557460; x=1757093460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HPIB2NOZ2cj0QcyIJQRClO072T/yHAEBz3a0VdO5Uoo=;
  b=PvNIksMKTSqlI6tyrYCfNQ2EfgRHK0vczlq0hSmm9vpvIxbVjDk/5zRN
   1pBJWjDKZA9vN142MOrixvALk7Xch/k2ZIGLQEn/i59oD5CrFmOfEmkHX
   pTlhCdy3wuCWYzXV50x3FBlkzOEsN6UHlJzx14XWwl+SK0PKRvZ3GMmz4
   Zy1jcz1jZsIx4kVBj7ditcnET+aYCqS4+Fjxecddv/xRc/KAu14jwna2I
   bDBw7pk3C5D9yELVbuw/eGwLhDNekSgNcTG/HJqEAgGH2NZVT6Z4fHeDF
   Ob+sYiqS6bQ9UYbtB4ZNuUGMlt/bb+irz5nBHHErJmyCpj3KE9JqB/J2o
   w==;
X-CSE-ConnectionGUID: eK0w39gQSfSsbeBHX0xGnQ==
X-CSE-MsgGUID: ZRH4kWMMRnGdyMX1aTvqbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49706060"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49706060"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:30:58 -0700
X-CSE-ConnectionGUID: bxa5dc3uSu+CBJ1EvsYJPg==
X-CSE-MsgGUID: Bk/4/A7oTGmGQkSYxV7Vdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="96429588"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.216])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:30:48 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net,
 akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 01/14] lib: Add TLV parser
In-Reply-To: <20240905150543.3766895-2-roberto.sassu@huaweicloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
 <20240905150543.3766895-2-roberto.sassu@huaweicloud.com>
Date: Thu, 05 Sep 2024 20:30:44 +0300
Message-ID: <87ikvaovnf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 05 Sep 2024, Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add a parser of a generic Type-Length-Value (TLV) format:
>
> +-----------------+------------------+-----------------+
> | data type (u64) | num fields (u64) | total len (u64) | # header
> +--------------+--+---------+--------+---------+-------+
> | field1 (u64) | len1 (u64) | value1 (u8 len1) |
> +--------------+------------+------------------+
> |     ...      |    ...     |        ...       |         # data
> +--------------+------------+------------------+
> | fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
> +--------------+------------+------------------+

Okay, take this with a grain of salt. I'm actually not interested in
your use case, but the generic part here. But hear me out.

Why do you need to have num fields in the header? I'd think the generic
TLV would have tag/length/value, where value may contain more TLV, or
not, depending on the use case specific tag. The same parser can parse
everything recursively, with no special handling for headers. To me,
that's the great part about TLV.

Also, making generic TLV have u64 tag and length is huge waste in most
use cases. Saving one byte requires 16 bytes of tag and length. You
could encode tag and length with UTF-8. Sure, it's wasteful if you need
an enormous amount of tags or huge lengths, but it's efficient for most
use cases.

Anyway, just my thoughts.


BR,
Jani.

>
> [same as above, repeated N times]
>
> Each adopter can define its own data types and fields. The TLV parser does
> not need to be aware of those, but lets the adopter obtain the data and
> decide how to continue.
>
> After parsing each TLV header, call the header callback function with the
> callback data provided by the adopter. The latter can return 0, to skip
> processing of the TLV data, 1 to process the TLV data, or a negative value
> to stop processing the TLV data.
>
> After processing a TLV data entry, call the data callback function also
> with the callback data provided by the adopter. The latter can decide how
> to interpret the TLV data entry depending on the field ID.
>
> Nesting TLVs is also possible, the data callback function can call
> tlv_parse() to parse the inner structure.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  MAINTAINERS                     |   8 ++
>  include/linux/tlv_parser.h      |  48 +++++++
>  include/uapi/linux/tlv_parser.h |  62 +++++++++
>  lib/Kconfig                     |   3 +
>  lib/Makefile                    |   2 +
>  lib/tlv_parser.c                | 221 ++++++++++++++++++++++++++++++++
>  lib/tlv_parser.h                |  17 +++
>  7 files changed, 361 insertions(+)
>  create mode 100644 include/linux/tlv_parser.h
>  create mode 100644 include/uapi/linux/tlv_parser.h
>  create mode 100644 lib/tlv_parser.c
>  create mode 100644 lib/tlv_parser.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8766f3e5e87e..ba8d5c137bef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23055,6 +23055,14 @@ W:	http://sourceforge.net/projects/tlan/
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
> index 000000000000..6d9a655d9ec9
> --- /dev/null
> +++ b/include/linux/tlv_parser.h
> @@ -0,0 +1,48 @@
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
> + * typedef hdr_callback - Callback after parsing TLV header
> + * @callback_data: Opaque data to supply to the header callback function
> + * @data_type: TLV data type
> + * @num_entries: Number of TLV data entries
> + * @total_len: Total length of TLV data
> + *
> + * This callback is invoked after a TLV header is parsed.
> + *
> + * Return: 0 to skip processing, 1 to do processing, a negative value on error.
> + */
> +typedef int (*hdr_callback)(void *callback_data, __u64 data_type,
> +			    __u64 num_entries, __u64 total_len);
> +
> +/**
> + * typedef data_callback - Callback after parsing TLV data entry
> + * @callback_data: Opaque data to supply to the data callback function
> + * @field: TLV field ID
> + * @field_data: Data of a TLV data field
> + * @field_len: Length of @field_data
> + *
> + * This callback is invoked after a TLV data entry is parsed.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +typedef int (*data_callback)(void *callback_data, __u64 field,
> +			     const __u8 *field_data, __u64 field_len);
> +
> +int tlv_parse(hdr_callback hdr_callback, void *hdr_callback_data,
> +	      data_callback data_callback, void *data_callback_data,
> +	      const __u8 *data, size_t data_len, const char **data_types,
> +	      __u64 num_data_types, const char **fields, __u64 num_fields);
> +
> +#endif /* _LINUX_TLV_PARSER_H */
> diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
> new file mode 100644
> index 000000000000..fbd4fc403ac7
> --- /dev/null
> +++ b/include/uapi/linux/tlv_parser.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement the user space interface for the TLV parser.
> + */
> +
> +#ifndef _UAPI_LINUX_TLV_PARSER_H
> +#define _UAPI_LINUX_TLV_PARSER_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * TLV format:
> + *
> + * +-----------------+------------------+-----------------+
> + * | data type (u64) | num fields (u64) | total len (u64) | # header
> + * +--------------+--+---------+--------+---------+-------+
> + * | field1 (u64) | len1 (u64) | value1 (u8 len1) |
> + * +--------------+------------+------------------+
> + * |     ...      |    ...     |        ...       |         # data
> + * +--------------+------------+------------------+
> + * | fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
> + * +--------------+------------+------------------+
> + *
> + * [same as above, repeated N times]
> + *
> + */
> +
> +/**
> + * struct tlv_hdr - Header of TLV format
> + * @data_type: Type of data to parse
> + * @num_entries: Number of data entries provided
> + * @_reserved: Reserved for future use (must be equal to zero)
> + * @total_len: Total length of the data blob, excluding the header
> + *
> + * This structure represents the header of the TLV data format.
> + */
> +struct tlv_hdr {
> +	__u64 data_type;
> +	__u64 num_entries;
> +	__u64 _reserved;
> +	__u64 total_len;
> +} __attribute__((packed));
> +
> +/**
> + * struct tlv_data_entry - Data entry of TLV format
> + * @field: Data field identifier
> + * @length: Data length
> + * @data: Data
> + *
> + * This structure represents a TLV data entry.
> + */
> +struct tlv_data_entry {
> +	__u64 field;
> +	__u64 length;
> +	__u8 data[];
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
> index 322bb127b4dc..c6c3614c4293 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -392,6 +392,8 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>  
>  obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
> +obj-$(CONFIG_TLV_PARSER) += tlv_parser.o
> +CFLAGS_tlv_parser.o += -I lib
>  
>  # FORTIFY_SOURCE compile-time behavior tests
>  TEST_FORTIFY_SRCS = $(wildcard $(src)/test_fortify/*-*.c)
> diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
> new file mode 100644
> index 000000000000..5d54844ab8d7
> --- /dev/null
> +++ b/lib/tlv_parser.c
> @@ -0,0 +1,221 @@
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
> +
> +/**
> + * tlv_parse_hdr - Parse TLV header
> + * @hdr_callback: Callback function to call after parsing header
> + * @hdr_callback_data: Opaque data to supply to the header callback function
> + * @data: Data to parse (updated)
> + * @data_len: Length of @data (updated)
> + * @parsed_num_entries: Parsed number of data entries (updated)
> + * @parsed_total_len: Parsed length of TLV data, excluding the header (updated)
> + * @data_types: Array of data type strings
> + * @num_data_types: Number of elements of @data_types
> + *
> + * Parse the header of the TLV data format, move the data pointer to the TLV
> + * data part, decrease the data length by the length of the header, and provide
> + * the number of entries and the total data length extracted from the header.
> + *
> + * Before returning, call the header callback to let the callback supplier
> + * decide whether or not to process the subsequent TLV data.
> + *
> + * Return: 1 to process the data entries, 0 to skip, a negative value on error.
> + */
> +static int tlv_parse_hdr(hdr_callback hdr_callback, void *hdr_callback_data,
> +			 const __u8 **data, size_t *data_len,
> +			 __u64 *parsed_num_entries, __u64 *parsed_total_len,
> +			 const char **data_types, __u64 num_data_types)
> +{
> +	__u64 parsed_data_type;
> +	struct tlv_hdr *hdr;
> +
> +	if (*data_len < sizeof(*hdr)) {
> +		pr_debug("Data blob too short, %lu bytes, expected %lu\n",
> +			 *data_len, sizeof(*hdr));
> +		return -EBADMSG;
> +	}
> +
> +	hdr = (struct tlv_hdr *)*data;
> +
> +	*data += sizeof(*hdr);
> +	*data_len -= sizeof(*hdr);
> +
> +	parsed_data_type = __be64_to_cpu(hdr->data_type);
> +	if (parsed_data_type >= num_data_types) {
> +		pr_debug("Invalid data type %llu, max: %llu\n",
> +			 parsed_data_type, num_data_types - 1);
> +		return -EBADMSG;
> +	}
> +
> +	*parsed_num_entries = __be64_to_cpu(hdr->num_entries);
> +
> +	if (hdr->_reserved != 0) {
> +		pr_debug("_reserved must be zero\n");
> +		return -EBADMSG;
> +	}
> +
> +	*parsed_total_len = __be64_to_cpu(hdr->total_len);
> +	if (*parsed_total_len > *data_len) {
> +		pr_debug("Invalid total length %llu, expected: %lu\n",
> +			 *parsed_total_len, *data_len);
> +		return -EBADMSG;
> +	}
> +
> +	pr_debug("Header: type: %s, num entries: %llu, total len: %lld\n",
> +		 data_types[parsed_data_type], *parsed_num_entries,
> +		 *parsed_total_len);
> +
> +	return hdr_callback(hdr_callback_data, parsed_data_type,
> +			    *parsed_num_entries, *parsed_total_len);
> +}
> +
> +/**
> + * tlv_parse_data - Parse TLV data
> + * @data_callback: Callback function to call to parse the data entries
> + * @data_callback_data: Opaque data to supply to the data callback function
> + * @num_entries: Number of data entries to parse
> + * @data: Data to parse
> + * @data_len: Length of @data
> + * @fields: Array of field strings
> + * @num_fields: Number of elements of @fields
> + *
> + * Parse the data part of the TLV data format and call the supplied callback
> + * function for each data entry, passing also the opaque data pointer.
> + *
> + * The data callback function decides how to process data depending on the
> + * field.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +static int tlv_parse_data(data_callback data_callback, void *data_callback_data,
> +			  __u64 num_entries, const __u8 *data, size_t data_len,
> +			  const char **fields, __u64 num_fields)
> +{
> +	const __u8 *data_ptr = data;
> +	struct tlv_data_entry *entry;
> +	__u64 parsed_field, len, i, max_num_entries;
> +	int ret;
> +
> +	max_num_entries = data_len / sizeof(*entry);
> +
> +	/* Possibly lower limit on num_entries loop. */
> +	if (num_entries > max_num_entries)
> +		return -EBADMSG;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		if (data_len < sizeof(*entry))
> +			return -EBADMSG;
> +
> +		entry = (struct tlv_data_entry *)data_ptr;
> +		data_ptr += sizeof(*entry);
> +		data_len -= sizeof(*entry);
> +
> +		parsed_field = __be64_to_cpu(entry->field);
> +		if (parsed_field >= num_fields) {
> +			pr_debug("Invalid field %llu, max: %llu\n",
> +				 parsed_field, num_fields - 1);
> +			return -EBADMSG;
> +		}
> +
> +		len = __be64_to_cpu(entry->length);
> +
> +		if (data_len < len)
> +			return -EBADMSG;
> +
> +		pr_debug("Data: field: %s, len: %llu\n", fields[parsed_field],
> +			 len);
> +
> +		if (!len)
> +			continue;
> +
> +		ret = data_callback(data_callback_data, parsed_field, data_ptr,
> +				    len);
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
> +		pr_debug("Excess data: %lu bytes\n", data_len);
> +		return -EBADMSG;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * tlv_parse - Parse data in TLV format
> + * @hdr_callback: Callback function to call after parsing header
> + * @hdr_callback_data: Opaque data to supply to the header callback function
> + * @data_callback: Callback function to call to parse the data entries
> + * @data_callback_data: Opaque data to supply to the data callback function
> + * @data: Data to parse
> + * @data_len: Length of @data
> + * @data_types: Array of data type strings
> + * @num_data_types: Number of elements of @data_types
> + * @fields: Array of field strings
> + * @num_fields: Number of elements of @fields
> + *
> + * Parse data in TLV format and call tlv_parse_data() each time tlv_parse_hdr()
> + * returns 1.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +int tlv_parse(hdr_callback hdr_callback, void *hdr_callback_data,
> +	      data_callback data_callback, void *data_callback_data,
> +	      const __u8 *data, size_t data_len, const char **data_types,
> +	      __u64 num_data_types, const char **fields, __u64 num_fields)
> +{
> +	__u64 parsed_num_entries, parsed_total_len;
> +	const __u8 *data_ptr = data;
> +	int ret = 0;
> +
> +	pr_debug("Start parsing data blob, size: %lu\n", data_len);
> +
> +	while (data_len) {
> +		ret = tlv_parse_hdr(hdr_callback, hdr_callback_data, &data_ptr,
> +				    &data_len, &parsed_num_entries,
> +				    &parsed_total_len, data_types,
> +				    num_data_types);
> +		switch (ret) {
> +		case 0:
> +			/*
> +			 * tlv_parse_hdr() already checked that
> +			 * parsed_total_len <= data_len.
> +			 */
> +			data_ptr += parsed_total_len;
> +			data_len -= parsed_total_len;
> +			continue;
> +		case 1:
> +			break;
> +		default:
> +			goto out;
> +		}
> +
> +		ret = tlv_parse_data(data_callback, data_callback_data,
> +				     parsed_num_entries, data_ptr,
> +				     parsed_total_len, fields, num_fields);
> +		if (ret < 0)
> +			goto out;
> +
> +		data_ptr += parsed_total_len;
> +		data_len -= parsed_total_len;
> +	}
> +out:
> +	pr_debug("End of parsing data blob, ret: %d\n", ret);
> +	return ret;
> +}
> diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
> new file mode 100644
> index 000000000000..8fa8127bd13e
> --- /dev/null
> +++ b/lib/tlv_parser.h
> @@ -0,0 +1,17 @@
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
> +#include <linux/tlv_parser.h>
> +
> +#endif /* _LIB_TLV_PARSER_H */

-- 
Jani Nikula, Intel

