Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C5DF044
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJUOqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 10:46:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49967 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727101AbfJUOqx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 10:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571669211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+f6Um5bpTwJO4qunw0Yd8/KHXqiY+M67vv91zC8CJs=;
        b=NJcUp5iGcGt3uqtOC6s0hQULNQioFM3GIIZYvoBn/8i8OgP8LU6mvcyeuBo1HhXyiWJsSw
        EkiteiIfqxRAAUAxtMuvhqQgwju3YvekVmT5mEQJjBBQ7P9KYO3fPS9FHCpCamSNaAv60h
        ilUWheeH0PP95Kf2NiFz80Q6xlP9VYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-c3fBOIFINueFSQEaUpFbbA-1; Mon, 21 Oct 2019 10:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B018D800D41;
        Mon, 21 Oct 2019 14:46:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id E463D5C240;
        Mon, 21 Oct 2019 14:46:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Oct 2019 16:46:46 +0200 (CEST)
Date:   Mon, 21 Oct 2019 16:46:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] clone3: add CLONE_CLEAR_SIGHAND
Message-ID: <20191021144633.GA2720@redhat.com>
References: <20191014104538.3096-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
In-Reply-To: <20191014104538.3096-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: c3fBOIFINueFSQEaUpFbbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/14, Christian Brauner wrote:
>
> The child helper process on Linux posix_spawn must ensure that no signal
> handlers are enabled, so the signal disposition must be either SIG_DFL
> or SIG_IGN. However, it requires a sigprocmask to obtain the current
> signal mask and at least _NSIG sigaction calls to reset the signal
> handlers for each posix_spawn call

Plus the caller has to block/unblock all signals around clone(VM|VFORK).

Can this justify the new CLONE_ flag? Honestly, I have no idea. But the
patch is simple and looks technically correct to me. FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

