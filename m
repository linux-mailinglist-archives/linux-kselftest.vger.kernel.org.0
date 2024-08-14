Return-Path: <linux-kselftest+bounces-15308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF595191C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 12:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915C01C22BD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DA1AE02E;
	Wed, 14 Aug 2024 10:40:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EF137772;
	Wed, 14 Aug 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632022; cv=none; b=UsElw0p7jh1ypRQLDtS2qAGLZ2gFfCKXrU3mMvz3Qtf+mLwCknhUThDLIWLy4s2LY2KBSguuGeYPZfzoh/3lnBwLee2uBRVJyMBzYuNBjk0f4f0dqlAxRUt+gMEejOmSGC3C9d2FY1trEnX+KRIhXOt6p2M5mBLw/tm6zVp1NAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632022; c=relaxed/simple;
	bh=yONxehNp5hgxhsnNP+XGe8/9pZ3v1iiUBkf6T/K2+JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLVcdTV+/QnjtCdBFDV704GPAjRg/ym96QWeQimKopYhvI9WSs5ddSwJIzCtpRnNMOgoldvzrGS1a+gV9lOWJUVs/5fTLCgd5o7YHrvt8zxDBBsr81/Fso4B7/fPIqSqgoI9hYd+4ZjhSFacFd7xZMwzLq47mKoagswCxFBy8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C0C32786;
	Wed, 14 Aug 2024 10:40:17 +0000 (UTC)
Date: Wed, 14 Aug 2024 11:40:14 +0100
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
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v8 1/9] Documentation: userspace-api: Add shadow
 stack API documentation
Message-ID: <ZryJjiWbZltfyIH1@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-1-0acf37caf14c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-clone3-shadow-stack-v8-1-0acf37caf14c@kernel.org>

On Thu, Aug 08, 2024 at 09:15:22AM +0100, Mark Brown wrote:
> There are a number of architectures with shadow stack features which we are
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

