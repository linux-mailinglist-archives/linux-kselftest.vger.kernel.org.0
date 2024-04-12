Return-Path: <linux-kselftest+bounces-7816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775BE8A334D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160131F246BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3061494C2;
	Fri, 12 Apr 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhtgdG9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA11487EB;
	Fri, 12 Apr 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938190; cv=none; b=Uw4RrDaiQzGa4qeArQjsb6oj3Re2rR3P5DzVVGopEzB2tBOfcUrBIalcRwQviooq1ciNsn8Qj+ZvUMxP9Gdv34lvKz6hF964ZTQ0Ee0nGjLJDg3l73KCWVg9iWBKPZcwWHycnfthGpy0hlkB/NdPzJFhUFuaF4XyradZQwD9Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938190; c=relaxed/simple;
	bh=NHEosDAr8Rb4zus1id61A96KJAOMQUosPKWpMjsuoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLV5NSI3oCPWfkzfAPZKBbpN7e0uHHdXbIEqiDmc3knHR5riszpwDhCYKGo1vn2BbnmYun+YbNNOV5ZYoAwpJyQmLl8R+CRhejG+I+g7EHxcjIJMdWE1iG8+FuiTBLjkgPb3ui5UQ2SyYcehuJZXHemzptX3TdEpp6+4DVt9JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhtgdG9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92823C113CC;
	Fri, 12 Apr 2024 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938190;
	bh=NHEosDAr8Rb4zus1id61A96KJAOMQUosPKWpMjsuoMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhtgdG9+Gv7WDPh93a8RcZRn5LmUGW8J3FrZjyxaym4sjg5hScyJ5ZHDbl7ToE4kF
	 NhBd4IwZROEiTjGKRge+mkoR219UDgYrNAWPJ0N2AzyLFCO+8y3hd/ziZ0xrwDxwNC
	 AeBc8NTb4IClRXlC6Zhykgfvmxy01tEdpqR6ONTuLb/f7h5SaCkpU91qNmKKkaUaZy
	 lHDQKCVXg9vn4WXzQalHW5TfnMA6Fx7CsFC6p1qckePQSuJOhBTFIWL9lHsrnWt80W
	 CWxAYSq/wMasawkgQrCD2RTjA43PoML54gWT5bizPQLVDYJkAh6qR1/5DJ+TrIKAVg
	 xzjMBSTi87Mqg==
Date: Fri, 12 Apr 2024 09:09:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, shuah@kernel.org
Cc: oleg@redhat.com, anna-maria@linutronix.de, frederic@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] kselftest: Mark functions that unconditionally call
 exit() as __noreturn
Message-ID: <20240412160947.GA2252629@dev-arch.thelio-3990X>
References: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
 <87sezqzsys.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sezqzsys.ffs@tglx>

On Fri, Apr 12, 2024 at 02:05:47PM +0200, Thomas Gleixner wrote:
> On Thu, Apr 11 2024 at 11:45, Nathan Chancellor wrote:
> > I have based this change on timers/urgent, as the commit that introduces
> > this particular warning is there and it is marked for stable, even
> > though this appears to be a generic kselftest issue. I think it makes
> > the most sense for this change to go via timers/urgent with Shuah's ack.
> > While __noreturn with a return type other than 'void' does not make much
> > sense semantically, there are many places that these functions are used
> > as the return value for other functions such as main(), so I did not
> > change the return type of these functions from 'int' to 'void' to
> > minimize the necessary changes for a backport (it is an existing issue
> > anyways).
> 
> Hrmm. This really want's to be fixed once the change hits Linus tree as this:
> 
> static inline __noreturn int ksft_exit_pass(void)
> 
> looks seriously broken :)

Yeah, I only realized this morning that prior to this change, making
these functions return void instead of int would have broken

  int main(void)
  {
    <code>
    ksft_exit_pass();
  }

because without __noreturn, the compiler will complain that main() is
missing a return value. So 'int' -> '__noreturn void' would have been
the proper atomic change but the use of 'return ksft_exit_...();' made
that seem rather difficult when I was writing/testing that change on top
of this one.

However, now that I am actually sitting down and looking at it with a
fresh perspective, I am able to produce a pretty mechanical looking
change with just two sed commands:

  sed -i 's;__noreturn\(.*\)int;__noreturn\1void;g' tools/testing/selftests/kselftest.h &&
  sed -i 's/\(\s\+\)return\s\+\(.*ksft_exit_x\?\(fail\|pass\|skip\)\)/\1\2/g' $(git grep -lP 'return.*ksft_exit_x?(fail|pass|skip)' | sed s/:/-/g)

Perhaps Shuah could just run that in the kselftest tree and commit the
result once the change from Linus's tree is merged there? Otherwise, I
am happy to send a formal patch once I have something proper to base on.

Thanks for taking just the minimal change :)

Cheers,
Nathan

