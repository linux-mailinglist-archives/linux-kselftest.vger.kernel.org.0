Return-Path: <linux-kselftest+bounces-36150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9AAEF04A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0429F3B2EFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7E26462A;
	Tue,  1 Jul 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viy9vkbn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C21F4634;
	Tue,  1 Jul 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356752; cv=none; b=XqcLtecQX4/IQbYLmjDxd5n3g7RK80MF6jNMg68efqHzReHBJBP/IYqu0fVQ4ElZ77tbpE5x3MiG9o7Fb7YS9GrGMQA0+EqZYxJ/XcJ4a9wmBzwnJCs5xAdcbpxPpf116pbPmBLqcICqJPg0x98bS91YG5XovmYut7sSFPwDStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356752; c=relaxed/simple;
	bh=FXBWxhP5fNGtBm2G4g6rXmgO0yrGa9otmQ9GR7xU75k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACYA2lac68OxXEOaDKTajlxxslfqcpj1hF6O+TauQjv/ZLmwEVyq4g+GC+LfmTcWjIcfT58nPa159pla4wzmo5gKPFurCxRUDdkMNszG32kA3rarAdrLFVVXq99E5rFgDSVa1LNMH/KQ+VuH9h4WrFHDWy2fJtaktCxNV342CZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Viy9vkbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD081C4CEEB;
	Tue,  1 Jul 2025 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356752;
	bh=FXBWxhP5fNGtBm2G4g6rXmgO0yrGa9otmQ9GR7xU75k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Viy9vkbn78lvxRSqN7M+AQw2siZL00zdOnTEMzkiuxEOf/g4acgwErRlouO7iuBCu
	 R5THugv8Rq3ntYhQXN9/+i45eWAbVgOTOH1RL9vlcEHiMOy4IeXKp3AOtnqli4y/r5
	 EXdZO1a+G/DN3utIigl0ClMAeTaLQGtqDfABTAf7SWV782WuIdrOq8AaSvN40iMBlI
	 RSEvEXwCAhm/Rx4CChGcbvRssNLLD+Nd1Yte72HQNlmoawjJufPc2pXReBmZu6nq0z
	 AH28R0LYJSmKWeReoxtG6qrq47Y8smxzJqzqReyP6h0cD3jqJuGq99amuGqvSIGQ+g
	 AXwq/1kdKvsJg==
Date: Tue, 1 Jul 2025 09:59:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [RESEND PATCH net-next 6/6] selftests: net: extend SCM_PIDFD
 test to cover stale pidfds
Message-ID: <20250701-gehege-portrait-c098442c73d1@brauner>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-7-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629214449.14462-7-aleksandr.mikhalitsyn@canonical.com>

On Sun, Jun 29, 2025 at 11:44:43PM +0200, Alexander Mikhalitsyn wrote:
> Extend SCM_PIDFD test scenarios to also cover dead task's
> pidfd retrieval and reading its exit info.
> 
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Thanks for the tests!
Reviewed-by: Christian Brauner <brauner@kernel.org>

