Return-Path: <linux-kselftest+bounces-39186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225AB29736
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 05:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019DC17BACB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BB25CC40;
	Mon, 18 Aug 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wu/A0SKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51188632B
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486405; cv=none; b=oTIpQvMThrlAdyCjrx9+XW1MOIbnI63NOakJ0hHx4Xo2Dl5vk26wFiqDMm/dx4a5YGCEBJx+IlQcrJn9Iq88BnuyruEfSVYOcZn7HN9ZQpsYdeQ/AVTSJ0ua67zown2KdzvHNgnOY0rk0Kv5P6iA/CuyH0kLcw5Qtq0aalFqhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486405; c=relaxed/simple;
	bh=O29tCrJHU7rF/MV6Hy+n/kwRPq9NUr3UFlrphrwAj00=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tY6kDlj8zQR5uH7iePGvDP7GKPPmtVDVO51Y2Oc9/RS/tcd0WrfkBI0hnUtem1EUUa24hTPJqjIXoQT44HjNwNtkNi+4UZ3guOSsuf7VHTN+wi84Je0uwnIqXCjyXVxmta5/vbko84yn+4CQVXVKb5R3rnFHrNSPS+pU4XBs390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wu/A0SKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F47C4CEEB;
	Mon, 18 Aug 2025 03:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755486403;
	bh=O29tCrJHU7rF/MV6Hy+n/kwRPq9NUr3UFlrphrwAj00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wu/A0SKCu67qPI3H0x0peUYytalBSwfEQra4zvXSxBLut7inuvgto+B3ExcvS3GlQ
	 cktoq94mtVbujmdWSd2zsAhaBsDjWT8rphOaxiSZsdspkAAiT05CWXcFLn8IHRWWDe
	 hIgPXGWMCXuq73nZulRf8uHz4OHAunRF5Hm/IvOQ=
Date: Sun, 17 Aug 2025 20:06:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, riel@surriel.com, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [Patch v3 0/2] assert rmap behaves as expected
Message-Id: <20250817200642.c3ca3c89832fd9e0cb5117f4@linux-foundation.org>
In-Reply-To: <20250818022905.15428-1-richard.weiyang@gmail.com>
References: <20250818022905.15428-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 02:29:03 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> As David suggested, currently we don't have a high level test case to
> verify the behavior of rmap. This patch set introduce the verification
> on rmap by migration.

I'm seeing many rejects here, so please redo against tomorrow's mm-new?

Also, seeing "assert" in the changelogs was a little surprising.  The
term "assert" made me expect to see assertions, such as VM_BUG_ON(). 
Perhaps "test that" would be clearer.


