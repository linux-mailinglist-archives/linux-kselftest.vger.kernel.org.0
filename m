Return-Path: <linux-kselftest+bounces-16658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D159963BEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A661C214CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B6158550;
	Thu, 29 Aug 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rq61SCrW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE1145FE5;
	Thu, 29 Aug 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914123; cv=none; b=WH5UVLaFSr+EU21gslUT3Am0WXVBGZkEUkSE3wEH6rge1WgOwaMN3+OX9eI1zsn0AbZGL/gM+TaXZ72RcLBhMQYrbjU8OLXZFsw5qjk9Nzw63g5Zpj1EMvX1T2FOZ2sAMo+XGjuTeqBKpboE/hes+5Hhl2cdLRHbMoauglg+MTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914123; c=relaxed/simple;
	bh=EgqJyZaRG9NMw27jnmExCjXo1H5/Db5bvqr2e3nDIsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOo7aSrsw+Wdvj9y+tEUO2rEJmsIODDE7WlmtrObB25pqURvypbyGqwKcQau5Ig61TAiGWLJP92b+EJTcjRXG80D7vG/zBK+ltuZhBBMflYghT3V7f6lFgiijdc0JML3Hoxf7we1jQb3uoWBBggZ5QxoQ7YbfdfEX7QRanes9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rq61SCrW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C50340E016A;
	Thu, 29 Aug 2024 06:48:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id in12HXV0g9gh; Thu, 29 Aug 2024 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724914107; bh=gSxyyZmhTPGc9Pg281VWv96h3GTVKEh6JFkqSk1iXGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rq61SCrWnZwbY1z+sUOlpppcjXJfNlrrcSzOh5cc9L/Bens8nUCvmeYyS+8BjGY2Q
	 xvlRobIUhpGHGtnYZ6X5NDWO3Alp4/Ztzd4lY8Rx7QluN77sFRDKAiZB4N0VgbvtT0
	 Bvga3RkztroKlwact/aBQEWWDRPt/JlXISq4DpFTvH470R0iqIiCGtBw1qGfyxXC4a
	 72EIh1WK/DTDWLWsXyfngdPh1kooV8I8cLbWqpQTuVdHkS7EKVOnEw4bm/dZyUa/5J
	 Pv0Aht8RPGKi683Aki+cEAOzmUGEuUnsweUunNv7Vj5tTXERsdBVtGpybzC+Jq1ecy
	 9+Wx16Wc3e91IjAvNbTjwWdNoF3G8JQz7rPyLQ2rRzct+xzPruh8VsnKCEAZMyaDIo
	 ZRGU6eDYoHvFlUFSSueD9mM6PZd2bR0dC+XBWEaXGcnF1KBEZbEHlUC2wO5O6ONBHe
	 qQ1pBiJk2GPjcGNaIzbJ/ES19lR+yeI0vKYP8Z3Wi98LHzommZUYbkQQFQ+cIZqpa5
	 ovHQDxsXJPiY8yfWVlcoD9VCkNJjdRIAe9f7G4UTxhAQ2EjtEApND6A9zcv9ZUqfio
	 DNT9IeuLrJP04Yb283f+Lyyt+4l6Ria/ojc2KpZpHv8n7khXvDEK27xVc/rQg/3yg0
	 jlh0OUvC2oIYX7bTfbAiM7j0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0573440E01C5;
	Thu, 29 Aug 2024 06:48:16 +0000 (UTC)
Date: Thu, 29 Aug 2024 08:48:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com,
	vkuznets@redhat.com, babu.moger@amd.com
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for
 the Bus Lock Threshold
Message-ID: <20240829064811.GAZtAZqzWkmF79VOs7@fat_crate.local>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-2-manali.shukla@amd.com>
 <Zr-qkJirOC_GM9o6@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr-qkJirOC_GM9o6@google.com>

On Fri, Aug 16, 2024 at 12:37:52PM -0700, Sean Christopherson wrote:
> I would strongly prefer to enumerate this in /proc/cpuinfo, having to manually
> query CPUID to see if a CPU supports a feature I want to test is beyond annoying.

Why?

We have tools/arch/x86/kcpuid/kcpuid.c for that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

