Return-Path: <linux-kselftest+bounces-11896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A03907B64
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF86285B1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082714B081;
	Thu, 13 Jun 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2US+rGJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8814B075
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303510; cv=none; b=gxSG3EIyZZnZujld6DgSjoEt5x6a/hklC1tIq5kkRfErfDGCbu3+4kLhrDCk+vfirWHPb3TtLiE01Jf3e9itxw0uuu0nfjsv4qVmghIg1xOdk5UUktGy/hY5rFM9X6mAI3OORMYfb2EAg1Kirmzi9mHK57+68lZuW/410eUPVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303510; c=relaxed/simple;
	bh=FAMe6ZfN8ocTQz72VF1wxp4zgj8DpMNIJ5NFawO1sOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=brn5rqL58A2lOgy40C+jnUqydHRGXdINcpGPc1zU4+LeKb0uwnCJqoFdAt7lxuPv9aau/Zm5vfwDZWsnUNaOLMHVATn+lMUi5QblCajry1kmw8OgOMxzCkC3jPuMAUlSkEGmXEKV0Mf7csCEf9uEaZrtzUG9+YGDEl29Ucvu0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2US+rGJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa5743655eso2434796276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303508; x=1718908308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAMe6ZfN8ocTQz72VF1wxp4zgj8DpMNIJ5NFawO1sOI=;
        b=t2US+rGJT+tw1WrqvQIBP3/7VKiEg6tkZyQEdACI1XLRpZJ7vM1pp0MVy1geqUYTDG
         ahLUJIggTcbLDrXBns+jVg83aog7ieHnqoe8PBTb3XdEhGMKK6PnCs6N/e3m4cX2EoCR
         XGkJ9hekRet6LaNoGChWGsBmhHVFcAWBRMHoeTFhWdroW502g3kH4EJJrS4HrmzIJNiZ
         VOqj/bboWESATyHP/eNoLfvioKkAbr10vjErh9yBybIMcTVGBXuml3ldCKIrZ6tYWWZB
         agc8AxR+aUsEBPacMIN32OkblTs8oQcvMkoeqkteksCAMAlPZhB6rFJY3Tjmt4pYOaKb
         OkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303508; x=1718908308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAMe6ZfN8ocTQz72VF1wxp4zgj8DpMNIJ5NFawO1sOI=;
        b=dC+82kOLlF4u4pa/AwuYEJIqiHkpxcU0lATOZjmRwg12GwS1xUw1/C73xPBZKcfea7
         W0ttljt+m2NoS/AVyfglwoHmXXCOvo1IJ6ob/Wt80Yt3WSEVBl0n7AVWHXG3fOUyulhd
         6wC4GKbL4kUnK7frE+k7v89DC6eX1o5ZfU4MtONeAiGg6vDVNKosueAIdwUsRJpm6w5o
         ler3qhy+fzww+GJz7mGkFFpyTZDpsRIA05bngSV+1SEmcMap8pCl81gswq4QasvRYmyO
         gPyZyF27/mUV6R4ojNhJkJYge7XiLKpi2TdWk/FZDEC8WyS3p0anWa7xKcV8AC+lJCbd
         o2rA==
X-Forwarded-Encrypted: i=1; AJvYcCXaqQZ2dKdpKnnsCsb4Ezu+F9M1Vxhufs6Hn3kwnKZjSx9OJEc6G0g2FlaYU8/kgqq1+e7/TWCjthYMDIIK//HTNQezcGiNq0lObZDqUAGX
X-Gm-Message-State: AOJu0YyAH8d/v+1dmiHfB5PLDWCnY5P763xRHa7c5zgZV2WNzdZoNLu/
	4yL/GG3AHoER/TC2cDMLjwjvRE+U8IfNgh/CaPLc40WZM6ozVUuvvnsR/SFpMvl53v4whGCGmii
	cDA==
X-Google-Smtp-Source: AGHT+IHJdhDYs97torwnnhU6KnlaCZsdrWccR1M8UsNd8oy3s5V+SSgGLN9j20SAhn7b35SEH2kqBCITkow=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8445:0:b0:df7:9ac4:f1b2 with SMTP id
 3f1490d57ef6-dff153d7f58mr42781276.5.1718303508321; Thu, 13 Jun 2024 11:31:48
 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:31:46 -0700
In-Reply-To: <20240207172646.3981-23-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-23-xin3.li@intel.com>
Message-ID: <Zms7EnytQfy_y4mw@google.com>
Subject: Re: [PATCH v2 22/25] KVM: x86: Allow FRED/LKGS/WRMSRNS to be exposed
 to guests
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> Allow FRED/LKGS/WRMSRNS to be exposed to guests, thus a guest OS could see
> these features when the guest is configured with FRED/LKGS/WRMSRNS in Qemu.

(a) please describe what these features are, and (b) one patch per feature unless
they _must_ be bundled together, in which case there needs to be code to enforce
that.

> A qemu patch is required to expose FRED/LKGS/WRMSRNS to KVM guests.

Omit this, QEMU is not the only VMM that uses KVM.

