Return-Path: <linux-kselftest+bounces-10682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F758CEAB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA391F210EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BA433D8;
	Fri, 24 May 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1zFJRgB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D983CBD;
	Fri, 24 May 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581574; cv=none; b=W23KshCyrjviiCaFxR9vm/6AJfLjBWAH6xuXbVFzokRj3K8juvgbPcC1ehwDZTbVrY1RRrg7Z+vBioTw7FQRtg/c554WbbJ5W+AYNlePuQfLbC09RM/bHlxH2jvEnCQa5reiO67tqcgjTZ2IF5BwcJUwlbOi9pur3P/H79IJatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581574; c=relaxed/simple;
	bh=3UnR8vsmR8CcxvacyVVttEzPUuRJVz8jYNuEfHywzW4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A3MBTXKo9UXapaunnw7BgW9XHCajXohIkibFAgZDkP4D6glmClOJkbEe8tNxeb9t9HeI75uKVBTA9DnDwdiHyIX/IkrKDi0PMfC/XJBg506WkGfq3RtZCHDmsQV4BTfwp0Y+px9DFK9m470HY0pv1ufmWC5tHj7zkPoQt+WUoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1zFJRgB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EAAC2BBFC;
	Fri, 24 May 2024 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716581573;
	bh=3UnR8vsmR8CcxvacyVVttEzPUuRJVz8jYNuEfHywzW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1zFJRgB7GUn20f6S8m3qnHj7wBwqWEifkehnYbb5C3CHrLqqQEp2ckQJccVPm3hEN
	 82fbFl2JJI0VlLLmIgAdrnKJoVjWd6d7u3R0O4L09cLNvWUk+D4PFxRzyLiNUkKT6Y
	 EsjcEmBJlOmoUfkb0ZoGkWbgu5VJ5v+NJC48B+yY=
Date: Fri, 24 May 2024 13:12:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Donet Tom
 <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Tony Battersby <tonyb@cybernetics.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-Id: <20240524131252.52475e7dc695b4d924c253a2@linux-foundation.org>
In-Reply-To: <87msofsntw.fsf@gmail.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com>
	<20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
	<d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
	<87msofsntw.fsf@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 12:23:15 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> >>> This patch verifies that a hugepage, used as a user buffer for DIO
> >>> operations, is correctly freed upon unmapping, regardless of whether
> >>> the offsets are aligned or unaligned w.r.t page boundary.
> >>>
> >> 
> >
> > Two SOF, is there a Co-developed-by: missing?
> >
> 
> Sorry about that. Andrew, could you please add the tag (let me know if you
> would like me to send v2). Will take care of it next time.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I made that edit, thanks.

