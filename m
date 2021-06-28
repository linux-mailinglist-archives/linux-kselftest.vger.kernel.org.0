Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E343B5A50
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhF1IRJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 04:17:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3322 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhF1IRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 04:17:09 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GD0ZG2Tw0z6FBMy;
        Mon, 28 Jun 2021 16:07:02 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 10:14:41 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 28 Jun 2021 10:14:41 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 04/12] digest_lists: Objects
Thread-Topic: [RFC][PATCH 04/12] digest_lists: Objects
Thread-Index: AQHXaeMQ882MDA2nPUO25iJDWY5SoqsnkMmAgAF5OpA=
Date:   Mon, 28 Jun 2021 08:14:41 +0000
Message-ID: <22fff08f1a70460da814d3f21b497f8b@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-5-roberto.sassu@huawei.com>
 <YNhZTR5VSin7ABZP@kroah.com>
In-Reply-To: <YNhZTR5VSin7ABZP@kroah.com>
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
> Sent: Sunday, June 27, 2021 12:56 PM
> On Fri, Jun 25, 2021 at 06:56:06PM +0200, Roberto Sassu wrote:
> > +++ b/security/integrity/digest_lists/digest_lists.h
> > @@ -0,0 +1,117 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2005,2006,2007,2008 IBM Corporation
> > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation, version 2 of the
> > + * License.
> > + *
> > + * File: digest_lists.h
> > + *      Unexported definitions for digest lists.
> 
> Unexported to whom?

Hi Greg

I meant not placed in include/linux.

> > + */
> > +
> > +#ifndef __DIGEST_LISTS_INTERNAL_H
> > +#define __DIGEST_LISTS_INTERNAL_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/crypto.h>
> > +#include <linux/fs.h>
> > +#include <linux/security.h>
> > +#include <linux/hash.h>
> > +#include <linux/tpm.h>
> > +#include <linux/audit.h>
> > +#include <crypto/hash_info.h>
> > +#include <linux/hash_info.h>
> > +#include <uapi/linux/digest_lists.h>
> > +
> > +#define MAX_DIGEST_SIZE	64
> > +#define HASH_BITS 10
> > +#define MEASURE_HTABLE_SIZE (1 << HASH_BITS)
> > +
> > +struct digest_list_item {
> > +	loff_t size;
> > +	u8 *buf;
> > +	u8 actions;
> > +	u8 digest[64];
> > +	enum hash_algo algo;
> > +	const char *label;
> > +};
> > +
> > +struct digest_list_item_ref {
> > +	struct digest_list_item *digest_list;
> > +	loff_t digest_offset;
> > +	loff_t hdr_offset;
> > +};
> > +
> > +struct digest_item {
> > +	/* hash table pointers */
> > +	struct hlist_node hnext;
> > +	/* digest list references (protected by RCU) */
> > +	struct digest_list_item_ref *refs;
> > +};
> > +
> > +struct h_table {
> > +	atomic_long_t len;
> 
> Why is this atomic?  Why would that matter?

Yes, it shouldn't be. There are not concurrent updates.

> > +	struct hlist_head queue[MEASURE_HTABLE_SIZE];
> > +};
> > +
> > +static inline unsigned int hash_key(u8 *digest)
> > +{
> > +	return (digest[0] | digest[1] << 8) % MEASURE_HTABLE_SIZE;
> > +}
> 
> Don't we have hashing functions in the kernel already?

We had a discussion before:

https://lore.kernel.org/linux-integrity/1587739544.5190.14.camel@linux.ibm.com/

It seems there is no real advantage in hashing a digest.

> > +
> > +static inline struct compact_list_hdr *get_hdr(
> > +					struct digest_list_item *digest_list,
> > +					loff_t hdr_offset)
> > +{
> > +	return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
> > +}
> 
> pointer math feels rough, are you shure you want to do this this way?

Maybe, I could change digest_list_item_ref to:

struct digest_list_item_ref {
	struct digest_list_item *digest_list;
	u8 *digest;
	struct compact_list_hdr *hdr;
};

where digest and hdr are calculated in the same way.

Or you have a different suggestion?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> greg k-h
