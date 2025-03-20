Return-Path: <linux-kselftest+bounces-29507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444FA6AC1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC87AD8BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38502253EC;
	Thu, 20 Mar 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy+OOc46"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C6224236
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492070; cv=none; b=sfli32mOfo3cU0bBzjOwemKzJtyfcFJexWpjQr+QJ5jG/PII4Bwf3QyzchK3f03/6QV7RdIK9nkihKofuTOSIh0LccgiTO0tfhZg0mzi3peBxKtbUOl3rMgG1kdSRYew3ZyjGKtZTi8x176YOg2welfMZVOXEJG0nhanwGXwsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492070; c=relaxed/simple;
	bh=ya3r5Y6SCRZPS6zantYDYhM3T+z2E2D+0eUveodGqwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaNJhpPswlCQc/NOcgY3taoWySIQvHhGHzHitgXSs77VCyvZIzB2XAc1wLa+GGHo9k7g6h4PvvpwoNGbQjEybv5mlx441gqjHcvH6fCi2zaueSszvtsWsaGCkxl0GjTvk02iaTRmENjMEw0TVYZCJ3BJJGVnJCXq5B61A2YCU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy+OOc46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742492066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYX2M6/2zKOpQJ6SwtSXKJMLCmPtRFZ3mltXSXoF2CU=;
	b=Xy+OOc46ISgrQjHOYtlRoX4IrLkoEREe50EJSftMiiv5oChMfW1ujj6R042Gz0JCjnMOWB
	NFSYrjgMDIYAXVOOvQVkoeQk4mYZxdEZX+MAUkNxf16P+nafa7MsBzj7d1g2a6ijX8CSDE
	8fzsEJ4ex9HECIyk+k4Br1sAGquNUPQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-nrrpx9WpPluP4lCNmVLIuA-1; Thu, 20 Mar 2025 13:34:25 -0400
X-MC-Unique: nrrpx9WpPluP4lCNmVLIuA-1
X-Mimecast-MFC-AGG-ID: nrrpx9WpPluP4lCNmVLIuA_1742492065
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e6372bafb96so1319363276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 10:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492064; x=1743096864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYX2M6/2zKOpQJ6SwtSXKJMLCmPtRFZ3mltXSXoF2CU=;
        b=kewHFWUGYf2NIGXQl97g6V6Tii3g/76xwIM6K/HktUtHe1AuEWfLzA3PWbYJzDZdXF
         06uAJTNzGoI1jdBVMaYfYt/3jGMODvj2nvh6EzRUXW0kyueUhuEG1185cseTwwm9JSpp
         BUOxmrqc9kDQoMqZwK2fU5MTpuyTOHZnIm0jm2EKa17iQFipwPbGQK4v3ddJ1VQAmF40
         DuZUS22lcClOTphBhSM016/TlgD4KzdYIH0jHOBqaHTmhzCQtvkHM7fS0aH5y5nvp6IA
         +kSJrhgmiBRrFO0FSTqPULvObIe+6Hv8ShS4E/DCIQKsDqjWDzq1vMWWnHJImJxqGJjD
         qbJg==
X-Forwarded-Encrypted: i=1; AJvYcCWzjjsyMqRh6K4VCP0CMFvWrSNKfhKYCHECWN9rk9dLwnAUdSLjuVXIHeBL1GSE8xwfsEL3OplrGvZA0olH5XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbyxa/TPu2iaY9155xtmS6tQZKwJKzxKn9+zUDBp/to6qdJiNH
	aYMki5oSFn3mAWeednvCzQOg1ygQtUq76hzUJBDW3cuqCjAVzrNrAyU/ElKCg1hZzhJP9Kgc1ev
	Xg0/gLYsgDi8y84OoGYPpbGWaEnR/A7kkOgk4YdF324RDHDY2c2juEBdPAu/OzQ6e9sldVcFJvS
	WukAKkkDnvIMn+4u3jLHadkyk7ygId3eLJ3RcQYjuy
X-Gm-Gg: ASbGnct4oOD91JimMAgSjZQjxpxAUz306VG6f6d1qj5SZ7hYlT4TqYAYVtMK7KTsF9j
	A40/nF8HA1oIoMideKX6bN3rrc2uXb8W0kuNRYwaCZaCwNtnatDBBNJ+SO27LevABw29iZlp3re
	jWKEFV9EE2ijU=
X-Received: by 2002:a05:6902:2004:b0:e64:4082:85fd with SMTP id 3f1490d57ef6-e6691fcbe0dmr5244697276.7.1742492063546;
        Thu, 20 Mar 2025 10:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1kwV9KUIkDrSfNgg0aIxmfOfiVAxVKdNTNJaQSadYwEDJirpIaPlQrsdWB2Zg0Z1ERJqJTCIhPZiXTCBsUzQ=
