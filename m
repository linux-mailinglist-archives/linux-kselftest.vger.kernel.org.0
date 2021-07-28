Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBA3D8DF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhG1MgH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234683AbhG1MgH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:36:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C8F06023D;
        Wed, 28 Jul 2021 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475765;
        bh=r00I02wm4ZOvXi0RFopUbrsdEof20KsRLXvMm9FeprE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4Gt2KUwGcH3qJW3qI7g6+yTuslhkBomBmR5dXAIbGvvgl11KFnB8aKlZkAEzVmMm
         R4HJq9kU3YWh9uaFGHPG6DjjRPldypeyKQjOwrSp2T07iikEIYwHchKCG2UcHO2Fxw
         LwqhJBqkil8AlHUQAd/XkShuZPzFPhQF5v4QVWgnfuaVDhdYA2sCx62YZgB2knnwJj
         JW28GtcXdRJS3LlbfDaK33/kxtbpd+X3XSaFLKAeO+naDWbODEhLPSyUqvVEgcalUT
         MgxquwA4WecbBiRFARiRZCSNsC6ji6h54Kwt7f1uOBbd57gbv/0hkvtKHgrZtnoN0N
         qPjpUElCcpUEg==
Date:   Wed, 28 Jul 2021 14:35:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 05/12] diglim: Parser
Message-ID: <20210728143558.3eec1c93@sal.lan>
In-Reply-To: <20210726163700.2092768-6-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-6-roberto.sassu@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon, 26 Jul 2021 18:36:53 +0200
Roberto Sassu <roberto.sassu@huawei.com> escreveu:

> Introduce the necessary functions to parse a digest list and to execute the
> requested operation.
> 
> The main function is digest_list_parse(), which coordinates the various
> steps required to add or delete a digest list, and has the logic to roll
> back when one of the steps fails.
> 
> A more detailed description about the steps can be found in
> Documentation/security/diglim/implementation.rst

