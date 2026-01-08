Return-Path: <linux-kselftest+bounces-48561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52ED06609
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C6EE3011998
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F0334C2C;
	Thu,  8 Jan 2026 21:52:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C60329C53;
	Thu,  8 Jan 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767909143; cv=none; b=htavYNuzuVk2k6/mH+znrUIMnuvNupt4ARLE1ifenFjAxhsyOQLMdpD/W2JVOEffQwBZva+Kh4TAPeLQ/UeY0BoGFP+m3VQMFsanwT2zJoUC6Gbcx+KHaJ56czDj/cZYm35dw8tmHGS0OwHOUTUfENh9c+XpnxJJMls6oHg/OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767909143; c=relaxed/simple;
	bh=A/nBz3mdkKl+I6E9bussskCC3dzJs5B84blrFw9lSTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk89IPbavO+a+y0NRoYfXf4HqJqx+liozg1X6uPkxAlsIssDqb7LphUGQWXlz/TsxQEZ8d3uBoOPfx9VLA9zxHwONEjYb7cvqoPFCyi2xCmQSYWOmUFwsxBzmqac/4PhrBQHUh0L0wmn/a8E/YMAlL1zca5C0gzmXrC2N1cAab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ECB961A9FCC;
	Thu,  8 Jan 2026 21:52:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id C7BD430;
	Thu,  8 Jan 2026 21:52:17 +0000 (UTC)
Date: Thu, 8 Jan 2026 16:52:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah <shuah@kernel.org>, Fushuai Wang <fushuai.wang@linux.dev>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
Message-ID: <20260108165247.3ae2f21a@gandalf.local.home>
In-Reply-To: <3d31087c-ce86-4ce2-9b70-f955720a7311@linuxfoundation.org>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
	<20260107034914.22315-1-fushuai.wang@linux.dev>
	<20260107101846.61c182e0@gandalf.local.home>
	<4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
	<20260108144842.0663008c@gandalf.local.home>
	<3d31087c-ce86-4ce2-9b70-f955720a7311@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kjx3cohqubfb6rifk7rbmhrm4dswd6qh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C7BD430
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Qt+0mfqD+t5hW4heq/NHhl+KWsN/a118=
X-HE-Tag: 1767909137-851556
X-HE-Meta: U2FsdGVkX1+tTQoM2Vp9myGt4uf/Dvt6WWWb+mwsHTTAPy65SzDlUNFdWHqx2mdMohRRrenuE4uj5t4G9G7nlYzWMOxUk/WH7XIjsy0MmF085WRBkZoSpuAM8wGoN+kHdhA22+hjXTDZ3YEb2bMwLjMxnkgZVLxDZSiPMVSMPfBdbxtDjHR5XLujprfqpX5df9h+siVfrTsZ3fehThkW82PuAVViLo+vX8MSXKg+hJAT4fJBhvmPrmR9M+PR2U1sv1edGJKJtwhpY3076jKu1ZzlaF2r1Qphv3497XDpjy9lg26TLi/bKvKRB4aILbt+tFnB9AeNQpAoQfSlfFUxE2V4Oxr4NjHQHthTE+y57P5S3W5a529Ew8Kdbp4K2vvAk11sanln6ZZFG4Juea+24cDwAIo6wzUwooyginEXszXn5nbryq0FLQRV2SSxg0SC5UgOPyEu8pcHnomMBscbm83xbJHfgoxOHT+Qf1EKC2w=

On Thu, 8 Jan 2026 14:03:31 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 1/8/26 12:48, Steven Rostedt wrote:
> > On Thu, 8 Jan 2026 11:27:26 -0700
> > Shuah <shuah@kernel.org> wrote:
> >   
> >> Yes I can take this through and send this for rc5 or rc6.
> >> But first the following warning needs fixing before I can
> >> apply the patch
> >>
> >> WARNING: From:/Signed-off-by: email address mismatch: 'From: Fushuai Wang <fushuai.wang@linux.dev>' != 'Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>'  
> > 
> > Hmm, do emails have to match? There's times I used a different SoB than the
> > From. The From is different than the SoB. The important part I found was to
> > make sure the name is the same. But I didn't think the email address was
> > important. And this will become more of an issue, as gmail blocks my
> > goodmis.org account, so I send with my kernel.org account when my goodmis
> > is the only one I sign off with. Thus this restriction will fail for me on
> > my patches.  
> 
> I go by the warning - I don't take patches unless From address
> matches the SoB.

I guess my patches would then fail your requirements ;-)

Anyway, Fushuai, you can add to the top of your commit:

From: Fushuai Wang <wangfushuai@baidu.com>

and that will make the From and SoB match without having to change your
mail client. I usually have that. Because Linus doesn't like my patches
having my company name in it for the "author" but I have it in the SoB to
give credit to the one paying me to do the work.

-- Steve



