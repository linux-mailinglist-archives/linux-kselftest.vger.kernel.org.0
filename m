Return-Path: <linux-kselftest+bounces-6052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654987520C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AF2288B61
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98F1C6B2;
	Thu,  7 Mar 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZ+5hC+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B241E525
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Mar 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822293; cv=none; b=pQKLS/+TgjfYMK8Rz5npiVzjz5YfQRvEqoDn8uO+Ywje12vDWe+2TW3cHbjnK9U/p/Qbp2vNzxnRpsULP1yCBjlrmALCjEhUMaXVSVfbNm7L1Oh0DKdmZNf4ZJ2X/mF09qsIdVPKZTdTM3fA/bYHq+sx9xibSLLCG8pdR1JyY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822293; c=relaxed/simple;
	bh=Q53ulGj/OUW0Xpudx9yI+PrPeWdV0r48TtFHRKuObNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqSQdqnOykPH36fegC/4dZRVj6q2IrhtJGQ6SLokS/hsDXWhPTueqHEjHTQ96YGA1NgfqdOcBa7GjcW1LQ/G08ioC1AJHRBATMLhc7XYSvU9zPvfObPeMeqSHkkHOHJVsTIStgHntfxQzezvGckPeJ/TsbQRUQ3SPnzRLieCwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZ+5hC+n; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-42ea54868d2so8548831cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Mar 2024 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709822291; x=1710427091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYYsNxYdvDYSBDgwXknTihQ30Mu1y1yczIPGPd3QlPU=;
        b=dZ+5hC+nMwDZ+QTgpGYJWf80lm/BiwNXIBRR78Lc1aJblrJi2v8t8mzjH5Pe/mpC5D
         2qlTQ4dYjVK3DT0twHEH0kFgPorBZ2q5QOogJo4Lv3D+FHMRxc5M+Zboi7rwh/X5RyI1
         WEffpgBnn7wU9HxwwmkdIbH8OTyu4Nr341BAd4SrNDuaXt8Xr+vwQBpHKlkmHMT3nAnM
         49YlxVkmifRnJ/ZxS5TuQbOA5vVD6H5KtF6s3vyjj8VFQPnG8h1xC4R7WOz6luHjKwk3
         geKu/fLpNqaIQOgg1EKr/fwdKe4Boai9U8xrql1GD3MgIgvxlsX+rIIICr/6ZsJsoX0b
         OjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709822291; x=1710427091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYYsNxYdvDYSBDgwXknTihQ30Mu1y1yczIPGPd3QlPU=;
        b=BM9ild8TCbc4V+bnplSzSZO93hyUo5NMs1KeQGa2Dk1+RkXCTfn5VSvWpxqWQPvagI
         AyCRJiw47zTqGXlBP+880Yty/QFgtF41xAFoiMzjOZWCoyG+kBeZmeKuDsESuPQUMlnt
         NI0L2hNH/Bux/ZlS4utbmwoPho3xQo1X+IUBep5rMmllPZwIJRDs85Il4l9uGTgGj+LD
         BUeTrqiPMj8N3raRd51iNEAOjJRKudk4dSJxKUXq18lzUlYLSpyReqvl6L4TlTNJHAKe
         MFtRI/JxIS/dRkM66Bh5++yGHYtyrC69oBcBaLXtEjE0z2kwBb2xsP9mVuCEvzcewufn
         oLLA==
X-Forwarded-Encrypted: i=1; AJvYcCVKKJVjOOw77Rv8UQsolBV0eRx5U/uh++4azr24NqrUDdVAMLcULUjGZLW6O3vb31cJw9dE0rh0OaexsfoZFKk3gTCQHZAnMsAh612j08ns
X-Gm-Message-State: AOJu0Yzs3l/edY8/s9TibN6gzsaUejoDSDBnyUu9wsI7gU0LYWJP+Za0
	Wid8/XOw9C3RwNB1S6G6XJtumU+8LCvYb0Y5JnpCip157QG5cttDXijqD9/RH4jmm8gl+IkC8CD
	6rA==
X-Google-Smtp-Source: AGHT+IG0qG/KaO4E6qlW73/iuTzrET6wxm+Z8LhNEG1/J3bSokT2NsFKqyxCzCAJthjUGrQk4dcuioHv6MQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1c63:0:b0:5dc:af76:660 with SMTP id
 c35-20020a631c63000000b005dcaf760660mr48005pgm.10.1709821833133; Thu, 07 Mar
 2024 06:30:33 -0800 (PST)
Date: Thu, 7 Mar 2024 06:30:31 -0800
In-Reply-To: <20240307054623.13632-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307054623.13632-1-manali.shukla@amd.com> <20240307054623.13632-4-manali.shukla@amd.com>
Message-ID: <ZenPdRGYkf-Y-MgD@google.com>
Subject: Re: [PATCH v1 3/5] tools: Add KVM exit reason for the Idle HLT
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The Idle HLT intercept feature allows for the HLT instruction execution
> by a vCPU to be intercepted by hypervisor only if there are no pending
> V_INR and V_NMI events for the vCPU. The Idle HLT intercept will not be
> triggerred when vCPU is expected to service pending events (V_INTR and
> V_NMI).
> 
> The new SVM_EXIT_IDLE_HLT is introduced as part of the Idle HLT
> intercept feature. Add it to SVM_EXIT_REASONS, so that the
> SVM_EXIT_IDLE_HLT type of VMEXIT is recognized by tools like perf etc.
> 
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  tools/arch/x86/include/uapi/asm/svm.h | 2 ++

Please drop the tools/ uapi headers update.  Nothing KVM-related in tools/
actually relies on the headers being copied into tools/, e.g. KVM selftests
pulls KVM's headers from the .../usr/include/ directory that's populated by
`make headers_install`.

Perf's tooling is what actually "needs" the headers to be copied into tools/;
let the tools/perf maintainers deal with the headache of keeping everything up-to-date.

