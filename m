Return-Path: <linux-kselftest+bounces-17622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CB973D98
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F198B285E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74041922F4;
	Tue, 10 Sep 2024 16:45:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6E41746;
	Tue, 10 Sep 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986741; cv=none; b=qrE5tkC4UG05ot/W6LXVQ30RZhQRvGILRmWxsQ/6QWZhAttQTIC9XdNuXTcYcEgagM8aG5y/2IciMyQRCp+5FZQzqeolbg7fSGQfcU9+i9vIbPEvvUvOZLvMh8baPvijFBQCGD01wSr4PxKRo22r2rCHc4Xy7Ce/ETtSGT9GILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986741; c=relaxed/simple;
	bh=9nuz7KBsRmTZjf7Of9Sr97RXKva1r0kaa96eGnUzNqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTWBP6aEKY+pnrKr4mcVcrapTlzU3oSPfpgwQtopCDgEKRVR3EDjZ6xkCaEguPtW2u7yJEVtWyLghDiyooaUDtHpbYtju84TKLT+w3FSoYdxsFhkRY4zUs7mbvcgWrHsqXYSH3dxdm378QlJBHLe2oEtMMxB20AHY/4d7Pu+aBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95872C4CEC3;
	Tue, 10 Sep 2024 16:45:40 +0000 (UTC)
Date: Tue, 10 Sep 2024 12:45:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
Message-ID: <20240910124541.23426cee@gandalf.local.home>
In-Reply-To: <20240910162335.2993310-2-vdonnefort@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
	<20240910162335.2993310-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Shuah,

Can you take this through your tree?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


On Tue, 10 Sep 2024 17:23:34 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Improve the ring-buffer meta-page test coverage by checking for the
> entire padding region to be 0 instead of just looking at the first 4
> bytes.
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> index 4bb0192e43f3..ba12fd31de87 100644
> --- a/tools/testing/selftests/ring-buffer/map_test.c
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -231,15 +231,15 @@ TEST_F(map, data_mmap)
>  
>  	/* Verify meta-page padding */
>  	if (desc->meta->meta_page_size > getpagesize()) {
> -		void *addr;
> -
>  		data_len = desc->meta->meta_page_size;
>  		data = mmap(NULL, data_len,
>  			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
>  		ASSERT_NE(data, MAP_FAILED);
>  
> -		addr = (void *)((unsigned long)data + getpagesize());
> -		ASSERT_EQ(*((int *)addr), 0);
> +		for (int i = desc->meta->meta_struct_len;
> +		     i < desc->meta->meta_page_size; i += sizeof(int))
> +			ASSERT_EQ(*(int *)(data + i), 0);
> +
>  		munmap(data, data_len);
>  	}
>  }


