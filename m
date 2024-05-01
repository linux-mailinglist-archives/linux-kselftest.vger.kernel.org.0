Return-Path: <linux-kselftest+bounces-9178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8E8B8561
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 07:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19719B22191
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC148CE0;
	Wed,  1 May 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VoxZFK9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DD210EE;
	Wed,  1 May 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542089; cv=none; b=f6PfGum+fNGWGvlvarjEOMD9OYq34iIHXb7n64jYgsIlfdx8VUiwGTxoud9VTRU81aXy0rQGv9/vEDR1PWJwNNmTgh2lcgM4hW/N+InRHAg0/JnD6tohlFifGklk1Mh/hA/YiSQ/JawmsflerL2Zf1KSh4saPoPDZhUGHqcedBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542089; c=relaxed/simple;
	bh=HZgy8IynNapACv9oqb7dNMwXQ5pxb+tDS7GOLDQaU8o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IpE9ejLQ7AYdidPWsqf0eah61pg0tMCXTRaAwDKd149QBBgHSndCN5ZRhn7Wir7348+wapKIvv07Hc9WSId78pFVGFbRlJ/r8V2skK+5J+C3MecSm1ssmVncEnQGNUdYk3S8vZjOdxYIiJ1K/dnsO9tQvzczSukHY2FGvYOBnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VoxZFK9q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714542085;
	bh=HZgy8IynNapACv9oqb7dNMwXQ5pxb+tDS7GOLDQaU8o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VoxZFK9qLekCXwHSd1rQlfp3fMPjFnhg+jfer/8H6urzJOMThKTlcnbS6GVIqPlgZ
	 QENMzmko43a4exh06hZBx6x/acdAvj0Qr9aPvpcG46Yn2/ZWwGGSzs3OfJRfgGE6r1
	 v47+WFKIf/UE+2dF4efYNFmGTOT/qvbq/JmWtAKuZNzYzFuRqJ5UHc2M4zPH5bJyxp
	 qKKMzTGDKM5uCi0IiE5HouQpb33naR85FmbG9tHF61PAEmgd6EPDLQXnNkN0thVsrb
	 7tnS5k0et7b+Qh0kTui1r5K3doVyMP6o1pjBp5PvJTV12azppWlUpD0zfl2bLlSZkI
	 SizxKDIue6jvw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A4D437814A4;
	Wed,  1 May 2024 05:40:14 +0000 (UTC)
Message-ID: <be921714-b684-401e-a89a-8256df5fcb86@collabora.com>
Date: Wed, 1 May 2024 10:40:47 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sgx@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Define _GNU_SOURCE for sources using
To: Mark Brown <broonie@kernel.org>, Edward Liaw <edliaw@google.com>
References: <20240430235057.1351993-1-edliaw@google.com>
 <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the fixes.

On 5/1/24 6:59 AM, Mark Brown wrote:
> On Tue, Apr 30, 2024 at 11:50:09PM +0000, Edward Liaw wrote:
>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>> _GNU_SOURCE to either be defined prior to including headers or with the
>> -D_GNU_SOURCE flag passed to the compiler.
> 
> This seems like something that should be handled centrally rather than
> having to go round and audit the users every time some update is made.
The easiest way I could think of is to add -D_GNU_SOURCE to KHDR_HEADERS
definition in tools/testing/selftests/Makefile. It wouldn't be obvious from
KHDR_HEADERS name that there could be other flags in it as well though.


-- 
BR,
Muhammad Usama Anjum

