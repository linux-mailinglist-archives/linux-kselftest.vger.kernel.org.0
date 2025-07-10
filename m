Return-Path: <linux-kselftest+bounces-37049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE6B00C2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34297B9F9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3C2FCFE4;
	Thu, 10 Jul 2025 19:34:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2E21A43D;
	Thu, 10 Jul 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176058; cv=none; b=kesc6wg55osaVX4lH/3GnA6lzxvUZBZvyIk2yzLJUUD28fz0BCSKyDUGcoxDxc7WnvcZpYSxkf8q6YiVPNaN74XFO+Xm93NtoDz2KEoXKDT9kJ0Eu1MidQF6jNZOeIHY24v9IqHosk/Rdbn8baoHbYn2sDwQDOJ9XO/HjeH4rDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176058; c=relaxed/simple;
	bh=HQmL8qC/NJpVN+Y9DU6iB7BsPtcSr1FwNmcTw1svsfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWn7SD5yvThDCbHX+zXsNg+X1S+PovC9m/IhadNnzpFN3SnBjep1TUQzxKpgJRBBQwsNCW6eZuM4PB1OSQrPNvW1wrTiHlyDMTcRQd2ihTRwIKGI+lh01+pTNLeUooz5OmSAbHydYLekEEm1TUDEwQSDdyv3/dO5T+OHDv+vZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 15BEE140F6F;
	Thu, 10 Jul 2025 19:34:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0578420026;
	Thu, 10 Jul 2025 19:34:10 +0000 (UTC)
Date: Thu, 10 Jul 2025 15:34:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Yuanhe Shu
 <xiangzao@linux.alibaba.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next] selftests/ftrace: Prevent potential failure in
 subsystem-enable test case
Message-ID: <20250710153409.3135fb17@batman.local.home>
In-Reply-To: <20250710130134.591066-1-wutengda@huaweicloud.com>
References: <20250710130134.591066-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hbn5tzpcwd5ghuwt5pssryo7et9px9pj
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0578420026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ny7HmihNTvti8NVpFB1Jp8hNcklJzZc4=
X-HE-Tag: 1752176050-153866
X-HE-Meta: U2FsdGVkX1//K8elZUG++8hVHzegozmIyXvruB1fQfVLOaf3/LlwE2lUGVSEyrYP89mNBXwdjJmv2OlMflHCchCyJz1WMymp9xY1fLX9bUxUqTiRfyiwZzUV9a3Ws1kf7LCKLMeOqeHEmLZfkhAgnBSyS3Wzj8mOrAsqa9bpqKM9lRx2fM5L56/o7jyurhWx6v/LAIQzarUhuHOkfvTxK3nL5LofiRQpc/HvwR7zZAN18O/989aWVnv2hr2zDSoI53wA0U135iRaMjT58WTMvxC/enWrFBmswzt6lNF2Ci42+6k6Tlp15vtw5KmZK3nhvy7TPP1L2ShfVIOg7B5Ar2CS0ShiSB8zG9eI5GpKMwUeycMTxMUbPxBUGzzr4Ap2

On Thu, 10 Jul 2025 13:01:34 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:


> 
> Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../selftests/ftrace/test.d/event/subsystem-enable.tc     | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> index b7c8f29c09a9..3a28adc7b727 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> @@ -19,8 +19,8 @@ echo 'sched:*' > set_event
>  yield
>  
>  count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> -if [ $count -lt 3 ]; then
> -    fail "at least fork, exec and exit events should be recorded"
> +if [ $count -eq 0 ]; then
> +    fail "none of scheduler events are recorded"
>  fi
>  
>  do_reset
> @@ -30,8 +30,8 @@ echo 1 > events/sched/enable
>  yield
>  
>  count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> -if [ $count -lt 3 ]; then
> -    fail "at least fork, exec and exit events should be recorded"
> +if [ $count -eq 0 ]; then
> +    fail "none of scheduler events are recorded"

So if there's a bug that causes the system enable to only enable a
single event, this will no longer catch it?

I rather not let the slide.

Can you test this to see if this works for you?

-- Steve

diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b7c8f29c09a9..46a9e6d92730 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -14,11 +14,32 @@ fail() { #msg
     exit_fail
 }
 
+check_unique() {
+    cat trace_pipe | grep -v '^#' | awk '
+	BEGIN { cnt = 0; }
+	{
+	    for (i = 0; i < cnt; i++) {
+		if (event[i] == $5) {
+		    break;
+		}
+	    }
+	    if (i == cnt) {
+		event[cnt++] = $5;
+		if (cnt > 2) {
+		    exit;
+		}
+	    }
+	}
+	END {
+	    printf "%d", cnt;
+	}'
+}
+
 echo 'sched:*' > set_event
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +50,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi

