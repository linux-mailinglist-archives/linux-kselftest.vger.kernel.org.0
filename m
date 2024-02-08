Return-Path: <linux-kselftest+bounces-4288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EDF84D7EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B732875F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB010A0D;
	Thu,  8 Feb 2024 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm6f/fzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF51D522;
	Thu,  8 Feb 2024 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360173; cv=none; b=DaOPEyyUK5LlmHQ3Er0jd3CBJAfF+yRg6oHcZKN5HzNW83DKWksDbhDdDHOLAl2WnwulCHA7tRtOw6XqwQyxsN8lL0Z28efS2SizdW2sa5BJXFfSexb8VF382nLMk9c6pEnmr+YAE66/UwL4M3iKV9cLx9LRmcdf88e1Of4s5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360173; c=relaxed/simple;
	bh=C4fuvlVmQnT6nWFGWMaKy4k/11SGN2a7GPJbdzHB4wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji7KIJxnjhyYvIpT3nFeLkd3BE9gYgSHqCmMe+6c8GZt2wK/puXwkVNBwykrWSBzZ4anGWdMZ7FnDlrsoAE4nYprd4mcPq/qjM+gkvja5suHg6v3A9e8LUkckSlVQMXvveMtDs2+LEI9oEWaLJTgxTYlVujfO881J2wCbEr1BKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm6f/fzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2168C433C7;
	Thu,  8 Feb 2024 02:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707360173;
	bh=C4fuvlVmQnT6nWFGWMaKy4k/11SGN2a7GPJbdzHB4wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sm6f/fzJOS7VCX7N5mXAHV+I6ydsE/PGbxXLjDA236KQ+QX8aeHHjBL537yTwBdPE
	 XSSO0O7lmxx+KRhQ8/DtCd9rhZktY7yXUFzQtKT9StqFdZfw9imVn9XIT15q5cmsox
	 HcDSUUR2bs/jBpvJJSgslVUh020K/6NCTK5PrmByF1xBTodIt/kWbUaV5au9lmuXSa
	 8fADzxmcLtjfIZ9h3hYLA2S+VbwNbWjPM4zkGozXlYG1yNAc+PB4nSJY8n/ekdEUkY
	 MBtLk0ptgoCL5jNsQmyD2qRQ++jrQUMz00sS+JfOfgotGYd8Ms4nX20DdxN0ERAOIf
	 8PMfKGsXmAcOQ==
Date: Wed, 7 Feb 2024 18:42:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: cope with slow env in gro.sh test
Message-ID: <20240207184252.5d7327fa@kernel.org>
In-Reply-To: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
References: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 16:27:40 +0100 Paolo Abeni wrote:
> The gro self-tests sends the packets to be aggregated with
> multiple write operations.
> 
> When running is slow environment, it's hard to guarantee that
> the GRO engine will wait for the last packet in an intended
> train.
> 
> The above causes almost deterministic failures in our CI for
> the 'large' test-case.
> 
> Address the issue explicitly ignoring failures for such case
> in slow environments (KSFT_MACHINE_SLOW==true).
> 
> Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that the fixes tag is there mainly to justify targeting the net
> tree, and this is aiming at net to hopefully make the test more stable
> ASAP for both trees.
> 
> I experimented with a largish refactory replacing the multiple writes
> with a single GSO packet, but exhausted by time budget before reaching
> any good result.

It does make things a lot more stable, but there was still a failure
recently:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/455661/36-gro-sh/stdout

:(

