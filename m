Return-Path: <linux-kselftest+bounces-47279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9ECAE1D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 20:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6F130AE9A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CAB2EBDF2;
	Mon,  8 Dec 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qZ7BVsrX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD782594BD;
	Mon,  8 Dec 2025 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765223056; cv=none; b=S42I353iPewvPLqDal3pUZQl1sDeJKz3rNnwli96q2XgGOU46zjBAaKVMXvPmcrhJKLuxg1bw3FrrzKrXOZ6c3l4PbgLgvxqSuOkKIWCw4cmLEMpglLBxmMUraR+DOq7VjZqVXkDCog8EhdD54iCRbEHjcix6gOqKsHnGuVEZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765223056; c=relaxed/simple;
	bh=gqK4p0EdZrQm1+mU1yrNkzScCZ7jQMmY+y+sszpKS3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B40qXks7qyjUSrJx4mpuT5W38r/ry2XozWdLGYh/Al75Bt2b4h6Baxvn9KKZjAGjLahBvGenAj2d4jsOulFRl7202dJ1bsRztE1CbpBSidvu9YMFHKC190t2WSuoh+c5xJ4K8JF7TZCE+Ur6ygOJTAz3SJGIqA/HSRwJ7WqlhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qZ7BVsrX; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SS2/Skvn3Cx0YBaWBhrfX12Ucuywuf1bTb3hcPXKazI=; b=qZ7BVsrXPm9KQBXVbcoMmn3R98
	ELiEXtFZ7fSy5Gf7vZ48upURofOJDFg9ujw0wfHhqO4NhgIHpHCDtbSLmJ35iSljfr3UELLy+dWl1
	94xyjAxXhLSY4tW6dcogWMtyNYX9DFbvsvEqfatmhqZCWomb1ZbnHdGCI66C21BnEc4ED3fSXWvfS
	7VNj1t5J+qa4kFwDO/xeRAzPZ0FcZNPmcj5aX6i9eqQU6+A7AflKhSfHGXWJqMrK9VKtH2EnZ/KSY
	HoPLy0R04KiA/fswkixHmdbsbaAQOXqnhsY3sniT8irqWmYMoh6Gj2k+Nn90rKfN3GX9bJMtmxz6O
	1ot8drkg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1vSgtE-006Vqa-2R;
	Mon, 08 Dec 2025 13:27:20 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Shuah Khan <shuah@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 02/13] selftests: ntsync: Fix build warnings
Date: Mon, 08 Dec 2025 13:27:20 -0600
Message-ID: <8962735.jnjZ57t7OP@camazotz>
In-Reply-To: <20251205171010.515236-3-linux@roeck-us.net>
References:
 <20251205171010.515236-1-linux@roeck-us.net>
 <20251205171010.515236-3-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 5 December 2025 11:09:56 CST Guenter Roeck wrote:
> Fix
> 
> ntsync.c:1286:20: warning: call to undeclared function 'gettid';
> 	ISO C99 and later do not support implicit function declarations
>  1286 |         wait_args.owner = gettid();
>       |                           ^
> ntsync.c:1280:8: warning: unused variable 'index'
>  1280 |         __u32 index, count, i;
>       |               ^~~~~
> ntsync.c:1281:6: warning: unused variable 'ret'
>  1281 |         int ret;
> 
> by adding the missing include file and removing the unused variables.
> 
> Fixes: a22860e57b54 ("selftests: ntsync: Add a stress test for contended waits.")
> Cc: Elizabeth Figura <zfigura@codeweavers.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Update subject and description to reflect that the patch fixes build
>     warnings 
> 
>  tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> index 3aad311574c4..d3df94047e4d 100644
> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -11,6 +11,7 @@
>  #include <fcntl.h>
>  #include <time.h>
>  #include <pthread.h>
> +#include <unistd.h>
>  #include <linux/ntsync.h>
>  #include "../../kselftest_harness.h"
>  
> @@ -1277,8 +1278,7 @@ static int stress_device, stress_start_event, stress_mutex;
>  static void *stress_thread(void *arg)
>  {
>  	struct ntsync_wait_args wait_args = {0};
> -	__u32 index, count, i;
> -	int ret;
> +	__u32 count, i;
>  
>  	wait_args.timeout = UINT64_MAX;
>  	wait_args.count = 1;
> 

LGTM.

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>



