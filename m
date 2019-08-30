Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C61A3FA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Vb5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 17:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfH3Vb5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 17:31:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D1123427;
        Fri, 30 Aug 2019 21:31:56 +0000 (UTC)
Date:   Fri, 30 Aug 2019 17:31:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/ftrace: Fix typo in trigger-snapshot.tc
Message-ID: <20190830173154.467d9335@gandalf.local.home>
In-Reply-To: <20190803000126.23200-1-standby24x7@gmail.com>
References: <20190803000126.23200-1-standby24x7@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat,  3 Aug 2019 09:01:26 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes a spelling typo in tigger-snapshot.tc
> 

As Randy said: "trigger-snapshot.tc"

Shuah, can you take this?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  .../testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> index 7717c0a09686..ac738500d17f 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> @@ -28,7 +28,7 @@ if [ -z "$FEATURE" ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test snapshot tigger"
> +echo "Test snapshot trigger"
>  echo 0 > snapshot
>  echo 1 > events/sched/sched_process_fork/enable
>  ( echo "forked")

