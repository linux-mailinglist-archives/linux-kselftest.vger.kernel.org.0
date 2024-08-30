Return-Path: <linux-kselftest+bounces-16858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D77966B71
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2651F2326D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FFF1C1ADC;
	Fri, 30 Aug 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae+M8Yya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A37176AB6;
	Fri, 30 Aug 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054262; cv=none; b=NB5mAaTkGoAI5DQZ8XWcBilHy3rruDbvCVO0KCP6jhqpHD9OK4XsUMXXRkLWzBBji3cNXcZzrc9KstVWXH6rJ1aM9ERpRZh/ubydgG1W5jU65WMJIZGCo5vp/P8wS60d61bLJYa+gb9l6c4esK11LAow2bhAm99z1kA/PWSUnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054262; c=relaxed/simple;
	bh=56pyQIk32qEl5TVUo1ZFECYgfnmipsHARwCTJJlB+44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/fW+JClDXXlpT9yIIWB2gwCQSZtUvd29iDfZpQkAnXheKtTpOTfNFDn6Plyb3U/6V7rqDaYXeT10ldRaz/n9MgRnv92SfDGyvKRE9NlDdMx6Q9xWqBmwibDqN67T23QsAeu4O1NmxKfrnkGxgX/jJi5sT3Jlir3z0JGBrMRUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae+M8Yya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A68FC4CEC2;
	Fri, 30 Aug 2024 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725054261;
	bh=56pyQIk32qEl5TVUo1ZFECYgfnmipsHARwCTJJlB+44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ae+M8YyauT/t3QGMKe/5l2664wckTzj6TtfKam3x6TuuXdwryhv3vw6Tv1/xdkGPf
	 1kjwjID2Fr2a37WmUR/zDwBnk3UJ4E1gjRZ0wtyeYSblp5OVAUQxAJ6J08H7lVQh7R
	 vUlP4SF6pxvPJCv3AJUGBWqJdAllmT0OxmI7vyklolO0JpSkMvAMpgwEgG1XMSWffE
	 8KIUOvcPB66vzsLoW/ahESLmBkG64o3tQ+miDz7sLtdE8n4u5BHaPf9liIIH8b/V/P
	 8XPEcOFXUMVSNr2BUf7zAPLDyHbMGmtuwXCu7j6CxDpGThaQtrm/Mb9bmsDWUtnaOM
	 Qz0cEFXs4N3pw==
Date: Fri, 30 Aug 2024 14:44:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240830144420.5974dc5b@kernel.org>
In-Reply-To: <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
	<20240828090120.71be0b20@kernel.org>
	<66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
	<20240828140035.4554142f@kernel.org>
	<66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
	<20240830103343.0dd20018@kernel.org>
	<66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 14:47:43 -0400 Willem de Bruijn wrote:
> > We have directories in net/lib, and it's a target, and it works, no?  
> 
> net/lib is not a TARGET in tools/testing/selftests/Makefile. Its
> Makefile only generates dependencies for other targets: TEST_FILES,
> TEST_GEN_FILES and TEST_INCLUDES.

Oh right, TEST_FILES vs TEST_INCLUDES :(

Looks like only x86 does some weird stuff and prepends $(OUTPUT) to all
test names. Otherwise the only TEST_NAME with a / in it is

x86_64/nx_huge_pages_test.sh

But then again maybe we should give up on the idea of using directories?
Use some separator like --, I mean:

mv packetdrill/tcp/inq/client.pkt packetdrill/tcp--inq--client.pkt

Assuming we're moving forward with the interpreter idea we don't need
directories for multi-threading, just for organization. Which perhaps
isn't worth the time investment? Given that we'd mostly interact with
these tests via UI which will flatten it all back?

