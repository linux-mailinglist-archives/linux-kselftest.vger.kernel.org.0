Return-Path: <linux-kselftest+bounces-42783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA3BBED19
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC413189B241
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006F2248AE;
	Mon,  6 Oct 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxEdPzaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0219ABD8;
	Mon,  6 Oct 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771816; cv=none; b=qLGUYh5XXSCXrC4bh2ukFsETlZ0PclEmgyd9ef1e0cc4heVu/5CpOMjNZbYxXY9sUPLASrMTH7Nr68i7NF+nXCVfUjX6/PB5hGjIZP6Vx9j2ZQBxKmlLnCp/RrvYRCOqT7jNfIaGpndUtGMXB7UjrNz3AgZBlWBsKHUOFK4hMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771816; c=relaxed/simple;
	bh=rWN6jto2RHp+3FusQV0xt+2Au+Nnsz5tLgY5xTBytlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQem9i+E7Q1yHZjxcdNFlBK/s3ynfx0iVoyNg3ozZ9ac0m1wkx4qBf5qor8y/YiPwUWGzUWuQMJgm7t7XSM0SfImv8KbSKhJLdiYYZ1Omxb26Btn10gzXwVoWrQmG0yGCA3XYGkMYriPUmqTcBiiMs8mhld6/72NWSLhmnD4VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxEdPzaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBF9C4CEF5;
	Mon,  6 Oct 2025 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759771814;
	bh=rWN6jto2RHp+3FusQV0xt+2Au+Nnsz5tLgY5xTBytlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxEdPzaaYpi98i/RUy5nqwFo5gHyjKethtBdLCNHcu6zg4/DpWjAnn0CvUPskipQO
	 CoBEr9yWw/MGvrefx/TuHX0BzFQVFNA0UcSL0yLzYo6Ar8oDqWzi9i3vgPnb2SO/Kt
	 ST7SBqMCW/t9pWuYRY45/umve1Mq5FFMab5/95fVAiB/dbJ2MxeID7ZPxHavXVYzsw
	 mFoJhKKkDr9vaGoXlKN09uQT8loxrk/FdrZoeuZ4QpleRT7MFaAEpO4bT69YenTtyJ
	 emoIrlcJbv+eECHr2P1LiW12WqkHh4MB3+9yzxDFEwI0gsYj1PqJgoUifPF9RCpXfU
	 rb/mdQqB+di+w==
Date: Mon, 6 Oct 2025 10:30:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>, "Antonio
 Quartulli" <antonio@openvpn.net>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Allison Henderson <allison.henderson@oracle.com>,
 <shuah@kernel.org>, <jv@jvosburgh.net>, <olteanv@gmail.com>,
 <jiri@resnulli.us>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <kuniyu@google.com>,
 <martineau@kernel.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
 <fw@strlen.de>, <razor@blackwall.org>, <idosch@nvidia.com>,
 <linux-kselftest@vger.kernel.org>, <mptcp@lists.linux.dev>,
 <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>
Subject: Re: [PATCH net v2] selftests: net: unify the Makefile formats
Message-ID: <20251006103012.0493a4b4@kernel.org>
In-Reply-To: <87o6qkcnol.fsf@nvidia.com>
References: <20251003210127.1021918-1-kuba@kernel.org>
	<87o6qkcnol.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 11:40:59 +0200 Petr Machata wrote:
> > We get a significant number of conflicts between net and net-next
> > because of selftests Makefile changes. People tend to append new
> > test cases at the end of the Makefile when there's no clear sort
> > order. Sort all networking selftests Makefiles, use the following
> > format:  
> 
> If we see weird errors in CI, it might be because tests now run in a
> different order and previously masked missed cleanups are now exposed.

Yes, sorry. I enabled the check before merging this so there's probably
some transient false positives. Which is fine, the pw checks are for
maintainers? :)

> > diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
> > index cd6817fe5be6..699e3565d735 100644
> > --- a/tools/testing/selftests/drivers/net/dsa/Makefile
> > +++ b/tools/testing/selftests/drivers/net/dsa/Makefile
> > @@ -9,11 +9,13 @@ TEST_PROGS = bridge_locked_port.sh \  
> 
> This should have the header converted as well:
> 
> TEST_PROGS := \
> 	bridge_locked_port.sh \

Ack, let me fix when applying.

