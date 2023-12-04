Return-Path: <linux-kselftest+bounces-1080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E460E803E84
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0921F210D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1D3174C;
	Mon,  4 Dec 2023 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CU1mRtxl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1882E847
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 19:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3AEC433C7;
	Mon,  4 Dec 2023 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701718641;
	bh=lK4GudktDVgm1iuvrLvxPY0Vvf+ce66Q63DHjs/RTW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CU1mRtxln5V5eOtpL7+7SyMQktbwgW6FxcuGkF2oQlwFTt6OKwrGbmDIrbqfkP3on
	 8iHIhNCuADWxll7p8Z6ymnPxlRHC4jlmvI3zZfGMTfsqu9EaRNHgUhQwVVsPOgSvbR
	 O5/q7newgVZ/fzt0iDlD28Wm/Zu67iP5evG1Jpsc=
Date: Mon, 4 Dec 2023 11:37:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: shuah@kernel.org, adobriyan@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] Fixed an open function not judging the return value and
 closed the open function
Message-Id: <20231204113720.3c6ccf7b8eb11eda942d1215@linux-foundation.org>
In-Reply-To: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
References: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 03:05:54 -0500 liujing <liujing@cmss.chinamobile.com> wrote:

> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/proc/proc-pid-vm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index cacbd2a4aec9..5fc9b46f236f 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -205,7 +205,12 @@ static int make_exe(const uint8_t *payload, size_t len)
>  	/* Avoid ETXTBSY on exec. */
>  	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
>  	fd1 = open(buf, O_RDONLY|O_CLOEXEC);
> +	if (fd == -1) {

fd1

> +		exit(1);
> +	}

unneeded braces

>  	close(fd);
> +	close(fd1);
>  
>  	return fd1;

Returning an fd which we just closed is clearly wrong.

