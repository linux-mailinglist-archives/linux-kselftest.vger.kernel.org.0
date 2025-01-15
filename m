Return-Path: <linux-kselftest+bounces-24592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F489A12A7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC753A5A9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA01A8F7D;
	Wed, 15 Jan 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/9Tykbk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484214A630
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964623; cv=none; b=eInaDYB1JpdIYjzpiJcYNWk4i6G7Jl/43KnbvIa5F2drn3npwKbWz2NXW3d4R7frEirJIKFDr+1v1Q0Sh+xzfubsOhmly95ovcK3EDMKA+rwn9wCWyr6JOdrkVM1zTPrBdArXMutQKzyREb0T8mj7f103KWdcZGpieYcgmTh/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964623; c=relaxed/simple;
	bh=JXmTrsaNqVrR1MmMysbscv4cmOFjopCGy4kCDdPxb8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+C/7BlEO/5T37SRg/DP/CE+1ttfoqAAvscbaIpfzircBHegAxdUD7YTEN+PX0osRSmH7xXKxn4xctQtoENoTMOyxd9oLFbpWrHrgyzhbXLT0GPOfLqsV3AjSfKPiyDlL0SSvrR6qeeKBIjA+yncmZmG2iYweFc9LVGDe4b5IJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/9Tykbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736964621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Np7pSsxaw2iUiB/sIQw22hWaNnI9by8bAfVe0S6KgrQ=;
	b=i/9TykbknnYnH/5huvZ9sHjknCxJRASBhm64anDLferdn6FtidAKAzZIcrO9X31Z2WBqEu
	QkSJwDAj5Pw/2wF4NwQ7eXsyZmtWzKNz3YqcFgNe4QKuNXxU4K3hbHj3+FP4gedIgqeF4E
	67u6qATUSz3WQ+dfegZlNncUfFIg+2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-cfTrX9eZNAu5ZcVcw0aX2w-1; Wed,
 15 Jan 2025 13:10:17 -0500
X-MC-Unique: cfTrX9eZNAu5ZcVcw0aX2w-1
X-Mimecast-MFC-AGG-ID: cfTrX9eZNAu5ZcVcw0aX2w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 278E71956055;
	Wed, 15 Jan 2025 18:10:15 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 151E719560AB;
	Wed, 15 Jan 2025 18:10:11 +0000 (UTC)
Date: Wed, 15 Jan 2025 13:10:09 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, shuah@kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen@kernel.org, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
Message-ID: <Z4f6AbC7pQLIWuX+@redhat.com>
References: <20250114143144.164250-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114143144.164250-1-maddy@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 14, 2025 at 08:01:44PM +0530, Madhavan Srinivasan wrote:
> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER, which
> adds the caller id as part of the dmesg. Due to this, even though
> the expected vs observed are same, end testcase results are failed.
> 
>  -% insmod test_modules/test_klp_livepatch.ko
>  -livepatch: enabling patch 'test_klp_livepatch'
>  -livepatch: 'test_klp_livepatch': initializing patching transition
>  -livepatch: 'test_klp_livepatch': starting patching transition
>  -livepatch: 'test_klp_livepatch': completing patching transition
>  -livepatch: 'test_klp_livepatch': patching complete
>  -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  -livepatch: 'test_klp_livepatch': initializing unpatching transition
>  -livepatch: 'test_klp_livepatch': starting unpatching transition
>  -livepatch: 'test_klp_livepatch': completing unpatching transition
>  -livepatch: 'test_klp_livepatch': unpatching complete
>  -% rmmod test_klp_livepatch
>  +[   T3659] % insmod test_modules/test_klp_livepatch.ko
>  +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
>  +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
>  +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': patching complete
>  +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
>  +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
>  +[   T3659] % rmmod test_klp_livepatch
> 
>   ERROR: livepatch kselftest(s) failed
>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> 
> Currently the check_result() handles the "[time]" removal from
> the dmesg. Enhance the check to handle removal of "[Tid]" also.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index e5d06fb40233..a1730c1864a4 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -306,7 +306,8 @@ function check_result {
>  	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
>  		 grep -e 'livepatch:' -e 'test_klp' | \
>  		 grep -v '\(tainting\|taints\) kernel' | \
> -		 sed 's/^\[[ 0-9.]*\] //')
> +		 sed 's/^\[[ 0-9.]*\] //' | \
> +		 sed 's/^\[[ ]*T[0-9]*\] //')

Thanks for adding this to the filter.

If I read the PRINTK_CALLER docs correctly, there is a potential CPU
identifier as well.  Are there any instances where the livepatching code
will use the "[C$processor_id]" (out of task context) prefix?  Or would
it hurt to future proof with [CT][0-9]?

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

--
Joe

>  
>  	if [[ "$expect" == "$result" ]] ; then
>  		echo "ok"
> -- 
> 2.47.0
> 


