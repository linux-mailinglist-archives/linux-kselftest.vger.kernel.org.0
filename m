Return-Path: <linux-kselftest+bounces-14504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23516942483
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 04:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3591F24533
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3D3232;
	Wed, 31 Jul 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7fW9y3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC1125BA;
	Wed, 31 Jul 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393183; cv=none; b=uDjpoFocliRO8z0HrlnFs7i6A7guY/UyBf6RLlSJPCO6DeU0Ex5kSeApbVadF6KTAh/OmHg+rnQBj4Jxs2RpaFHDe9jVI7QyH2+wzmI+cVz/OWGvQlwWsJYTjZ7xl8kA5EZLueFS8K2eW0cjhtBQ0HjYvk65Fs/1Uzg3SybR+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393183; c=relaxed/simple;
	bh=i4hgWJlYRb7gA1vkh1Vt5AuzmcHFPSZmV/Ib1lGvVEc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QrRwDJ4PzX8Yi+17VH6V8apraHVwgJHvksMvBD16p8VVeomHHW+9mRpaS0W2N99c3YNGl/5DlqJoYCZW0lCG2K6Eq5EQT085ZcTYYLaiyIG7QtT67AVf31hAYgGkWdQRLkIysDjSa9Jyg16hHa9A4+p4sYIURwU0xjctMPpDc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7fW9y3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6067C32782;
	Wed, 31 Jul 2024 02:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722393182;
	bh=i4hgWJlYRb7gA1vkh1Vt5AuzmcHFPSZmV/Ib1lGvVEc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=W7fW9y3wfVjp8eE6HEKzEd/xHRTgF/rINyKFxeehkJFCp/VUEKmiKJVnddm36+Z7J
	 iyJjyvXmM2g/MI/bsoV+QK5vLqdjcfb91vXi+Bu5NcX63XVb8WYcbghgE7qAZm6LPT
	 d5iPUa65soXF5hoBIRDm57M0whfRVZySq3BKxTrTjAGlIqigOWBqgjqcidJXVWt2Eh
	 NE/SLiN5bVLwmBGb3e9koLLsIzozfrsVP9LlwsLaiMSjfZNo2YwNi8Qwo2Vm760fDx
	 QkSxejShkP/WgD6JiJ7ntwmL9dpvwoM8NcfpM+OAAgeTOUdkcgh4mU8NFQqvesX+SO
	 9+QbFWRMWeORA==
Date: Tue, 30 Jul 2024 19:33:01 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
 Vitor Massaru Iha <vitor@massaru.org>
CC: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: user: remove user suite
User-Agent: K-9 Mail for Android
In-Reply-To: <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com> <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org> <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
Message-ID: <5B0BBE86-C3F3-4CA3-87F5-49F0DB1B28EE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 30, 2024 3:36:11 PM PDT, Shuah Khan <skhan@linuxfoundation=2Eorg> =
wrote:
>On 7/25/24 08:44, Shuah Khan wrote:
>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>> The user test suite has only one test, test_user_copy which loads
>>> test_user_copy module for testing=2E But test_user_copy module has alr=
eady
>>> been converted to kunit (see fixes)=2E Hence remove the entire suite=
=2E
>>>=20
>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>=20
>> Remove fixes tag - this isn't a fix and we don't want this propagating
>> to stable releases without kunit test for this=2E
>>=20
>>> Signed-off-by: Muhammad Usama Anjum <usama=2Eanjum@collabora=2Ecom>
>>> ---
>>=20
>> Thanks,
>> -- Shuah
>>=20
>
>As mentioned in other threads on this conversion to kunit and removal
>of kselfttest - NACK on this patch=2E
>
>Please don't send me any more of these conversion and removal patches=2E
>

I think there is a misunderstanding about these particular patches (for st=
ring and usercopy selftests)=2E Those were already converted, as desired, b=
y the maintainer (me) to KUnit=2E These associated patches are cleaning up =
the dangling kselftest part of them, and should land (with the Fixes tag, w=
hich is aimed at the commit that did the conversion)=2E

-Kees


--=20
Kees Cook

