Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC49E3D8E20
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhG1Mpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234966AbhG1Mph (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:45:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F324060F9E;
        Wed, 28 Jul 2021 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627476336;
        bh=si2ClFifESL47uxR4OasyzchtN6biah0h6QTPkfLJiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UtqTA7p3Am3N4eyS/WIO1mryqqlA8ouWeM+poYxw1k6Z23BS7DniKOeXzXNoBNDT4
         dCtakWGs6lTJTccjnqk0UlKY5Bx6D+5AkvFOHrLEuOHhuMEn+AAZSIw2b+RwKacAbi
         vBDHCV510nR4TfSovCN8v4QEatcH97LgM/Zzp+MpziwUegI5twjEYUI2tlfM1kO00t
         5OrioISdBb5pKZpFFlzne8sQIZW2p67kPSN8w1Qw7vEdVCBPZly7RONI6Ke5SeCg4j
         TwZcQ3zE2WKxHDZpwMrJdsvK9ImZ4T1ZgemA4h9YbQRUBxWp0J3eRt1mSPB1MQvPru
         r+cfoU29AGSWQ==
Date:   Wed, 28 Jul 2021 14:45:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [RFC][PATCH v2 10/12] diglim: Interfaces - digests_count
Message-ID: <20210728144529.756dfc94@sal.lan>
In-Reply-To: <20210726163700.2092768-11-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-11-roberto.sassu@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon, 26 Jul 2021 18:36:58 +0200
Roberto Sassu <roberto.sassu@huawei.com> escreveu:

> Introduce the digests_count interface, which shows the current number of
> digests stored in the hash table by type.
> 
> Reported-by: kernel test robot <lkp@intel.com> (frame size warning)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Patches 7 to 10 also LGTM.

> ---
>  security/integrity/diglim/fs.c | 48 ++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
> index f1c1fc56448a..3b1d9616cb62 100644
> --- a/security/integrity/diglim/fs.c
> +++ b/security/integrity/diglim/fs.c
> @@ -23,6 +23,7 @@
>  #include "diglim.h"
>  
>  #define MAX_DIGEST_LIST_SIZE (64 * 1024 * 1024 - 1)
> +#define TMPBUF_SIZE 512
>  
>  static struct dentry *diglim_dir;
>  /**
> @@ -36,6 +37,13 @@ static struct dentry *diglim_dir;
>   * removed.
>   */
>  static struct dentry *digest_lists_loaded_dir;
> +/**
> + * DOC: digests_count
> + *
> + * digests_count shows the current number of digests stored in the hash
> + * table by type.
> + */
> +static struct dentry *digests_count;
>  /**
>   * DOC: digest_label
>   *
> @@ -73,6 +81,39 @@ static struct dentry *digest_list_del_dentry;
>  char digest_query[CRYPTO_MAX_ALG_NAME + 1 + IMA_MAX_DIGEST_SIZE * 2 + 1];
>  char digest_label[NAME_MAX + 1];
>  
> +static char *types_str[COMPACT__LAST] = {
> +	[COMPACT_PARSER] = "Parser",
> +	[COMPACT_FILE] = "File",
> +	[COMPACT_METADATA] = "Metadata",
> +	[COMPACT_DIGEST_LIST] = "Digest list",
> +};
> +
> +static ssize_t diglim_show_htable_len(struct file *filp, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	char *tmpbuf;
> +	ssize_t ret, len = 0;
> +	int i;
> +
> +	tmpbuf = kmalloc(TMPBUF_SIZE, GFP_KERNEL);
> +	if (!tmpbuf)
> +		return -ENOMEM;
> +
> +	for (i = COMPACT_PARSER; i < COMPACT__LAST; i++)
> +		len += scnprintf(tmpbuf + len, TMPBUF_SIZE - len,
> +				 "%s digests: %lu\n", types_str[i],
> +				 htable[i].len);
> +
> +	ret = simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
> +	kfree(tmpbuf);
> +	return ret;
> +}
> +
> +static const struct file_operations htable_len_ops = {
> +	.read = diglim_show_htable_len,
> +	.llseek = generic_file_llseek,
> +};
> +
>  static int parse_digest_list_filename(const char *digest_list_filename,
>  				      u8 *digest, enum hash_algo *algo)
>  {
> @@ -696,6 +737,12 @@ static int __init diglim_fs_init(void)
>  	if (IS_ERR(digest_lists_loaded_dir))
>  		goto out;
>  
> +	digests_count = securityfs_create_file("digests_count", 0440,
> +					       diglim_dir, NULL,
> +					       &htable_len_ops);
> +	if (IS_ERR(digests_count))
> +		goto out;
> +
>  	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
>  						diglim_dir, NULL,
>  						&digest_list_upload_ops);
> @@ -726,6 +773,7 @@ static int __init diglim_fs_init(void)
>  	securityfs_remove(digest_label_dentry);
>  	securityfs_remove(digest_list_del_dentry);
>  	securityfs_remove(digest_list_add_dentry);
> +	securityfs_remove(digests_count);
>  	securityfs_remove(digest_lists_loaded_dir);
>  	securityfs_remove(diglim_dir);
>  	return -1;
