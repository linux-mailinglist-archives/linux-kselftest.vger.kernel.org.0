Return-Path: <linux-kselftest+bounces-42861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6BFBC3171
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 02:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6473C66C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556D2877DB;
	Wed,  8 Oct 2025 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF8Ordug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D642AA6;
	Wed,  8 Oct 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884802; cv=none; b=PhB90da7QVu+aFmMqtViEFfhVNwfxkcKq2+dRjck+5ma8AncneYFjqEQWj1Qp+WY0KsBszge5f+G7hV5L0FCD0jt/rcG8m9q+0BDD8NyWK0b87cuO00h3SquvPV3znuE10XKECul42URbTj12fEyyXPjOyOLbJvuEIZWdakfEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884802; c=relaxed/simple;
	bh=JBSbaU3wurx+m2j0pr63W/ZFMfMHTM+A8wgPiiU/SYc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WSyKa/pMjGJSnuoO+mv5YRN7p/NIUk+LbRKNxY/FwRQ1yknZ8JXHTLx3cXpnnzNIBbq0nnx3/XhPYOLMcWa5p6Ump5gd8ZMAJDlpBJWNcIJasW2SdCeKPufpuYPjJl8ANUoft5zOSf5l2uNx5wCcW5SBFSVZ/0QDGu6kcOw2A7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF8Ordug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6422C4CEF1;
	Wed,  8 Oct 2025 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759884801;
	bh=JBSbaU3wurx+m2j0pr63W/ZFMfMHTM+A8wgPiiU/SYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CF8OrduggTOOSUWladRyJnTQfe9dtCi59iklpTstA+mh2Guq7td4ttx0OEkNui5RQ
	 eWUQ9B88jsQ011p8X4ZtaHNmpiQIVJg9lhNs5o++vCcPA1L2tIRK9FlCmsoyPDYP2S
	 1+kEYydPjDInn+maKn+okoy8YNfSJh7/J9Ne/XAnAnB1G6X5xX2IIPbKfNnZ0RhJk1
	 IEOwFqPcDxJsnQxZcY1Vn7oLolFyNG7VSNIaoaCraz/iH0XEMNj+sUCcEAW6rFhuXQ
	 9deROXRuEdGSxHSflkNR3LaYmkArlejpga95lFHLkjfR5p4oieQ6ru/vhJCwTJESm/
	 9GuJ8w7sY3vhw==
Date: Wed, 8 Oct 2025 09:53:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 hca@linux.ibm.com, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT
 for list/wildcard
Message-Id: <20251008095316.cf24f13a84a454ddbf530120@kernel.org>
In-Reply-To: <20251004235001.133111-3-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
	<20251004235001.133111-3-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This should be a part of [3/5], because when bisecting, the test will check the
README file and check the feature.

Thank you,

On Sun,  5 Oct 2025 08:46:56 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  kernel/trace/trace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b3c94fbaf002..ac0d3acc337e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5524,7 +5524,8 @@ static const char readme_msg[] =
>  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
>  #endif
>  #ifdef CONFIG_FPROBE_EVENTS
> -	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> +	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> +	"\t                (single symbols still accept %return)\n"
>  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
>  #endif
>  #ifdef CONFIG_HIST_TRIGGERS
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

