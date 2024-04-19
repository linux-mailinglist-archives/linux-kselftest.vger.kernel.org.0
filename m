Return-Path: <linux-kselftest+bounces-8477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3318AB52A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8F1F21FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37277F13;
	Fri, 19 Apr 2024 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNTgdd1M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD50225CF;
	Fri, 19 Apr 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552345; cv=none; b=Bqk3fd+PQkfb900tSbCjDE5TdLkkj083tqHd/5e61p1ypxi/tkFoDJxv7E282GcoPozT7VKiKto+3SrktjQCkAHs5od4qHxver/7VTQGkbTGE4yQHestBKDaC1HDSmXGDJDh1ret6sXgZ4Es8QiuWJK0xqjNnuo2a0TrQnPp7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552345; c=relaxed/simple;
	bh=TRulkkAOvsGRfjsQewped+Ly0aSe8u9aY8qD+MMGqPI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=reNkSt69FBGMWu1R0xiTajG18SwZp+SLm7uCnNeV93msOXgx3qe/Nm7IRTo/xy0L+4usZlO3LMaiymgtmlWu6GBZscV92XJKpoAdDTyMBR1WEToM3Ul3Jo1i+lAylHUxoxBlyLfPLCRJbcrFmxux8f2Zcd98oUbzWLgtRGWmOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CNTgdd1M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=TRulkkAOvsGRfjsQewped+Ly0aSe8u9aY8qD+MMGqPI=; b=CNTgdd1MuSz3QNZBgNyK++zRA8
	IJCzl9muTPkk0MydVImRTa0dpivKn7Dbi1kcYJH3iJzoWJZBE0lG6owXlMrn99Ek6WSIT8Vhuxiwn
	8n3toDSKggCO04GXUpRkuvZRnoKujay3W9tIqazCJTtqsiwCrYwUdEPQW8XRCDw5TTrDYD2cjfhXf
	QLHOpGNeKBvSxoEK/VM7RHlNPAs2wkvlCCrO6pGiG8fRHUlNcT58B08uI5I6xvr52LVhiJ0ychxPy
	9kBjqE02y5l4F6PhemUgLGn2HgJWe8BmPp21xtRCiekrbuCg2mGo8DV8OB/s/ZdQMZjYS5Yqu9VVy
	4AMVwlag==;
Received: from [154.49.97.68] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxtEg-00000008IaG-2MiK;
	Fri, 19 Apr 2024 18:45:23 +0000
Date: Fri, 19 Apr 2024 19:43:43 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Chen, Zide" <zide.chen@intel.com>, Jack Allister <jalliste@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
CC: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_KVM=3A_selftests=3A_Add_KVM/PV_c?=
 =?US-ASCII?Q?lock_selftest_to_prove_timer_drift_correction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org>
References: <20240408220705.7637-1-jalliste@amazon.com> <20240408220705.7637-3-jalliste@amazon.com> <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com> <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org>
Message-ID: <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

On 19 April 2024 19:40:06 BST, David Woodhouse <dwmw2@infradead=2Eorg> wrot=
e:
>On 19 April 2024 18:13:16 BST, "Chen, Zide" <zide=2Echen@intel=2Ecom> wro=
te:
>>I'm wondering what's the underling theory that we definitely can achieve
>>=C2=B11ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC freque=
ncy,
>>and I can see delta_corrected=3D2 in ~2% cases=2E
>
>Hm=2E Thanks for testing!
>
>So the KVM clock is based on the guest TSC=2E Given a delta between the g=
uest TSC T and some reference point in time R, the KVM clock is expressed a=
s a(T-R)+r, where little r is the value of the KVM clock when the guest TSC=
 was R, and (a) is the rate of the guest TSC=2E
>
>When set the clock with KVM_SET_CLOCK_GUEST, we are changing the values o=
f R and r to a new point in time=2E Call the new ones Q and q respectively=
=2E
>
>But we calculate precisely (within 1ns at least) what the KVM clock would=
 have been with the *old* formula, and adjust our new offset (q) so that at=
 our new reference TSC value Q, the formulae give exactly the same result=
=2E
>
>And because the *rates* are the same, they should continue to give the sa=
me results, =C2=B11ns=2E
>
>Or such *was* my theory, at least=2E=20
>
>Would be interesting to see it disproven with actual numbers for the old+=
new pvclock structs, so I can understand where the logic goes wrong=2E
>
>Were you using frequency scaling?
>

Oh, also please could you test the updated version I posted yesterday, fro=
m https://git=2Einfradead=2Eorg/?p=3Dusers/dwmw2/linux=2Egit;a=3Dshortlog;h=
=3Drefs/heads/clocks

