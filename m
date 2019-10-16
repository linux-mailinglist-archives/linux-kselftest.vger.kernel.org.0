Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBFD93B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJPOZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 10:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfJPOZH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 10:25:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3D0218DE;
        Wed, 16 Oct 2019 14:25:06 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:25:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191016102504.274fc88d@gandalf.local.home>
In-Reply-To: <20191016094853.3913f5ae@gandalf.local.home>
References: <20191016113316.13415-1-mbenes@suse.cz>
        <20191016113316.13415-2-mbenes@suse.cz>
        <20191016094853.3913f5ae@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Oct 2019 09:48:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -6796,10 +6798,12 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
>  
>  	ret = proc_dointvec(table, write, buffer, lenp, ppos);

As you just stated on IRC, the update to ftrace_enabled gets updated in
the above routine.

I forgot about this :-/ (Senior moment)

I guess there's nothing to worry about here.

-- Steve



>  
> -	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
> +	if (ret || !write || (ftrace_enabled == !!sysctl_ftrace_enabled))
>  		goto out;
>  
