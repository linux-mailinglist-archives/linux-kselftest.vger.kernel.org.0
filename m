Return-Path: <linux-kselftest+bounces-45335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5288C4F31E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BD63B86FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07362377EA5;
	Tue, 11 Nov 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YPTFVnFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="INQXEWgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD0377E9E;
	Tue, 11 Nov 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880993; cv=none; b=kZH/h3WItHz4RWzkVY8/pdwWHw621UOpHTHYgpoKoCYNbTiYTjN/oF2JjyaWvSwTATJk7Dark0tKHRlMf9HfvoBvFgqta9Utqp0OAnICg070prGo0G+RPkHAjw3osyZeR/W4HBxJGhXUaL28tZ5f7R/NE4OTa8iBBikpGkgWnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880993; c=relaxed/simple;
	bh=s9avd5DNDEv50mlQq9FEBxHn8HVH1C0dSgJMkwcO/m8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXzOwQTVxGujqYUPXR488T+DAaXVYJpdSQExqnoXckjD61tJETncwRF/I8HMAGc1CXv3QNomVG7MFOjoBsj0CV5/wBL2MvUnJuWRtZ2Q4BeQNLyfA1KTbNIcc9Q5yjBmpK+aisqAiqY/CoQYChoWL4n1Z73ervA+EHVRCseMQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YPTFVnFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=INQXEWgO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2AD7BEC0235;
	Tue, 11 Nov 2025 12:09:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Nov 2025 12:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762880991;
	 x=1762967391; bh=RwfRD5+ZeOb3MmKEAqbGGslkRPhYhRs1Lm6mFQtS1LM=; b=
	YPTFVnFvC1EwwJxcYdhwWhZyxR3XWY14+KH1jYeC6awGTPuRl5kDu8UrikxY6G+l
	dKY6/OmbKwUEIx6MO0LHPSoSePfqWVO7OPJX+R6ukFzBk8kaXChWFy43ndhRZ5gL
	O5omGNp+o/uZVHFdirhnFP6MJhMKxRor+g2HEExYFfkhcc6oye+ZWhlgC5SHBAoj
	DhV/JSJbvAH5+OuV00eowY9evniaLReLHjv8/eH1HD6zzU0Ngo8zb3BFrHl5HTBz
	sajrWWoJ6x2tubSziHc1joelFTQosN1bORXbxd/MMaiQ+iqEXXfuzD/KeiUf9UmY
	2NfbUIi83555eIFGb0HhOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762880991; x=
	1762967391; bh=RwfRD5+ZeOb3MmKEAqbGGslkRPhYhRs1Lm6mFQtS1LM=; b=I
	NQXEWgOWWNIByWxLU/eLsQqPCWH+S4IS3BF9kDaWKVa6xHoKwC864JDaylnabmox
	QBCazn2nf+KewOon5hn5n/9PIIQ7XGi/lut2MUFA/ueCE0vsDZhwjmsZfT78HYt/
	+ZR4g/rXaWbNqXlKgR+AIux+Xny84kQ9EUD7rBXkVTEl9PdukTlnu1oTZbPHcqFC
	+Ko9UlN9oYEOjHgjBiPdecqzJobbp8H79XMkHo2urj4lE9wK9O/SMJaB1X8JjEzq
	8mxtkswjoR3STchWont3wGusaQv0G97J+DssJLbm5AFG8p5cStjP4ENlBzGnGM27
	6TcuhTuA9cef7QY3IOBEA==
X-ME-Sender: <xms:3m0TaUt3uZNQICvo9VW4SUBhc0zZ6DRir-GCjmJLTZnswZ0dqDCaog>
    <xme:3m0TabiMltxUy3pa20xZR2DbVb5WXZFG95RrRmB-sO737dgYSzyCMosOJR6HOf-vB
    6pOFhIK1G5RKYYTIIzNnw6J5u2qZkt3c0HXDTt_rfZBV8-a7_QB>
X-ME-Received: <xmr:3m0TafqVAew5WttMr0LnfqLOQcvBsxAuBiW0UeTwPFrb0k4MhDHR5Gqf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
    gumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    shgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3m0TaYtyTIbkYlsxXA8_39E4JX77bjGFPR1zSrWDb2gl6dSGSlqjtQ>
    <xmx:3m0TaSZlJpNGX-SjXjXj5Z2cLUSgGbqnxtTn6Hk2IoFaqidqJuAZZg>
    <xmx:3m0TafZSKs5aHP9yXmkFN2IekD9TJy0gcjCMGV4IKecB9yctAZIhMQ>
    <xmx:3m0TaTnllMXmImCLYvC5gMx89TRds7EAjdufmRQ_wH0T5omWxj2b2Q>
    <xmx:320TaVxjgkYaoPK-92gQ0eYdMvHRZ2-yXVIS9BUAHo-b_mvFnxV0_Qyz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:09:50 -0500 (EST)
Date: Tue, 11 Nov 2025 10:09:48 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vfio: selftests: add iova range query helpers
Message-ID: <20251111100948.513f013b.alex@shazbot.org>
In-Reply-To: <20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
	<20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 06:52:02 -0800
Alex Mastro <amastro@fb.com> wrote:
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index a381fd253aa7..7a523e3f2dce 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -29,6 +29,173 @@
>  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
>  } while (0)
>  
> +static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
> +						 size_t *cap_offset)
> +{
> +	struct vfio_info_cap_header *hdr;
> +
> +	if (!*cap_offset)
> +		return NULL;
> +
> +	VFIO_ASSERT_LT(*cap_offset, bufsz);
> +	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
> +
> +	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
> +
> +	if (hdr->next)
> +		VFIO_ASSERT_GT(hdr->next, *cap_offset);

This might be implementation, but I don't think it's a requirement.
The vfio capability chains are based on PCI capabilities, which have no
ordering requirement.  Thanks,

Alex

> +
> +	*cap_offset = hdr->next;
> +
> +	return hdr;
> +}

