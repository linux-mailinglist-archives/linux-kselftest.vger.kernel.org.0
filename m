Return-Path: <linux-kselftest+bounces-21693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310219C2061
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D950F1F2359F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C12071EC;
	Fri,  8 Nov 2024 15:29:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E990206E8B;
	Fri,  8 Nov 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079781; cv=none; b=ZNjscCpksKS9rslfYBE1MZwOWbi7r8JNPh8juPOSWYjGm1TzXm4thk8T96DlqOIp7qnBOe98qd54Ap4frFbpUPKM/QAMJL2mMgfFl171AWKjXQ2/qFSB7O+RziD1xsmW3v19K2XkH0h0zHO1wf4kJjMGu4aFGwGka7B2+nOVEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079781; c=relaxed/simple;
	bh=OgOUF3U0a2BsZnXZXlc2ZHlVQ3+YhG5YZ5u+RpMUKiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYiHsYCQ2V2ddqaqly8X4hvROqFlHEeH9Flo9nyri8hh0RmCfiopmE6GWViUqJ01qHvuNxBFKQDp0o4BmJfJYYtr+Rz0aeGEPTfcVsseFq7SXbR257z2jw/NWb6PI/kvNCj7i8phWGvmpcQTVPIuCpA1HusJoUIqLtOpArhlV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F9CC4CECD;
	Fri,  8 Nov 2024 15:29:39 +0000 (UTC)
Date: Fri, 8 Nov 2024 15:29:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build with stricter assemblers
Message-ID: <Zy4uYZVkIR8ntUIV@arm.com>
References: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
 <Zy4t-tHV18D6BrXJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4t-tHV18D6BrXJ@arm.com>

On Fri, Nov 08, 2024 at 03:27:58PM +0000, Catalin Marinas wrote:
> On Fri, Nov 08, 2024 at 03:20:46PM +0000, Mark Brown wrote:
> > While some assemblers (including the LLVM assembler I mostly use) will
> > happily accept SMSTART as an instruction by default others, specifically
> > gas, require that any architecture extensions be explicitly enabled.
> > The assembler SME test programs use manually encoded helpers for the new
> > instructions but no SMSTART helper is defined, only SM and ZA specific
> > variants.  Unfortunately the irritators that were just added use plain
> > SMSTART so on stricter assemblers these fail to build:
> > 
> > za-test.S:160: Error: selected processor does not support `smstart'
> > 
> > Switch to using SMSTART ZA via the manually encoded smstart_za macro we
> > already have defined.
> > 
> > Fixes: d65f27d240bb ("kselftest/arm64: Implement irritators for ZA and ZT")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  tools/testing/selftests/arm64/fp/za-test.S | 2 +-
> >  tools/testing/selftests/arm64/fp/zt-test.S | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
> > index 95fdc1c1f228221bc812087a528e4b7c99767bba..9c33e13e9dc4a6f084649fe7d0fb838d9171e3aa 100644
> > --- a/tools/testing/selftests/arm64/fp/za-test.S
> > +++ b/tools/testing/selftests/arm64/fp/za-test.S
> > @@ -157,7 +157,7 @@ function irritator_handler
> >  
> >  	// This will reset ZA to all bits 0
> >  	smstop
> > -	smstart
> > +	smstart_za
> 
> And is smstop ok for assemblers? I think I got the error first on
> smstop with my toolchain.

Ah, we already have a macro for that. Let me check the error I got,
maybe I got confused (with the multitude of other warnings ;)).

-- 
Catalin

