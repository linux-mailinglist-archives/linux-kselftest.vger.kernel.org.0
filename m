Return-Path: <linux-kselftest+bounces-21907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1E9C6705
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 03:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D54B28BF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D470809;
	Wed, 13 Nov 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI1KV7hh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5722081;
	Wed, 13 Nov 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463189; cv=none; b=bm7HpwV03bGcolP/bNJYeqwije13hpZCaBEzP6BMVqA+YIZfArkqbGZlqFfIYL1LIwEmdrgZwtEJ6S4wcvzMLfAS9S1ydYg5PAooRKn5Zr95PiesW2ta9pjl2DDXeGtpszjajoMHKUUD/pcXnnq5jAEH0TEO9VtWQbN8ZoMykfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463189; c=relaxed/simple;
	bh=3jl0LqgQBmtO/Ifvfdc//Amn4KbW7yPO9JNv14BIQyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/LoYfxqAwnYCZOHLA+1UK/yFRoX8pHRG7IuRixYGzyFw50holawOvMqzNH809vTV9MS7v/HiEbI+7cIevlDfEQpb1YTCE7YrLL9HFRZwBBANJNOFUODMo9I/kMMrwxrCBI5FXjcYs2O/nlt1J0O7qkyq91gImrnXRUh49C5Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI1KV7hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A34EC4CECD;
	Wed, 13 Nov 2024 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463189;
	bh=3jl0LqgQBmtO/Ifvfdc//Amn4KbW7yPO9JNv14BIQyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GI1KV7hhX4RAJNCX39tPOLzI4eUAIb1uWFXIBkiZb4HCrEt67Ab92aPSb6BFVpaSI
	 Z4Ost0Jst8H8ZEd5zc8SgLRu2/0o00ep8Ovbm6fhP4KI65N1yqLQ1NbqSYxdrH/tkP
	 etcRFjQQrwP+xdhabzpwGyerc86yXLQZ89+bpRBiR6Kg3xf7c8ZBAAW3HVjwoxTYBr
	 b5+JwF3uidwiYAL9E/fe/5hBVEubZD9g9u9iWfV0Rz78f8BrXQNet0IlRUjka4s+H5
	 5BQzOW/bh4MEGJblPP81+w9MB2UJhYinfYim5xq5MsmHqHB4No3YNl2W+9H8dQv6Wr
	 8FOYXHQG1QISw==
Date: Tue, 12 Nov 2024 17:59:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Xu" <dxu@dxuuu.xyz>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>, "David Miller"
 <davem@davemloft.net>, "Shuah Khan" <shuah@kernel.org>,
 andrew+netdev@lunn.ch, "Michael Chan" <michael.chan@broadcom.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Pavan Chebbi"
 <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, "Kernel
 Team" <kernel-team@meta.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rule
Message-ID: <20241112175947.4c308ba1@kernel.org>
In-Reply-To: <d5b21f01-0f19-4580-bb7a-829d46ee7dcb@app.fastmail.com>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
	<dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
	<93831343-03c3-d540-369d-fe82eb480c58@gmail.com>
	<d5b21f01-0f19-4580-bb7a-829d46ee7dcb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 17:51:50 -0800 Daniel Xu wrote:
> > This won't match the output from your ethtool patch, because that
> >  removes the colon.  Probably want to wait until the patch is
> >  finalised and then write a regex that matches both versions.  
> 
> Argh, I meant to have wildcards here. But yeah, makes sense, will wait
> until the other patch is finalized.

Keep in mind Michal scans ethtool patches once every week or two,
so there may be a bit of a delay there.

