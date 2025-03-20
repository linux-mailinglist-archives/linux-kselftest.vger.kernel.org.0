Return-Path: <linux-kselftest+bounces-29508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B02A6AC22
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3133F3BBB8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C822577C;
	Thu, 20 Mar 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3mnqiLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA202253A4
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492190; cv=none; b=H3Elaowlr5snbCaRKc/LLwu50hx+oKw4iMBpn75OQ1NRR8PBF065eaKAGapO2mJi3g4gwsyL2/xf4n5RL4iyVd9YQtfd13Bk0GMCGR4jFDV3AQA0L2jj/kP5narzxAvgvh+yHEGuzuTeovPAmjMi0SN8P8vLI+LCOSc613nAAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492190; c=relaxed/simple;
	bh=BsxCuARzgsXF0fZ/cJynLwC1BadWBfylj8v4JP89yYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZCUF3h1WYf3eXJg7hCW7WchtXLpbOtuu0BdSqeJSsBKnturC/M6vHIS9SecRd5fTCDLjinVd5nRvJuZF11cSCSVZ+zt8A2nybd9BXsJJ4O+EN744SSxeuuazlgE7vg3ismkw97oOZrZ6hvdvMW4lWVzqnJuQOBkTPAR2OjjL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3mnqiLF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742492187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS+4w9CAl2tIEOQMQq3dJT2Sg4uIiNyRqIfuwfurzGo=;
	b=K3mnqiLFlGcwKe4DcRg3xm8PVWwvBvloGLAi2YeZUVgZR3WrIMSJT8jUrzwhCcFrbn51hy
	iA14PeduQua5PFSJOPkCBZ0pc+ux0oxJGlheTdcttbGyJsJFGXUPQ0+xeMTIlqXfAwWUc7
	pFYM17dzWFa0rgBC2FuSV77OgGY+Q4I=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-6FMSLGEHMCeTY2B3rj_yBg-1; Thu, 20 Mar 2025 13:36:25 -0400
X-MC-Unique: 6FMSLGEHMCeTY2B3rj_yBg-1
X-Mimecast-MFC-AGG-ID: 6FMSLGEHMCeTY2B3rj_yBg_1742492185
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e572df6db3eso1361487276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 10:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492183; x=1743096983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS+4w9CAl2tIEOQMQq3dJT2Sg4uIiNyRqIfuwfurzGo=;
        b=jBVQDoGCpKFmQKt1y3O4w9aM/n7Mi1kxoji2W+tIjSj6Vv4zVHjJjnirUwrdzOlxe0
         DDtw89mefMgCEnHsmxT/RmlezbQEEBZv2PE1xVXoDuaML5JhQV7j7ah7Yhr71gMYuu2H
         badegah6h5jtUpTbSHN8SQjaP+cJjiW+0ShZ1ixsK73FnxPGIVcXyMbaP5RhqZ+SMwXS
         DgZnS1MNQKZZ7WhCw8vgy6Q5kdKsAc1YAREm+f2xdJxHWlnhTmshLTxD3jnAKA386mvg
         LeRh6+nifGCYRfrUfcSs6IOIwvHqyT1MZYQBzsl/KiCk43wHhuDvqvoWFa2t//JN2fvp
         I6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCyE1XJFl1xi+F51gveyOfbG0nRpwCoeTyQur/C6VyQoCMi5TCvQGOPG3cGp+ShRPWBscss6UeuhA0VhuWtis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9D9+6cjnLPayBklpqS2BhHImBfeUHg5PtXBwKs8l+Mlm3FHx
	/V4mruWMg7wK/Xqvpz9u3r62YNz9AMXZDPlPyllMmfuhhn18OQovNNajZ0zzPx7WaeZ0SoOeolZ
	qMHtybrOPOhS/cS5QYhjo5E8xdciAdcPqHzuENtRXTTYJ7l3nm2H53FLGwXDdjJZG6pLZa2FpAn
	vgsNitdc5wYwMGPqIQ6WXYWSs2Q1t5LNAVxkKBm5JV
X-Gm-Gg: ASbGncty/VO91i2oOLkiwQ653dTFsNEWGqHZEL2PD/f/ogUV5CNb335heESv7fs08mE
	BlJ/hguCuFKloWC46+rvgSauACv43RKf8Vjo3yjGOJsgDLqgCjwjw2FiR37OO2ytLdKJ9d+iMQa
	yYYU9xwNmh6qI=
X-Received: by 2002:a05:6902:1202:b0:e61:1c56:d65e with SMTP id 3f1490d57ef6-e667b440ef8mr10265016276.39.1742492182682;
        Thu, 20 Mar 2025 10:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4DsqqSKudGoKHtTUn4Fmd3OoauVYJ8GzOdn97tjiAKk4pZ909yot7m2DdxBTPxvcnexGeBhyy56vFTgpGLlY=
X-Received: by 2002:a05:6902:1202:b0:e61:1c56:d65e with SMTP id
 3f1490d57ef6-e667b440ef8mr10264952276.39.1742492182191; Thu, 20 Mar 2025
 10:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com> <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
