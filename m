Return-Path: <linux-kselftest+bounces-31743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B63A9E54F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 02:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C4D3B9FBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070B747F;
	Mon, 28 Apr 2025 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="13pVZAzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918D522A;
	Mon, 28 Apr 2025 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799189; cv=none; b=AkygeV4b3QVEnPM7FtSrNDvst833R8oHTlNqBQY6eUF4YRJqCSl5Nc+0wTsrnpQgrN7APrzx4R+Psr7HX9uMcD2cCxGYwXhjjY5lyEGzVSr1OdK+KgjaDxZa+/9y+Yif/Mxs+UbNLBhn9c2uYPwe/LbtrvHItpQ3ly4pX46r/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799189; c=relaxed/simple;
	bh=ZTamBMCve2lFpnHfPi0T31Vkk8EBZKIoOuJEWSiRVAI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S5lc4FuLtJ/ssMTBKGLQbTGzsHvHdEy5579Ki2HLlrs8ypjM2PQnJ1Z/8d8DTkEPuQZXIs6WO2saqCf2DsaWziHdKJHSe7pPGB032Nxk6aXVF+xZeHACIoANCdiOZnoSnWBu2gCiB6aUrAmdbCnkkxaGJMrqpfPvq8R9lBKWnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=13pVZAzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4348CC4CEE3;
	Mon, 28 Apr 2025 00:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745799188;
	bh=ZTamBMCve2lFpnHfPi0T31Vkk8EBZKIoOuJEWSiRVAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=13pVZAzyalk42k8saklNaMlpHkgijLAOax8tDoptMbkcY9z5cBCHE1+QIaSOalQ7O
	 V41kgg7m+FGzBXfAnoFJSfODddBulRSsFaBa59DfLdkdoTzxUFgCLCclQWi8IdIk/t
	 G0wQmyxpUIulPkfI7wMeswWLLiqfPKS78UQHdluU=
Date: Sun, 27 Apr 2025 17:13:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Siddarth G <siddarthsgml@gmail.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] selftests/mm: use long for dwRegionSize
Message-Id: <20250427171307.876badf3d5606cf502b7f46f@linux-foundation.org>
In-Reply-To: <20250427102639.39978-1-siddarthsgml@gmail.com>
References: <20250427102639.39978-1-siddarthsgml@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 15:56:39 +0530 Siddarth G <siddarthsgml@gmail.com> wrote:

> Change the type of 'dwRegionSize' in wp_init() and wp_free()
> from int to long to match callers that pass long or
> unsigned long long values.
> 
> wp_addr_range function is left unchanged because it passes
> 'dwRegionSize' parameter directly to pagemap_ioctl, which expects
> an int.

Thanks.  Does this fix any known compile-time or runtime issues?

