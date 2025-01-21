Return-Path: <linux-kselftest+bounces-24901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2EA18773
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C767A43D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D151F893F;
	Tue, 21 Jan 2025 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UAaiESDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854891F8907;
	Tue, 21 Jan 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495763; cv=none; b=fmTW46vOTiOB4O8fGAikePPl4FcoEbfqJHfYHC5MfYFLAsNSr3CnLVhjpOTrQfVGQUlHSYFOsXsSLmOsCtDaAnP+sXYD/XxnCwvjzqVAmtXM3eogTET2RUf7vbEga6Jb8+UVN9zCYUmIduJDt9DJ7uDflVLJIx3wBiA9nJhfNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495763; c=relaxed/simple;
	bh=n4RD4dubYEheuUHrbVhCJJ//W+/igb2v1YzPOqVxCQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC+4T2LTYZZZ4vnTSnkmAc52YP2K8gQj4+Jo6mozQLC7OHrggvJ+7q8OyB81nzvKy7SWwICEme1YWa1O0Hw6KAAbHB0LQmTqjMyN8AaWtx/rhjQBLI9nDGX0X7PagZ6SscznACwUOPZM+otgbnE3FKDG/g4/S/YzOSrjVMa3vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UAaiESDb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737495749;
	bh=n4RD4dubYEheuUHrbVhCJJ//W+/igb2v1YzPOqVxCQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAaiESDbbzPdmNmoLHqaSS32neGSY4I4ypNS43cOa1opJYbIFzp5lwCRIdBJAVUg1
	 SJ/flduuaUI2McTECmdux8LoW+AFAtJ4YYQarZbEhhxciSfztwrJAY4gnYGR1DKCnm
	 yvGK4nzYCbAgq6qyPhkj/UqjJ4HCwmc0d+ihxV5k=
Date: Tue, 21 Jan 2025 22:42:28 +0100
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
Message-ID: <74b5c88d-7ab6-49f2-9b96-ac96cb4daf6e@t-8ch.de>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
 <c316b1be-d18f-4bb0-8434-bcc9236619df@t-8ch.de>
 <b14358075fa56f7250d5c9000ab8ee181003ff13.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b14358075fa56f7250d5c9000ab8ee181003ff13.camel@huaweicloud.com>

On 2025-01-21 15:55:28+0100, Roberto Sassu wrote:
> On Tue, 2025-01-21 at 14:29 +0100, Thomas Weißschuh wrote:
> > On 2024-11-19 11:49:08+0100, Roberto Sassu wrote:

[..]

> > > +typedef int (*callback)(void *callback_data, __u16 field,
> > > +			const __u8 *field_data, __u32 field_len);
> > 
> > No need for __underscore types in kernel-only signatures.
> 
> It is just for convenience. I'm reusing the same file for the userspace
> counterpart digest-cache-tools. In that case, the parser is used for
> example to show the content of the digest list.

This reuse leads to quite some ugly constructs.
Given that the single function will be really simple after removing the
unnecessary parts, maybe two clean copies are easier.
One copy is needed for Frama-C anyways.

> > > +
> > > +int tlv_parse(callback callback, void *callback_data, const __u8 *data,
> > > +	      size_t data_len, const char **fields, __u32 num_fields);
> > > +
> > > +#endif /* _LINUX_TLV_PARSER_H */
> > > diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
> > > new file mode 100644
> > > index 000000000000..171d0cfd2c4c
> > > --- /dev/null
> > > +++ b/include/uapi/linux/tlv_parser.h
> > > @@ -0,0 +1,41 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/*
> > > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > > + *
> > > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > + *
> > > + * Implement the user space interface for the TLV parser.
> > > + */
> > 
> > Can you explain in the commit message where this will be exposed to
> > userspace as binary?
> 
> I see that my explanation is not ideal.
> 
> This is the format for data exchange between user space and kernel
> space, but it is still the kernel that reads and parses the TLV-
> formatted file for extracting the digests and adding them to the digest
> cache.

I figured that out :-)
It should be clear from the commit itself, though.

> > > +
> > > +#ifndef _UAPI_LINUX_TLV_PARSER_H
> > > +#define _UAPI_LINUX_TLV_PARSER_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/*
> > > + * TLV format:
> > > + *
> > > + * +--------------+--+---------+--------+---------+
> > > + * | field1 (u16) | len1 (u32) | value1 (u8 len1) |
> > > + * +--------------+------------+------------------+
> > > + * |     ...      |    ...     |        ...       |
> > > + * +--------------+------------+------------------+
> > > + * | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
> > > + * +--------------+------------+------------------+
> > > + */
> > > +
> > > +/**
> > > + * struct tlv_entry - Entry of TLV format
> > > + * @field: Field identifier
> > > + * @length: Data length
> > > + * @data: Data
> > > + *
> > > + * This structure represents an entry of the TLV format.
> > > + */
> > > +struct tlv_entry {
> > > +	__u16 field;
> > > +	__u32 length;

Looking at this again, the "length" field is unaligned by default.

Also FYI there is already a TLV implementation in
include/uapi/linux/tipc_config.

> > > +} __attribute__((packed));

[..]

> > Some kunit tests would be great.
> 
> I implemented kselftests also injecting errors (patch 13). If it is not
> enough, I implement kunit tests too.

These selftests are for the digest_cache.
If the TLV library is meant to be used alone, some dedicated tests would
be nice. kunit has the advantage that it can directly call kernel
functions with arbitrary parameters and does not require any userspace
setup.

