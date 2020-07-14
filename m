Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6817A21F173
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNMgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 08:36:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45833 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726823AbgGNMgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 08:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594730197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN+URw2m81+BGl4jOJuzvBqo88yHsU8OolOc4NwmsLI=;
        b=O5WUPXHD/oJfYjcMvNsVe0RWicWxsF8ZhP2TTzjLgGClMntoyxeFRiRtRJEHsZRYtDxAme
        WTxMlqd+cxkY7C/FY9j46huc9JpgoJzFJlouuX0hwSJ0BIO0+VKSDV6A9HmLAzLYlb8SZa
        7YSTmpl3De+iSMyRXxrHRZjKR1L5N5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-94l5EXXuMgaqUySrQrUW0g-1; Tue, 14 Jul 2020 08:36:34 -0400
X-MC-Unique: 94l5EXXuMgaqUySrQrUW0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BF91085;
        Tue, 14 Jul 2020 12:36:32 +0000 (UTC)
Received: from [10.10.112.73] (ovpn-112-73.rdu2.redhat.com [10.10.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6F17B42D;
        Tue, 14 Jul 2020 12:36:31 +0000 (UTC)
Subject: Re: [PATCH v2] selftests/livepatch: adopt to newer sysctl error
 format
To:     Petr Mladek <pmladek@suse.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc:     Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714091030.1611-1-pmladek@suse.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <480e4da4-36b6-c112-255c-8cdab57e24ff@redhat.com>
Date:   Tue, 14 Jul 2020 08:36:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714091030.1611-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/20 5:10 AM, Petr Mladek wrote:
> With procfs v3.3.16, the sysctl command doesn't print the set key and
> value on error.  This change breaks livepatch selftest test-ftrace.sh,
> that tests the interaction of sysctl ftrace_enabled:
> 
> Make it work with all sysctl versions using '-q' option.
> 
> Explicitly print the final status on success so that it can be verified
> in the log. The error message is enough on failure.
> 
> Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> The patch has been created against livepatch.git,
> branch for-5.9/selftests-cleanup. But it applies also against
> the current Linus' tree.
> 
> tools/testing/selftests/livepatch/functions.sh   | 3 ++-
>   tools/testing/selftests/livepatch/test-ftrace.sh | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 408529d94ddb..1aba83c87ad3 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -75,7 +75,8 @@ function set_dynamic_debug() {
>   }
>   
>   function set_ftrace_enabled() {
> -	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
> +	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
> +		 sysctl kernel.ftrace_enabled 2>&1)
>   	echo "livepatch: $result" > /dev/kmsg
>   }
>   
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index 9160c9ec3b6f..552e165512f4 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -51,7 +51,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
>   livepatch: '$MOD_LIVEPATCH': starting patching transition
>   livepatch: '$MOD_LIVEPATCH': completing patching transition
>   livepatch: '$MOD_LIVEPATCH': patching complete
> -livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
> +livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
>   % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
>   livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
>   livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> 

Looks good, thanks.

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

