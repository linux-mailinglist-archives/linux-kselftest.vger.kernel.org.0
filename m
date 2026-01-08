Return-Path: <linux-kselftest+bounces-48556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7AD05E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FEB304C6DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA7328623;
	Thu,  8 Jan 2026 19:48:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73452DFA31;
	Thu,  8 Jan 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767901704; cv=none; b=HUtcE9eVAeFxVvnb1lJMz+GB7seZMc9fCJ3ajKkSLIM7CSgW6FQbiv9DYclL01MXGrpbJGNwf2nZDDvhGPWEs9uZgKIYSYnsfK2tQ9+lLrStruGd1+yHFKYft7bwKpMyLdwc9K5kmz8C3A6EpqCkhNQ4XWTeNMa7Czy6R092Xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767901704; c=relaxed/simple;
	bh=Q9YulQ2Q91+00TxIBVhdbvmj1kOhQK/OChBk5P1N1aA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMTYSepLYaXH+8oHdCy2wqSISzAC81bb+so0LRltY+inocByLc97z+oWciGVLxnJqINFcz+CPU6K/2+yuGKm0WIXxGP64D6uATMMVIJfNuMfRBLx8kwgQFYlANL4uiJH6Sb+vYMBhv7eLz92gWiZ2hRIc43HyvNX6eSYxE/qqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9A7DEB787D;
	Thu,  8 Jan 2026 19:48:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 61D0018;
	Thu,  8 Jan 2026 19:48:13 +0000 (UTC)
Date: Thu, 8 Jan 2026 14:48:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah <shuah@kernel.org>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, wangfushuai@baidu.com,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
Message-ID: <20260108144842.0663008c@gandalf.local.home>
In-Reply-To: <4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
	<20260107034914.22315-1-fushuai.wang@linux.dev>
	<20260107101846.61c182e0@gandalf.local.home>
	<4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8syyknp4nyfkdnsmb1h9os9mtbo11osb
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 61D0018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DV4NUvQiax3uIETwXgOh8kY8zIPOZULo=
X-HE-Tag: 1767901693-277265
X-HE-Meta: U2FsdGVkX18gkmNDHiHN92/lWnSGHjHDwNcghf+Z1KbbBRNkbiJ9HdKgjJIpEwD8LlwfxbIZ9w8ckCIb212GbZcZGsnOKMb5MFsn9c9CgDctwJGhfPgi2uLB4oLQ/fcW4P4AmfJPdWQms1depEGnOkQbiVzkSrALbPFPDXHS2JUocWS2phQ5tCRMzLTaLmT5hJVCO9LBtq3COir9uETEWvzbSET+/IHkPMiOis8xtSc5ECz2HZ6039l2aNKnJHzum0k9+2t1APLjA9W4XSRssG7xWS30PcrxBxF1A3RH89VFilcezjThdTIEeFue5q27tmJVOoC19VURvfnOOh4s1cKW0rjXh4qnldnpcG6ecMCdy25jo/eaEyNn1aym5LHSg0u131BLbASVcpDG718HIrP1/A8KrPJd/D8tdGtyDXIVXYqaqx3DXXd3DkTMWXTm6HmAIGTOOQ0=

On Thu, 8 Jan 2026 11:27:26 -0700
Shuah <shuah@kernel.org> wrote:

> Yes I can take this through and send this for rc5 or rc6.
> But first the following warning needs fixing before I can
> apply the patch
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Fushuai Wang <fushuai.wang@linux.dev>' != 'Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>'

Hmm, do emails have to match? There's times I used a different SoB than the
From. The From is different than the SoB. The important part I found was to
make sure the name is the same. But I didn't think the email address was
important. And this will become more of an issue, as gmail blocks my
goodmis.org account, so I send with my kernel.org account when my goodmis
is the only one I sign off with. Thus this restriction will fail for me on
my patches.

-- Steve

