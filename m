Return-Path: <linux-kselftest+bounces-17623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06180973D9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69C3287C7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B7E19E7E0;
	Tue, 10 Sep 2024 16:45:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792A197A7D;
	Tue, 10 Sep 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986755; cv=none; b=nW8WDgwmiuhlEsC7PTjvN+nn2rBBZHNbZ5uYgdbqnzu4UYPHwDAiy2XZjsfndDzsNyE9P14F/v+agPKUyQcLE5R1muntf1c8Qk3NgIJupneqVW8do0rYotewpeyS6pERTWGQ/iC2iJi5IQ20QgacCWqxvNZ2amUB62LlU1e1Ea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986755; c=relaxed/simple;
	bh=fusM7GgOKP08TtZMuMQh8xGhSh2zXVmHpF7OT2kQN40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbLezd+8Sz0yO5vbPH1UhJ82T6zF47UzWb2An0cPscuKZn0aL0BKwAQSkTHiCB1EyE7uw26izzejefTjeH6NRsvnOgOoem23FB99KQPALniX+E9KQtkP2uDSqZzYwD+3qabmAF7xofKIJu86OIFyfUF/3PvhYkvug11MVV4wS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B3C4CEC3;
	Tue, 10 Sep 2024 16:45:54 +0000 (UTC)
Date: Tue, 10 Sep 2024 12:45:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page
 bigger than the system
Message-ID: <20240910124555.180428eb@gandalf.local.home>
In-Reply-To: <20240910162335.2993310-3-vdonnefort@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
	<20240910162335.2993310-3-vdonnefort@google.com>
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

On Tue, 10 Sep 2024 17:23:35 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Handle the case where the meta-page content is bigger than the system
> page-size. This prepares the ground for extending features covered by
> the meta-page.
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> index ba12fd31de87..d10a847130fb 100644
> --- a/tools/testing/selftests/ring-buffer/map_test.c
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
>  	if (desc->cpu_fd < 0)
>  		return -ENODEV;
>  
> +again:
>  	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
>  	if (map == MAP_FAILED)
>  		return -errno;
>  
>  	desc->meta = (struct trace_buffer_meta *)map;
>  
> +	/* the meta-page is bigger than the original mapping */
> +	if (page_size < desc->meta->meta_struct_len) {
> +		int meta_page_size = desc->meta->meta_page_size;
> +
> +		munmap(desc->meta, page_size);
> +		page_size = meta_page_size;
> +		goto again;
> +	}
> +
>  	return 0;
>  }
>  


