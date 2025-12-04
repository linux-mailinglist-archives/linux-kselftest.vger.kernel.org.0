Return-Path: <linux-kselftest+bounces-47049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D2CA4CAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA9B3096CC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39A34F47B;
	Thu,  4 Dec 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aaxeh+yv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340C34F46F;
	Thu,  4 Dec 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870055; cv=none; b=A8RpjsYd+sQAbfgU2670bc1yiKBwlImsDr8VuOTXHWrMRCcVmRYZgktumcURyQXdE1pFCNCF+JcSsoOwJhWtxo5bnAmIE1uo9MitNHBWMcsY8w80Q64bxhyVztEfLQJd7DxntH6Xp9QEcp/vcg/o0qwK0H3eEb91AozojKRdezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870055; c=relaxed/simple;
	bh=SHLURkCQA5LDGPwldqVRxNVG4mULPP3GUZqavXAzURY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snQCk3teqx+9T8rnii86PQHhQV3Rh3XSnvJGdzuaff31PNT83IrH8/OhLmJ3Zgv+aH8+bc+LhOo8NHjzA5slKX36j8HMhV8N8uH08uSlzu1PWoMZ4omTlpANK2WCplYtaIxJWt54E9Ra7sqP1cxd6pZNMRgVI9K004rJ3jMB6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aaxeh+yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FEC116B1;
	Thu,  4 Dec 2025 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764870055;
	bh=SHLURkCQA5LDGPwldqVRxNVG4mULPP3GUZqavXAzURY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aaxeh+yvpDLK/23YxWSFxLfvI2ivEtFe4M9t3VSR8sJRm1uf04sWmylcO/C8cPlRk
	 E7Cud+paQaf/O2rZ8PgDUYUbrpSRzzI1K+Bn0wvNs9TV/8mXVJXXeg6bVV4dwwXoBL
	 buXYiEQjyoBlxC5V5ZGU4M35Ekqv55TumwlWlMjt+iWI2IgulR8gpBX8hPySIH0YHo
	 amQdGaqF7P0YCTeWGbuNhWVafG0j0qvnta6IPS1ZQcJPhfURba9Lfa/ECoC8Ave+qc
	 Kn3uJooz5VwnU/SYiVN3HHKbQCc/NFH8HI7B6E6I3jwD/Jmuwom9hpi+BMEzbAtq5T
	 +/ANllDhIaA0A==
Date: Thu, 4 Dec 2025 09:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Elizabeth Figura <zfigura@codeweavers.com>, Thomas Gleixner
 <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@google.com>
Subject: Re: [PATCH 06/13] selftest: af_unix: Support compilers without
 flex-array-member-not-at-end support
Message-ID: <20251204094054.01c15d1e@kernel.org>
In-Reply-To: <20251204161729.2448052-7-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
	<20251204161729.2448052-7-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 08:17:20 -0800 Guenter Roeck wrote:
> -CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
> +CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)

Hm, the Claude code review we have hooked up to patchwork says:

  Is cc-option available in the selftest build environment? Looking at
  tools/testing/selftests/lib.mk (included at line 14), it doesn't include
  scripts/Makefile.compiler where cc-option is defined. When cc-option is
  undefined, $(call cc-option,...) expands to an empty string, which means
  the -Wflex-array-member-not-at-end flag won't be added even on compilers
  that support it.

  This defeats the purpose of commit 1838731f1072c which added the warning
  flag to catch flexible array issues.

  For comparison, tools/testing/selftests/nolibc/Makefile explicitly
  includes scripts/Makefile.compiler before using cc-option.

Testing it:

$ make -C tools/testing/selftests/ TARGETS=net/af_unix Q= V=1
make: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests'
make[1]: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests/net/af_unix'
gcc -isystem /home/kicinski/devel/linux/usr/include -Wall  -D_GNU_SOURCE=     diag_uid.c  -o /home/kicinski/devel/linux/tools/testing/selftests/net/af_unix/diag_uid

looks like the flag just disappears. Even tho:

gcc version 15.2.1 