LGTM.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../security/diglim/implementation.rst        |  35 +++
>  MAINTAINERS                                   |   1 +
>  security/integrity/diglim/Makefile            |   2 +-
>  security/integrity/diglim/diglim.h            |   3 +
>  security/integrity/diglim/parser.c            | 274 ++++++++++++++++++
>  5 files changed, 314 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/diglim/parser.c
> 
> diff --git a/Documentation/security/diglim/implementation.rst b/Documentation/security/diglim/implementation.rst
> index 54af23b2f5f1..9d679567a037 100644
> --- a/Documentation/security/diglim/implementation.rst
> +++ b/Documentation/security/diglim/implementation.rst
> @@ -209,3 +209,38 @@ This section introduces the methods requires to manage the three objects
>  defined.
>  
>  .. kernel-doc:: security/integrity/diglim/methods.c
> +
> +
> +Parser
> +------
> +
> +This section introduces the necessary functions to parse a digest list and
> +to execute the requested operation.
> +
> +.. kernel-doc:: security/integrity/diglim/parser.c
> +
> +The main function is digest_list_parse(), which coordinates the various
> +steps required to add or delete a digest list, and has the logic to roll
> +back when one of the steps fails.
> +
> +#. Calls digest_list_validate() to validate the passed buffer containing
> +   the digest list to ensure that the format is correct.
> +
> +#. Calls get_digest_list() to create a new digest_list_item for the add
> +   operation, or to retrieve the existing one for the delete operation.
> +   get_digest_list() refuses to add digest lists that were previously
> +   added and to delete digest lists that weren't previously added. Also,
> +   get_digest_list() refuses to delete digest lists if there are actions
> +   done at addition time that are not currently being performed (it would
> +   guarantee that also deletion is notified to remote verifiers).
> +
> +#. Calls _digest_list_parse() which takes the created/retrieved
> +   struct digest_list_item and adds or delete the digests included in the
> +   digest list.
> +
> +#. If an error occurred, performs a rollback to the previous state, by
> +   calling _digest_list_parse() with the opposite operation and the buffer
> +   size at the time the error occurred.
> +
> +#. digest_list_parse() deletes the struct digest_list_item on unsuccessful
> +   add or successful delete.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e085a36654a..77c3613c600a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5465,6 +5465,7 @@ F:	include/linux/diglim.h
>  F:	include/uapi/linux/diglim.h
>  F:	security/integrity/diglim/diglim.h
>  F:	security/integrity/diglim/methods.c
> +F:	security/integrity/diglim/parser.c
>  
>  DIOLAN U2C-12 I2C DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
> diff --git a/security/integrity/diglim/Makefile b/security/integrity/diglim/Makefile
> index b761ed8cfb3e..34e4e154fff3 100644
> --- a/security/integrity/diglim/Makefile
> +++ b/security/integrity/diglim/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_DIGLIM) += diglim.o
>  
> -diglim-y := methods.o
> +diglim-y := methods.o parser.o
> diff --git a/security/integrity/diglim/diglim.h b/security/integrity/diglim/diglim.h
> index 25851e7d4906..3adc218a0325 100644
> --- a/security/integrity/diglim/diglim.h
> +++ b/security/integrity/diglim/diglim.h
> @@ -149,4 +149,7 @@ struct digest_item *digest_list_add(u8 *digest, enum hash_algo algo,
>  				    const char *label);
>  void digest_list_del(u8 *digest, enum hash_algo algo, u8 actions,
>  		     struct digest_list_item *digest_list);
> +
> +int digest_list_parse(loff_t size, void *buf, enum ops op, u8 actions,
> +		      u8 *digest, enum hash_algo algo, const char *label);
>  #endif /*__DIGLIM_INTERNAL_H*/
> diff --git a/security/integrity/diglim/parser.c b/security/integrity/diglim/parser.c
> new file mode 100644
> index 000000000000..89a48945b460
> --- /dev/null
> +++ b/security/integrity/diglim/parser.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2005,2006,2007,2008 IBM Corporation
> + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Functions to parse digest lists.
> + */
> +
> +#include <linux/vmalloc.h>
> +#include <linux/module.h>
> +
> +#include "diglim.h"
> +#include "../integrity.h"
> +
> +/**
> + * digest_list_validate - validate format of digest list
> + * @size: buffer size
> + * @buf: buffer containing the digest list
> + *
> + * This function validates the format of the passed digest list.
> + *
> + * Return: 0 if the digest list was successfully validated, -EINVAL otherwise.
> + */
> +static int digest_list_validate(loff_t size, void *buf)
> +{
> +	void *bufp = buf, *bufendp = buf + size;
> +	struct compact_list_hdr *hdr;
> +	size_t digest_len;
> +
> +	while (bufp < bufendp) {
> +		if (bufp + sizeof(*hdr) > bufendp) {
> +			pr_err("invalid data\n");
> +			return -EINVAL;
> +		}
> +
> +		hdr = bufp;
> +
> +		if (hdr->version != 1) {
> +			pr_err("unsupported version\n");
> +			return -EINVAL;
> +		}
> +
> +		if (hdr->_reserved != 0) {
> +			pr_err("unexpected value for _reserved field\n");
> +			return -EINVAL;
> +		}
> +
> +		hdr->type = le16_to_cpu(hdr->type);
> +		hdr->modifiers = le16_to_cpu(hdr->modifiers);
> +		hdr->algo = le16_to_cpu(hdr->algo);
> +		hdr->count = le32_to_cpu(hdr->count);
> +		hdr->datalen = le32_to_cpu(hdr->datalen);
> +
> +		if (hdr->algo >= HASH_ALGO__LAST) {
> +			pr_err("invalid hash algorithm\n");
> +			return -EINVAL;
> +		}
> +
> +		digest_len = hash_digest_size[hdr->algo];
> +
> +		if (hdr->type >= COMPACT__LAST ||
> +		    hdr->type == COMPACT_DIGEST_LIST) {
> +			pr_err("invalid type %d\n", hdr->type);
> +			return -EINVAL;
> +		}
> +
> +		bufp += sizeof(*hdr);
> +
> +		if (hdr->datalen != hdr->count * digest_len ||
> +		    bufp + hdr->datalen > bufendp) {
> +			pr_err("invalid data\n");
> +			return -EINVAL;
> +		}
> +
> +		bufp += hdr->count * digest_len;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * _digest_list_parse - parse digest list and add/delete digests
> + * @size: buffer size
> + * @buf: buffer containing the digest list
> + * @op: operation to be performed
> + * @digest_list: digest list digests being added/deleted belong to
> + *
> + * This function parses the digest list and adds or delete the digests in the
> + * found digest blocks.
> + *
> + * Return: the buffer size if all digests were successfully added or deleted,
> + * the size of the already parsed buffer on error.
> + */
> +static int _digest_list_parse(loff_t size, void *buf, enum ops op,
> +			      struct digest_list_item *digest_list)
> +{
> +	void *bufp = buf, *bufendp = buf + size;
> +	struct compact_list_hdr *hdr;
> +	struct digest_item *d = ERR_PTR(-EINVAL);
> +	size_t digest_len;
> +	int i;
> +
> +	while (bufp < bufendp) {
> +		if (bufp + sizeof(*hdr) > bufendp)
> +			break;
> +
> +		hdr = bufp;
> +		bufp += sizeof(*hdr);
> +
> +		digest_len = hash_digest_size[hdr->algo];
> +
> +		for (i = 0; i < hdr->count && bufp + digest_len <= bufendp;
> +		     i++, bufp += digest_len) {
> +			switch (op) {
> +			case DIGEST_LIST_ADD:
> +				d = digest_add(bufp, hdr->algo, hdr->type,
> +					       digest_list, bufp - buf,
> +					       (void *)hdr - buf);
> +				if (IS_ERR(d)) {
> +					pr_err(
> +					    "failed to add a digest from %s\n",
> +					    digest_list->label);
> +					goto out;
> +				}
> +
> +				break;
> +			case DIGEST_LIST_DEL:
> +				digest_del(bufp, hdr->algo, hdr->type,
> +					   digest_list, bufp - buf,
> +					   (void *)hdr - buf);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +out:
> +	return bufp - buf;
> +}
> +
> +/**
> + * get_digest_list - get the digest list extracted digests will be associated to
> + * @size: buffer size
> + * @buf: buffer containing the digest list
> + * @op: digest list operation
> + * @actions: actions performed on the digest list being processed
> + * @digest: digest of the digest list
> + * @algo: digest algorithm
> + * @label: label to identify the digest list (e.g. file name)
> + *
> + * This function retrieves the digest list item for the passed digest and
> + * algorithm. If it is not found at addition time, this function creates a new
> + * one.
> + *
> + * This function prevents the imbalance of digests (references left after
> + * delete) by ensuring that only digest lists that were previously added can be
> + * deleted.
> + *
> + * This function also ensures that the actions done at the time of addition are
> + * also performed at the time of deletion (it would guarantee that also deletion
> + * is notified to remote verifiers).
> + *
> + * Return: the retrieved/created digest list item on success, an error pointer
> + * otherwise.
> + */
> +static struct digest_list_item *get_digest_list(loff_t size, void *buf,
> +						enum ops op, u8 actions,
> +						u8 *digest, enum hash_algo algo,
> +						const char *label)
> +{
> +	struct digest_item *d;
> +	struct digest_list_item *digest_list;
> +	int digest_len = hash_digest_size[algo];
> +
> +	switch (op) {
> +	case DIGEST_LIST_ADD:
> +		/* Add digest list to be associated to each digest. */
> +		d = digest_list_add(digest, algo, size, buf, actions, label);
> +		if (IS_ERR(d))
> +			return (void *)d;
> +
> +		digest_list = list_first_entry(&d->refs,
> +				struct digest_list_item_ref, list)->digest_list;
> +		break;
> +	case DIGEST_LIST_DEL:
> +		/* Lookup digest list to delete the references. */
> +		d = __digest_lookup(digest, algo, COMPACT_DIGEST_LIST, NULL,
> +				    NULL);
> +		if (!d) {
> +			print_hex_dump(KERN_ERR,
> +				       "digest list digest not found: ",
> +				       DUMP_PREFIX_NONE, digest_len, 1, digest,
> +				       digest_len, true);
> +			return ERR_PTR(-ENOENT);
> +		}
> +
> +		digest_list = list_first_entry(&d->refs,
> +				struct digest_list_item_ref, list)->digest_list;
> +
> +		/*
> +		 * Reject deletion if there are actions done at addition time
> +		 * that are currently not being performed.
> +		 */
> +		if ((digest_list->actions & actions) != digest_list->actions) {
> +			pr_err("missing actions, add: %d, del: %d\n",
> +			       digest_list->actions, actions);
> +			return ERR_PTR(-EPERM);
> +		}
> +
> +		break;
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return digest_list;
> +}
> +
> +/**
> + * digest_list_parse - parse a digest list
> + * @size: buffer size
> + * @buf: buffer containing the digest list
> + * @op: digest list operation
> + * @actions: actions performed on the digest list being processed
> + * @digest: digest of the digest list
> + * @algo: digest algorithm
> + * @label: label to identify the digest list (e.g. file name)
> + *
> + * This function parses the passed digest list and executed the requested
> + * operation. If the operation cannot be successfully executed, this function
> + * performs a rollback to the previous state.
> + *
> + * Return: the buffer size on success, a negative value otherwise.
> + */
> +int digest_list_parse(loff_t size, void *buf, enum ops op, u8 actions,
> +		      u8 *digest, enum hash_algo algo, const char *label)
> +{
> +	struct digest_list_item *digest_list;
> +	enum ops rollback_op = (op == DIGEST_LIST_ADD) ?
> +			       DIGEST_LIST_DEL : DIGEST_LIST_ADD;
> +	int ret, rollback_size;
> +
> +	ret = digest_list_validate(size, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	digest_list = get_digest_list(size, buf, op, actions, digest, algo,
> +				      label);
> +	if (IS_ERR(digest_list))
> +		return PTR_ERR(digest_list);
> +
> +	ret = _digest_list_parse(size, buf, op, digest_list);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (ret != size) {
> +		rollback_size = ret;
> +
> +		ret = _digest_list_parse(rollback_size, buf, rollback_op,
> +					 digest_list);
> +		if (ret != rollback_size)
> +			pr_err("rollback failed\n");
> +
> +		ret = -EINVAL;
> +	}
> +out:
> +	/* Delete digest list on unsuccessful add or successful delete. */
> +	if ((op == DIGEST_LIST_ADD && ret < 0) ||
> +	    (op == DIGEST_LIST_DEL && ret == size))
> +		digest_list_del(digest, algo, actions, digest_list);
> +
> +	return ret;
> +}
