Return-Path: <linux-kselftest+bounces-38190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF289B18889
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC78E16E54A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24C26C391;
	Fri,  1 Aug 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0sGwPvU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558621A01C6;
	Fri,  1 Aug 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082358; cv=none; b=lK6QTDwp2Yhda9n3gRRvoKaOfeM76Llc2B3JJQiVdV0+W+90alAb6wgD1zckNccs65AN4SNmgHxLNrDsk6Q2r9vRlYB6qoo+oXleLJVLlCVS2+qPdIwaS4LX59N19L706FRfF/uTqysD399eSun9DgmqX9ezDdFWf2WKW5fnqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082358; c=relaxed/simple;
	bh=WoLvDfKHC8rXAhX8dU4W9WkDcw3sCXY0/sQU2CyY7GM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWNxz4299GnvCNVTp2YPUS2A+N6/8Mlej11fTpE2LUFZZKorbSt9vnExlq4+MqFDFjqfEs8ARkx942yL4EY8Psr3qUlGsnLmAfs5PFRiX6RlV3bGePK3xxj6xHt93TFW5VVq9rPE57OzUV3bnfjMjyoeqZll0DL+cmJVVU6xlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0sGwPvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA64FC4CEE7;
	Fri,  1 Aug 2025 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082358;
	bh=WoLvDfKHC8rXAhX8dU4W9WkDcw3sCXY0/sQU2CyY7GM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U0sGwPvUhv7vaKp+HEe7l/OhtPY7xcQMPzzJyYcTDBdPgCu4dPut+8xWTFegSxO1C
	 tGbn+B+Ku0qxJTK8CGHCPkbL5B1TH9v8LI3UXqP4IHzCvw7B9IAwk7kwVEaSucWyNn
	 YayDUJNAJRoPgyHl7E4/1NTdyDAI6AnXY/zUnbWmfZZpYI5opT36WuKeRoaqTeQqJL
	 DsPqeWS8ahqoWUpb3HwFTA6f11a8SwiXImm0Ey5jMmEMJp5eS2Ou+Iv2xIHvG9dEa5
	 73QaDOKf8meRxcgdOPduKqAtY1JYWsqZKL+8idSkvt6CD/uwkE+FTICEW0rqSsjv8B
	 Ud1VRZsDQtZ3A==
Date: Fri, 1 Aug 2025 14:05:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: packetdrill: xfail all problems on
 slow machines
Message-ID: <20250801140557.53a36012@kernel.org>
In-Reply-To: <688d2af39aff_2e1a6829416@willemb.c.googlers.com.notmuch>
References: <20250801181638.2483531-1-kuba@kernel.org>
	<688d2af39aff_2e1a6829416@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Aug 2025 17:00:35 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > We keep seeing flakes on packetdrill on debug kernels, while
> > non-debug kernels are stable, not a single flake in 200 runs.
> > Time to give up, debug kernels appear to suffer from 10msec
> > latency spikes and any timing-sensitive test is bound to flake.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

I should have added "Willem was right" 'cause you suggested this 
a while back. But didn't know how to phrase it in the commit msg :)

