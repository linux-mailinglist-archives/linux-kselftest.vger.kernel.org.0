Return-Path: <linux-kselftest+bounces-36296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD19AF119D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D34A2711
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBB219A86;
	Wed,  2 Jul 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3EfSGv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261C238C1D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451598; cv=none; b=UAuqnjTQySiljSk641l1yx2OVSLRPyOqCGOm+meVHP8NT3DTtTgazV/DZ3FHXMqEzuDA8NwjkMikqPNQnDjTH7NnB0LCWSBh9qFG2uRTf63Fq8mZFqr91+ITtS8CsP3pydlnouMrNNHs1AE9KvsH2GsP5oPFAsbtDLWiIf01cNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451598; c=relaxed/simple;
	bh=QMSg+H9E85nSP8AMVhfKPz+3Q4Lbs/NOUsOvvYe5PHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKUgRfjGRFFQlKRjFV3roaJI02Zbs8mzKzlHedNnOXAnmWvoUKg3sIWoVyKXoEPpCsn/9L5Zg3ncywY46oPnVT3q+4gcUYv4qLHL2ooA2KDCfC+iBc3VsOy9ROPLv9TDSlbsWoSKwsV3FjdvUnNwfUqToAz9oBCz7c5SMvaaIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f3EfSGv4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e77831d68so45035367b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Jul 2025 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751451596; x=1752056396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMSg+H9E85nSP8AMVhfKPz+3Q4Lbs/NOUsOvvYe5PHE=;
        b=f3EfSGv4GqYgqO4MpVUaeaCURwtltoNVPUFLJDWZKbvKM2wwvfXRTI6Ucg3x4Iftu/
         VhyTnD7eFf/M+kEnoCsCNUGV9T53rUo0iXT/qTa+cVmegjUE/8McUYQWu5oeh7M1xJyo
         G7qwbb3wXv6/l4bIA8oxKnxJY9tX3r+5q5FhXPvZCsQ9/vV9p08GYahxrKRp10NhXcGY
         TiASsYjaqAhwzWruG2q//MeDhnfIkBLYkLFEsXH3vjM5wfMZX46sND6KROsim3SLlKY+
         VC9fmMQWqC1ViRILbAlaT2QzGxEG/+TPakDm1UGFaSwu+BMnKevPadk4nXgxa2vx57HU
         L3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451596; x=1752056396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMSg+H9E85nSP8AMVhfKPz+3Q4Lbs/NOUsOvvYe5PHE=;
        b=MO9P5nskDpkgnlIJKrPgbVXTJN5W+FzQEu8vpC0jxSxHPS3O+IJvaPc3itL4mgwvGJ
         TzJqNyVUmyxO7QGmo5Qrp2q1BaYUhgDDGanezpeyRKw5kD5AKN/qpH74IyFMAHgdAtCh
         c5aObOlBTgzC1k3dZHLjBYJs0Ov+72BVqdJ93RGpGy8rLNE4v+4hyNclmpxGJVN9jdSS
         75vsgwjvkdLPgsEuvgqURSJPvYkCzbfPgGvb8toOCiykjBFBCDs3aito94tHYB90nAeM
         UdDib5yliGaTCbat783xtwhHeVVwMkSbmvQ7pTTCoiXkF+B+9+z3A6dr9a1yHbqQKOpw
         Pz1w==
X-Forwarded-Encrypted: i=1; AJvYcCUznLhoieI/d2FHrZ+U8CELgUSxhJdYM6OPS6/uxN2Su3I93wLNhHOl1vWWW7dv6Ns0AYLWQCg8pndqeqcEkK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBJjF79ewkPOMYLaaoZjheRVYvG7PGIC4O6arTmi9CuLPlmxH
	SSfepbndTtRde9ilpsCk2zQBKBv7/G1IuforH90ihfH7gk01v65xAqbjpRW6cU6edEybOSUlUpU
	TbPdaYWOb6K0Byx3SAD5/xNtIFlkkRQCQyaq1GhhXAQ==
X-Gm-Gg: ASbGncsaV//EiuSkyT0gS3X07d24dd0HwVjAGpTsMxL3rTE9IHHt2ppB0c7n0DSxLhv
	SO4kKXEw9ZLmDMqZpko19TixgAgqpNmxC60itkbMqgLq38qJxDLSnO5IZSDT64/H8uvjchpZDhv
	PCIFeOIL1Rs6KE8ZddAbhx9ajgfkXz7EMx+omX1mMcQFA=
X-Google-Smtp-Source: AGHT+IHG/1GissPVmpknsYzFHMpB6ytPy9MhshgzbgoGfNZ2rCgq5NLTEQSFfMSr0XJegByETigg6aj5tsl8WILZc8k=
X-Received: by 2002:a05:690c:6802:b0:70c:d256:e7fc with SMTP id
 00721157ae682-7164d3f9161mr27758297b3.21.1751451595695; Wed, 02 Jul 2025
 03:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701142313.9880-1-terry.tritton@linaro.org>
 <87ikkblkff.ffs@tglx> <aGUggwe_gJon_2E3@MiWiFi-CR6608-srv>
In-Reply-To: <aGUggwe_gJon_2E3@MiWiFi-CR6608-srv>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Wed, 2 Jul 2025 11:19:44 +0100
X-Gm-Features: Ac12FXyuLh0QFcbaVWbl5yokqfl7teNpNT1gidQEcqC-rhZCYHiTlieQ4JcBwVo
Message-ID: <CABeuJB15QXyxSgB60VokSRFVGBRQJfcTNcwuX_wMzrNqmSz0PQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
To: Wei Gao <wegao@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	ttritton@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > Signed-off-by: Wei Gao <wegao@suse.com>
> > > Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> >
> > This is still wrong.
> >
> > If it is based on someone else work, then you need to attribute it
> > Originally-by and omit the Signed-off-by of the original author.
> >
> > If you just picked it up and adopted it to a later kernel version then
> > you need to add 'From: Original Author' and preserve his Signed-off-by.
>
> @Terry @Thomas, Thank you both for the mention in the commit. I appreciate being included.
> I guess above options both good.

No problem!
Not sure how often this situation comes up where an ltp patch is also
needed in kselftest.

