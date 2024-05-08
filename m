Return-Path: <linux-kselftest+bounces-9680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3738BF66D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C49B1C21E3C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043423772;
	Wed,  8 May 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTfgDz1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BA17C72
	for <linux-kselftest@vger.kernel.org>; Wed,  8 May 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150484; cv=none; b=UAuwteZ7WYPG6FJ2jlABW9h6C4Utgacvt4bkVDZoCom1uiyDrYlL2dg/m5lt/U4tLkqNAeSO3+zVnngwdx4depSLZxxCTWdOkF58oUMzRXCPLZ46RJuGelKLNOVvrAeiS3O/WqRbseQV8Bcxzv1GqO81ege64n97QplGbuMVB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150484; c=relaxed/simple;
	bh=HudRakf3D9CeUbnWUUiGSx/9kGKnmIN2BmxCQmevDME=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KfrDSNCJxhqkMpIyL/qMhGH1SwPExb92Po9VOa+rCssoepaVgu//l5mbw0wNeeDvJ3hWW9sfJjmIdr1SgPZi9QyaLbsUwPlojZxjpks7FdGj2WOMygcdO8LY6gaBMd9/QuKruO9TIN32nEjv7qaw9Oev64dpU7dsiKUe2iW2kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTfgDz1X; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715150479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HudRakf3D9CeUbnWUUiGSx/9kGKnmIN2BmxCQmevDME=;
	b=fTfgDz1XhsgVdMHzUgZE9QB/inof8pX2WqyQObELukjydd455eFIOjtzdVv+ee369xusup
	mN+EAqxU2hUqgAids7bmsiuT3T6ErZaEc3UDnHsp2XrGuanIBNuH+/Vkd8u9wyQTclMdnf
	K3cVaerHysVz4nPpYXKV9u2tL2ibjiQ=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] Build guest_memfd_test also on arm64.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <CABgObfakz1KQ==Cvrxr5wS36Lq8mvF9uJtW3AWVe9m-b+0OKYA@mail.gmail.com>
Date: Wed, 8 May 2024 15:41:00 +0900
Cc: Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7E9D65D-1DAC-4CA5-BDA5-D515D15E50F8@linux.dev>
References: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
 <CABgObfakz1KQ==Cvrxr5wS36Lq8mvF9uJtW3AWVe9m-b+0OKYA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Paolo,

> On Feb 23, 2024, at 17:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On Thu, Feb 22, 2024 at 12:44=E2=80=AFAM Itaru Kitayama
> <itaru.kitayama@linux.dev> wrote:
>> on arm64 KVM_CAP_GUEST_MEMDF capability is not enabled, but
>> guest_memfd_test can build on arm64, let's build it on arm64 as well.
>=20
> The test will be skipped, so there's no point in compiling it.

It=E2=80=99s not merged yet, but the Arm CCA support series V2 is out =
there, would you consider building it for arm64
as well?

Thanks,
Itaru.

>=20
> Paolo
>=20
>> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
>> ---
>> tools/testing/selftests/kvm/Makefile | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/testing/selftests/kvm/Makefile =
b/tools/testing/selftests/kvm/Makefile
>> index 492e937fab00..8a4f8afb81ca 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -158,6 +158,7 @@ TEST_GEN_PROGS_aarch64 +=3D =
access_tracking_perf_test
>> TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>> TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>> TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
>> +TEST_GEN_PROGS_aarch64 +=3D guest_memfd_test
>> TEST_GEN_PROGS_aarch64 +=3D guest_print_test
>> TEST_GEN_PROGS_aarch64 +=3D get-reg-list
>> TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
>>=20
>> ---
>> base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
>> change-id: 20240222-memfd-7285f9564c1e
>>=20
>> Best regards,
>> --
>> Itaru Kitayama <itaru.kitayama@linux.dev>
>>=20
>=20


