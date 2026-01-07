Return-Path: <linux-kselftest+bounces-48359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB9CFB956
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A2F307E26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362F26E711;
	Wed,  7 Jan 2026 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNxAQ5lI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460126E6F3;
	Wed,  7 Jan 2026 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748339; cv=none; b=RhbL/Ma1AzPjCLR67VyElVobxZKAMTKZe+Ye+CB4RtJAyfFBRdrjClHmGapHUkkym2HPm8k6p29HHDHIMeR/2agXbYdTnRRhi7XBEh5ekm/gqaIqYpgrVhi7HM5lq/6M1GN5RxETSRnetz2WbwwVuKa7WWsnAHbnwvvUBOZchxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748339; c=relaxed/simple;
	bh=LXXSVaeh7UfZaj6LnMe7QNqcXuoZ/Hu60UXNaEIToiw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uHaQ69Kc3UR//GFgwUSAu+AV83ptsAAmLKK/70U/pB23x4I4XzFMyOp5f3a+i+XPpUwNhmPM4+tpFfFhxXvJibAJoSG7vYUxLJdPdYQYIQ8rwN3R4V1AIE1iB/DaHMcJnFZMWTk9DdY6Db/IX+D9JkyjXwkwB8yV03kK9+8nxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QNxAQ5lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD8FC116C6;
	Wed,  7 Jan 2026 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767748338;
	bh=LXXSVaeh7UfZaj6LnMe7QNqcXuoZ/Hu60UXNaEIToiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNxAQ5lI8deRq9bn96jJoDJ9zPBOG4jyYio8OWb67gb7Av9RFFEu+02aIzr/Cfn9R
	 XGhd8RZ7zazD0sRTgFiJvrKxQ8k3/nPxA2G5DZnc9KnCJ4ZVr8urnXDcvzNlfpQ2pZ
	 TgyA8G/TOUdJDFe5SgbCiL/77/1NDP8wgMvPr/64=
Date: Tue, 6 Jan 2026 17:12:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <liwang@redhat.com>
Cc: sfr@canb.auug.org.au, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: Trailers missing for some commits in linux-next 20260106
Message-Id: <20260106171217.b97e62a450217c1e7d8e04a6@linux-foundation.org>
In-Reply-To: <CAEemH2eN8FF4-sgnNSC-pO0pFw3O6R_JQ8iyoi2JHoGM3toBrw@mail.gmail.com>
References: <CAEemH2eN8FF4-sgnNSC-pO0pFw3O6R_JQ8iyoi2JHoGM3toBrw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 09:01:22 +0800 Li Wang <liwang@redhat.com> wrote:

> Those patch trailers (Signed-off-by, Reviewed-by, Acked-by, etc.) are
> missing in the linux-next tree.
> Do you know what happened? What should I do to add back that?
> 
> commit 8bd5f5187 ("selftests/mm/charge_reserved_hugetlb.sh: add waits
> with timeout helper")
> commit 378d74dfd ("selftests/mm/charge_reserved_hugetlb: drop mount
> size for hugetlbfs")
> commit 99f5e30c3 ("selftests/mm/write_to_hugetlbfs: parse -s as size_t")

These patches had "^----" in their changelogs, which git-quiltimport
incorrectly took to mean "end of changelog".  I turned those into "===="
so things should be OK in next -next.

I also added a rule to my nightly check-all-the-patches script to
prevent this from occurring again.


