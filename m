Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363293B52E0
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Jun 2021 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhF0K4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Jun 2021 06:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhF0K4O (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Jun 2021 06:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0698F619CD;
        Sun, 27 Jun 2021 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624791229;
        bh=+34VPgiMBz1koI+NKofcB6T7PqC9IC9eLfw6ueg4J6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRUXKeioHl34Q+YdKZwYw/6xzHioPuX8tGf2OvPaRX54BZ+06Z0WT0eAYz9JwV0/m
         XzhxBftOnG8RXVhF0bk015aTyFOa7qZapOh8CugPpgSxqOcq+OzxM9Mum6+Lr6+zOD
         yclvSSE6t34/s77/tveE7Tpt3P4a8/YUucBeALaU=
Date:   Sun, 27 Jun 2021 12:53:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 03/12] digest_lists: Basic definitions
Message-ID: <YNhYu3BXh7f9GkVk@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625165614.2284243-4-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 25, 2021 at 06:56:05PM +0200, Roberto Sassu wrote:
> --- /dev/null
> +++ b/include/uapi/linux/digest_lists.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.

As you already have the SPDX line up there, you do not need this
paragraph.  Please remove it from all of the new files you have added in
this series.

> + *
> + * File: digest_lists.h

We know the filename, no need to have it here again.

> + *      Digest list definitions exported to user space.

Now this is what probably needs more information...

> + */
> +
> +#ifndef _UAPI__LINUX_DIGEST_LISTS_H
> +#define _UAPI__LINUX_DIGEST_LISTS_H
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

For enums you export to userspace, you need to specify the values so
that all compilers get them right.

> +struct compact_list_hdr {
> +	__u8 version;

You should never need a version, that way lies madness.

> +	__u8 _reserved;

You better be testing this for 0, right?

> +	__le16 type;
> +	__le16 modifiers;
> +	__le16 algo;
> +	__le32 count;
> +	__le32 datalen;

Why are user/kernel apis specified in little endian format?  Why would
that matter?  Shouldn't they just be "native" endian?

thanks,

greg k-h
