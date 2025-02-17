Return-Path: <linux-kselftest+bounces-26799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92DA38B01
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362E8188D706
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E6233153;
	Mon, 17 Feb 2025 17:59:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDB22AE7A;
	Mon, 17 Feb 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815171; cv=none; b=gLU4WgpHfqqJzPltV6M6MVj9iUaohNC3Ze55JK1ABFVDIVkOLMjiUM0+921TqXE8oKsXmkYntBrTfYH4QwDXDet/b2X2vDOq84Kqj1RGUmRbwMw5aa6eW3XKuM9HG4WznzwlokXeusChR+f8LHD8/2aTkNSggqNiDt80G7ndtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815171; c=relaxed/simple;
	bh=HBTFlEtW/5/Q3d/t2LVuQARVEufkfmUFRGuesCgbf6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtAnvhOvl/g99H7TBOreCYsN84tZJ9WI9vZAosp+02FQ3c/kS51gdxyNK2BXeyr87YNG3INGh2+0I7Xcjk4Hun6GpdG/j7/OtLRQtDwMkEeWmPtm85LKxK6gyXW5MF9g+uyqoGCzH4Zaf+52+sP77+v4MkvCDkwVaL/XNFq+2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28ECC4CED1;
	Mon, 17 Feb 2025 17:59:29 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:59:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Make uprobe test more robust
 against binary name
Message-ID: <20250217125949.24d52997@gandalf.local.home>
In-Reply-To: <20250217134244.21424A57-hca@linux.ibm.com>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
	<173625187633.1383744.2840679071525852811.stgit@devnote2>
	<20250217134244.21424A57-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:42:44 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> > +REALBIN=`readlink -f /bin/sh`
> > +
> >  echo 'cat /proc/$$/maps' | /bin/sh | \
> > -	grep "r-xp .*/bin/.*sh$" | \
> > +	grep "r-xp .*${REALBIN}$" | \
> >  	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events  
> 
> This test fails on s390, not because of this change, but since the
> test seems to assume that the entry point of /bin/sh is at offset 0;
> or at least there is some code that is executed at least once at
> offset 0; but that is not the case (at least) for s390.
> 
> Not sure how this can be addressed. Using "readelf -f" to get the
> entry point address of the executable and use that for the uprobe
> would work, but it would also add a dependency to binutils for the
> ftrace selftests, which doesn't exist yet, as far as I can tell.
> 
> Would it maybe an option for architectures to opt-in to use readelf
> and skip the test (exit_unsupported) if readelf is not available?

I'm OK for adding a dependency on readelf existing on the test system, as
it is part of binutils.

Masami and Shuah,

Are you OK with that?

-- Steve

