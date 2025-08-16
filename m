Return-Path: <linux-kselftest+bounces-39145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F9B28B72
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95E02A1050
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF822AE7A;
	Sat, 16 Aug 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xeNdiuBN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E8223DC0;
	Sat, 16 Aug 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329415; cv=none; b=tPU8xvLyNwvafIc+73zLeYBvni0PtiGagT6x2niY9+Ksj/OjCJf7+gt6up5wXEUNlPE1I59WS0GdS2wkVV0lCrBqSh9bJC/mzcbXdby5SkJrs26li92JifP73Qdz9q5yv6kZt+1eL4s6YOodFjDOWegfemplZyggYE3XUpKvqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329415; c=relaxed/simple;
	bh=W1jPhQbOGvJw7bmvZPdhh7Lule+hHk8dgqDnHCJClug=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D+exmeyb7fyLhxXluOELunH985HZXDQK4w3k/vq0t7tPzI6axNUTLPH26RzGnz/XuaM+tMH32/bErsWQrj979Xl5CX5wm3kcm4IzVvyx5VahRZozbNYk6yVD2NpFqngOrTbwh87dSAk+lsYLOJ98GCMuDKLd/lJy5gjm559HH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xeNdiuBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A79C4CEEF;
	Sat, 16 Aug 2025 07:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755329414;
	bh=W1jPhQbOGvJw7bmvZPdhh7Lule+hHk8dgqDnHCJClug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xeNdiuBN7WIW7MvKM1RCruMKLATDNGUNtsrGckot72L2Sni5mUCFfbVMPdyjM8QU1
	 hyk43WlO47ZjnE4NMBBmtL7Bdggy3qnYRVagfBz7Q4RzMOKsw2m7XcA3WCTUNra3P3
	 AZjJBaAIvsvb8QILmsQSB0SHMocxrxeSLe1jj+xU=
Date: Sat, 16 Aug 2025 00:30:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
 <david@redhat.com>, linux-mm@kvack.org, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp()
 with more precise check
Message-Id: <20250816003013.e12ecb8f2dc45e7f934ff281@linux-foundation.org>
In-Reply-To: <20250815023915.1394655-4-ziy@nvidia.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
	<20250815023915.1394655-4-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I hit a large reject.  Can you please redo against next mm-new?

Thanks.

