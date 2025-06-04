Return-Path: <linux-kselftest+bounces-34291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FDACD9EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A881F172DE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47918248868;
	Wed,  4 Jun 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR9tZW67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9968410E9
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026057; cv=none; b=qUTkzKgs7knutuX1phSC1Mphtz7DnWQPX3PekJNk/ruyfWpItkWajNYGaXPXwPnS1VTbELQUe+ThftVVkNXk1g8CkAyUSq8HaHpPWWEULpaZDrRT1f6RvfnAsBka25Y1vEdPnvRNlClThQs2lDQh8H7BWIyGY33QivX2RMWYdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026057; c=relaxed/simple;
	bh=oIRXxYpaCE7P1jXJfM1KOU/ukUCp6xeSehnHV/gu2PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr75NtIqJxEycAPha/AZNEG1AIhOgsp5V/AUUq6jjjcBR8Rehmdhn2aeagbT7IoDL8HkRmPsPUvsF6ak+1dy7aQeRbJ+ITY/1olG4VwSiaB5veJHnKiz+5Wrqi5UGC5sxrbwe/lgP/MIulAZhEzPMR3D+UXNDHcc6ER9DTDwKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DR9tZW67; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710bbd7a9e2so25704347b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749026054; x=1749630854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIRXxYpaCE7P1jXJfM1KOU/ukUCp6xeSehnHV/gu2PY=;
        b=DR9tZW67GrnfddsR2iQhT3KM5xtXRrndODiWvxGgPodgfcPLV+zt0tu+HNPzOPKsxf
         fPEg7E+rbrrnr5/2x00+CemiTSfkhFQHkBw2eqLuylNCPOo7mkNxSQbPHRQyeJAagMLN
         R81NPeq96OZzESD18wBPRm3robMDmPJTSCMdDwrGqwwHC3iri7NjppnGeccMoxbsyaW3
         P2hN83HLGgygGLTea/aYuTUBUKYkDge/piLqDxgn6bfoZ7aJY0g/QZKAcwm2awch8w14
         gT3rb9nrMjmd7yoSfnxemnuxYk3/hrShWKePfbmQX8FiDbBtSXJyy9fFUZamcvgUI5C7
         WM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749026054; x=1749630854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIRXxYpaCE7P1jXJfM1KOU/ukUCp6xeSehnHV/gu2PY=;
        b=wQIwgODe38n+mH79V2ZPZ04X/e6IsDF26dVmE8SawaHw8U1+wpanqeU/DACNbvCTjz
         lvy4KLWzar8oDXDMV46gf5zztK26SkkmmH/6yKf2J0G/feK38PEXj/GKfmF2ms5Do6pm
         5nv+2gEp4Cr5ikTJzrAaWIGSjW5DHQpx+SV9hZoBDv0Lo+akHZCjwgzfagmfMnPZdgWN
         nmoIs3XyxEQEj2sSk/XF+t2l0dkb18syMdFC3aLNla99j6pBciIg09tBHHFdaHtoSMaK
         A5OpLKOIyB/VIatK3N4YHV+hiCS7EWoy4NKtCBRwwFJJl/bUh/ssELwC7xKT8CoktET0
         W5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBBNUJKWywpkOe8QnC/Xjbgz/iNsVXANpwoJdoMsthRnNam9X5Eu/00L1gcG0uU2zQADlTuF0fx4S7NnykQZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01lvyyxC1SeUDFt3RE0qUfyRvHLa9dcyMrb5d/q6j+F+uEn88
	0LzzwM3SQbgAMgLk8UIehb4wGQkp66PtukGHgp0Ge78KlVA1w0KvlLKpkvcGNuqtt0PCRrMvFSu
	EK8xjLDyXX9vr5mbfuLO/UoJGeO7tPLdF8s3bLPOa3w==
X-Gm-Gg: ASbGncsEiuhkj6xmHv/ZyHIJAjBGTi/zYiKbaUAuvJ3XefDpZQ6xfgl61aEx2vugSgF
	IgUfDeeuqkYYncKj9cHlObbfjfFd9qnf5sah3OddFanVOkBW8c2YzW5p30f5W9OOVO+sqbXMSuN
	iGoQrhAZA5fpxPitKI7zSe22lah8AD1Oir
X-Google-Smtp-Source: AGHT+IFdMlKQEHFB9rAIPubm+oWCxtLQaBriPs9FGR9ZFu04+vMyrF1AGrH76Qny9PZkqn4FiSFsMO29KEcocYymM64=
X-Received: by 2002:a05:690c:6e01:b0:70e:29d2:fb7b with SMTP id
 00721157ae682-710d9dba8e0mr22420457b3.33.1749026054535; Wed, 04 Jun 2025
 01:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603201036.44504-1-terry.tritton@linaro.org> <CANDhNCoiKjPOyGwiu5Apg2y4LduPTRQvEjG7snmbzrenZojAKg@mail.gmail.com>
In-Reply-To: <CANDhNCoiKjPOyGwiu5Apg2y4LduPTRQvEjG7snmbzrenZojAKg@mail.gmail.com>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Wed, 4 Jun 2025 09:34:03 +0100
X-Gm-Features: AX0GCFvGl7sGmmJPlA-wX27a4YxRu7KVpfougQMpQZxrLZQMi9H8NHMyKYJfLQs
Message-ID: <CABeuJB3vDEaaPuCK_n1JZ_0j2wgcpe9j01yLkEpkt6hsMLSB_A@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Fix integer overlow errors on 32 bit systems
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	ttritton@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So this seems to be undoing commit 80fa614e2fbc ("selftests: timers:
> Remove local NSEC_PER_SEC and USEC_PER_SEC defines")
Thanks John, I somehow missed 80fa614e2fbc and was wondering how
this had got in.

> Would it make more sense to fix the NSEC_PER_SEC definition in time64.h to a LL?
I was just thinking the same this morning but wasn't sure if this would cause
issues anywhere else.

I'll send a patch to change NSEC_PER_SEC in time64.h as its a lot cleaner
that way.

Thanks
Terry

