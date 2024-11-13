Return-Path: <linux-kselftest+bounces-21908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8F9C67DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 04:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546CFB2B695
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAB16EB55;
	Wed, 13 Nov 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p2FyNdhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4D2231C;
	Wed, 13 Nov 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468705; cv=none; b=DZ8f8KGaALAN3qmtkMDO1D7d9obK5CjUgfQ1XjIeqi4AEd9UxHK2vmYI91tZkInWYpTP0gNniq27snI+xL1378mc6HvZ6zESK7sID/BQDF5npU/gjIKnSjwK3vXvDXfFdqsiljJYKm/CukaGwI8ciLpuZbtnSacPCklDiLpo2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468705; c=relaxed/simple;
	bh=/bYsay7vg1weqenJRpb4pqt79mASw+nrIHAtGk1mYk0=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=mZbLYxWyIoDj+Txve+6wv7kbAkLR9pgH7cxHe110BpJ7aDSbSZm+wRnatiymdB1B4ya2hua1oYLEVsHUU6z9zEZ+TpZ5mWdKLNkNehlAARKXTRDGKCI3jz2YZ/Gzq/7/haeGSrG/74wJLAKsMVlLKstE48q5C6py2tiUET7Qyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p2FyNdhI; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731468703; x=1763004703;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=/bYsay7vg1weqenJRpb4pqt79mASw+nrIHAtGk1mYk0=;
  b=p2FyNdhIAi+6xoWhb29VwwL4rYVU/pPGGnyai28akMRJ0vFNwFs/T6Vj
   eiueWOUGu4dnJNH5Hny1h8CHvZzYocsG0h16E+FlLNBRa8F3JcaIdqmrJ
   KCD5NNrIGc573cvqyJrNOyw+0LzZnLf/WD6iGQCHkldT9dIQ+7S1M071M
   M=;
X-IronPort-AV: E=Sophos;i="6.12,149,1728950400"; 
   d="scan'208";a="442195777"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:31:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:35392]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.112:2525] with esmtp (Farcaster)
 id 1975e212-552a-4756-aa4f-791440302fe9; Wed, 13 Nov 2024 03:31:37 +0000 (UTC)
X-Farcaster-Flow-ID: 1975e212-552a-4756-aa4f-791440302fe9
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 13 Nov 2024 03:31:37 +0000
Received: from [192.168.205.1] (10.106.101.35) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 13 Nov 2024 03:31:34 +0000
Message-ID: <96c24397-b081-4570-adb2-8d4443f3359c@amazon.com>
Date: Tue, 12 Nov 2024 20:31:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <elena.reshetova@intel.com>
CC: <ackerleytng@google.com>, <agordeev@linux.ibm.com>,
	<aou@eecs.berkeley.edu>, <borntraeger@linux.ibm.com>, <bp@alien8.de>,
	<canellac@amazon.at>, <catalin.marinas@arm.com>, <chenhuacai@kernel.org>,
	<corbet@lwn.net>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<david@redhat.com>, <derekmn@amazon.com>, <gerald.schaefer@linux.ibm.com>,
	<gor@linux.ibm.com>, <graf@amazon.com>, <hca@linux.ibm.com>, <hpa@zytor.com>,
	<jgowans@amazon.com>, <jthoughton@google.com>, <kalyazin@amazon.com>,
	<kernel@xen0n.name>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <luto@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>, <mingo@redhat.com>,
	<mlipp@amazon.at>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <quic_eberman@quicinc.com>,
	<rostedt@goodmis.org>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <svens@linux.ibm.com>,
	<tabba@google.com>, <tglx@linutronix.de>, <vannapurve@google.com>,
	<will@kernel.org>, <x86@kernel.org>, <xmarcalx@amazon.com>
References: <DM8PR11MB57505F62D149EF153F89B8BAE75D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Subject: RE: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <DM8PR11MB57505F62D149EF153F89B8BAE75D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-08 at 10:36, Elena Reshetova wrote:
> On 2024-11-06 at 17:04, Derek Manwaring wrote:
> > On 2024-11-04 at 08:33+0000, Elena Reshetova wrote:
> > > This statement *is* for integrity section. We have a separate TDX guidance
> > > on side-channels (including speculative) [3] and some speculative attacks
> > > that affect confidentiality (for example spectre v1) are listed as not covered
> > > by TDX but remaining SW responsibility (as they are now).
> >
> > Thanks for the additional info, Elena. Given that clarification, I
> > definitely see direct map removal and TDX as complementary.
>
> Jus to clarify to make sure my comment is not misunderstood.
> What I meant is that we cannot generally assume that confidentiality
> leaks from CoCo guests to host/VMM via speculative channels
> are completely impossible. Spectre V1 is a prime example of such a
> possible leak. Dave also elaborated on other potential vectors earlier.
>
> The usefulness of direct map removal for CoCo guests as a concrete
> mitigation for certain types of memory attacks must be precisely
> evaluated per each attack vector, attack vector direction (host -> guest,
> guest ->host, etc) and per each countermeasure that CoCo vendors
> provide for each such case. I don't know if there is any existing study
> that examines this for major CoCo vendors. I think this is what must
> be done for this work in order to have a strong reasoning for its usefulness.

Thanks, that makes sense. I'm a little hyperfocused on guest->host which
is the opposite direction of what is generally used for the CoCo threat
model. I think what both cases care about though is guest->guest. For
me, guest->host matters because it's a route for guest->guest (at least
in the non-CoCo world). There's some good discussion on this in David's
series on attack vector controls [1].

Like you mention, beyond direction it matters which CoCo countermeasures
are at play and how far they go during transient execution. That part is
not clear to me for the host->guest direction involving the direct map,
but agree any countermeasures like direct map removal should be
evaluated based on a better understanding of what those existing
countermeasures already cover and what attack is intended to be
mitigated.

Derek


[1] https://lore.kernel.org/lkml/LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com/

