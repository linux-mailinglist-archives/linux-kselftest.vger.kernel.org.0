Return-Path: <linux-kselftest+bounces-394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29737F3A67
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 00:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102091C20E21
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1A5B1F1;
	Tue, 21 Nov 2023 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EKDEOdC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E25B1E0
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 23:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFDC433C7;
	Tue, 21 Nov 2023 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700610182;
	bh=0E+9caTXrjQBwJBAJqwRJSyBT3yHDxmE++P218ayimA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKDEOdC1PQipolVADz3Mdu8p01F13vBXUgruoliE3VXEOhIo92kl/ONeZPZ5q3yEy
	 pbUWjEWo+jiQRjiqcsp4W4kgRR+8y9W7iwRnH5hX/3B0bn5Qo4srL2BqkGWIAMG7/4
	 M8ZIXCBV0Jy9cK8/jXh0JsUFhUjCvwT2NydNUomg=
Date: Tue, 21 Nov 2023 15:43:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: mathieu.desnoyers@efficios.com, cyphar@cyphar.com,
 dverkamp@chromium.org, jeffxu@google.com, keescook@chromium.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/memfd: fix a memleak
Message-Id: <20231121154300.734732c744f272214e160a3c@linux-foundation.org>
In-Reply-To: <20231121025506.2391-1-zhujun2@cmss.chinamobile.com>
References: <12dd2fb2-0fac-4763-ad34-02af9653f91b@efficios.com>
	<20231121025506.2391-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 18:55:06 -0800 zhujun2 <zhujun2@cmss.chinamobile.com> wrote:

> The memory allocated within a function should be released
> before the function return,otherwise memleak will occur.
> 
> ...
>
> --- a/tools/testing/selftests/memfd/fuse_test.c
> +++ b/tools/testing/selftests/memfd/fuse_test.c
> @@ -217,6 +217,7 @@ static pid_t spawn_sealing_thread(void)
>  		abort();
>  	}
>  
> +	free(stack);
>  	return pid;
>  }

We just freed a thread's stack while it is still running?


