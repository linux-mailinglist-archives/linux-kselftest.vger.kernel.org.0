Return-Path: <linux-kselftest+bounces-23628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E946E9F886B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA52F189465A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE01CC8AD;
	Thu, 19 Dec 2024 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BNl7AOgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFC1BC9E2;
	Thu, 19 Dec 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734650410; cv=none; b=ufbUvh4+5uIa0wSdNCWwdRKt5Tnn5Zua9kTbtEybb2wClUJJPpTrX97ZABoO+6e4DrK0lTY/C+UWdy7j5unXnwicVuS7JMPGg2hW+clXdwLg/sIP8KiRXdt3L+O4HRFLu4IX5kCvFs+lCDpYRuNUKykt86h2zARg4UizIo6se9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734650410; c=relaxed/simple;
	bh=q8GWX1k/JqInj+D9puv5zulzbKpKHFJrsUcxLaO3tnM=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWQiTZJei0hDyTLutclYYK6yRwXe1ARp+KPfET5d+hKE5hMCu7tWN1MRJ+iU12OS+mk0w1awhJedkh3OMNQrwxcws0LkS+RPJn7fTg/35JQYldRwuxvcxnQInrUlnJlIvV3lW7L2GlhVBBBL70U1sWenE2g4iXkf3galhGXbzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BNl7AOgI; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734650408; x=1766186408;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=ylam2A8WL6Y39bN1NcplgYgTXD/E8crnsGDHgkTN84o=;
  b=BNl7AOgI52CGWYixPSwRAII+moJQ7ZNqJ2y5xpAXI/ghYUU5KOxmK4UZ
   ti+s1dbryP0+CdNS1g/FJcGRI1AfaVnKfVBuOKH9tPAnTeK4R4L5vhRHf
   zPkRaQ68QreK7W+EGmMiuSpc9hMsmqFCeAVSFabx2QY+AFxlpeFMcduTa
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,249,1728950400"; 
   d="scan'208";a="50842765"
Subject: Re: [PATCH v3 0/7] Enhance event delivery error handling
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 23:20:05 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:48486]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.15.239:2525] with esmtp (Farcaster)
 id fba20d9f-9d29-4652-a9e3-5c8b998f5a39; Thu, 19 Dec 2024 23:20:05 +0000 (UTC)
X-Farcaster-Flow-ID: fba20d9f-9d29-4652-a9e3-5c8b998f5a39
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 19 Dec 2024 23:19:56 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 19 Dec 2024 23:19:56 +0000
Received: from email-imr-corp-prod-iad-all-1a-059220b4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 19 Dec 2024 23:19:56 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-059220b4.us-east-1.amazon.com (Postfix) with ESMTP id 78FFB40593;
	Thu, 19 Dec 2024 23:19:56 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id 35D194F9A; Thu, 19 Dec 2024 23:19:56 +0000 (UTC)
Date: Thu, 19 Dec 2024 23:19:56 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <x86@kernel.org>, <dwmw@amazon.co.uk>,
	<pdurrant@amazon.co.uk>, <jalliste@amazon.co.uk>
Message-ID: <20241219231956.GA75820@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20241217181458.68690-1-iorlov@amazon.com>
 <173457555486.3295983.11848882309599168611.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173457555486.3295983.11848882309599168611.b4-ty@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Dec 18, 2024 at 06:40:46PM -0800, Sean Christopherson wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Tue, 17 Dec 2024 18:14:51 +0000, Ivan Orlov wrote:
> > Currently, the unhandleable vectoring (e.g. when guest accesses MMIO
> > during vectoring) is handled differently on VMX and SVM: on VMX KVM
> > returns internal error, when SVM goes into infinite loop trying to
> > deliver an event again and again.
> >
> > This patch series eliminates this difference by returning a KVM internal
> > error when KVM can't emulate during vectoring for both VMX and SVM.
> >
> > [...]
> 
> Applied to kvm-x86 misc, thanks!  If you get a chance, please double check that
> I didn't fat-finger anything.
> 
> [1/7] KVM: x86: Add function for vectoring error generation
>       https://github.com/kvm-x86/linux/commit/11c98fa07a79
> [2/7] KVM: x86: Add emulation status for unhandleable vectoring
>       https://github.com/kvm-x86/linux/commit/5c9cfc486636
> [3/7] KVM: x86: Unprotect & retry before unhandleable vectoring check
>       https://github.com/kvm-x86/linux/commit/704fc6021b9e
> [4/7] KVM: VMX: Handle vectoring error in check_emulate_instruction
>       https://github.com/kvm-x86/linux/commit/47ef3ef843c0
> [5/7] KVM: SVM: Handle vectoring error in check_emulate_instruction
>       https://github.com/kvm-x86/linux/commit/7bd7ff99110a
> [6/7] selftests: KVM: extract lidt into helper function
>       https://github.com/kvm-x86/linux/commit/4e9427aeb957
> [7/7] selftests: KVM: Add test case for MMIO during vectoring
>       https://github.com/kvm-x86/linux/commit/62e41f6b4f36
> 
> --
> https://github.com/kvm-x86/linux/tree/next

Hi Sean,

The commits (and the messages specifically) look good to me, thanks a
lot for making the changelogs better! :)

Also, I ran the selftests for the `next` branch on both Intel and AMD
platforms, and all of them seem to pass.

--
Kind regards,
Ivan Orlov

