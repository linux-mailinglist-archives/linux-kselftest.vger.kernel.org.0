Return-Path: <linux-kselftest+bounces-2678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC3826096
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DDD1C21033
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA08479;
	Sat,  6 Jan 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARjQjLme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A8882E;
	Sat,  6 Jan 2024 16:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAEEC433C7;
	Sat,  6 Jan 2024 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704557784;
	bh=r/nXSa+pyJ2FFMn+9ZFlPb2PfjPG9f7aUg4HimUF1Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ARjQjLmeLvI7Jly1qcKqYM6vmGaeVt9vNp7GSRLiQoMrmnNaYU7ISmV4rz9dIDe5S
	 GpBuaU1OqVdyahiPwcGR5gya3FaFLz8WVK9Ucih28nlJ8j6nrolOB+dAqoGZYOciuK
	 Ccneuwk4rs8FSn+9WoKDsMGCQ0OQ+8EmmAkFc2IsGFhdoCIbG4OQHaqhoQ0YoH2I5A
	 tTCtlGLCoOQ84YthiZBVPyhnIOkS9gY+8gkZAWb2cS8uAYcoe5TCs3BIuUZczqeN9Q
	 iEANHisDrMpD1J5UQeFWQE4F9r6sj2gIA2vNXl3/Uph3gR6ViK28LwWvgFtXGymZGj
	 UOqx4ZSYB1fFw==
Message-ID: <e0a52f62-3ea8-48c4-a5c4-307f7642cd45@kernel.org>
Date: Sat, 6 Jan 2024 09:16:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftest: net: fcnal-test.sh TIMEOUT
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <0b9a2827-c9c5-41d6-a4f1-dbd91262c474@alu.unizg.hr>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <0b9a2827-c9c5-41d6-a4f1-dbd91262c474@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 2:41 AM, Mirsad Todorovac wrote:
> diff --git a/tools/testing/selftests/net/settings
> b/tools/testing/selftests/net/settings index dfc27cdc6c05..ed8418e8217a
> 100644 --- a/tools/testing/selftests/net/settings +++
> b/tools/testing/selftests/net/settings @@ -1 +1 @@ -timeout=1500
> +timeout=3600

bumping the timeout is fine to me. that script is running a lot of
permutations.

