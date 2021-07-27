Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC11A3D78B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhG0Onh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 10:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236901AbhG0Ong (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 10:43:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB7AF61AFA;
        Tue, 27 Jul 2021 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627397015;
        bh=qFd46qxbPifoDl2lqdkdIoc082Sb+xM4m6IGi89yhls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrvS+IYAOcf97227HS/Q9Iyyf5tkB/2yfsFhEMFuAHFI+ixOqywfPd1Vtsw7VHIlz
         Py9PO/aNn53s3JvmhPUP/2gg1AZnjSk9FtIyjPIofOOeG8VjoUKk5dhJJN3poBzHaD
         QolSTbbnuqdSmXgCoQGWapojJbW6nNLPzsbhfdfo=
Date:   Tue, 27 Jul 2021 16:43:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, mchehab+huawei@kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v2 02/12] diglim: Basic definitions
Message-ID: <YQAblc+UuMq68jxu@kroah.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
 <20210726163700.2092768-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726163700.2092768-3-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 26, 2021 at 06:36:50PM +0200, Roberto Sassu wrote:
> --- /dev/null
> +++ b/include/uapi/linux/diglim.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * DIGLIM definitions exported to user space, useful for generating digest
> + * lists.
> + */
> +
> +#ifndef _UAPI__LINUX_DIGLIM_H
> +#define _UAPI__LINUX_DIGLIM_H
> +
> +#include <linux/types.h>
> +#include <linux/hash_info.h>
> +
> +enum compact_types { COMPACT_KEY, COMPACT_PARSER, COMPACT_FILE,
> +		     COMPACT_METADATA, COMPACT_DIGEST_LIST, COMPACT__LAST };
> +
> +enum compact_modifiers { COMPACT_MOD_IMMUTABLE, COMPACT_MOD__LAST };
> +
> +enum compact_actions { COMPACT_ACTION_IMA_MEASURED,
> +		       COMPACT_ACTION_IMA_APPRAISED,
> +		       COMPACT_ACTION_IMA_APPRAISED_DIGSIG,
> +		       COMPACT_ACTION__LAST };
> +
> +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
> +
> +/**
> + * struct compact_list_hdr - header of the following concatenated digests
> + * @version: version of the digest list
> + * @_reserved: field reserved for future use
> + * @type: type of digest list among enum compact_types
> + * @modifiers: additional attributes among (1 << enum compact_modifiers)

I do not understand this description, what does it mean?

> + * @algo: digest algorithm

Is this also a #define or an enum?  Where is the list of them?

> + * @count: number of digests
> + * @datalen: length of concatenated digests

Where does this count and length come into play as nothing else is in
this structure?

> + *
> + * A digest list is a set of blocks composed by struct compact_list_hdr and
> + * the following concatenated digests.
> + */
> +struct compact_list_hdr {
> +	__u8 version;
> +	__u8 _reserved;

You MUST check this for 0 today, and document it above.  If not, you can
never use it in the future.

> +	__le16 type;
> +	__le16 modifiers;
> +	__le16 algo;
> +	__le32 count;
> +	__le32 datalen;
> +} __packed;
> +#endif /*_UAPI__LINUX_DIGLIM_H*/
> -- 
> 2.25.1
> 
