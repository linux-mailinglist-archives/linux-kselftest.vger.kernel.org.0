Return-Path: <linux-kselftest+bounces-27083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECBFA3DF7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE393A401C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAE2040B5;
	Thu, 20 Feb 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNwqK2ba"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F8200132
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066948; cv=none; b=FczgzJV1GD0YNu/S0R+NcfQAdjr0HwaOpSPMQJkXZmKUJblbuNTsB58EOtNGYYW7hwKPsc+8brwSGiGgCLWP0FwjR26hCDVnFpSp23kwzL/JASJEnytSNbAFTz1t3EAKH4Y9vqYfyxyOInuWffu/POG9ERuQvqXOud22rNoobhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066948; c=relaxed/simple;
	bh=nGjY0pcALgantTol9y3eDcS8ift8hVBdT5A0SWQDHUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXBesTRiEqATZ6w13EycS0wMEA+9lD1No+CmnADZJRwC5QCdjpU8nsPFl5/2yAsCPWrf8JTg2Toe8wjM5p0sNaqqN+x5/SxZzEUWf1YAtDucWQ6TL/Yxe7coXz65X6i4++SjZ1bFnkGY53zaoWspEUqPnN5oSI3OAcGmx4irB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNwqK2ba; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471fa3b19bcso304711cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740066946; x=1740671746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqf65nED3NYJwmlnVPTvXBomckILIduk3AQAFu4O9k0=;
        b=PNwqK2baPDmaRfZtyCmk1BJ6kk3baSK4E16rOBF/bIHfe4lkGs5XNVDXGNVkRgIfjt
         stKA9To9oVOE8LvHh0AAVIYguoBxSmE3DnV84MFxcaJw5046bze+eM5A+jWASaqPtfG8
         KEdnQoDTKMd7nDNOzz2nWsNnljOPXExVdHmAgiA+bjktH9eGjWFwqxG/SWz+yoiButaU
         FUkZX0QEB7apg2yPundG0d/M34Ms3KIGq+LEHUvKum7rYbQvx06ZART0ztJefGX4uLpb
         2dQ2qZPM661rXQzpy8zgFy77z6jsKSHV1NgR3UVGqZaqYAYzFBOu2gjc/WLP5acxCvgK
         c1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066946; x=1740671746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xqf65nED3NYJwmlnVPTvXBomckILIduk3AQAFu4O9k0=;
        b=Ru9SWrux9W/uTvz6PNZGmkrEUH4cYBb/HTMUrNI4pvAT2pt9j5cqAlQud67iopHzzF
         BbF5Cciyd9y4ip7b6aIKTYqYX69gra19VzJwVvz3GhBS0PvDh7gLCTgnTUx06EXqN3FS
         h5LySHJ3KmfTVQpwwFkOjDX4q14Zo7KC1LpiCAhZfsWlJ2qVKPW+MSJrJnKJuooRmLuZ
         trbWLcd+OaDO705jZRHLp8HDSeg2NRqi6iDtVD/Tvfb1JDyCucRO0bqqEXklzTMR7wfc
         5nKr8lA+YIYNwKHZUU4pjXciAEIO76xte5R2AmwrrfX9lE07y8FK+ulobmnyZshMfYHZ
         BNgA==
X-Forwarded-Encrypted: i=1; AJvYcCUOgfOkqcaPeDTslEYWbMyerQqzcE6VXUSes9xCGeppQIZOJNUt5Wwi1JWPAQg88OHRj4SMvEZThji9N7XAXK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QKH8UGigbJB/dklGyTBITVGrw8zMmY2ycYrnfKXcZCs+MHFR
	+X7NC2Oz9quTR8M20l2hH3cxxi2dIZWOzJ37Ow/qiIejmARvwyIoGZ1ioQyS+Sj5xu889lv2woI
	twv1XkXZRW4mU4iX1b/6rZFXrufe4UCsEjKGE
X-Gm-Gg: ASbGncvUXlzb4Ixlm8+ME5gKRYqd4feaxq2WYp/2fD+RvcE8jKJevuqsPyEZ4n/JnI6
	XW9NV88SisTVbpqP63uGQTTOQd2GrrcxU294GwafxToduR93pQMahh99E8KmNNvVnfREbspxWMy
	Mn9VqsG1fBC5yTtojrn0f/S6vfvvE=
X-Google-Smtp-Source: AGHT+IHOdWO/3Z/ofouQMFSA/yPXXraLlaV7hAkItx8s9YCocwCXJATlNZf0CcBawq4mps1HDugVCO75m47tbi/iLio=
X-Received: by 2002:a05:622a:428a:b0:471:f257:7a5f with SMTP id
 d75a77b69052e-4721711149bmr4179751cf.13.1740066946034; Thu, 20 Feb 2025
 07:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-6-9bbf57d64463@google.com> <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
In-Reply-To: <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 16:55:34 +0100
X-Gm-Features: AWEUYZlPMDgaqu__QrVZ4KFp2sTS1uCxjoo7b3B-CAxYQcbUHy2R1SAZIvagXmU
Message-ID: <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
Subject: Re: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:48, Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 20/02/25 8:33 pm, Brendan Jackman wrote:
> > This calculation divides a fixed parameter by an environment-dependent
> > parameter i.e. the number of CPUs.
> >
> > The simple way to avoid machine-specific failures here is to just put a
> > cap on the max value of the latter.
>
> I haven't read the test, but if nr_cpus is being computed, then this
> value must be important to the test somehow? Would it potentially be
> wrong to let the test run for nr_cpus != actual number of cpus?

Based on my _extremely hasty_ reading, the variable is misnamed and
it's actually a thread count not a CPU count. I can double check
that's the case and rename it.

> Also, if the patch is correct then will it be better to also print a
> diagnostic telling the user that the number of cpus is going to be
> capped for the test to run?

Sure. The level of detail in the  logging and error messages is
extremely low here so I didn't feel like being too anomalous, but why
not.

