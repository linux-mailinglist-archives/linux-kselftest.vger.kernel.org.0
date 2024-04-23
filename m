Return-Path: <linux-kselftest+bounces-8691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAFC8AE2D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86CF282357
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D773131BA1;
	Tue, 23 Apr 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cmbeqjF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BEF12F585;
	Tue, 23 Apr 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869183; cv=none; b=CjHciFAqJZfVC8Q5sA03GHAj0p46mxWVkiJGBkRKLH2shPqXdFfZ33yc/vBVOjqKyVVWUOvbJspcQv0mT+X2clD2dai33Fzn+IeEnKcKntGuyyYq/HU+cSRERjxcF5PJF/yBZcGRNfjfkZPGNzznLnRZ/0OQWjQOjrmovDhesHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869183; c=relaxed/simple;
	bh=mmjotz2m/s2wCzaIz5vGpF6Ju6kc+foSpiaBrorBsdg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EOJ88/iTVglr5lmE+8pvjfrKMim0wo2FVEaHquQ5h2o21IvRhMHpdQ3XZPP7lCgo6X1p7L1G6rUilndWcWdBeWnsJb5SJjxcUbt/ll+fqPBRhaDidQsSY3zuG+oytYtIqyLKFHIquZGOXzFQOPAZnCqEClkksd2nmPwGM6cRHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cmbeqjF9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713869161; x=1714473961; i=markus.elfring@web.de;
	bh=Z2QfoNYsNXaask8xcpoAL8dlyuCS+LFLGRl6vuwhzKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cmbeqjF9MI/4Xc/cWfQvZU4+GjT1LN+3fohkWCFX1fVX7qGZFUI3WyZhRGRzzgz6
	 SBcwU3rH2wvfa9QG1QMKAhP3JlELYBNEoDz6YTlm4eXjJ9MuFe667qbJSBj0sMKf/
	 MZ5TSLbujJJcrnyw9E+NS2n+eM5qbaiCOnpqaLmc5kgd1kRZBN4z5BYFeBfecdidS
	 +pxRD7OQyTs2eZk/ChX9Njo+BFAFud0LxFUW3QP/RoaHkq6CzIU6bWB+IEDM3nZaa
	 8rPeFCH1ehIcGWqkd1HewCblSY6geGGmmRxhmicU5zAKM9HGeyq3IYj1Zw+/of5k7
	 3FbGLrVVJ/bGcpNa1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1rrq3m0BfH-00BpJG; Tue, 23
 Apr 2024 12:46:01 +0200
Message-ID: <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
Date: Tue, 23 Apr 2024 12:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240423073952.2001989-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n0vG778YO3AlCLa1Kkm9T2tHkc4o+LBjG5klT6TJdU77Jh8Dora
 QFIaJiH85W6Xc7fjQoiRabVVD44o4/UHu0iWfxFwNJowQmmXfs0A6Zn3Qys8CPRvwkLLNsu
 whyjAWIuocz1zh22880mu8XUXCZp6MUK0I8Zj8OZLMETQNwHawKPxzyHeTfXq0gEPLqycpa
 mH4Kkq7K0eOyfe9mfJ+ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RYvcZeMOHFQ=;vIuz/LWBBbAEi+MLP3uR5HcF0S2
 fKZlZqWia6HX2nKjYaSheqvvCWSVJV9WAWF8z6c1ycLowSt34X3TIYZIGzw/tsXNfX9C/Qm8W
 2O0oDDLWY1lkZ/WiwmhlEwXOMHFVBegFFdRNfI5dwg/p9Is4PS7W5wyb0W+Wodwzi9AG2AAcl
 FzaxKtx7aeMfzoXu7TytaH5hkA4LQrqmKtGc71tM2IZtDz4f1xYy9p7IoMWZ/UI4cgk1xGRcI
 Qpz5gKeK0ZHibwOxRsZ4kwiHzEWl+m+5uu5+gndOvc9QtMF1HCm0/wyT8M/wPdqhQpWfFrkZf
 srcFX4IdTU9rrMRYlEAMOU8APeEk/ePBp8sqRDxJGK7Q3HwrAf1vfqiQvBnmy31jVjcn5tavj
 1chOk5dyfcpLXeG20VJo+OXde0ot7jumObxz4Ba5RtkakzOg7T+tyhfgfYnqdyMDcgiqvrpQw
 ZVlqlggxlj+STKT1+/QAnY7LqOWkFNU+xPP6WLe7OB1T7zF8YlfnTaUnTP5erR0T68Sl40K0M
 KkVDpeJQu8hH8fWw1x3YQG7FEbc5iXANOK5FmE8yHzCubDlz0uKKdhp0zQDPIJRhkFjUVbKJF
 a0NbfPGE8ArC+miv6ZN6F/JuH277QhWYLZUtM5X8FVFPJSO/YWqfQDw6yBtAKmbZupBIfvoHd
 Gx6uKztEiPZj0goQVz5KmDmhA82JwhiMugOl8xJMKjDu4vU4vpa6o6RDppRgvQZlIUOXYZf7Z
 hq4MTWC2LtvIfYgXECGjFrb0fgkYWWRF8JQvlX8CLY97yJgavGFGxjnS96jI8PKl1N62SnUK6
 56j7kMp+kepa+px+bg02Nkzo2DG+BXdhxfc7N+CiS0w2Q=

=E2=80=A6
> This patch will add the malloc failure checking
=E2=80=A6

* Please use a corresponding imperative wording for the change description=
.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
>  	const int state_sz =3D sizeof(struct kvm_nested_state) + getpagesize()=
;
>  	struct kvm_nested_state *state =3D
>  		(struct kvm_nested_state *)malloc(state_sz);
> +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
=E2=80=A6

Can =E2=80=9Cerrno=E2=80=9D be relevant for the error message construction=
?

Regards,
Markus

