Return-Path: <linux-kselftest+bounces-23741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBD9FB8CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Dec 2024 04:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3455188336A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Dec 2024 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AEB18AE2;
	Tue, 24 Dec 2024 03:04:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8416FB0;
	Tue, 24 Dec 2024 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735009455; cv=none; b=Y+HQubLQ9hjZot6MnprPtlTkLV6dac7adECJQMQa+MB9oIOyRxSx2z0wqf9sCyIurga/WP2Dy09LSEudD+Ldf2gDe638gP9GP8oJDIL58U0At3OQg995dFA2EnG3Gd+xLSF3WI7WDH3wwMQKsxH/zEzhOR1yVfTAZ6kCQ4rOJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735009455; c=relaxed/simple;
	bh=YxA0KHq7c4WL8WEfp7rdnCJqMKDdaSip03Dk/2E0JmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2RajuRPYDn7hO95GLn/WPIUeopZ7lN0r/1HykBR2tesclOsPlp/E08Ib89z3nykByD6ZAdx9IaJc1PmDSC+/tZr8UdCaCjvuGlj2A06G6sRl54DCBslUJiXPcuLMxU1mgPcApdnlFk7+YwGwfnSnZOw4r5B66HpK1xU2+tu+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD6AC4CED3;
	Tue, 24 Dec 2024 03:04:12 +0000 (UTC)
Date: Mon, 23 Dec 2024 22:05:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, aha310510@gmail.com, eadavis@qq.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ring-buffer: Add test for out-of-bound pgoff
 mapping
Message-ID: <20241223220504.4ae4adf2@gandalf.local.home>
In-Reply-To: <20241218170318.2814991-1-vdonnefort@google.com>
References: <20241218170318.2814991-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Shuah,

Care to take this through your tree?

On Wed, 18 Dec 2024 17:03:18 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Extend the ring-buffer mapping test coverage by checking an out-of-bound
> pgoff which has proven to be problematic in the past.
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> index d10a847130fb..a58f520f2f41 100644
> --- a/tools/testing/selftests/ring-buffer/map_test.c
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -233,12 +233,18 @@ TEST_F(map, data_mmap)
>  	ASSERT_NE(data, MAP_FAILED);
>  	munmap(data, data_len);
>  
> -	/* Overflow the available subbufs by 1 */
> +	/* Offset within ring-buffer bounds, mapping size overflow */
>  	meta_len += desc->meta->subbuf_size * 2;
>  	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>  		    desc->cpu_fd, meta_len);
>  	ASSERT_EQ(data, MAP_FAILED);
>  
> +	/* Offset outside ring-buffer bounds */
> +	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
> +		    desc->cpu_fd, data_len + (desc->meta->subbuf_size * 2));
> +	ASSERT_EQ(data, MAP_FAILED);
> +
>  	/* Verify meta-page padding */
>  	if (desc->meta->meta_page_size > getpagesize()) {
>  		data_len = desc->meta->meta_page_size;
> 
> base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69

You can ignore the above "base-commit" (I don't have it), as it applies
fine to v6.13-rc4.

-- Steve

