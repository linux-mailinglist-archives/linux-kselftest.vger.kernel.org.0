Return-Path: <linux-kselftest+bounces-19127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D708991CC3
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 08:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5A428229C
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B95165EED;
	Sun,  6 Oct 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bI7GUOyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B13158862;
	Sun,  6 Oct 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728196006; cv=none; b=JuU1JEBXHNt9vBvK6j9vjfjW0JtFfsffR1O81aV/4J2REPSNn82HCMr7yCJ2FtzWouU1RJW+K/OuFTiR/GCHjDGNA46dAhNQin44cHqAehpl7xvjUfrZxzha/jCqaLXPbFvR4s3jVRbk+st7gTlg4yUnbmBsmWAxf5GznBIsE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728196006; c=relaxed/simple;
	bh=BwSmet5U3UeygxPIkLXf2oFWJOec+/C3NC4O/tCdlU8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MF3Mtmkp+ik1kigfql32gyvn7EcQf/0gZiOXCei19bgyRFPi7+uyAIhB6nbRhGCQLA8ISSep5bctKoG2f6AeT7Ev78CKBJl3wUDY7DEfGVOZsLPn8d+1NqvTS+YrRMMUQY52gLrxgv3In8yVOQJMPRF6mFwi3lfjcemznFtLe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bI7GUOyp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AB5440E021E;
	Sun,  6 Oct 2024 06:26:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tJkNPRUveA0w; Sun,  6 Oct 2024 06:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728195990; bh=FSNhRWJawPKwGCAyC5UzTVAx9BVH6LPc3vWgO6rGn44=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bI7GUOypuitxvx6A+tgaftVrKiqqLnbjfUzlqS0WjU21fVUB4WCRpNB/yPQsNSeqO
	 r6/1CFDLLf1zJwWsa6KBMiFVosQ1WX1srs/z4j/yyWU7gIx0TvBw/GbhNr9N6KHlqn
	 tm6T2txMVhQxrF+AbC5vRuSNKJ3EnAr6T17W4nnf+a7fe1CHLFq37aRKGCbUnV/Kmi
	 2BMaRsT6a1CCnXIiV5ibLprOMBhG+PAKkIYMqy8cv5PZypNTdfOufm8mV4VbSTEfhD
	 UE9oGV56eDAkoxDW2zbQ3Gml6vr9GfZrBbNWPMpl30yEX5p56aHIqsoImTxX9iCP7Q
	 u6L8SQWj5aXHQlHgjr6JDaq0tyPGUVv+9EwQ/ozyKetbxJYfUGGw2qKm+Gbx4TdgKd
	 QvF/Jrl7z5b34nRranQCAKe1dA3JOvSqqeYRYc4SQ8hC9sELerXr1X/PvpA+lRHk7i
	 KN1afkIWJPvbqDFTfVsrYu49Dxk0uaVI5ldEh5dT7P0KEQ0CXO4d8Bmh8XdaM/gplg
	 IvWTWdJY/XTDC6+C9jSzaeigIPDC0A4j4eMsAshGS9yEHRF+ldqk2NpefFabSKx5YZ
	 AG17X1tVho9SoanOOJpDDbL6HlLPgv50dvnO20F7YIW1E7Tq6I80Mi+JiPXZk7gMNp
	 mmNShvLi2IoZLwx9LKMuArW0=
Received: from [127.0.0.1] (dynamic-176-003-046-066.176.3.pool.telefonica.de [176.3.46.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2F1340E0184;
	Sun,  6 Oct 2024 06:26:19 +0000 (UTC)
Date: Sun, 06 Oct 2024 08:26:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
CC: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, manali.shukla@amd.com,
 babu.moger@amd.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/4=5D_x86/cpufeatures=3A_Add_CP?=
 =?US-ASCII?Q?UID_feature_bit_for_the_Bus_Lock_Threshold?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241004053341.5726-2-manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com> <20241004053341.5726-2-manali.shukla@amd.com>
Message-ID: <213827CA-4A73-4E3C-A4D1-3B325E34768D@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 4, 2024 7:33:38 AM GMT+02:00, Manali Shukla <manali=2Eshukla@amd=
=2Ecom> wrote:
>Misbehaving guests can cause bus locks to degrade the performance of
>the system=2E The Bus Lock Threshold feature can be used to address this
>issue by providing capability to the hypervisor to limit guest's
>ability to generate bus lock, thereby preventing system slowdown due
>to performance penalities=2E
>
>When the Bus Lock Threshold feature is enabled, the processor checks
>the bus lock threshold count before executing the buslock and decides
>whether to trigger bus lock exit or not=2E
>
>The value of the bus lock threshold count '0' generates bus lock
>exits, and if the value is greater than '0', the bus lock is executed
>successfully and the bus lock threshold count is decremented=2E
>
>Presence of the Bus Lock threshold feature is indicated via CPUID
>function 0x8000000A_EDX[29]=2E
>
>Signed-off-by: Manali Shukla <manali=2Eshukla@amd=2Ecom>
>---
> arch/x86/include/asm/cpufeatures=2Eh | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/asm/=
cpufeatures=2Eh
>index dd4682857c12=2E=2E77fa8e743ccc 100644
>--- a/arch/x86/include/asm/cpufeatures=2Eh
>+++ b/arch/x86/include/asm/cpufeatures=2Eh
>@@ -382,6 +382,7 @@
> #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPE=
C_CTRL */
> #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
> #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
>+#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock =
threshold */

Why does this feature flag need to be visible in /proc/cpuinfo?=20


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

