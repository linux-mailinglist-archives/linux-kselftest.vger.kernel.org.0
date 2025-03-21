Return-Path: <linux-kselftest+bounces-29552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78423A6B9FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CA01688B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029F224AFE;
	Fri, 21 Mar 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyix/Twz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005E22371B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557101; cv=none; b=aGVYgwlLae4cQx+s6nQgMo6QyzSoIy/EvCiFmmTlOFyy2O8N/axhoxmDNsiWpQB+afbCiwEzye32X9Aocs5RK8H9Kekz/8E2skiu64PEO6xi6f7Pygyzmc4fbSFdYF8E/44H7CAmeEHD98E8GpcMYPoXlxHwpM9PO5e0/xyi+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557101; c=relaxed/simple;
	bh=7RyCmasSsEfxACG5VwHAY4+UkBtXil0L7+AhGUqIQPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6dbtyUAaN/zm+1Mq5/DY30/YEWxAOQh9Ng13Bd1+82f4FM6EJXSdePeBycNjCJ8fv3BcWcdvaLU2Ie74fWwFdX9r2mPloJ3uF5mH20P/N8HbAPnmoGH+4kngjzrOyPzM62xOCVG4l0FsOkoa+/6Jo3LxM8LzjMDIPGQ7zTreNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zyix/Twz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt+BFS9gqKRMofPgohFZmNx1aIY6jgeF2NC1PQqZP6c=;
	b=Zyix/Twzc0fbVG8+qqtXaEMV3LGBtQjH5OysR9SMhwgApPUxLSltEZ/hmAzJshxsGpuxAM
	s5K1+xj0cznppAjGpqEixwhI+kXcTFYHS3XldxCOb5mkBERtWJAzMRaWGvFvvZSI8JbUEs
	KubTdA09S3udAxJjKY6GdxTABfsyRS0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-sNyaWRl5PAuu4seZP9C0MA-1; Fri, 21 Mar 2025 07:38:17 -0400
X-MC-Unique: sNyaWRl5PAuu4seZP9C0MA-1
X-Mimecast-MFC-AGG-ID: sNyaWRl5PAuu4seZP9C0MA_1742557097
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5798866415so2863937276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 04:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557097; x=1743161897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt+BFS9gqKRMofPgohFZmNx1aIY6jgeF2NC1PQqZP6c=;
        b=pQ666d7yRoiWv8IhBd11m1nyxJUToo83qdpANXH8esWwfWQGalmWAIdB+tO+BZcMWX
         yHNC29LmRw0oTaQU8HRrjirobVMHgHnYqOuIjQNxQLA1zrhrizzcSvv8NN6f3SRQFISa
         4mng01V+/WLTJLF7e4v8VSq/dKCD4Gl9k/99f7f/jplydjdtGrhmwsc/LfjfLZWgCufC
         ImXlNsCTYUBVjnGgmAJAhHA2p69dAKz0O+1zP9b4VWzJcpwYXsPUxCRRdNaTVILm0IQa
         ztk3igVXHiNKBLAeN5/NmFGlJb0GwGjOhmsCNwvYIcOPeeSZDR1wws+dZTWr0arxH6o4
         F3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWObSSMoHuWtLFYy0GK2SBhieNVkLU+S80xLp2EGZ+/KbRJEg1PNNzcUZ07EGacHPbRW9raEnrndhxyj4dHjTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLtEgyqhup9St3ofjHHwqpPH1GMNG79UwfuwsPLuKYPg8+hbi
	wP7JePiV+g1AUUKoPHQuCETUfY1khE4JQF+qKex759mzOQIGYjUFYzgVTk5IMtayrqPeJyjaxbw
	CssTNR+Ue+qkH9mMYhcxITxmlRwOrIZRDoShKE1+t8vBwUio9srEeoqsaFcpwLg6HwqjxAV/6hi
	LQborEs7nTB2Sseo/q/WdHb/Bg3qqckf5JMQ+lJXhv
