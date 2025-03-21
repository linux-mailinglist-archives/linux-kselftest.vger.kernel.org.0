Return-Path: <linux-kselftest+bounces-29565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145EA6BDE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DD97A2CBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF21553AA;
	Fri, 21 Mar 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdMIoKVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0942A94
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569328; cv=none; b=FXskB6H/EfA89DzGDqorxzSnK7yci35zVra3bx0cNnsfObD4plRSdqWHOQ9LfDTdPfCe0FlU92xhC9VGeJXBpUPnyHq8w+zYA1XMtDr9p4J1k6dASOFHm6nA0ISwqOeVnX50uDcHyDGJHj+Jdoz9M3d51nSUODEGkQKxL/iR3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569328; c=relaxed/simple;
	bh=83Q0Qw7I4VIoIyFtcO3ONAKW+0v0w2T3F/DO/HaBXck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeCzosXV2OthxehYyOfC7pGPTR9EQFAUNM4PTgiQ7gglCe2XtM+AO8qpG2c7Imm9NqzPfOkaFKzEKQDwYpieFrgz481s2ZP04Gz4CSV2k/ygsdXULTK5KtMqX+OH6MmZeYGUH1pEkqo4Wz+ltyQB26nnxZc3+DONPbrWwIOdWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdMIoKVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742569325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXDokhrAaPf86QJp4iWqtWLlS2xj4t/tKQqX3klhNZk=;
	b=KdMIoKVOFgPIslUFFIYxuuAo1HcZvAp+LMY4jiZGr4yPbkNXPN59SKywFslU+oi0jCuUkY
	5Va8nKupnAGRGId7YxuWXBcDPcUbC1eRboSU/LzQadfkyBGMrK3pgu2xygeWFH3kg7s2rY
	xDiWJFwwU3TcQ5cRm2ZL+EtLElsR7Ic=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-ZdGCKcU3NEudBPGQRl1a_g-1; Fri, 21 Mar 2025 11:02:04 -0400
X-MC-Unique: ZdGCKcU3NEudBPGQRl1a_g-1
X-Mimecast-MFC-AGG-ID: ZdGCKcU3NEudBPGQRl1a_g_1742569324
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-724d17262dfso565428a34.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742569323; x=1743174123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXDokhrAaPf86QJp4iWqtWLlS2xj4t/tKQqX3klhNZk=;
        b=J+khIHkOplAgCMFerDUJ8aVHXVMO1ZfbSd4TdFevQScvgzhjDjCxabdH5LUHhOthJS
         /MDbvOAF9f+/SPtnKiJePPzqMoMGTGj05VLxGPlW2P+ZAsbcHK0Fxx2uPWor9RObLhZn
         xFZ5ZZRURC2lGrtC+zZlHS7ZOsdWJyFywPfLgUyqqDmtoiJJAPeGe0j+T/ni068aZroD
         if6C9zjgj5zVWPUuFoBDcxhsmwH+AxLrnXrVQUPsP0GTNBspiGR6XwoDIexaxF3kNxuE
         jCqR7ib5Me7WndRKTVN0b8cjYAR6pUPxZRnXtrMIgLcXVSui5xCLTecZZdrVnVEYvK/C
         FS6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFz4+/H+nXZpfPaimHpCPBEFixD+JbSW9TSZT3QaeQrJCsy0QP4dpGMfqSHFBfp78uz9rRpVzHIeEVP66WwYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EEqzLj8+J/2TCPABFGHhS17qETU8CzO4ACESzEqPwci2jOLC
	m+ocvQ77ePh7+dygn8tLBgHrmQCfD4140OiBVwDC/CApHkIPgr5hV9LOiOCzZjtG8oRyPB6ChZt
	YZvCiDCtlbwHgHfC6RdRziZ7zRbR585gmMNm1xvuxrsks9Cz7IxpLlZ86qJ10lDieo/1PGmV3p7
	qp5gEGOy4GXyT84z4Xwl95oP06ASh0m76rpYhqdgG8
X-Gm-Gg: ASbGncuvQ0Y9JFC9P7dKwITX2YRYnPAm990kdlg/TjQDdyecZP57wmVvCrAQNccUjWD
	ENTYGTTOPEANdnxxJcWohbmsZAYA6R/T5F8RTmKeBokF2nfONqNXflkSPwYBTxfZqVXUKR0ut6z
	4AcrtdPqXgBdg=
X-Received: by 2002:a05:6830:44a5:b0:72b:a9f0:50 with SMTP id 46e09a7af769-72c0ae46583mr2281091a34.6.1742569323123;
        Fri, 21 Mar 2025 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzpcflRd3grvgJw7oYf7w7riEHFM2LiOJmYWlN+Yk2EYNXdODRH99L7hJO0uAsI/7DXMs7laRP2j8+TeIOHbo=
X-Received: by 2002:a05:6830:44a5:b0:72b:a9f0:50 with SMTP id
 46e09a7af769-72c0ae46583mr2281033a34.6.1742569322660; Fri, 21 Mar 2025
 08:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk> <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
 <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
In-Reply-To: <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
From: Nico Pache <npache@redhat.com>
Date: Fri, 21 Mar 2025 09:01:35 -0600
X-Gm-Features: AQ5f1JpT3vyW0yGQ55DsCJSyymwDfJyOoIrPkZeKHZVfnPxN0vElQflPBO1DXGw
Message-ID: <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Mark Brown <broonie@kernel.org>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Mar 21, 2025 at 05:37:50AM -0600, Nico Pache wrote:
> > On Thu, Mar 20, 2025 at 4:49=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Simply adding it to the all_tests.config will just result in it getti=
ng
> > > turned off by Kconfig during the build since it's not a visible optio=
n
> > > so that's not accomplishing anything.  all_tests.config is not UML
> > > specific, it's for enabling all the KUnit tests that could run in UML=
 no
> > > matter how you're running them.
>
> > So would the correct approach be allowing users to select FW_CS_DSP,
> > then apply these changes?
>
> That user select should only be visible if KUnit is enabled though,
> it really is library code so shouldn't actually be user selectable.  I'm
> not sure if there's some other strategy other KUnit tests for libraries
> use.
I'm a little confused how the FW_CS_DSP config which was added in
v5.16 is reliant (library code that is only used by KUNIT) on a config
that was added in v6.14. Presumably the library is not just for the
KUNIT test. What was the purpose of this config before the
introduction of the KUNIT test. Im guessing it was not user selectable
back then too.

>
> > It also looks like FW_CS_DSP_KUNIT_TEST_UTILS and FW_CS_DSP_KUNIT_TEST
> > are redundant.
>
> Possibly there's more tests to come that'll use them?


