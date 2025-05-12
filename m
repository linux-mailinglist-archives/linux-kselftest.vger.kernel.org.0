Return-Path: <linux-kselftest+bounces-32863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D3AB3CEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0338C169F80
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64783246781;
	Mon, 12 May 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+U6Jdwf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337281AAE08;
	Mon, 12 May 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065867; cv=none; b=JE99+P8KnqHK+xyb09Dnw285FXhG2v7owGjceZyw/gqmmK6TuKSeuR7N/ugre1K4jhiJdoidXILB0n1BvY4gOedrfe1YcTpzO2WOpRqQ0jpoorlc5c6JJo2xsxklzd4CNmkPQH8XlN5YJkZKZREUf+dowWkwQVNxUGs0FH9Lga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065867; c=relaxed/simple;
	bh=syJvETKrlZB42kjU9fnlmjti0G9JCoO/nUPSovUn/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT+6Xzun5HXemb3WLKK8WX3hlHVcGCFazUKxk1x7GqnCXn09QTIZT162avIpbbfRCF/4Mel5KJXLMDJx72TelUjOWkFoaWF9mp4O/T1Ew9cJOoOixgLvAwZYdhEI0DwO0VOQfov+45zHJkZqsMYMj7nzm48DW2WU5NFzheYF/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+U6Jdwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE1C4CEE7;
	Mon, 12 May 2025 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747065866;
	bh=syJvETKrlZB42kjU9fnlmjti0G9JCoO/nUPSovUn/Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+U6JdwfUjcO+sz4FBodf84HB5LFPPdDx2JkX7xvDrmoxLMd74QMQoOQ9KBy0XxKs
	 I9NDBCOh3oqKi70fBjESh69xvcZiERWkNYHucMu348QMJ4hlr8rOKFaYl+yCa9QykE
	 YMflrJFEHImdLIzf+2OWKrn2vlEqn7/Qvu9oHTv4+rxc9DfIq26TBoKl4gL9+dkv8j
	 2gtDQpLkFl/v10c1OUzpp2NK9hHHI6QnUFLmcwJsDsRRNWxx2KHGs7VwCZsWIkLWoh
	 n34HYPKdXQjKo6QxUfVJhWSn6WvSyMiFhwXIDIvh+nMA4ieRrgp4T3HYZh4rNkT3Ba
	 shfiwAcN8MBaQ==
Date: Mon, 12 May 2025 17:04:21 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCHv2 net-next 1/6] selftests: net: disable rp_filter after
 namespace initialization
Message-ID: <20250512160421.GO3339421@horms.kernel.org>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
 <20250508081910.84216-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508081910.84216-2-liuhangbin@gmail.com>

On Thu, May 08, 2025 at 08:19:05AM +0000, Hangbin Liu wrote:
> Some distributions enable rp_filter globally by default. To ensure consistent
> behavior across environments, we explicitly disable it in several test cases.
> 
> This patch moves the rp_filter disabling logic to immediately after the
> network namespace is initialized. With this change, individual test cases
> with creating namespace via setup_ns no longer need to disable rp_filter
> again.
> 
> This helps avoid redundancy and ensures test consistency.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


