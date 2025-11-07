Return-Path: <linux-kselftest+bounces-45056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F6C3E726
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 05:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBD084E0364
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 04:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0718BBAE;
	Fri,  7 Nov 2025 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QnEmy/++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/PgFm1c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D3208D0;
	Fri,  7 Nov 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490071; cv=none; b=m0d+keXM3/nL5pgz5s6E4WvJJPuvnTyUGTu2Ox+WLGpsLUFRb/Ya0k6sUj4W3rHcxzc1UmDY8LfLX0gtZilsT8rXlJz0R2K0QRcD3H16xBWqdn0KAiZ8XuaLQ6fG8l0cZrNxnnZTrdY9kwJZlY5Fu6lRjZAlRoU4+zvKSiw7YnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490071; c=relaxed/simple;
	bh=yb0DTCG1cInP1rCdVIX5ryZQqriDMPhdew/tOD6ElF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcdYrSdRw1fJRYltp7FIjEbGsvRknqHKTLwwUik50BmyWSk0drchP9w/kmc4YkkMizYzf2YhRaeUOh2Pa6sRfqizEODKlDrNax+RVmIlLeX6ZhDfLSqkOlC+6JX49o3AgkysaKwIkQaotCQmZl3t0eSdU8lQ7FIYWZIBsOGFBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QnEmy/++; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/PgFm1c; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C518D1D00114;
	Thu,  6 Nov 2025 23:34:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 23:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762490066;
	 x=1762576466; bh=tYA6R0NaI8iwcsq17fX3OvwCMuWL8pN7VRVo/MHWCRY=; b=
	QnEmy/++yUsnJU7n1lEwPOqUJjzWDZOgZ+os4HLvC0MZV9m/oBepr7fKh2IRGwu2
	+T94s5WHjkn020XK2/V+FZEqqQE5tCLr44F1XS+NVAYlpNhZTQjuC+/yOe7hv1XP
	6BpRuR9x8CnAnN9CsCSacxKMwboj2DX/EWxKZ4qK8E3X+wPh04lG5oPNA1YsH+AD
	2m2yiX2IIfsKTJE4V+EajXY/Ad2Bp1Qlr/y1hcz+nUeJyY3BbDwF3Wj6YJq/Te8V
	Vv0LvnYGm9ODLT35/ddQOIJAxz5EBM9nTa55xoe1zEWpyWhW037CrKDMtkplYWye
	cAhs3cr12R647sqoeI+uGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762490066; x=
	1762576466; bh=tYA6R0NaI8iwcsq17fX3OvwCMuWL8pN7VRVo/MHWCRY=; b=S
	/PgFm1cM7A3B1V2Hu44Q+NvJV9kKsUZYkR0S5vimxz/Iju/8aqSTJtyZTXeB5AZt
	lllkVB32sOfJo3QU8TFuzUrRIymEYfMS8W/g8kMR8tMovMA55/EWyy7xUnMyPY+I
	AcJ8Ltvd+IcjZh9Bz6FuSfjsyl3F3EqlRrj+9vs955fHJqyNceB2xc70xhhm+6qi
	UY1T3A+8M3qSPOnH90Eyo45TN3fIWoyaPc06/R3xAdvHK6OMT64/3E2C2uhjl/rn
	cQ3VZnfcmu4SbX00IzY+ajcqoPk+qJsMkKM8nWx39rBRWqWcmPcRIBDc07fGAivy
	gcQUJVRTnjrfO4QEhzaHQ==
X-ME-Sender: <xms:0nYNacxzXtc_fIWugndE3z7ImtFDqg1h6O6QKHy4aThemkiXahcLzA>
    <xme:0nYNacSTCBh3qvyXcRfOv4hUl-CBLe15wRSIAIGDvnzUPzGBci3PqE8anfR29fGof
    p5Tm4d4mDWGmz9QqQHikkKVuv3avjKzjtP5XoSfYd57b2tDLcmsFSo>
X-ME-Received: <xmr:0nYNaQhT3KOsVyT6s4JZKw2Hk_z4Sh1HiBqYoQpKQxHhbRASaR5VLTBS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkedufeekkefggeelfeekhedvvefhueekfeegvddtffetjedvffekveeivedv
    tdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehs
    hhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepug
    grvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhhinhhitghiuhhsrdhgohhmvghssehinhhtvghlrdgt
    ohhm
X-ME-Proxy: <xmx:0nYNablqfGWV71m5ghcZBLk5TzsAebHefSClfAzy0PWjuui16T_grA>
    <xmx:0nYNabt7hVVE_NXpUcKkZ5zSYjqOjFbsYNRquKDyg2uppMA8sN9TEg>
    <xmx:0nYNaRZm8J6P9LlM8fVw4yp129xdu9EnMvzQhmnORqkRGYrWIV8XuQ>
    <xmx:0nYNaTBr21kNQ4aGc7BCcxRDz8CZR7d3z-Qb9dpDEBccADkKro8kAA>
    <xmx:0nYNaZzrikpLlmK3bz53HyWr7pMcqpQNCtysFiIg-3PPJGmw5S4wzrBC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 23:34:25 -0500 (EST)
Date: Thu, 6 Nov 2025 21:34:22 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Dave Jiang
 <dave.jiang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH] vfio: selftests: Store libvfio build outputs in
 $(OUTPUT)/libvfio
Message-ID: <20251106213422.1632efef.alex@shazbot.org>
In-Reply-To: <20250922224857.2528737-1-dmatlack@google.com>
References: <20250922224857.2528737-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 22:48:57 +0000
David Matlack <dmatlack@google.com> wrote:

> Store the tools/testing/selftests/vfio/lib outputs (e.g. object files)
> in $(OUTPUT)/libvfio rather than in $(OUTPUT)/lib. This is in
> preparation for building the VFIO selftests library into the KVM
> selftests (see Link below).
> 
> Specifically this will avoid name conflicts between
> tools/testing/selftests/{vfio,kvm/lib and also avoid leaving behind
> empty directories under tools/testing/selftests/kvm after a make clean.
> 
> Link: https://lore.kernel.org/kvm/20250912222525.2515416-2-dmatlack@google.com/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> 
> Note: This patch applies on top of vfio/next.
> 
> https://github.com/awilliam/linux-vfio/tree/next
> 
>  tools/testing/selftests/vfio/lib/libvfio.mk | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Applied to vfio next branch for v6.19.  Thanks,

Alex

