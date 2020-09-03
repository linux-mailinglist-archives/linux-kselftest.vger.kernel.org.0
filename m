Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642BF25C347
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgICOsZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 10:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728871AbgICOWz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 10:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599142973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91ijUty15Prtg/8b/t9+zr7UAa40xpsWcSzisd5H3Us=;
        b=EzOVGVGVwCgpOKoF2M0rU9CWi8VPtnOWKLoqMxWeVmFRgeVv7km4AZjP+v1qAvPW+VcDYB
        eEYB41koij1OHOcSKUYBv8JBi34Q23jKewwRlwa5nSyHqWCZX+CjT+/wW3VJcn7GBFubdm
        ZbZy0nDyfKdGMq63/T7LJhDvlbZ9Iks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-06yz8j6xNA-U3FFxO-0Hyw-1; Thu, 03 Sep 2020 10:22:49 -0400
X-MC-Unique: 06yz8j6xNA-U3FFxO-0Hyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2E11084C89;
        Thu,  3 Sep 2020 14:22:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FA455D9EF;
        Thu,  3 Sep 2020 14:22:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  3 Sep 2020 16:22:46 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:22:42 +0200
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
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/4] exit: support non-blocking pidfds
Message-ID: <20200903142241.GI4386@redhat.com>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102130.147672-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/02, Christian Brauner wrote:
>
> It also makes the API more consistent and uniform. In essence, waitid() is
> treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
> socket.
> With the addition of support for non-blocking pidfds we support the same
> functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
> for pidfds waitid() supports WNOHANG.

What I personally do not like is that waitid(WNOHANG) returns zero or EAGAIN
depending on f_flags & O_NONBLOCK... This doesn't match recvmsg(MSG_DONTWAIT)
and doesn't look consistent to me.

Nevermind, the patch looks correct and if you think this can really help
user-space I won't argue.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

