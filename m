Return-Path: <linux-kselftest+bounces-38036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7EB1458B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 03:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87B03B7C7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 01:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7E6192D6B;
	Tue, 29 Jul 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmXsFJJv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26273C38;
	Tue, 29 Jul 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751263; cv=none; b=roG43IyvKwVDt3/Dsyo3L+/iuRAcegZ94sQ/sji9TrqLUN5U8LI0hVLHBZ1U4FMexACqE/LLd3D7SrBgVTNKpVymjly+zXQwgjYPkOkmtgl30vzGps62C56CpvtsIpc3kRS8KAouWAwlRk/gR14r5jE0pZ0BXK8EqVgnLBMRSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751263; c=relaxed/simple;
	bh=K+XJKON1jTwCC7qOlV22aAjWILSMD7MaOIvJDEbvbHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsavOtCvcsd5NToQKca6SktKpS0l0XqOQfEep7vg7yYDB5YRjNrBktQ3ecy0iyZtpgAIObjzpvoImU/PMBeU75mS5kBLyx6E9oYYi0q+K29883K3DLtzJNGq4O6VW/MQErQYNb5hX6rWbgTvGOIDxY5GHPTlNvNknEPXqg8/LVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmXsFJJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13571C4CEE7;
	Tue, 29 Jul 2025 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753751263;
	bh=K+XJKON1jTwCC7qOlV22aAjWILSMD7MaOIvJDEbvbHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmXsFJJvQNFazQG4Wz8CYrvQTps1XsU0VWY6YAbEIVzFxi8ynzoVUNw+CWcnEGNYV
	 eO47voV84AUIanORs/0xRazJjP9Cpf4nm0vwWbziVJNE5sVop4YSxR9j4S+ksucchH
	 gU8J40EiExn0LfWqqD0yrlxEHza86+l6bFGHuzzJTLEpWmGAfhNZTks0BFAn3D+2BK
	 QB5InVGgpoIFAce4crrxNGUB8xy+kbyRlybfh77rq33nLD0zVubIXsAWLYbBgVAKzh
	 AM+2NNhuVC2VRbM6knfWgJuFg9Ue6MM9iXVNYTbx5kceauhj7ENN/77S9kpgkqUcfl
	 VlXbf6205sJEQ==
Date: Mon, 28 Jul 2025 18:07:42 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Nixdorf <johannes@nixdorf.dev>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Sargun Dhillon <sargun@sargun.me>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/seccomp: Add a test for the
 WAIT_KILLABLE_RECV fast reply race
Message-ID: <202507281805.14457D3EAF@keescook>
References: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
 <20250725-seccomp-races-v2-2-cf8b9d139596@nixdorf.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-seccomp-races-v2-2-cf8b9d139596@nixdorf.dev>

On Fri, Jul 25, 2025 at 06:31:19PM +0200, Johannes Nixdorf wrote:
> +		struct itimerval timer = {
> +			.it_value = { .tv_usec = 1000 },
> +			.it_interval = { .tv_usec = 1000 },
> +		};

To get this to build, I needed to add a sys/time.h include:

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b24d0cbe88b4..fc4910d35342 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -24,6 +24,7 @@
 #include <linux/filter.h>
 #include <sys/prctl.h>
 #include <sys/ptrace.h>
+#include <sys/time.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>

But, with that, yes, I can confirm the race and the fix. Thank you!
I can fix that up locally.

-Kees

-- 
Kees Cook

