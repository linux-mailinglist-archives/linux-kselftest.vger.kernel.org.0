Return-Path: <linux-kselftest+bounces-29469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838E1A69C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7581888354
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB8222594;
	Wed, 19 Mar 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctJVAq1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3101C3C11
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425936; cv=none; b=qJYLK/TPUmYRe57yLg0nBfpM7Qy5AuZsAF7KG7o1uOuOHoRVbJhQQ+1Y2YNvmLvoFLjZs1X/o/DAFtV+XfJzV0wUPbCn5SixcLb9TzsTtF1HjtLS9ihzT8pP9LFyk4vaw4Mh1Ccx5vcvlgZ4ox2VTDyCZqdUYM+tFXGOAJ96ABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425936; c=relaxed/simple;
	bh=1s+mT13Po59uk7JTIoXRVLteCQIeAS7uaT5/b1rskCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwvMFgFgiNXSeSFz3GyhrazxOb3P1UZhKkFBolQ4CY9UMZf3VTSz8iB+uq364I8P7bmN/pSRP6jLd/YMox7sf9kZw7x/pO/oTEQIHVVH405J9QE4KPkd0qmZj64LmeIRcu1/rJtOU5heEeanfH1gQhe9BjAf5TAEl/si8in8IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctJVAq1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742425933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwKvnnVbbmyLH9edSeNILr3inqdgiQDTas58Nmmy7mo=;
	b=ctJVAq1QOsd0RCA3pnia+ilargYE+BQBECUnh+vFjNnrtT5pqzeClTJ0r6K7Xi0/v9XG32
	g7ZCm2di2qAYaSkLWG/Hi3OPhzUU6TROnxnakOii+G+LWRUYXniY9PPniWsdRJY7cn6Z3f
	2PVfAG2lmlc5G4CFcf6Pt2W2F7SDi1s=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-iT72UySRMhmqRNf9zh7EVQ-1; Wed, 19 Mar 2025 19:12:12 -0400
X-MC-Unique: iT72UySRMhmqRNf9zh7EVQ-1
X-Mimecast-MFC-AGG-ID: iT72UySRMhmqRNf9zh7EVQ_1742425932
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e63aad1e67dso232994276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 16:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425931; x=1743030731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwKvnnVbbmyLH9edSeNILr3inqdgiQDTas58Nmmy7mo=;
        b=V3jIiXIMkvTbBs3rg5U/G3L7eBs83CpNqmcQe8MB2HZKmXrgZLuHDkhGVxDyzWCSy2
         MfC9OUCLfIhFyctdVI4u82Vx+6K0uhCtI7YN0NnOMBDmdPCR8dE0S8atxKYNnv/DZc53
         gDzr1myFuQmphP4eQGQppzX0K262/H3VLwHJwtiPOwwyCTTDvnqJpdDghAGm7RzSmKWe
         uokiXsBPjE+3Ar8MsQiA7tlybLxY5x2i2MZS5XrdUP1HCWcaG0s+w7Em+y/RuF1DdF/H
         dQGy+E6/965/f2hwn6YPNIxfbK2k0AeqgEn22SSYL7VR2RVDQLSwp97N8pl8a6xZ4INv
         SFKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1cNBGXv0Tt2UsFkjCKqpOjUFG586wqMaMVqlgDEsVrG4X0oxV6r3yv8FBTXcuE5AsvSgspfuBuLu1j5Tv/Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv/C4V0VbUfSiKLRb5dWefCN4ZHQ0KAQDq73TjlC8kjpg9Kon
	gabchfi5kARljl0YNGL17qPyygIX3gbpbVdNBh/fGL9tLuaQZjZPwIJ3MfRPe6r3V0/8rahCzoY
	qDJeZ+8lHUi3gWIbbdybzQBtZ3MzuUEJW/XVjPBIPpCgTZ5FU9MLacZXYqOurxS4GR8pAVM9j7a
	JftH+bHR6QzBsjlndP5tZbO/WBXFCmX0wYo6OtYMrB
X-Gm-Gg: ASbGnctf8zRScwC7sZYsZrG504DCOgPiyR+MyiIJ5QM4iRVGoA0zhJAxDb3pYMk9vjD
	8aUSBX0y0jgDdw69b3hzftJ7kUWGmYs/4FLclmrL8AoWDxyChl0l4Yun7ZxmDSgvyKbg41t6Ofv
	qroQUfZ6jdeog=
X-Received: by 2002:a05:6902:2205:b0:e5b:32f5:e38b with SMTP id 3f1490d57ef6-e667b3dd988mr5498774276.23.1742425931741;
        Wed, 19 Mar 2025 16:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6FeV7+mWqOI/3/OyEWXgIzufD492CON6BYOPad5bM5/LtU2mCh4VKx46YcYVWPrbpTkPdRVob2IhGifFeY0=
X-Received: by 2002:a05:6902:2205:b0:e5b:32f5:e38b with SMTP id
 3f1490d57ef6-e667b3dd988mr5498751276.23.1742425931486; Wed, 19 Mar 2025
 16:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com>
In-Reply-To: <20250319230539.140869-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 19 Mar 2025 17:11:45 -0600
X-Gm-Features: AQ5f1JoUzsJo2CV6xpdFsEEpCBkHT07cu984t-d39OyyRxqZm4KEhHFzcrh-1EU
Message-ID: <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: rf@opensource.cirrus.com, broonie@kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: simont@opensource.cirrus.com, ckeepax@opensource.cirrus.com, 
	brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com, 
	johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:05=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling.

A further note here:

This test is failing and panicing across multiple arches, and
triggering kasan slats on debug kernels. I think this test needs more
testing ;P

>
> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file dow=
nload")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/firmware/cirrus/Kconfig              | 3 +--
>  tools/testing/kunit/configs/all_tests.config | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kc=
onfig
> index 0a883091259a..989568ab5712 100644
> --- a/drivers/firmware/cirrus/Kconfig
> +++ b/drivers/firmware/cirrus/Kconfig
> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
>
>  config FW_CS_DSP_KUNIT_TEST
>         tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TEST=
S
> -       depends on KUNIT && REGMAP
> +       depends on KUNIT && REGMAP && FW_CS_DSP
>         default KUNIT_ALL_TESTS
> -       select FW_CS_DSP
>         select FW_CS_DSP_KUNIT_TEST_UTILS
>         help
>           This builds KUnit tests for cs_dsp.
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index b0049be00c70..96c6b4aca87d 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -49,3 +49,5 @@ CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
>  CONFIG_SND_SOC=3Dy
>  CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> +
> +CONFIG_FW_CS_DSP=3Dy
> \ No newline at end of file
> --
> 2.48.1
>


