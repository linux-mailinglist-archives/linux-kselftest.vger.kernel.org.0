Return-Path: <linux-kselftest+bounces-26749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C476EA37649
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46423B013D
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268001990D8;
	Sun, 16 Feb 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJlvOadT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D63A27B;
	Sun, 16 Feb 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727174; cv=none; b=ZQXZGTqrg2bpNBbiQX+8aYE1qblJLnI9AQAcmL7mnrmJJVF7OAwYng6SNVxS30WcKyVQnyDdQ6+bdG9cK6D3xW+w9jCD/u3S7FYVLAghlFu/fmcV1G7seA5DkPGGL9oS58Z003RUqQoFLAwlcA1wu/lOPsnbJgbwwyTW74XHAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727174; c=relaxed/simple;
	bh=ow7MXjJv8y7XSzY4o451jjVltwqUn73I4DQmCVE/vfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adLKwh2+bVzMfx8hxaS0mc4Zu3w38p6zorxu7tUpRTeN1dhwqUsYMwix5Jygiywk96HO4XqOP0NRwue0GvT0H7fiiBrJ7YYC/wvAttMiWS945arRE3Qb3SIzgApnD87/1rqCYVgQVqmIA/RWcrBV5D19tbnmuLUi2qsJzvc+pgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJlvOadT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 90A5D114008E;
	Sun, 16 Feb 2025 12:32:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Feb 2025 12:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739727170; x=1739813570; bh=JdbKeKNTkrJ3d+Viq9l9I5VzS7Tlw/bfiXQ
	7lTDS2OM=; b=SJlvOadTKZsXKiiyuJM3snM0Tsmwh7nV19ZeEEElqlG/xpdkBeo
	rGnH0wytXgfN79SR1Mpey3KRA5GiEz7nr5mqjdyzSLKKj2tZheqP3BmuYQm/5Ll1
	caUVJcOnRv+PbYRItQ5aofcae4y191ysxgOyyQ2BPu1B33NWP2YXFJ08mmhh8ITC
	qhelEorgzH1V0MgAf2QF6Pm3IzCl95z0VZAtfo8ogV5MQQdJc70V8eqCN+IH9ljZ
	BtWenBenBSDFPxqkclRohE4qeV6ZFIeKRvvtP8qPgKasg5LQS4dijjtFtMBScLsA
	V63nK3GAg6LLd3WhnJ5a44G5y33OEQ+UhtA==
X-ME-Sender: <xms:QCGyZ6lX5O3LxfogByxSeiS-0Y9uchGMzOH5g2XRIl679pEW-GoX1Q>
    <xme:QCGyZx1FvRYwJMkQOM6gvoRAQ4tZdxBMtPaLm--AQ7nFKkYZdGuOgmlyVd8Hr_BVT
    pxxs2pK6KGdiJ8>
X-ME-Received: <xmr:QCGyZ4rTyo5Kg1wAPN7BNEESqcAc8C467J7YNPA0n9acF3v-CsMN4FR2JKzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehiedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpefgkeeffedthefhleekvefgiefgfefhkefhledu
    uedtvdfgfefhffeuieeujeekueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    htqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepud
    dupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhnrggvmhgvshgvnhihihhr
    ihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehfvghjvghssehinhhfrdgvlhhtvgdrhhhupdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvght
X-ME-Proxy: <xmx:QCGyZ-l5hfq2xu1uPLrdKuhowYHLseQkLhRP9rmYAoW96Sub8c7k3w>
    <xmx:QCGyZ40CbENEAD0eSlvrx5PqrR4x534MiPRPlnxXOdtKlFRPlRO3Rw>
    <xmx:QCGyZ1tgKuC0cG86irIK0cR2IoDxPdvNHnDVWtcoSGDkKgmlKN_ihw>
    <xmx:QCGyZ0VaHrUuahI-ASOqpOMIxh0cHwLzICS8k-rXnJcYzpSNWY4LoA>
    <xmx:QiGyZxtSvI6I-Hy0Y99vTpzXXmjCvKVdIqe29orFESns0_ZNvqTEWkY4>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 12:32:47 -0500 (EST)
Date: Sun, 16 Feb 2025 19:32:46 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	horms@kernel.org, davem@davemloft.net, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: net: add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Message-ID: <Z7IhPhvwXlXzXysv@shredder>
References: <20250214205828.48503-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214205828.48503-1-annaemesenyiri@gmail.com>

On Fri, Feb 14, 2025 at 09:58:28PM +0100, Anna Emese Nyiri wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and 
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct 
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> v3:

I put the changelog under the "---" so that it won't be recorded in the
commit message. Nowadays maintainers usually record a lore link in the
commit message, so it's easy to reach the changelog from git log.

Example:
https://lore.kernel.org/netdev/056c8f4765a52179630b904e95fc4e3f26c02f2a.1739548836.git.petrm@nvidia.com/

You can use git-notes for that:
https://git-scm.com/docs/git-notes

> 
> - Add the C part to TEST_GEN_FILES.
> - Ensure the test fails if no cmsg of type opt.name is received
> in so_rcv_listener.c
> - Rebased on net-next.
> 
> v2:
> 
> https://lore.kernel.org/netdev/20250210192216.37756-1-annaemesenyiri@gmail.com/
> - Add the C part to TEST_GEN_PROGS and .gitignore.
> - Modify buffer space and add IPv6 testing option
> in so_rcv_listener.c.
> - Add IPv6 testing, remove unnecessary comment,
> add kselftest exit codes, run both binaries in a namespace,
> and add sleep in test_so_rcv.sh.
> The sleep was added to ensure that the listener process has
> enough time to start before the sender attempts to connect.
> - Rebased on net-next.
> 
> v1:
> 
> https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

