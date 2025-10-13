Return-Path: <linux-kselftest+bounces-43005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E3BD4EB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5018A69B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05402278165;
	Mon, 13 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JQss/l/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372B322A;
	Mon, 13 Oct 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372179; cv=none; b=AZDDHuLBbxqxVerBibP5BSk83EB+ALwiK7PoY5rt/r6Eszk4uv5VPNhXoJvGGqLpsLbjW9+0jDXcOM9Uu5Wh7DYX6QeEFuFmh6hIghv3+8NHL3Es2U6MXG3hG1F5WgfxWlVxsBVq8nnPieJkRsNiT78n3UgaXBSRhklyTBOP2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372179; c=relaxed/simple;
	bh=q4TWi+EHOJV5TC7Iymk26iR2c2LUySOZ0b50x1RvGCo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e0pMzxrfjZfgGjV++sYwlXKVSERVdFVu0XGp55xOzYFoL0V4prVDCMk8vaezj0D1bwkqIFei1gk8c1l4sY7qbdk8sEAcxq+25P93UUqVyJss5ydaFFOxoyXHn4sEHnzcssIsaWZLP09VFSTlTD6UEoYNxgtAFTiDJoLKJEFdm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JQss/l/M; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DGEplg1360107
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 09:14:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DGEplg1360107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760372093;
	bh=MzpJMWVhNoOjgk4BJX8F1SShnKbckMn+Nc+zuR294Q0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JQss/l/MXShiySKzZWsav9VeArEu5N+uHoA047KLEMyntuwcMeK9wlN7HIQ0Tqk38
	 JWP3hXYKNvikpWfX6arlx9W0uwDMOxRmDNvKTDAE5F6UoQRuW2UYdQH8FS/dmu5d3E
	 IWsydJI7iSqT/4JiUB/QpAvO0m3CLOT54r0BnuzOxjwp1hTkoYG5cC2cXMzIqbFFu/
	 hVeOMUm7eShn55+XGXxv1i0cXqiWlUTDXcOMz142IMJrmHCUqBtj9hGS3pSQf+YHB+
	 vjYWunPASD2OmpmvS1CGd8ToW6X150kS6ymSlNwqvCNTUzUlIQ4v/fyvlZZe23Moc7
	 PV1r9bSGOj9qg==
Date: Mon, 13 Oct 2025 09:14:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>
CC: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
User-Agent: K-9 Mail for Android
In-Reply-To: <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de> <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
Message-ID: <9F23DEFF-FCD7-488E-B31C-E891A7521D9E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 13, 2025 7:06:55 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 10/13/25 02:20, Thomas Wei=C3=9Fschuh wrote:
>> -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused);
>> -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused)
>> +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)=
;
>> +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
>>  {
>>  	int cpu_id;
>
>It would ideally be nice to have a _bit_ more history on this about
>how it became unused any why there is such high confidence that
>userspace never tries to use it=2E
>
>Let's say someone comes along in a few years and wants to use this
>'unused' parameter=2E Could they?

I believe it was a private storage area for the kernel to use=2E=2E=2E whi=
ch it doesn't=2E Not doing anything at all with the pointer is perfectly le=
gitimate=2E

