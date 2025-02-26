Return-Path: <linux-kselftest+bounces-27633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0FCA46797
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA317A69EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FF224AFE;
	Wed, 26 Feb 2025 17:12:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE32248AC;
	Wed, 26 Feb 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589956; cv=none; b=udPAJC7SGYT3+/hgXFRREutn/w10mqfRQiP3w6hJiAshfIlBr6kUL6liY3sqiQvLs8GiZTpzxUbZU82qQV8PdTPZE1Tynq20fnZrCzWhiHRrxMU4+pMrP27j2GBRKiIuIH5pOq0/qXsbGr/LLMTLdoN66x69cpb4GzrbyltMhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589956; c=relaxed/simple;
	bh=g9PtS94SimNpV+zQLwIgKPUHzoPC2EfDWNlYHcTqODk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIr4+c14FHKKvLvAw7ZZnVnG1ECV4ZYqtCOjIv7SUOjijYcMrWkJI7B2jupt+rpywIBbpprAJ0nnpNi4qYf8cj8FRCardQOlhW/ENjSfcUJr1h9Dvtttux0kM49SR+GsjSZ60h1xOvXSe3vuN4csjyboiT06a3SYs9WRos+4PHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC03EC4CED6;
	Wed, 26 Feb 2025 17:12:35 +0000 (UTC)
Date: Wed, 26 Feb 2025 12:13:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Use readelf to find entry point in
 uprobe test
Message-ID: <20250226121316.7653ae38@gandalf.local.home>
In-Reply-To: <20250220130102.2079179-1-hca@linux.ibm.com>
References: <20250220130102.2079179-1-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 14:01:02 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> The uprobe events test fails on s390, but also on x86 (Fedora 41). The
> problem appears to be that there is an assumption that adding a uprobe to
> the beginning of the executable mapping of /bin/sh is sufficient to trigger
> a uprobe event when /bin/sh is executed.
> 
> This assumption is not necessarily true. Therefore use "readelf -h" to find
> the entry point address of /bin/sh and use this address when adding the
> uprobe event.
> 
> This adds a dependency to readelf which is not always installed. Therefore
> add a check and exit with exit_unresolved if it is not installed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Can you take this in your tree?

-- Steve

> ---
>  .../ftrace/test.d/dynevent/add_remove_uprobe.tc        | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> index 86c76679c56e..f2048c244526 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> @@ -3,14 +3,18 @@
>  # description: Generic dynamic event - add/remove/test uprobe events
>  # requires: uprobe_events
>  
> +if ! which readelf > /dev/null 2>&1 ; then
> +  echo "No readelf found. skipped."
> +  exit_unresolved
> +fi
> +
>  echo 0 > events/enable
>  echo > dynamic_events
>  
>  REALBIN=`readlink -f /bin/sh`
> +ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
>  
> -echo 'cat /proc/$$/maps' | /bin/sh | \
> -	grep "r-xp .*${REALBIN}$" | \
> -	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events
> +echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
>  
>  grep -q myevent uprobe_events
>  test -d events/uprobes/myevent


