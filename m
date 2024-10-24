Return-Path: <linux-kselftest+bounces-20556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF59AECC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6181C2330A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3521F80C3;
	Thu, 24 Oct 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5chs4SY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841271F4FC2;
	Thu, 24 Oct 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788998; cv=none; b=Ck5dDPZXRlbotdUuAeTB043Xu+EEP56kDS9j5szPFNb0AITLzIis0bKXZqjmY4pFQXTkD60HJqyZ1YHFbaFVy6ypw9yHg56wKqvyQUoEwJPvfZjHggSuuaZHVW2EK+5cB6PJMwtFTbgW2xWFylBQMvtsloExqo2ylNSRAYX3ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788998; c=relaxed/simple;
	bh=Q3vOXPfJT/INigL8mIrrdwhrgZmFE+XCSPM/ddS9CPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaALtRIJlLyCZmpOS8kijaLU1v8zLspKXlCFn3XJBAO1G67uTEUpA9Znj8pa6qCnhE7M8+WljppSvGzZ69httmJht3poZoQqCmoGdnunxn9VvT8kfUDxJ2WB1mmiyYsuuNdfAFob8yMSEPZFcpS7gRKo+chA/srDNGd2xbBf4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5chs4SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2882C4CEC7;
	Thu, 24 Oct 2024 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788997;
	bh=Q3vOXPfJT/INigL8mIrrdwhrgZmFE+XCSPM/ddS9CPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5chs4SY3nApjWplssFcmrXCHedjni9kQVlrs54LKctS7hREFi0cD26Z4rbHSFyiR
	 XwN7dnDoee5muCTHROAzoIs6WU1GtSfi55U1jJZgG2I0XAEJX4TL/tL/LYQJCnKfXr
	 regMFacd8pXDQrE0cbdutB0gxtPadh3sZp9NgxVH9mJJLO825vPzUxDC45QK/s85at
	 GZklfXorqSX1CILLOXZYLvVqjWWkcMydWPd0bhGE2OnEqlP1JV9lFwHHKtfSYKUwsB
	 cEwBkdzlsCSeAyx4tnBl+PLK5m/Fz+f/PRCKsznni7qt8O2cITpA1NaY66DLmEJpPN
	 v3b7VXaBsPAYA==
Date: Thu, 24 Oct 2024 06:56:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix function pointer type mismatches in BPF
 selftests
Message-ID: <Zxp8Q4mmNFoHYFXg@slm.duckdns.org>
References: <20241024051608.358683-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024051608.358683-2-vishalc@linux.ibm.com>

On Thu, Oct 24, 2024 at 10:46:09AM +0530, Vishal Chourasia wrote:
> Fix incompatible function pointer type warnings in sched_ext BPF selftests by
> explicitly casting the function pointers when initializing struct_ops.
> This addresses multiple -Wincompatible-function-pointer-types warnings from the
> clang compiler where function signatures didn't match exactly.
> 
> The void * cast ensures the compiler accepts the function pointer
> assignment despite minor type differences in the parameters.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