X-Received: by 2002:a05:6902:2004:b0:e64:4082:85fd with SMTP id
 3f1490d57ef6-e6691fcbe0dmr5244645276.7.1742492063069; Thu, 20 Mar 2025
 10:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
In-Reply-To: <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Mar 2025 11:33:54 -0600
X-Gm-Features: AQ5f1Jp06BXpfspSGNPLI-SadeSrcVhX--job0ADTdJn-pHdUw3d6mGqkxkKb3A
Message-ID: <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:21=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 19/3/25 23:11, Nico Pache wrote:
> > On Wed, Mar 19, 2025 at 5:05=E2=80=AFPM Nico Pache <npache@redhat.com> =
wrote:
> >>
> >> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> >> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to t=
he
> >> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling.
> >
> > A further note here:
> >
> > This test is failing and panicing across multiple arches, and
> > triggering kasan slats on debug kernels. I think this test needs more
> > testing ;P
> >
>
> Please supply details of failures or links to bug reports.
> "is failing" and "panicing" doesn't tell me enough to fix anything.
> Failing how? Panicking how? On what architectures?
> I tested it on the architectures I have available, and the kunit um
> architecture. Unfortunately not everyone has hardware for every
> architecture supported by Linux so we have to trust somewhat that
> other architectures don't do anything unexpectedly different from
> what we _can_ test it on.

Some of the runs return not ok on a bunch of tests, debug kernels
print splats, and some seem to brick the system, leading to a reboot.
Below are all the failures per arch/variant.

Failing on
---------------------
X86_64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-ar=
tifacts/1723153780/test_x86_64/9451298630/artifacts/run.done.01/job.01/reci=
pes/18353773/tasks/7/results/1742341634/logs/resultoutputfile.log
X86_64 (debug) :
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_x86_64/9419724200/artifacts/run.done.01/results_0001/console=
.log

aarch64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-a=
rtifacts/1723153780/test_aarch64/9451298664/artifacts/run.done.01/job.01/re=
cipes/18352965/tasks/7/results/1742330044/logs/resultoutputfile.log
aarch64(debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_aarch64/9419724214/artifacts/run.done.01/results_0001/consol=
e.log
aarch64-64kpagesize:
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
723154540/test_aarch64/9451303359/artifacts/run.done.01/job.01/recipes/1835=
2963/tasks/7/results/1742331192/logs/resultoutputfile.log
aarch64-64kpagesize (debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
723154644/test_aarch64/9451304808/artifacts/run.done.01/job.01/recipes/1835=
4911/tasks/6/results/1742356729/logs/resultoutputfile.log

ppc64le: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-ar=
tifacts/1723153780/test_ppc64le/9451298644/artifacts/run.done.01/results_00=
01/console.log
ppc64le(debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_ppc64le/9419724210/artifacts/run.done.01/results_0001/consol=
e.log

>
> Also, are any of these failures the unterminated string bug that someone
> fixed recently?
Not sure. That fix doesn't seem to have been merged yet.
>
> >>
> >> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file =
download")
> >> Signed-off-by: Nico Pache <npache@redhat.com>
> >> ---
> >>   drivers/firmware/cirrus/Kconfig              | 3 +--
> >>   tools/testing/kunit/configs/all_tests.config | 2 ++
> >>   2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus=
/Kconfig
> >> index 0a883091259a..989568ab5712 100644
> >> --- a/drivers/firmware/cirrus/Kconfig
> >> +++ b/drivers/firmware/cirrus/Kconfig
> >> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
> >>
> >>   config FW_CS_DSP_KUNIT_TEST
> >>          tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_=
TESTS
> >> -       depends on KUNIT && REGMAP
> >> +       depends on KUNIT && REGMAP && FW_CS_DSP
> >>          default KUNIT_ALL_TESTS
> >> -       select FW_CS_DSP
> >>          select FW_CS_DSP_KUNIT_TEST_UTILS
> >>          help
> >>            This builds KUnit tests for cs_dsp.
> >> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/test=
ing/kunit/configs/all_tests.config
> >> index b0049be00c70..96c6b4aca87d 100644
> >> --- a/tools/testing/kunit/configs/all_tests.config
> >> +++ b/tools/testing/kunit/configs/all_tests.config
> >> @@ -49,3 +49,5 @@ CONFIG_SOUND=3Dy
> >>   CONFIG_SND=3Dy
> >>   CONFIG_SND_SOC=3Dy
> >>   CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> >> +
> >> +CONFIG_FW_CS_DSP=3Dy
> >> \ No newline at end of file
> >> --
> >> 2.48.1
> >>
> >
>


