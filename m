Return-Path: <linux-kselftest+bounces-23269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8A9EF596
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64A218985C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DEB217F40;
	Thu, 12 Dec 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kfzcLrxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0E1487CD;
	Thu, 12 Dec 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023477; cv=none; b=elJbC6lEzMs8ML1K3Xq9khWsSBn5cAppkZFhTw/AlNszTXtLbZmyLT46AM4z5QFFTB4V6yqFim60hiOVLncFGGb7wvBjuRq0rgVSAUM9H/LmvSlqXxbw7c45IcravFl9C9G6jP1fAMXvN3/ajAyu4UcUc3AxGWMVQQa1VEZ9+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023477; c=relaxed/simple;
	bh=84OZ6IErP8u6zVz/Xj0Rvh4w+IpqqUOzcvU+U1gjd60=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY0NN40wmkyLO5Ty3N6DtWK+DPrZDMHrjZUcPGKT5EihF0auai+YcQZM2Fq0wSD+na4qoRfhKXpjaZs2iL+sAJQd3qVKsMN/bxigWAZux4teSf/IccYfJJAEYbjt3c+P7byXm4KvOY6y5gyTMVOLBrjgmbLMLo+5v5YbVdI3Co0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kfzcLrxW; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734023475; x=1765559475;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Stwri8NjOMHN1To4fk758jAq3xQcxV+/bqX/dHtALb8=;
  b=kfzcLrxW2ArsLo6Pg7QmSAnNa6RDqZntyxjwoYrbE34r8gkXFZxj5ePv
   GaI1E1IsK2CbeBqzur4eoRoyK/EJO/t+Cos5zd+aHXUeH2uFc5EHTF3gE
   3wbAb1DRmhTOqr4vuAyFpGJ2zoWOsgSFeunbiEZDUQK0AZ/KKRrudhhQS
   k=;
X-IronPort-AV: E=Sophos;i="6.12,229,1728950400"; 
   d="scan'208";a="392676613"
Subject: Re: [PATCH v2 6/6] selftests: KVM: Add test case for MMIO during vectoring
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:11:09 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:52070]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.13.90:2525] with esmtp (Farcaster)
 id dcdd255e-a807-4c3a-b3f0-02ddb7ee487f; Thu, 12 Dec 2024 17:11:09 +0000 (UTC)
X-Farcaster-Flow-ID: dcdd255e-a807-4c3a-b3f0-02ddb7ee487f
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 17:11:08 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 17:11:08 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 12 Dec 2024 17:11:08 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id 9859A40608;
	Thu, 12 Dec 2024 17:11:08 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id 54E966224; Thu, 12 Dec 2024 17:11:08 +0000 (UTC)
Date: Thu, 12 Dec 2024 17:11:08 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <x86@kernel.org>, <pdurrant@amazon.co.uk>,
	<dwmw@amazon.co.uk>
Message-ID: <20241212171108.GA47263@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
 <20241111102749.82761-7-iorlov@amazon.com>
 <Z1nXvL05VXShYpYR@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1nXvL05VXShYpYR@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Dec 11, 2024 at 10:19:40AM -0800, Sean Christopherson wrote:
> > +static void guest_code_mmio_during_vectoring(void)
> > +{
> > +     const struct desc_ptr idt_desc = {
> > +             .address = MEM_REGION_GPA,
> > +             .size = 0xFFF,
> > +     };
> > +
> > +     set_idt(&idt_desc);
> > +
> > +     /* Generate a #GP by dereferencing a non-canonical address */
> > +     *((uint8_t *)NONCANONICAL) = 0x1;
> 
> Now I'm curious what happens if this uses vcpu_arch_put_guest(), i.e. if the
> test forces KVM to emulate the write.
> 
> No action needed, the test is a-ok as-is.  I'm really just curious :-)

:) Just tried enabling `force_emulation_prefix` kvm parameter and replacing the
write with

vcpu_arch_put_guest(*((uint8_t *)NONCANONICAL), 0x1);

And the test simply passes (so it returns the same internal error with
suberror=3, patches applied)

--
Kind regards,
Ivan Orlov

