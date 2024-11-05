Return-Path: <linux-kselftest+bounces-21454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE79BCC15
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6701F22235
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EB1D2B2A;
	Tue,  5 Nov 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="XmK/AzQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0A1C07D9;
	Tue,  5 Nov 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807204; cv=none; b=hJFRsiocJLLiw7KEeSWx+Qa/XTVl77Zf5NarsF4R2hsHGDfE9fJUQSEm5LMAyiJO+/kqaGEMA0qoeNcuzzQOd2xeDvLMGjl5dlb5ZRqd43NQ631qAgpH4XdxkGe9nqOGfLQr22+tCK/FaUSL8XzbZfo0N9c61N6F8DHmy6PgW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807204; c=relaxed/simple;
	bh=CJiyeokDj6c9VIvYdrBd9CQEjiOeVmC3TfnoQ0s8ow4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGFhqKHlkEaVC/PmpLh0hTWXoDHnaspNc/hA02n7/DuK0ZT2zgA7V0SO4svMRLRm12szb27E9RxDLMiVTULWrdGS7EmvqKUv+GV4zUK7m9PUisoZK73jVdImNvcgywt8AVfEmniVXENyfX0D3254Glb0mPA4Frizf6p4oSs1TE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=XmK/AzQb; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 44B3F26760;
	Tue,  5 Nov 2024 11:46:38 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id BDCD93E859;
	Tue,  5 Nov 2024 11:46:29 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id F067140078;
	Tue,  5 Nov 2024 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1730807187; bh=CJiyeokDj6c9VIvYdrBd9CQEjiOeVmC3TfnoQ0s8ow4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XmK/AzQbLW3MPx5gEe4Pzv/y2uk/+okvNMd7CzxkK4V3C00d+9T9oFCs2GsFDG6UP
	 mJDLoHy/yhq3GqOufIL9dYQ6sh+bqgZ2Wcyz5GkWmspOrzvKdUC2J5iwvGFubrilWl
	 jrQnth5Eo9G3HIStdGHBua6Lx/dUCnnAMN3vgwuM=
Received: from [198.18.0.1] (unknown [58.32.43.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 478E441500;
	Tue,  5 Nov 2024 11:46:24 +0000 (UTC)
Message-ID: <48a22231-89ec-460b-913b-54af18166da7@aosc.io>
Date: Tue, 5 Nov 2024 19:46:21 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
References: <20240927131355.350918-1-bjorn@kernel.org>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20240927131355.350918-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F067140078
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,fb.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 9/27/2024 9:13 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> libbpf does not include the per-arch tools include path, e.g.
> tools/arch/riscv/include. Some architectures depend those files to
> build properly.
> 
> Include tools/arch/$(SUBARCH)/include in the libbpf build.
> 
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   tools/lib/bpf/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 1b22f0f37288..857a5f7b413d 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -61,7 +61,8 @@ ifndef VERBOSE
>   endif
>   
>   INCLUDES = -I$(or $(OUTPUT),.) \
> -	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
> +	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
> +	   -I$(srctree)/tools/arch/$(SRCARCH)/include
>   
>   export prefix libdir src obj
>   
> 
> base-commit: db5ca265e3334b48c4e3fa07eef79e8bc578c430

This fixes building of bpf tools, thanks! You can add the following tags...

Reported-by: Andreas Schwab <schwab@suse.de>
Closes: https://lore.kernel.org/all/mvmo74441tr.fsf@suse.de/
Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>
-- 
Best Regards,
Kexy Biscuit

