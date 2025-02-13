Return-Path: <linux-kselftest+bounces-26558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8513EA34866
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C859016B7B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6613194AD5;
	Thu, 13 Feb 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlpsxLIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252244C7C;
	Thu, 13 Feb 2025 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461384; cv=none; b=NG0gcgeLZ/MTmYNNDapcJ3BC4rs9Az7gnLTNXDBmbmegTwLEl3SwzgSPyUBw6j4Mue8M082j9EMeIdviaKn9xF+C8NozsPGtiWMDIabfpRBJzCGtAJZegijSnoNSMC/W22bed5Tt+cQkKjMj5kLkVQv9k7Xcx44h6wbLEoyjD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461384; c=relaxed/simple;
	bh=icdXS8p68rQCTSX1pWN2XJTVSdUQQv7nxWrTiZumR+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEFczMHcE2SvWd8XM00iwwC1pVrE+LX/FYWKYb19toLd/mvcD6G3ujookLX2jWL83ZmmWbCmFReJuVHc4KQ1t+1dbfAMN2PRWGn/v1zPHS5kiJfD/sv6l+Jcyx0GA5rlOjv/MmBFpJ+nOcNhlG0KZ6FWaUCpeMs300mhv6KIDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlpsxLIr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308e92c3779so22416831fa.0;
        Thu, 13 Feb 2025 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739461381; x=1740066181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icdXS8p68rQCTSX1pWN2XJTVSdUQQv7nxWrTiZumR+I=;
        b=TlpsxLIrrgBESXlf9I/9quwZWdX1v8juRima9tktAFQ41xaGjBvWF1oiENGm4lvAuJ
         kak/RU2cab/nw6y9SLrepFMsPB9oLg/TOCWTzn6DfcuNKeC4UNT05hxWJRt6wgnQs12V
         ilf+HTCeSDVMphqSSJKAkqWbkIZpKOSoEnkTyGutd0SI/e79bMAsiEnhJtAlDm11OISn
         E5fY4UHmhEK8Azwud+NkYOvO/V6l8VqcrOdt+NXcVppu4ttXvHOrs4DIhMUhRdlGSZRO
         UtF9FguirYu6QgUn+NAsbO9wNHA5SuBCZnfQOE+HF3487KpOrM4qwRr4mEibWaORZ/CB
         vkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461381; x=1740066181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icdXS8p68rQCTSX1pWN2XJTVSdUQQv7nxWrTiZumR+I=;
        b=aMe568B/Zhz9KCo1KCFRmUqWRISpFc78YkhjguSHzP2F1vfWSSeSiu4FMM2plsGX22
         Id8YGyZg15fqFbP7C74lOAbda3LYeF85y24ZZtM+qh1lQTHwCxy25I2J7o1c5HcjnDbd
         3dCl0XlRGBboYaLrKsocLu7aCn59tFgrdnrvXssSxAcDWbWd4cMHvs+UjOmfs9C3KYpE
         9lGKbyl4aYOmw9t9v+OgSTKh0ME9VA7IYkRz7CigMM6iwu/cWBobhUyypsBFN4nwDi8c
         ExH6zIZpaG/wAOYCwBwtsWPJ3r9X0Aj8v2ZrbDybF3KRlBV/eWmhFKKLgYgchZEqDaXT
         M1uw==
X-Forwarded-Encrypted: i=1; AJvYcCVUyGJBpnS3cyErYnnnm/A6mdGX9M6buQBo8nn52uNYS/3ZP1neNHyjhjljIGUHkItf664gGU78DFT8YRDjza0O@vger.kernel.org, AJvYcCW2OnojACqhIibj7G9ZKdktt3X+ymwMIXrLM8KIYQkiHkKQYmemY3QccHaCrvui+5M2LwsQ1fCMv1wqev0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYHNdPV2uuD0QpeWZ9prUlZQdhqSfbACQHSx6xF1XagP6suZX
	jSIo2JQQCFc+4nlRqIZeILVZW6UCG3gGHeQVtBHkng4HNfU1gg+pDuxr2oO2QJYwp1wX2MF+67T
	jEfQq5ZI1Hy6VRetCOWBy8oDmSz4=
X-Gm-Gg: ASbGncvn7Qrm3IZFVdSFn1rPKqDH5vrteQBzVzc4eYJyCG5AkH6oLgWfR2RKp2ac7jo
	JPKW9AoxBlX68pkLxp8NscoivwKLGKl4xVrggHG49P3bWWvD5P0KdpAyWNr86sPK2hyZgKkWwGj
	pzdiB66WYC7yOM
X-Google-Smtp-Source: AGHT+IH1DgGXOv9U05OxLJT05mfmUcX32MdUYL+UbmMo6S6W1PrqB+heOS5OeNphPyVdKvsISm/TxAN5RBatuANrYoM=
X-Received: by 2002:a2e:8887:0:b0:300:17a3:7af9 with SMTP id
 38308e7fff4ca-3090f3bee24mr10560491fa.19.1739461380591; Thu, 13 Feb 2025
 07:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com> <20250213115951.GF28068@noisy.programming.kicks-ass.net>
In-Reply-To: <20250213115951.GF28068@noisy.programming.kicks-ass.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 13 Feb 2025 10:42:24 -0500
X-Gm-Features: AWEUYZnmsQRxlJial_Srfud0qxhtqGpvdrhg2T7ZQYxl10OhVwKIEsBPtxdK_Kw
Message-ID: <CAJ-ks9mzYWSvVD=PCvCBohXg77BdFODq4ePMNstkL+70tkU5RA@mail.gmail.com>
Subject: Re: [PATCH v2] ww_mutex: convert self-test to KUnit
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Gow <davidgow@google.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Feb 13, 2025 at 06:40:20AM -0500, Tamir Duberstein wrote:
> > Convert this unit test to a KUnit test. This allows the test to benefit
> > from the KUnit tooling. Note that care is taken to avoid test-ending
> > assertions in worker threads, which is unsafe in KUnit (and wasn't done
> > before this change either).
>
> So this was something simple, and now I need to know how to operate this
> kunit nonsense :-(
>
> How is that an improvement?

Hi Peter,

David enumerated some of the benefits of KUnit in another
thread: https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLxmTY2T2=
Ti53DQADrW+sJg@mail.gmail.com/.

My personal reason for preferring KUnit is that it's much easier to
run from userspace; the tooling takes care of building, starting the
VM, running the tests, and producing a human-friendly report.

Anecdotally I've seen evidence that e.g. Intel's 0-day runs all KUnit
tests but not all kselftests
(e.g. https://lore.kernel.org/all/202502090223.qCYMBjWT-lkp@intel.com/).



Tamir

