Return-Path: <linux-kselftest+bounces-13894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5299352AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE3D1C2108F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAA145FEA;
	Thu, 18 Jul 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IpF8rhVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1231459F3;
	Thu, 18 Jul 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336717; cv=none; b=ok1hSxC/U+54NGTEVpMj1VswH7q9DlcgAdR9KZTyobcPzaZnW306X2K5PTLYE6pktRml1U1lizgoKO5kx8EsH0cHu7kVDqWK4h14pDN/OkspdiNoXwxNHlJdONCAZJH12vxcNYbRsfseRVgJypbdUKd8fofASkVf2vIf5BMTOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336717; c=relaxed/simple;
	bh=1v1jqKjcYUvw8UYOoT13Hp5wiWGbu+/qYozJU++DnG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DyG0hOklWTOwbaF2KmITJSqGhlJSwq63LFtSE5ENpviYP/rBdpJUZVP26MLP7IyHmpA+ijTZZ+ssktMOEZIuIQg73SnWWlQ3HgY3PYAx6eaItmAdxHSX8zY/v+MMwvzEA+7F0BlSzgTcwFSHbnUJu9B6sea52otcf1JtrELw5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IpF8rhVB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46IL4dBe3348195
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 18 Jul 2024 14:04:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46IL4dBe3348195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1721336680;
	bh=4e/wb8Y491QaVr7KpN/BHdZKNSDjapJmexIf6bpg06g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IpF8rhVB/mNH993z1cV6s3+O5XiEv99FHyBRcD70bJqvwGanjoCH9jSNBBAh5tZTt
	 QWu4vTMYC39qTclBHtY3CCbYAiI/flYnkguIOmQN/+0HnIYx//OGkE2VBC9yBJZ1tu
	 DjksAbQQuG+Lpa/ZSO2W4MoL1zUtIppcThvDo0QbOxwhtjF08vmupD33VLEacjXNpU
	 Sny+grcdUSrGmBxlD9Pa+1iJHn+sV73Tz4+pzuLxRTMycCSF0QiTAvQtSZzdRWNanA
	 zZUcpUPCPvAxeeFciSo6FGM0mrAyP//tzIvq0pJjDpdk4rrACoIV30nngdxw0B0yqS
	 6tA/35Dgcz49g==
Date: Thu, 18 Jul 2024 14:04:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sean Christopherson <seanjc@google.com>, Xin3 Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        "xin@zytor.com" <xin@zytor.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/25=5D_KVM=3A_VMX=3A_Swit?=
 =?US-ASCII?Q?ch_FRED_RSP0_between_host_and_guest?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZpFH86n_YY5ModwK@google.com>
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com> <ZpFH86n_YY5ModwK@google.com>
Message-ID: <099D0BF1-BDC6-489F-B780-174AFEE8F491@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 12, 2024 8:12:51 AM PDT, Sean Christopherson <seanjc@google=2Ecom> =
wrote:
>On Wed, Jul 10, 2024, Xin3 Li wrote:
>> > On Wed, Feb 07, 2024, Xin Li wrote:
>> > > Switch MSR_IA32_FRED_RSP0 between host and guest in
>> > > vmx_prepare_switch_to_{host,guest}()=2E
>> > >
>> > > MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
>> > > KVM, running on ring 0, can run safely with guest FRED RSP0, i=2Ee=
=2E, no
>> > > need to switch between host/guest FRED RSP0 during VM entry and exi=
t=2E
>> > >
>> > > KVM should switch to host FRED RSP0 before returning to user level,
>> > > and switch to guest FRED RSP0 before entering guest mode=2E
>> >=20
>> > Heh, if only KVM had a framework that was specifically designed for c=
ontext
>> > switching MSRs on return to userspace=2E  Translation: please use the
>> > user_return_msr() APIs=2E
>>=20
>> IIUC the user return MSR framework works for MSRs that are per CPU
>> constants, but like MSR_KERNEL_GS_BASE, MSR_IA32_FRED_RSP0 is a per
>> *task* constant, thus we can't use it=2E
>
>Ah, in that case, the changelog is very misleading and needs to be fixed=
=2E
>Alternatively, is the desired RSP0 value tracked anywhere other than the =
MSR?
>E=2Eg=2E if it's somewhere in task_struct, then kvm_on_user_return() woul=
d restore
>the current task's desired RSP0=2E  Even if we don't get fancy, avoiding =
the RDMSR
>to get the current task's value would be nice=2E

Hm, perhaps the right thing to do is to always invoke this function before=
 a context switch happens if that happens before return to user space?

