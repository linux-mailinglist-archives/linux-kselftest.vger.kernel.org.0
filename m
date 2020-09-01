Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F314259831
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgIAQXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 12:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729048AbgIAQXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 12:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a32Yjr2eFkkA5dmrRXs0DH1p+/gxeW0TLToW+n8z3yc=;
        b=hgNGO+u9jxtRdhjzkNizg4FWAFEvrIFyxzrcOVMkeqjH1vtpMm+dXsFNT/7NUgHiG+Lsle
        l6m1yh4yLPNT8K7BOv3CYx/5o7Tmfn2DM76L48YT8g8vUkne+MiAqHJOFFxexyRz2hg93N
        bqv6AP+bZywIQEfK9OEH/L02wHY1NyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-W7hirFWAM9WKO2i0NHJmjA-1; Tue, 01 Sep 2020 12:23:17 -0400
X-MC-Unique: W7hirFWAM9WKO2i0NHJmjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B61110ABDAB;
        Tue,  1 Sep 2020 16:23:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9CA257EB9A;
        Tue,  1 Sep 2020 16:23:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  1 Sep 2020 18:23:14 +0200 (CEST)
Date:   Tue, 1 Sep 2020 18:23:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Message-ID: <20200901162309.GB4386@redhat.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
 <20200831134551.1599689-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831134551.1599689-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/31, Christian Brauner wrote:
>
> --- /dev/null
> +++ b/include/uapi/linux/pidfd.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_LINUX_PIDFD_H
> +#define _UAPI_LINUX_PIDFD_H
> +
> +#include <linux/types.h>
> +#include <linux/fcntl.h>
> +
> +/* Flags for pidfd_open().  */
> +#define PIDFD_NONBLOCK O_NONBLOCK
> +
> +#endif /* _UAPI_LINUX_PIDFD_H */

Why? Can't we simply use O_NONBLOCK ?

Oleg.

