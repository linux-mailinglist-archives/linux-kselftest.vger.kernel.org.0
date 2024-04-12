Return-Path: <linux-kselftest+bounces-7797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A28A2DF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AAB21DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61F54FB1;
	Fri, 12 Apr 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0Hzsc3D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8bhR31+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E154646;
	Fri, 12 Apr 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923551; cv=none; b=J4EfwvWGJ8U8HCihjkklkvyq7+JfJmSn6WUS7MS/ymE3ZAKX+i9dpSDW3FF2PJqgHZ1Tgx7JBnTbCx5FdFdhZgjW6W875eFC3jyG0EFo3GFSGFUecoIltSeyEdBzAZptLWOe64HaEh6w23RjvI7HbHr+ZgVQzIYALlSmKsbUXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923551; c=relaxed/simple;
	bh=SBuRsIiZcNrRBF5WG3fb5yJwVUqcB4VIFj16EW9G3ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m75EuPo5nlXBKEEHor/LaWuAiNG2F97Zm5vkMGl2HtA4czwWW6y2nbNyU7AGwj+I2QEaJSthVFqKixbfV+Liu4bmS4AfLdmT82DJDNUsGd3vThhWQTL0EMatUCUh9wHJDMSVY99Y0aFsbAz7myWEyxSfURpu+0naC+NsdLWgcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0Hzsc3D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8bhR31+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712923548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBuRsIiZcNrRBF5WG3fb5yJwVUqcB4VIFj16EW9G3ks=;
	b=I0Hzsc3DpjiEcrZlEzbX7CmWU4X+j8YlOjJRgIpX030Eer2ESlLTkukeTJBW89XroZx04V
	TMb88w0cmPc00kQEB8n7fBFtyR9SvREwITqFyARust0CgLTJTVQ56ik6p7+MVxg5QpkiuY
	PiAyOrKNXvwBwER2ugudRYsCFupjpbB4unmC3fkmlg2JlXt0nvxt7lT1suGSYbLET4WGer
	+E1wT0gaV2FZaUvgQINbu6KHw0FxUivqSJUqf/5099Lkn3wR3CGvWhLfMuIgIDFMhC+vsT
	2lKW0gevM+G+S9zzKGgGTvvnCn3tTQbtI13HUqi7wxqFC5kyzJsApp5HhOd27Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712923548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBuRsIiZcNrRBF5WG3fb5yJwVUqcB4VIFj16EW9G3ks=;
	b=j8bhR31+UROX9BCH4AOHx8ts5vHT2n063r7glHTTv9XnNWez1+cgyLTpUyJ8Iin31Dv6ap
	YIKCCojqeNUpXFDQ==
To: Nathan Chancellor <nathan@kernel.org>, shuah@kernel.org
Cc: oleg@redhat.com, anna-maria@linutronix.de, frederic@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, John Stultz
 <jstultz@google.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] kselftest: Mark functions that unconditionally call
 exit() as __noreturn
In-Reply-To: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
References: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
Date: Fri, 12 Apr 2024 14:05:47 +0200
Message-ID: <87sezqzsys.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 11 2024 at 11:45, Nathan Chancellor wrote:
> I have based this change on timers/urgent, as the commit that introduces
> this particular warning is there and it is marked for stable, even
> though this appears to be a generic kselftest issue. I think it makes
> the most sense for this change to go via timers/urgent with Shuah's ack.
> While __noreturn with a return type other than 'void' does not make much
> sense semantically, there are many places that these functions are used
> as the return value for other functions such as main(), so I did not
> change the return type of these functions from 'int' to 'void' to
> minimize the necessary changes for a backport (it is an existing issue
> anyways).

Hrmm. This really want's to be fixed once the change hits Linus tree as this:

static inline __noreturn int ksft_exit_pass(void)

looks seriously broken :)