X-Gm-Gg: ASbGncvS45nW1B471K82cPg03pdhOlTKoAWFtuzGkSk+vtET60kmDhSNza655gQWkq2
	kGqL/uHUcyS9JxcNxtontpERYE2OvkNcG6oKe/eNALXYScWqDolhorRAqROBfDW8gQBS1WUEL9z
	rfW9M2+nx0zqQ=
X-Received: by 2002:a05:6902:2013:b0:e3c:9fb5:837a with SMTP id 3f1490d57ef6-e66a4fcae48mr3166474276.41.1742557097029;
        Fri, 21 Mar 2025 04:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG6ZiAbkH7cFfSc8gVNrbKtRo6NKlFgdvH5Ol4kuCTC3rTj0valzGa4Wsrdj/QIGQSqGGUHuir5bsGwTvBtKM=
X-Received: by 2002:a05:6902:2013:b0:e3c:9fb5:837a with SMTP id
 3f1490d57ef6-e66a4fcae48mr3166428276.41.1742557096515; Fri, 21 Mar 2025
 04:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com> <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
In-Reply-To: <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
From: Nico Pache <npache@redhat.com>
Date: Fri, 21 Mar 2025 05:37:50 -0600
X-Gm-Features: AQ5f1JpD38GF9Tuch-Icv4bAHf1Dxvy4GK2x83iHqPk_98ExGn4SB-B1ZnKh-SU
Message-ID: <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Mark Brown <broonie@kernel.org>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:49=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Mar 20, 2025 at 04:21:16PM -0600, Nico Pache wrote:
> > On Thu, Mar 20, 2025 at 1:14=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Wed, Mar 19, 2025 at 05:05:39PM -0600, Nico Pache wrote:
>
> > > >  config FW_CS_DSP_KUNIT_TEST
> > > >       tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_=
TESTS
> > > > -     depends on KUNIT && REGMAP
> > > > +     depends on KUNIT && REGMAP && FW_CS_DSP
> > > >       default KUNIT_ALL_TESTS
> > > > -     select FW_CS_DSP
>
> > > This makes no sense to me, the select statement is forcing on the cod=
e
> > > it's testing which is a library and so is selected by it's users, thi=
s
>
> > Similarly to eb5c79828cfa ("firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST
> > should not select REGMAP"), We shouldnt force a feature on when using
> > KUNIT_ALL_TESTS.
>
> This feature is not user selectable, at an absolute minimum you would
> need to make the library available in KUnit test builds.
>
> > > change will just stop the tests being run unless someone does the dan=
ce
> > > to enable a driver which relies on the library.  That is something th=
at
>
> > My config also sets the UML wrapper to enable this FW_CS_DSP config so
> > it will continue to work in that environment.
>
> Simply adding it to the all_tests.config will just result in it getting
> turned off by Kconfig during the build since it's not a visible option
> so that's not accomplishing anything.  all_tests.config is not UML
> specific, it's for enabling all the KUnit tests that could run in UML no
> matter how you're running them.
>
> > > seems unlikely to change the outcome of the tests when run from KUnit
> > > which is independent of any hardware.
>
> > KUNIT is supported outside the UML environment, and some distros (like
> > fedora, and downstream flavors), use KUNIT as modules, with
> > KUNIT_ALL_TESTS=3Dm. We only want the tests that are supported by our
> > config to be available, we dont want KUNIT going and enabling other
> > features so the test works.
>
> The point is not that KUnit is frequently run in UML (personally I
> mostly run it with emulated hardware instead) but rather that this is a
> library which can be tested independently of having a relevant DSP.

Ok, thank you for the carifying message!

So would the correct approach be allowing users to select FW_CS_DSP,
then apply these changes?

It also looks like FW_CS_DSP_KUNIT_TEST_UTILS and FW_CS_DSP_KUNIT_TEST
are redundant.


