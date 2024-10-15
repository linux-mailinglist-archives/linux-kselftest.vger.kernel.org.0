Return-Path: <linux-kselftest+bounces-19758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DC99F3D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1421F2225E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65D1F76CF;
	Tue, 15 Oct 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cgh80CJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5291F6684;
	Tue, 15 Oct 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012628; cv=none; b=d99gffoazEVqCA3f/smzYaL/jtf+XsHznpSZLiebAaGTop841qOuIPTU13J3xssXEa70h/kWySrF3VLrR0UJwc7IT11vJckmqnrlwddbyPk8vplrjZLHNj+37cFrfFs3BN8MqSHB3/OyCfLZoN1DvZ4C+4ld170pmKLHWywTAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012628; c=relaxed/simple;
	bh=3pgwbzfO+sAg7V1rNYJVaySR0aOfArSzvdBb+Bqtkfo=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=ESOs/LfJUZbEb/OAcR4S5BLwvKC7+FajiHWi2HlnQXPglNExmK1Yg4HGZP4ubn2pNs34+5A/jBTLAQz1foyzejgHymGEKH7LjEQLjfI9eLtVKhAZ25tOK+iOBxyR/czIT9oD6X/qEx3ptTxdNYs0sj1FRD2pzDijSdiGPjqcxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cgh80CJV; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729012627; x=1760548627;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=eFf2pTbi8+kG2U/aqW1y4su0gyH9oAJZFLQq1g6nLzU=;
  b=Cgh80CJVv1W3kGvbMOStsmM61rJvzR2OxVvlQCuUqU+kVz8GrjqTB1lq
   RCDm5/oKLMX3uQCUS1BHzxQQ2if3weFt+ehFFHKbEufFQAVXVzjGbBc6Q
   h+qJtJgqRYxTrebmLGo7VaP7FC0mmv6rpRkCmc/z+b851Ql7h3DboThfK
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="376377981"
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:17:00 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:25486]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.145:2525] with esmtp (Farcaster)
 id 5697c476-574f-4f11-a9aa-5648d5545514; Tue, 15 Oct 2024 17:16:58 +0000 (UTC)
X-Farcaster-Flow-ID: 5697c476-574f-4f11-a9aa-5648d5545514
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:16:57 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 15 Oct 2024
 17:16:53 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Oct 2024 17:16:49 +0000
Message-ID: <D4WJTFFVQ5XN.13Z7NABE3IRSM@amazon.com>
CC: Nikolas Wipper <nik.wipper@gmx.de>, Nikolas Wipper <nikwip@amazon.de>,
	Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd-dirty
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-3-nikwip@amazon.de> <875xq0gws8.fsf@redhat.com>
 <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de> <87h69dg4og.fsf@redhat.com>
 <Zw6PlAv4H5rNZsBf@google.com>
In-Reply-To: <Zw6PlAv4H5rNZsBf@google.com>
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Hi Sean,

On Tue Oct 15, 2024 at 3:58 PM UTC, Sean Christopherson wrote:
> Before we spend too much time cleaning things up, I want to first settle =
on the
> overall design, because it's not clear to me that punting HvTranslateVirt=
ualAddress
> to userspace is a net positive.  We agreed that VTLs should be modeled pr=
imarily
> in userspace, but that doesn't automatically make punting everything to u=
serspace
> the best option, especially given the discussion at KVM Forum with respec=
t to
> mplementing VTLs, VMPLs, TD partitions, etc.

Since you mention it, Paolo said he was going to prep a doc with an
overview of the design we discussed there. Was it published? Did I miss
it?

Thanks,
Nicolas

