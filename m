Return-Path: <linux-kselftest+bounces-32528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F34AACE4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1833B3115
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2B20CCC9;
	Tue,  6 May 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHgw+6Tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CE20B811
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560717; cv=none; b=moNd13jEqJhN2b5YIrA9dlH3HbutqcZS4jzH2xpXqMgXCEprnkYVsXQp9ahnyR8BVXy/osIB5e6yLd3PH2Z3yQX6UmwGbHa5hdVVLlrMPURtveaPsFzTC5tSR474SblWrkZN4BnxTk4nVfMC+ywEuGveVbrTkJy6qiwj7VrTC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560717; c=relaxed/simple;
	bh=fA6baFrBMTZPoGqIiJ7GW9c6V8LDlSpjpVUs3FFWZkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ilnqDgydUUx4fGzYYcpD2Wev7/yU815fO+dQ9or28Acu35sySdd42PMbgvD72CW07h7KMR2VoliZRQI1rnZUb8HOd54pSqwXVcN0oCM4QEvQIDWOcX8uEFrWvezrTggvCthxJCGfQT8NZXAfpNTsUpIlAG/orAkG5bnv2ZGmCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHgw+6Tb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1b2fa98c39so6052427a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746560715; x=1747165515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbit0ITm/pQP3NVf792bDV8mZNspv5mb/mti4+w+eCo=;
        b=gHgw+6Tbi4onJw6RFC+exOn31VEOpTMUcGk7gYftiFiapBfNIF3snUKXgbhxJ0dE3P
         WgF/kGpzdZVwXvnQutlYxv4OTLA7tmINS8p9mbbExpMN3jSfCmuoYJ6OUoGv6iDSFiNw
         NFDOvuQIApm6EDOgjAMPhC8t7nXF2RRil8ynkHPrb4EUxCN1d7wC/xTjmObwI74gOJGe
         ukitBNxY4eIZHD2vMS84Xc7/6EnQO3HvLHLY5z1XIlYDpStwor3sqFOxoe2DbtRa0676
         oeh3TWeSY8XrjnvR1/aM9B2R0MX8C7kPL3E2q6HVr29eKYdppJSGEpLODkNn8tdm9R5/
         7M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560715; x=1747165515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbit0ITm/pQP3NVf792bDV8mZNspv5mb/mti4+w+eCo=;
        b=poV5Edn546sIUmxn3G1vF6Q6WbFvDns17Vv5N6YgXT3nb0G3OIVu5xOQR5ALMi/sKs
         PnA0vW+AwXPm8/Yklqwx0xqzp0UgovEbOFGtt3huOEnneDSz2pxBedr41ktuqZ2wliaJ
         IjMJBCfjuOpVvDa6xOg4EvGGIsI3f3Jv+W0MG2PjzcsMyKySBr6ylB59Qy+kb4UV6cco
         lujN4ONV1WN4tOfcx5Lz43cEE6NE+kbmJavPG32FyHu7vyBzWkHAEWhvc4oBjSyB5j6L
         Hub9cDEi8QdkRgdrOK/YH+FmybSiWkzHfoqXGoP2R6A3oduxpa2JtjJLeINlwmg57gos
         vD3g==
X-Forwarded-Encrypted: i=1; AJvYcCV1AO9Lp2lWtpYjDyV+1yISzVfINpTJZz/li14Yl2IvGwnMSsiDYYtAQ06d2qPxaLd66EdcH+tp2qjKXG92zeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxY6VAdncOA27q8cUN4GFJh5cDagy0pPiF6l1zkdhN9kq1cj4I
	0d/nQEjA5zRw1mOx8kg66KyK+YQ80bPn/W49U6b18S24W0dS1kd8wjulk883R9fE2Z1wcvNWfC6
	wFg==
X-Google-Smtp-Source: AGHT+IFqRJC+/nE+KITlgWvBy1Ybx1q2CpPmR4WfkU+G+40vwLU3dW8GZ+n+QI5InJgQduz6JwxzACkmxAw=
X-Received: from plbmq4.prod.google.com ([2002:a17:902:fd44:b0:22c:3374:e338])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54f:b0:223:635d:3e38
 with SMTP id d9443c01a7336-22e5ea6ba5amr6666535ad.15.1746560715262; Tue, 06
 May 2025 12:45:15 -0700 (PDT)
Date: Tue, 6 May 2025 12:45:13 -0700
In-Reply-To: <827cc30b-35e0-4a63-a993-484d4616091d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <827cc30b-35e0-4a63-a993-484d4616091d@linux.intel.com>
Message-ID: <aBpmycjTn4Xo4Hc4@google.com>
Subject: Re: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 06, 2025, Dapeng Mi wrote:
> Hi Sean,
> 
> Not sure if you have bandwidth to review this mediated vPMU v4 patchset?

I'm getting there.  I wanted to get through all the stuff I thought would likely
be ready for 6.16 as-is before moving onto the larger series.

