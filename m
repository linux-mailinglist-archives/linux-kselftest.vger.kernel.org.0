Return-Path: <linux-kselftest+bounces-3975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CE846669
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D784128B60A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A0C14E;
	Fri,  2 Feb 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4j78Mpg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB97C2CF;
	Fri,  2 Feb 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843625; cv=none; b=sUCvQNBAcW/T8ll1tPY553PUgrWAuCNEHh3U2T5dE6pHQiYVPVouKndDKjHSl4ANvG3FqRqrLUCg1PdLEAJxm+4rbzPDH3qAFljLzImfgmcg32qW9HfwCp6OoI4spfsHoEiN8kyOg/85J5RdmmT4wta8QJWCg4+06fBucaKxHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843625; c=relaxed/simple;
	bh=tp1bXQDlXuxDkK/j6AFJ58xOLtftbewwvftDcqvNO1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF6Lqe4CZjfsBjWyrHYXBgzq6Ey0zxA6szaAYh4SgqQPdxJbjwuGiDFkLYeNFkdDACWT20s5C1ktXobQEP5HiYwwIhf7pC6a0hOBwUU4ZNG0EyIbkUH1UeyuF07nJJIwoG4BbSXH2pKQABoHFabwqm0Enq3X4X+4/tDYaVIyDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4j78Mpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2674C433C7;
	Fri,  2 Feb 2024 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706843624;
	bh=tp1bXQDlXuxDkK/j6AFJ58xOLtftbewwvftDcqvNO1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4j78MpgPT5lnOix7DebWLKx57Op3v4BVMbMVyanlF4UvXJaRWChFjWJwISuI6k9c
	 kKy0OmsEcWf2sebntticALA9zodlUi+moP8VpnNWVs7M4O7Rgw/z/lej9TFLZUxC/x
	 6geZ6csuoOUoCYw4Va3/hW3TOyQsit4uXqp+hiU9QtPwd8x5RvfJ7UwNYhdbLUAzM1
	 r3odYWGv9hvPXNprXozMpzt6c2ShZDNdqI1JW2uEWOl14W3yRZumEibjx8vFAqE3Wo
	 tJntmmTZ5BTiqGDHQPfY6fXW+Pe2Zdlp9GK0Ek/0m6+6tQZKrlzVbE4ma5sUmxbTom
	 hrAGyYjvZnphg==
Date: Thu, 1 Feb 2024 19:13:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Message-ID: <20240201191340.0d952a3f@kernel.org>
In-Reply-To: <6104436c-4c71-4427-a569-cf98174d0c20@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
	<20240131163630.31309ee0@kernel.org>
	<e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
	<20240201132153.4d68f45e@kernel.org>
	<44d893b4-10b0-4876-bbf7-f6a81940b300@arista.com>
	<a1ac7a6e-4447-4476-8fb7-fb5f0d7ec979@arista.com>
	<6104436c-4c71-4427-a569-cf98174d0c20@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 02:30:52 +0000 Dmitry Safonov wrote:
> > Actually, I think there may be an easier fix:
> > 
> > 4. Make sure that client close()s TCP-AO first, making it twsk.
> >    And also make sure that net-ns counters read post server's close().
> > 
> > Will do this, let's see if this fixes the flakiness on the netdev bot :)  
> 
> FWIW, I ended up with this:
> https://lore.kernel.org/all/20240202-unsigned-md5-netns-counters-v1-1-8b90c37c0566@arista.com/
> 
> I reproduced the issue once, running unsigned-md5* in a loop, while in
> another terminal building linux-next with all cores.
> With the patch above, it survived 77 iterations of both ipv4/ipv6 tests
> so far. So, there is a chance it fixes the issue :)

That was quick! Fingers crossed :)

