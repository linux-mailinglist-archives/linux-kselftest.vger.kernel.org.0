Return-Path: <linux-kselftest+bounces-20260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7A9A696F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CE282A29
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE71F4719;
	Mon, 21 Oct 2024 13:02:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321BA1EF95C
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515722; cv=none; b=EmvCYDmyxDQ5R3LH/4R6MGZ1OSJElNCt+hp49fivXWoTFLMJ9LsMYj/+V/zjkF7UFSamp4KuTak1TubEQvt845dRcWYlg48PLUK405TwZbhPGOfxWSQL0WsH4M1nrtYWBSWpglYG3fc8ajm0Pt/soovjOjBjRdQLWr5XP09pQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515722; c=relaxed/simple;
	bh=mZZTLI6Qt0QYpVDe+MMN/cI+2Cv/i8r3qpJHHdjWeT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUG9Fw61ROVE3bO8Rsj57m+VuN+BYbNhig3AAt+D2i/io0wCu47fviCEl4tPcYFN7rs6QSKhegZGB8zInWgSuhuK3h/R8p9yFO/VwpX7ZYRu/l38dEgYgbJXUaJKs8/5m46G1X2Fv2p/LclRrdhz1WT751hfgs5TWTxurfD3kvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A51FC4CEC3;
	Mon, 21 Oct 2024 13:01:59 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:01:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	dave.martin@arm.com, jeffxu@chromium.org, joey.gouly@arm.com,
	shuah@kernel.org, will@kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 1/5] arm64: signal: Remove unused macro
Message-ID: <ZxZQxRWKvGue9Rwt@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-2-kevin.brodsky@arm.com>

On Thu, Oct 17, 2024 at 02:39:05PM +0100, Kevin Brodsky wrote:
> Commit 33f082614c34 ("arm64: signal: Allow expansion of the signal
> frame") introduced the BASE_SIGFRAME_SIZE macro but it has
> apparently never been used.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

