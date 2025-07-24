Return-Path: <linux-kselftest+bounces-37946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C723B10C32
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8B7BA7BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B02E0910;
	Thu, 24 Jul 2025 13:53:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E42DCF5F;
	Thu, 24 Jul 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365203; cv=none; b=M7rLZ951iI47Jz3dmo5xLhIY3y9wZ9F9PAM8JBso5/O4yuXm7jkq8QYCMGh4Ka9/eT9/38PGlSlrhrFGIxTn9RLaI2ssOzBDwuEssaY/2Azlk402Rfz2fqWawD50F5dtrKmsAWq/BBmkyfYYpZwEkXd5jUCbxxP8n8zuSO4kjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365203; c=relaxed/simple;
	bh=LCWhsWslZhOW+qCG4ubZBPPYZz1UAXtYtfxFEVuONr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP4kwSNx3K5qJDMMOFclnvtR35zNI4YU7DJcD6CICeBySQjMyMnuQ2hoSOFLYemYbUXxV2zeLNbnYIxVD+TF+eCHACzRiM1bRYfkf+ZnBVH/lqcbh9ATftMG1IFbmCHvzZU7AG4/RzLKAeG+e0YxVa5xvld6fJyCvMsb3zaKqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 6F8A51A03D0;
	Thu, 24 Jul 2025 13:53:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C7A6620027;
	Thu, 24 Jul 2025 13:53:10 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:53:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuahkhan@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [PATCH] selftests/tracing: Fix false failure of subsystem event
 test
Message-ID: <20250724095309.480882c8@batman.local.home>
In-Reply-To: <20250721134212.53c3e140@batman.local.home>
References: <20250721134212.53c3e140@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C7A6620027
X-Stat-Signature: awohrkpw4ihisad4ihe3fycjqcmjqbhy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19T2I2qyibGxEwWSVE1GKbSgDm/oeBzoRA=
X-HE-Tag: 1753365190-817813
X-HE-Meta: U2FsdGVkX193fLY4CeoYpDrs4CA4BoNns1C7wVQrrT3oSNH/ACFa1J+jpGsuuMhK/cJaseviy/ZGeOX25QCVx6kAlcIsEvofxqau3lkDeaRNcyU/oC5fHBfQwtjlWI5B/hJM4HVU3GbyKWwLvJ7L6D5n2c142/HmIXuISevaIA3SHFxpLsUCIoxiB1qHta+HMBH3aGDx6a80UChfkF3m2UNtljqX0qRu3cxBf8EQZNZtKQGldOtwUjWVspRhyWSCctUIGM76CKgPR4myIlfDh/Ru/hLPw8gOaSES6evWA2NXnt762GM0nkr3Cfi0dCeA8FMwETswcEtl6wzjI1zkaxp9aZweIwRCUIYGY5QVNzq6ZkXeeugqKG2S9npjxsgB8nr6RNQC+06YcZNn+ezfn+sk+9ROj1XV4AVK3FFSSws=

Shuah,

Can you take this patch?

Thanks,

-- Steve


On Mon, 21 Jul 2025 13:42:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The subsystem event test enables all "sched" events and makes sure there's
> at least 3 different events in the output. It used to cat the entire trace
> file to | wc -l, but on slow machines, that could last a very long time.
> To solve that, it was changed to just read the first 100 lines of the
> trace file. This can cause false failures as some events repeat so often,
> that the 100 lines that are examined could possibly be of only one event.
> 
> Instead, create an awk script that looks for 3 different events and will
> exit out after it finds them. This will find the 3 events the test looks
> for (eventually if it works), and still exit out after the test is
> satisfied and not cause slower machines to run forever.
> 
> Reported-by: Tengda Wu <wutengda@huaweicloud.com>
> Closes: https://lore.kernel.org/all/20250710130134.591066-1-wutengda@huaweicloud.com/
> Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/event/subsystem-enable.tc   | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> index b7c8f29c09a9..65916bb55dfb 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> @@ -14,11 +14,35 @@ fail() { #msg
>      exit_fail
>  }
>  
> +# As reading trace can last forever, simply look for 3 different
> +# events then exit out of reading the file. If there's not 3 different
> +# events, then the test has failed.
> +check_unique() {
> +    cat trace | grep -v '^#' | awk '
> +	BEGIN { cnt = 0; }
> +	{
> +	    for (i = 0; i < cnt; i++) {
> +		if (event[i] == $5) {
> +		    break;
> +		}
> +	    }
> +	    if (i == cnt) {
> +		event[cnt++] = $5;
> +		if (cnt > 2) {
> +		    exit;
> +		}
> +	    }
> +	}
> +	END {
> +	    printf "%d", cnt;
> +	}'
> +}
> +
>  echo 'sched:*' > set_event
>  
>  yield
>  
> -count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`check_unique`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -29,7 +53,7 @@ echo 1 > events/sched/enable
>  
>  yield
>  
> -count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`check_unique`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi


