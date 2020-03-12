Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175C3183129
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 14:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCLNYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 09:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCLNX7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 09:23:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D3D20663;
        Thu, 12 Mar 2020 13:23:58 +0000 (UTC)
Date:   Thu, 12 Mar 2020 09:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix typo in trigger-multihist.tc
Message-ID: <20200312092355.73d8c019@gandalf.local.home>
In-Reply-To: <20200312040337.7631-1-standby24x7@gmail.com>
References: <20200312040337.7631-1-standby24x7@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 12 Mar 2020 13:03:37 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fix a spelling typo in trigger-multihist.tc
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  .../selftests/ftrace/test.d/trigger/trigger-multihist.tc        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> index 18fdaab9f570..68ff3f45c720 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> @@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test histogram multiple tiggers"
> +echo "Test histogram multiple triggers"

Winnie the Pooh will be upset.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Shuah, want to take this?

-- Steve

>  
>  echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
>  echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger

