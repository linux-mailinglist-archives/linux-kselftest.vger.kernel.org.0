Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B51422AC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhJEOSl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 10:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235417AbhJEOSj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 10:18:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EF65611F2;
        Tue,  5 Oct 2021 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633443408;
        bh=WRlu4hgjBKzmM/3ZK2fMF4M4daaiDFHSd+ws6sSU5HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtiAkFN5rbVddpsjXvjWRA7Ja+Ezs+sZZUH5S5OWL9GDyOmuU/sVP5l8Vhyr/rckG
         UNtoARMNoKuFrzraLiyH3THAJwXi/JcoK9JH5CYYkD/dOq9zt3ICG9Ba7zBbTR/AtD
         xyHzqXgwTvBI5unxWJVG2zK/H/Y2wzig3lHFYrXI=
Date:   Tue, 5 Oct 2021 16:16:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org, minchan@kernel.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, tglx@linutronix.de,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
Message-ID: <YVxeTvKkYs938g94@kroah.com>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 09:37:56AM -0700, Luis Chamberlain wrote:
> --- /dev/null
> +++ b/lib/test_sysfs.c
> @@ -0,0 +1,921 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> +/*
> + * sysfs test driver
> + *
> + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or at your option any
> + * later version; or, when distributed separately from the Linux kernel or
> + * when incorporated into other software packages, subject to the following
> + * license:
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of copyleft-next (version 0.3.1 or later) as published
> + * at http://copyleft-next.org/.

Independant of the fact that I don't like sysfs code attempting to be
accessed in the kernel with licenses other than GPLv2, you do not need
the license "boilerplate" text at all in files.  That's what the SPDX
line is for.

thanks,

greg k-h
