Return-Path: <linux-kselftest+bounces-8478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B938AB596
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 21:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C332816C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1D13C80A;
	Fri, 19 Apr 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PMit3UJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7F1C10;
	Fri, 19 Apr 2024 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555290; cv=none; b=omY8UFD0Hoz3Isf10YeBRQkMbe2+59+dUTAZD/UMkSYBC9Y5FxavHRJcdcrTSGM0MmzIPXkOFA5/OXNrhEXfU1RCtpLLqta44Sa+2eLvz78gT5f3jU3tcN0oOCOLAY+ZIODjy17JiBpE16R7zXmV9DtsSFTC8SzjabD91J2R1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555290; c=relaxed/simple;
	bh=A8n0J4h+vxWU70gw6aLE6thR3YCxol3CBu+SGEyLGxQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lTHUUXQxC3VXI8VSgsjKUoxqNJE5JmLwVZiz69z4hCYFRgm8jCCKKydtLTuIEBWpACgzG8yqjGIQrjMscVy/L9qI+zwoAUvl2AxUtuDSx5l4y9rydVB2y4EAqL+NVboiAwCJo7bih5vFdAReaXFXXNNkD45PSue+b7k+GbWXiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PMit3UJV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=A8n0J4h+vxWU70gw6aLE6thR3YCxol3CBu+SGEyLGxQ=; b=PMit3UJVifZl7GZqHAeVlXqJqp
	XMzMboZhtuwi8PqPnR/lQeQPWZA/oG3+taObZoT1jdqPVuoZq7fSNPbEwjYj0qEzXyS16id00fG8m
	3dQIdg3fm88DswLD+UOSoSAAeDjXgpiT+hwz+QhG5Jskz3fsyPr0YI9BCZZYpWcfj82i8dK6jc5wQ
	DLvTqnt2mbrWLbUL/XX/je8pjlOQf5MyLbN4qj/vUDtP17DfhJF3K/HnEWm+TEsVSUg2W5U3GKKBb
	RYmHjLFV/Jyp1Few4SZ6TZdrT9JdrUERap8+RmoYO+pyLXvy7OjluquH9B6uXDd+2Bl7TkpjNu35Y
	vBB3ogpw==;
Received: from [2a00:23ee:1548:3009:99e7:ae19:af82:c4cc] (helo=[IPv6:::1])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxu0J-00000008NdL-1uH7;
	Fri, 19 Apr 2024 19:34:35 +0000
Date: Fri, 19 Apr 2024 20:34:34 +0100
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
In-Reply-To: <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
References: <20240408220705.7637-1-jalliste@amazon.com> <20240408220705.7637-3-jalliste@amazon.com> <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
Message-ID: <FABCFBD0-4B76-4662-9F7B-7E1A856BBBB6@infradead.org>
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

On 19 April 2024 18:13:16 BST, "Chen, Zide" <zide=2Echen@intel=2Ecom> wrote=
:
>I'm wondering what's the underling theory that we definitely can achieve
>=C2=B11ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC frequen=
cy,
>and I can see delta_corrected=3D2 in ~2% cases=2E

Hm=2E Thanks for testing!

So the KVM clock is based on the guest TSC=2E Given a delta between the gu=
est TSC T and some reference point in time R, the KVM clock is expressed as=
 a(T-R)+r, where little r is the value of the KVM clock when the guest TSC =
was R, and (a) is the rate of the guest TSC=2E

When set the clock with KVM_SET_CLOCK_GUEST, we are changing the values of=
 R and r to a new point in time=2E Call the new ones Q and q respectively=
=2E

But we calculate precisely (within 1ns at least) what the KVM clock would =
have been with the *old* formula, and adjust our new offset (q) so that at =
our new reference TSC value Q, the formulae give exactly the same result=2E

And because the *rates* are the same, they should continue to give the sam=
e results, =C2=B11ns=2E

Or such *was* my theory, at least=2E=20

Would be interesting to see it disproven with actual numbers for the old+n=
ew pvclock structs, so I can understand where the logic goes wrong=2E

Were you using frequency scaling?


