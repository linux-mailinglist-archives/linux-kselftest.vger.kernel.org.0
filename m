Return-Path: <linux-kselftest+bounces-21311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA89B96B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3682827C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A761CCEC7;
	Fri,  1 Nov 2024 17:40:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C41CCB2A;
	Fri,  1 Nov 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482817; cv=none; b=d238Abe5GFJ+Zy4SGhG84LIQDKaDyw8ACU+x6q4L645ybUfy0KE3Pxvd6y6CLAHF3wGCExpO9bAy10IiKUlHsqqQ8YVecHEKK3Y5+VQR9k150RnrVV75oR2JYzEzH9f8932z3dvC2vtBN+ym7c/hvbFwxHXY2LOF0Lgynybpvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482817; c=relaxed/simple;
	bh=4cy3tc6b8lHBnAtp2nDIXchHjz5zfubHvkayv8p1D/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZw4sOvXCBvlQry7MIeLVVWisn3tYfH2woze8cvfcXlhUuwijmhQDTUC3Pho/g+NmCJyNxdFyGd0+gVpFWQsT6pthsmUhLqknqisGZ1+n80HI/dPBAygHR91OwWGZXBZsknKplfEPBhNIUOnmM3RH7phF6IMPcRVa0OcIfi5Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A92EC4CECD;
	Fri,  1 Nov 2024 17:40:12 +0000 (UTC)
Date: Fri, 1 Nov 2024 17:40:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v12 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Message-ID: <ZyUSesV2rj5-BWYn@arm.com>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
 <20241031-clone3-shadow-stack-v12-1-7183eb8bee17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-clone3-shadow-stack-v12-1-7183eb8bee17@kernel.org>

On Thu, Oct 31, 2024 at 07:25:02PM +0000, Mark Brown wrote:
> Currently as a result of templating from x86 code gcs_alloc_thread_stack()
> returns a pointer as an unsigned int however on arm64 we don't actually use
> this pointer value as anything other than a pass/fail flag. Simplify the
> interface to just return an int with 0 on success and a negative error code
> on failure.
> 
> Acked-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