In-Reply-To: <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Mar 2025 11:35:55 -0600
X-Gm-Features: AQ5f1Jp6vn-oRetNEyCNIJpnAAyYyOS_O9jU7OObd_b5NCpGJ35-7np594Rfj8o
Message-ID: <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry links got mangled

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

On Thu, Mar 20, 2025 at 11:33=E2=80=AFAM Nico Pache <npache@redhat.com> wro=
te:
>
> On Thu, Mar 20, 2025 at 6:21=E2=80=AFAM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> >
> > On 19/3/25 23:11, Nico Pache wrote:
> > > On Wed, Mar 19, 2025 at 5:05=E2=80=AFPM Nico Pache <npache@redhat.com=
> wrote:
> > >>
> > >> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> > >> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to=
 the
> > >> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling=
.
> > >
> > > A further note here:
> > >
> > > This test is failing and panicing across multiple arches, and
> > > triggering kasan slats on debug kernels. I think this test needs more
> > > testing ;P
> > >
> >
> > Please supply details of failures or links to bug reports.
> > "is failing" and "panicing" doesn't tell me enough to fix anything.
> > Failing how? Panicking how? On what architectures?
> > I tested it on the architectures I have available, and the kunit um
> > architecture. Unfortunately not everyone has hardware for every
> > architecture supported by Linux so we have to trust somewhat that
> > other architectures don't do anything unexpectedly different from
> > what we _can_ test it on.
>
> Some of the runs return not ok on a bunch of tests, debug kernels
> print splats, and some seem to brick the system, leading to a reboot.
> Below are all the failures per arch/variant.
>
> Failing on
> ---------------------
> X86_64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-=
artifacts/1723153780/test_x86_64/9451298630/artifacts/run.done.01/job.01/re=
cipes/18353773/tasks/7/results/1742341634/logs/resultoutputfile.log
> X86_64 (debug) :
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_x86_64/9419724200/artifacts/run.done.01/results_0001/conso=
le.log
>
> aarch64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted=
-artifacts/1723153780/test_aarch64/9451298664/artifacts/run.done.01/job.01/=
recipes/18352965/tasks/7/results/1742330044/logs/resultoutputfile.log
> aarch64(debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_aarch64/9419724214/artifacts/run.done.01/results_0001/cons=
ole.log
> aarch64-64kpagesize:
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1723154540/test_aarch64/9451303359/artifacts/run.done.01/job.01/recipes/18=
352963/tasks/7/results/1742331192/logs/resultoutputfile.log
> aarch64-64kpagesize (debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1723154644/test_aarch64/9451304808/artifacts/run.done.01/job.01/recipes/18=
354911/tasks/6/results/1742356729/logs/resultoutputfile.log
>
> ppc64le: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-=
artifacts/1723153780/test_ppc64le/9451298644/artifacts/run.done.01/results_=
0001/console.log
> ppc64le(debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_ppc64le/9419724210/artifacts/run.done.01/results_0001/cons=
ole.log
>
> >
> > Also, are any of these failures the unterminated string bug that someon=
e
> > fixed recently?
> Not sure. That fix doesn't seem to have been merged yet.
> >
> > >>
> > >> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin fil=
e download")
> > >> Signed-off-by: Nico Pache <npache@redhat.com>
> > >> ---
> > >>   drivers/firmware/cirrus/Kconfig              | 3 +--
> > >>   tools/testing/kunit/configs/all_tests.config | 2 ++
> > >>   2 files changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirr=
us/Kconfig
> > >> index 0a883091259a..989568ab5712 100644
> > >> --- a/drivers/firmware/cirrus/Kconfig
> > >> +++ b/drivers/firmware/cirrus/Kconfig
> > >> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
> > >>
> > >>   config FW_CS_DSP_KUNIT_TEST
> > >>          tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_AL=
L_TESTS
> > >> -       depends on KUNIT && REGMAP
> > >> +       depends on KUNIT && REGMAP && FW_CS_DSP
> > >>          default KUNIT_ALL_TESTS
> > >> -       select FW_CS_DSP
> > >>          select FW_CS_DSP_KUNIT_TEST_UTILS
> > >>          help
> > >>            This builds KUnit tests for cs_dsp.
> > >> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/te=
sting/kunit/configs/all_tests.config
> > >> index b0049be00c70..96c6b4aca87d 100644
> > >> --- a/tools/testing/kunit/configs/all_tests.config
> > >> +++ b/tools/testing/kunit/configs/all_tests.config
> > >> @@ -49,3 +49,5 @@ CONFIG_SOUND=3Dy
> > >>   CONFIG_SND=3Dy
> > >>   CONFIG_SND_SOC=3Dy
> > >>   CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> > >> +
> > >> +CONFIG_FW_CS_DSP=3Dy
> > >> \ No newline at end of file
> > >> --
> > >> 2.48.1
> > >>
> > >
> >


