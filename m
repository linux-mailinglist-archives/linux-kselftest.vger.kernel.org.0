Return-Path: <linux-kselftest+bounces-44152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875EAC120DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA15585EE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C132E6B9;
	Mon, 27 Oct 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p8Wf8c+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466A32779A;
	Mon, 27 Oct 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607523; cv=none; b=Ql8P8PxFJZZrYQc75v3WGBvdOeYu9xpCTEHpt9p3QUQglVrFHjhWhrAsQY5LUWOWAF4hfFYWO1SGL3kUk70OAvSkqgGLloqSNWt21G7LeXC8iKTpCB8jhBMNt8QbGmDhlDJjA2gOSLmegWtu+mfTVJ7Bt7mI9jrZhWJCtKl96RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607523; c=relaxed/simple;
	bh=1ZAtv1k7qLg8MgQOvSbxTtTfacA9rWU661BgI+pDVq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AIPhTS4pW52xGtKqnMB2ZTBM+PCi+SZwAKWFPdAX2gUVdLd0g+pTKMvVz0jv6+E5/jx7dhWhCf1wi3en6sP9Q78fVpJ/3UuiP5WyIZgwO9B9PAIwMeJdwH1PqTU/TGczYVhJKCeO80tYzZuY+6gpzNIi2XyBqOMX3wvCu3KBkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p8Wf8c+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C715C4CEF1;
	Mon, 27 Oct 2025 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761607522;
	bh=1ZAtv1k7qLg8MgQOvSbxTtTfacA9rWU661BgI+pDVq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p8Wf8c+3emDUEx/LKVNdgfy7OmdSHq8XWZ6wFAuaK1FwwE4aWRE5ucLMWzj4UouZG
	 /34e/TnVpdrTlsD1PWMyzRg0VDxDMkVEYHyPNBW+lsL+tamb4jIR2A3LTpLCB/5Y6O
	 n3lwF4kGPjgZRHinYZasxHvUwi1icLTF2VMUFhgc=
Date: Mon, 27 Oct 2025 16:25:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Wei Yang
 <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-Id: <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
In-Reply-To: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 17:04:39 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:

> Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
> warning due to potential unaligned pointer access:
> 
> perf_test.c:239:38: warning: taking address of packed member 'write_index'
> of class or structure 'user_reg' may result in an unaligned pointer value 
> [-Waddress-of-packed-member]
>   239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
>       |                                             ^~~~~~~~~~~~~~~ 
> 
> Use memcpy() instead to safely copy the value and avoid unaligned pointer
> access across architectures.
> 
> ...
>
> --- a/tools/testing/selftests/user_events/perf_test.c
> +++ b/tools/testing/selftests/user_events/perf_test.c
> @@ -201,6 +201,7 @@ TEST_F(user, perf_empty_events) {
>  	struct perf_event_mmap_page *perf_page;
>  	int page_size = sysconf(_SC_PAGESIZE);
>  	int id, fd;
> +	__u32 write_index;
>  	__u32 *val;
>  
>  	reg.size = sizeof(reg);
> @@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
>  	ASSERT_EQ(1 << reg.enable_bit, self->check);
>  
>  	/* Ensure write shows up at correct offset */
> -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> +	ASSERT_NE(-1, write(self->data_fd, &write_index,
>  	                    sizeof(reg.write_index)));

Simply casting &write_index to void* would fix this?

>  	val = (void *)(((char *)perf_page) + perf_page->data_offset);
>  	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);

