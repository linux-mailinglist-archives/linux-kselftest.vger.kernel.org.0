Return-Path: <linux-kselftest+bounces-35857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83FAE9CD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F121C26AF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6F5383;
	Thu, 26 Jun 2025 11:50:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE41BC3F;
	Thu, 26 Jun 2025 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938633; cv=none; b=gCJV5SLbDRHCsQZMJFbjYu5WeT/wYlHvVhJNv3FoRv5KZJvRLZM9RAaa0GIDdOUOuMGTi7zOMVZ0+zwaU6uZTnjm/ctfkc06PgedyB3lWDA1m3SF8nLP5M5tJJR+T2TRXVe1OWB2YK6AJzKjn9V/E1sewQYFxV7vb8FPqPWyLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938633; c=relaxed/simple;
	bh=OfX4Eo7aN2GspjGM6Q+odK6g64AxLCY6cZFORjYH9lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTJVjmSGT0O8VxAGKeY4Hqz3R51mR4IFGi0oS1kEfgIzh5uDAnUJiee3UI6A7+9ajMo9nOKJowW5FhLytTZg/6QOY40DHOJgNJNGnkt4EPa808ggANhNzZCEvl+pZhywtqO1cwPWQG8t4DSIBz1DTPKTrLg+WekZfs8PLeTT2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C78B1758;
	Thu, 26 Jun 2025 04:50:13 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F1173F63F;
	Thu, 26 Jun 2025 04:50:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:50:23 +0100
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
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v17 3/8] selftests: Provide helper header for shadow
 stack testing
Message-ID: <aF0z_7Q_ETj7Cjro@arm.com>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
 <20250609-clone3-shadow-stack-v17-3-8840ed97ff6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-clone3-shadow-stack-v17-3-8840ed97ff6f@kernel.org>

On Mon, Jun 09, 2025 at 01:54:04PM +0100, Mark Brown wrote:
> While almost all users of shadow stacks should be relying on the dynamic
> linker and libc to enable the feature there are several low level test
> programs where it is useful to enable without any libc support, allowing
> testing without full system enablement. This low level testing is helpful
> during bringup of the support itself, and also in enabling coverage by
> automated testing without needing all system components in the target root
> filesystems to have enablement.
> 
> Provide a header with helpers for this purpose, intended for use only by
> test programs directly exercising shadow stack interfaces.
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Tested-by: Kees Cook <kees@kernel.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

