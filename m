Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621523B52E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Jun 2021 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhF0K6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Jun 2021 06:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhF0K6j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Jun 2021 06:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A630B61C32;
        Sun, 27 Jun 2021 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624791375;
        bh=xs0Ga7yyhZsNXROXIVVWoDIcx1qs2TkJkZ9M6S2q3is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeJiaGforAIEgOuVUs2OVikq7+3xW61O85Ga3O1dPpmiRD2Zcz4M+67mPufmkraj7
         H+//MUoPUWptI9mbUvsWeiSFyrpTvRGJRTEpZOB+K9FsMH8oIYNvPrSMSiHoRio961
         Zp332abaAzcYgbzLcGV2RBxsqwl4KDYv7cGidx8c=
Date:   Sun, 27 Jun 2021 12:56:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 04/12] digest_lists: Objects
Message-ID: <YNhZTR5VSin7ABZP@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625165614.2284243-5-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 25, 2021 at 06:56:06PM +0200, Roberto Sassu wrote:
> +++ b/security/integrity/digest_lists/digest_lists.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2005,2006,2007,2008 IBM Corporation
> + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + * File: digest_lists.h
> + *      Unexported definitions for digest lists.

Unexported to whom?

> + */
> +
> +#ifndef __DIGEST_LISTS_INTERNAL_H
> +#define __DIGEST_LISTS_INTERNAL_H
> +
> +#include <linux/types.h>
> +#include <linux/crypto.h>
> +#include <linux/fs.h>
> +#include <linux/security.h>
> +#include <linux/hash.h>
> +#include <linux/tpm.h>
> +#include <linux/audit.h>
> +#include <crypto/hash_info.h>
> +#include <linux/hash_info.h>
> +#include <uapi/linux/digest_lists.h>
> +
> +#define MAX_DIGEST_SIZE	64
> +#define HASH_BITS 10
> +#define MEASURE_HTABLE_SIZE (1 << HASH_BITS)
> +
> +struct digest_list_item {
> +	loff_t size;
> +	u8 *buf;
> +	u8 actions;
> +	u8 digest[64];
> +	enum hash_algo algo;
> +	const char *label;
> +};
> +
> +struct digest_list_item_ref {
> +	struct digest_list_item *digest_list;
> +	loff_t digest_offset;
> +	loff_t hdr_offset;
> +};
> +
> +struct digest_item {
> +	/* hash table pointers */
> +	struct hlist_node hnext;
> +	/* digest list references (protected by RCU) */
> +	struct digest_list_item_ref *refs;
> +};
> +
> +struct h_table {
> +	atomic_long_t len;

Why is this atomic?  Why would that matter?

> +	struct hlist_head queue[MEASURE_HTABLE_SIZE];
> +};
> +
> +static inline unsigned int hash_key(u8 *digest)
> +{
> +	return (digest[0] | digest[1] << 8) % MEASURE_HTABLE_SIZE;
> +}

Don't we have hashing functions in the kernel already?

> +
> +static inline struct compact_list_hdr *get_hdr(
> +					struct digest_list_item *digest_list,
> +					loff_t hdr_offset)
> +{
> +	return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
> +}

pointer math feels rough, are you shure you want to do this this way?

thanks,

greg k-h
