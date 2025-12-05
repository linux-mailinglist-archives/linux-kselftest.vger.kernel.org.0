Return-Path: <linux-kselftest+bounces-47214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CCCA97CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7DE303A8D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4374C2D3A75;
	Fri,  5 Dec 2025 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgRjFJXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156161917ED;
	Fri,  5 Dec 2025 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973295; cv=none; b=YZTKjqctk1GsPZ1uV5kZAhMyV8hTzL4Ss0Sn+QH0C3qQUMT3QvB7N1DWzvL4dzPrzaAGxEOICz59BG4gfAPuiu9LaeIvHbQO58OH46HmOPvAmgLTNIG006w5uuVgcj4zV4lzvfKsCKfmGyP/epCmeoKzszjB0ikQoIjENCadvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973295; c=relaxed/simple;
	bh=PlYPjSe/WtTei2KOWQ2XY7wXUNPiqzN2chnzfwHdaT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU3adBp0wTAc93ZAinDBqs05ux4ZBolGmtg3S00AUlS14dq5y1DC+YsOqgJ+KvaMfjiNy+b8OYjo0RroxvXFhabDeREPiE6CYVUSNrTZOrMPIi2WqdIJE3tjiH87ZgnLOurlf5FiXFEO/sOlo+ozQrVwexYwA77+EyVXhdtmjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgRjFJXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57C8C4CEF1;
	Fri,  5 Dec 2025 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764973294;
	bh=PlYPjSe/WtTei2KOWQ2XY7wXUNPiqzN2chnzfwHdaT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgRjFJXFeifPSSzBXQmA2uLG1aRvj0vvNAxd6XBuUSPqtOTjGHq8rNl2azU8a+tuf
	 zOG5hhYXzy/ksKNwVHpJKpg/rLLIuyt2ULhwr6A50iWUnMD4uC/XgJpsHMPgnK768p
	 Sk+XFxLw3M0edioED9nzLHM0d+prJC2vJGnjYkXSG1yZL21MW0E3GkK+ey4TO5ybJg
	 9GNqODY/GpEkly+lvom5Kizm4w+Lv2GXwdTiRQ9xTPvq3c9Mqe6xo1WlimbHWM1Mm/
	 /32yu+F8MiN5FiLcI4wc4Lohuq3mJQTRWiO2cCI2hSmEfeyemX963MsUYYEIK0jkJL
	 OQFATWW71Y/KA==
Date: Fri, 5 Dec 2025 14:21:34 -0800
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/13] selftests/seccomp: Fix build warning
Message-ID: <202512051421.DCD77D0561@keescook>
References: <20251205171010.515236-1-linux@roeck-us.net>
 <20251205171010.515236-10-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205171010.515236-10-linux@roeck-us.net>

On Fri, Dec 05, 2025 at 09:10:03AM -0800, Guenter Roeck wrote:
> Fix:
> 
> seccomp_bpf.c: In function ‘UPROBE_setup’:
> seccomp_bpf.c:5175:74: warning: pointer type mismatch in conditional expression
> 
> by type casting the argument to get_uprobe_offset().
> 
> Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

