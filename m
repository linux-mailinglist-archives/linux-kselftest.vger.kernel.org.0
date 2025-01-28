Return-Path: <linux-kselftest+bounces-25279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C527A20794
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10CF3A4049
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F59199FA4;
	Tue, 28 Jan 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSmlINAv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BC199385;
	Tue, 28 Jan 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057396; cv=none; b=EvAo5ytMCQiwAKz4CIJeDHqnsl4/RO0pkuTDN1lY4oLCn2QOxtDHNPe6HvvfLBk6NWzyDqxJvzppOjnZD1utbsx67PNVwkogUlB+/dy/k1OdUIizefeINDcxUCA3xzkEWA444eSI8ZN+kfq97SlOQT/PJwsagHZbnnI/fwVZv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057396; c=relaxed/simple;
	bh=nhxX+KKjyAmhuZqSaSiq//fR1W9bmmcoErKE363JeZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/KHclpGReAFcYKBZGCZiHiG0xaaEguTW7LXoHUV0/D34KzSxgT2A/ybXW7SVDRjkXAgwYoFTgLrn+J+IwBdRwbTEbDAUFJr4WHe/5aWoob4m1SRRCZKYixVLvA0yFJT0loZ56jkKVQ/Kecz7P1X5ObihhfAydw+Vtl7BoRhvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gSmlINAv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=qiUVswsB3yTR4MT5Ln5A5p1vDg9ssqYWDaSK0rRPwXk=; b=gSmlINAvpXUPukFxeLE2Smgyak
	cvlBY3CRasQpvgwPWahNX2d8MPFy0mh7kQMPXvjGb8fADnPVzvID69/8xGJwpCx1mmQ+JnwnBT6vX
	qf5auJplfdAqa/IwrSw7c1o8W2Sm8qRR/XQc1/GLZgKAXa8ULXOXXPeItnv60Sj19Dm2Aa1i7NKGc
	RDDHQ2qeDWYWZKSGDuSVc88Q5QgQpt6LX9jvuVFioRYO8g86DjyKEjYwode7ri43JCKCV5PW8IkqO
	X/Arn50qNq+SSfLasPQR650XLG1/+fMeK5IEt10BasynsWapN5MWgfjAaZULelpjTp0YvbhIVCC/B
	10vqmnLA==;
Received: from [138.199.18.130] (helo=[172.31.28.190])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tci7X-0000000ARyH-2y9k;
	Tue, 28 Jan 2025 09:42:59 +0000
Message-ID: <83d44307f30ad8ce19de3edcdc00c179750e0e23.camel@infradead.org>
Subject: Re: [RFC PATCH 00/39] 1G page support for guest_memfd
From: Amit Shah <amit@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>, tabba@google.com, 
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com,
 peterx@redhat.com, 	david@redhat.com, rientjes@google.com, fvdl@google.com,
 jthoughton@google.com, 	seanjc@google.com, pbonzini@redhat.com,
 zhiquan1.li@intel.com, fan.du@intel.com, 	jun.miao@intel.com,
 isaku.yamahata@intel.com, muchun.song@linux.dev, 	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
 brauner@kernel.org, 	bfoster@redhat.com, kent.overstreet@linux.dev,
 pvorel@suse.cz, rppt@kernel.org, 	richard.weiyang@gmail.com,
 anup@brainfault.org, haibo1.xu@intel.com, 	ajones@ventanamicro.com,
 vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 	pgonda@google.com,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 	linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Date: Tue, 28 Jan 2025 10:42:57 +0100
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
References: <cover.1726009989.git.ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Ackerley,

On Tue, 2024-09-10 at 23:43 +0000, Ackerley Tng wrote:
> Hello,
>=20
> This patchset is our exploration of how to support 1G pages in
> guest_memfd, and
> how the pages will be used in Confidential VMs.

We've discussed this patchset at LPC and in the guest-memfd calls.  Can
you please summarise the discussions here as a follow-up, so we can
also continue discussing on-list, and not repeat things that are
already discussed?

Also - as mentioned in those meetings, we at AMD are interested in this
series along with SEV-SNP support - and I'm also interested in figuring
out how we collaborate on the evolution of this series.

Thanks,

		Amit

