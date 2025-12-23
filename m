Return-Path: <linux-kselftest+bounces-47934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1906CCDAD92
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBEE3021FA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C32E03EC;
	Tue, 23 Dec 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WkXOpqWd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTxq6Jli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF22D9EF0;
	Tue, 23 Dec 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766533330; cv=none; b=kEnS2+xPyAiTtyEEXJ5vP99kcecE2gJ7SqsJzgocT7f3vTMyvEKwigJ5NTZ5NFgGErAk0XMP8EVBlr1a0QmN3ZTnEq3T0mGTNYE36EdkbnmRPsm34EMbNpSGyHDwbH8pXWrnqQzc0Jt0c827mVzulSnM6nMOsywfb03qGg3NCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766533330; c=relaxed/simple;
	bh=tLOGe/J2aqc+/4ZAx75ceTkhPZHhWr7+kFRFeDjY0O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1rz6yKkexmQTxc1cPT7p5gpPBrPEwS9pVDm+bvziw9UMnAtBkFzqNFI+zvUFkvypfXVFMfQEDSH7kftJC+ZTaDkajQBf5uADjdgSTbI12EFDpMTp1WJGAY3/loiLEGRsX16YtqL4u0EjFx9YVkP7yFM4nw7pbE8hfqSVL7HQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WkXOpqWd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTxq6Jli; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 76B6CEC0108;
	Tue, 23 Dec 2025 18:42:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 23 Dec 2025 18:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766533324;
	 x=1766619724; bh=Y19c4fACZAnzvZCHc5/C1arfdbg9l3UmMLnXEqDYlQE=; b=
	WkXOpqWdFMUEIGt0CRPB2uj9acGZUydnLGH6H+ENSx0nzJ6zBdRWmrl/UhDr4CsX
	cHWE1kTFA4JsOYlOjr6R2HIhNELOpufjtFOUqFu91Ey6Jazwv2uI865m4mmx9st7
	0oVSUQKZcDN4lw6INbqKevSMYRRvN+Rc7qdCOohRN/D43R85ImQKbu+CyUU+WIJQ
	P/w4dDvgcWrsC2VDZoOIZtnjd1kEKKItScp7so2S+RPxNOoAVOUFFSQ5kgebE03N
	bFeOXuYc+aGc15jlE//EWPJVJUC4RuONIlgPR4f3nRqdBTg4N0VO1sCV4uBmYcHo
	DZ5/nBgtnZkvJQruftdQPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766533324; x=
	1766619724; bh=Y19c4fACZAnzvZCHc5/C1arfdbg9l3UmMLnXEqDYlQE=; b=M
	Txq6JliWXcmfTUQCWH+V6JBcYmTIdA/R5ks6TyydGIrFZp212oIxNcqLRUFp2t93
	1wcF7kxS+dWd3nC+7TF+s5ifRyNsDWpEXSxeeV/wpq4e1P889u6YT+eCymW71qzl
	zVNuzUXQGgoX3lBLUkXQCtzIE7KNSwsQ/e3IhEHqcZQi5WUzcicQF0F+ltZYatf/
	9Q/TcttBqEvYsth9hKbkXI17eALF1l+6wjfGsoETJEL6QihO+FC2AoLVNywgi6nu
	HhDsu41zXdSPMTpgyjoJz6dIxVOju9jqDfvtbBxXFVY/5Lkv2E4eLQw4704Q6fn3
	wrHB8WQZY8EfVe+1i+cog==
X-ME-Sender: <xms:zChLaZdB6w69oKqkPIvYJT5ch16W7FwvnjcRYrQPt6V4HTzi_3BErg>
    <xme:zChLaTFqMRd3KgO0gK2TTRs7O5XR8WmkYPcndwbfzansxFXvDhhSW1u0_iFyxQKwM
    opXsDLb7GEJFffWQC2S2hUKFyy20aM6OuBN2ONKdFC4bH12UQ44>
X-ME-Received: <xmr:zChLafhXaXjPAdv7-quDUyPbUCQWB0SIP6cEn2wik7__h121yNlADvm->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiuddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhggtgfgsehtjeertddttddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetteduleegkeeigedugeeluedvffegheeliedvtdefkedtkeekheffhedutefh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjrhhhihhlkhgvsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghnrghnthgrsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zChLaX2vtM8Bb_j9IVg34-tmkXFVMDbuVt-h4XEX6i86imdCHn_OsA>
    <xmx:zChLaac_JrtfA_Np_43vVkqL0U6nr2RClJyNTv_6KbDkNaSV9mCRwQ>
    <xmx:zChLaVxhG781IWr69l-EmHUO0V7_zUXrkIRtCP3RNYLpCDdLWYbnqA>
    <xmx:zChLaayye8eSHqGCTOnsQTxHigc8O9h9234GW6HqXanqD_K_Pvqq2w>
    <xmx:zChLaTiDUVgLNr_pI9l-7oUGeM_7ZoiARApEDLTBIsCyEx4cTBFGsSti>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 18:42:03 -0500 (EST)
Date: Tue, 23 Dec 2025 16:42:02 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>,
 Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Raghavendra
 Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH 0/2] vfio: selftests: Clean up <uapi/linux/types.h>
 includes
Message-ID: <20251223164202.34ea5015.alex@shazbot.org>
In-Reply-To: <20251219233818.1965306-1-dmatlack@google.com>
References: <20251219233818.1965306-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 23:38:16 +0000
David Matlack <dmatlack@google.com> wrote:

> Small clean up series to eliminate the extra includes of
> <uapi/linux/types.h> from various VFIO selftests files. This include is
> not causing any problems now, but it is causing benign typedef
> redifinitions. Those redifinitions will become a problem when the VFIO
> selftests library is built into KVM selftests, since KVM selftests build
> with -std=gnu99.
> 
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Josh Hilke <jrhilke@google.com>
> 
> David Matlack (2):
>   tools include: Add definitions for __aligned_{l,b}e64
>   vfio: selftests: Drop <uapi/linux/types.h> includes
> 
>  tools/include/linux/types.h                               | 8 ++++++++
>  .../selftests/vfio/lib/include/libvfio/iova_allocator.h   | 1 -
>  tools/testing/selftests/vfio/lib/iommu.c                  | 1 -
>  tools/testing/selftests/vfio/lib/iova_allocator.c         | 1 -
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c        | 1 -
>  tools/testing/selftests/vfio/vfio_dma_mapping_test.c      | 1 -
>  tools/testing/selftests/vfio/vfio_iommufd_setup_test.c    | 1 -
>  7 files changed, 8 insertions(+), 6 deletions(-)
> 
> 
> base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3

Applied to vfio for-linus branch for v6.19.  Thanks,

Alex

