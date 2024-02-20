Return-Path: <linux-kselftest+bounces-5008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9985B676
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745181C23CF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96D5FDC9;
	Tue, 20 Feb 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYRtRdD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197E5FDB3;
	Tue, 20 Feb 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419622; cv=none; b=CDaFn/Jw7YCEEEDKjslGHdfVZPy7DVH+LTJborC8qyiok0GFDcvJuVdc5Z52ESDX9hOYbbExXn+g6qW2thbyybINRPyLG4rc1KCbjgtMFd2w7LM5nXQ38kI8+loaq8HnGNhYcfulTaYduIKpSyHw7J6+h/P0P29Ohq66tZIRkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419622; c=relaxed/simple;
	bh=MMZ69NWVSIMBPzTuBOxqVKerqyU+nFyqB4sQ9zJpEuY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fEtOs2lIFzD3G1lrx+I/q+ojF6MZKNFs8CRDBILtk4AYo+Ve1mAUToNC+H+28B0jEow7rshH1WFy3yFOWXubfxPThGulM/J5nuCWn/8DgWdeBfR8Dzma882MdAh5/OghvG+0yTZT/518Z2VwFJTS2zM+8YjAS3auvk9bCHpWCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYRtRdD0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d61e39912so558326f8f.3;
        Tue, 20 Feb 2024 01:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419619; x=1709024419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06nVV8gZLPzPNMdjXBiKGbmSYzRhxgs/TBLz+qJraUY=;
        b=IYRtRdD0CzXlby0jacso/QJXNVoCr+CDj+jJUC4pykjh5i1KbtCSs7l3szGi0cZejZ
         VhLczVRlFakgsCMfBXS0a/G8R+rMDHitIP6iGZtufnoKGc8tRmRfKG+M9Qf/2VVJVu6/
         umAcXeQcSFMHEoj2TITl0Oby5oERXdrK0rRFJ/I5rYFyDogEewID3esa7zLfhKDWDNJ/
         a52zUVOUpt99N2hp7cT7PZz6/qLwcZSVK4vMf8o2Bet7i1K39GWssF4ErRxcECMeGNov
         bqfqCmchiJS+Gu1goDbS/QdW7cMFOqGfmu4zzopQNFmP2DgR4xrVpHz6iynzUGvuLMTp
         1ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419619; x=1709024419;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06nVV8gZLPzPNMdjXBiKGbmSYzRhxgs/TBLz+qJraUY=;
        b=sY6gReYOzStJNYTbnfbJkHfX7fI3NQcfPhEgqc3S3Kwr3v+DpVMRTuWu2cCHiUPoZi
         isPyQqOVD+jy9XFUO2DTzIPo46slfwFj2YKXnx0mHPGt0r1NOFiMmokTCH5hI4WtVg7c
         FLS9cy5NvAmNsspXcFXp2NMmdcH7y7Fb91m1dNp5WeQNA/NkIJ107NDKgYZDPUJ1Of1V
         RNAfSDCyCRlyG/Yuv8gUaG5AW3Z85piPNYqSxFo2KHXlBZY3BxyWlTKQwZiGfdR8IFtV
         2PuI8gda24KQfyRZ9ZIKZ87pehoCd+qgcQg2R3hEhqTK8YKFzJc+m9J+/sSLWkpIrse7
         BMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWd89rhrukJLMYQwYkfuePoR2whgw6mPYo7dFdAOJIFTV+V5zAKufQywf3qDgjjH0nRDtpTGq8rb6eK7b3PWtuZlPr9YqQr0gn2pr5CQvsUHnKKjjMdXPLOSdjxysmTgNZdmwOfyPZyyXq+ChP0Zb/mKvWPrS0Mav9ScEMN0aci2mFudHXArwRexYbEN7NkdSHDiPDKF1EO1wa2yHLp3jheEM6wegoMEzj6A1UHn3v1GrmuIcwYz1dasg==
X-Gm-Message-State: AOJu0YwII8KOh6U7Ok1C8v3SPcsOldc/GJmP5sIwuIgOfxIHeZayUXrP
	PQscQn6JXzxNPfpoBR7x76CxcfLzjUAVjUhzFh2zsjrs41ezDJcD
X-Google-Smtp-Source: AGHT+IFJH1ROf5PizX+EBDHKKIRH9OInqNPGE6NxaI5/Cf9mbeUyQfGCwS/BNTEoM/nSTJJMcyqgXw==
X-Received: by 2002:adf:e7c7:0:b0:33d:3047:d2e2 with SMTP id e7-20020adfe7c7000000b0033d3047d2e2mr4990736wrn.36.1708419619042;
        Tue, 20 Feb 2024 01:00:19 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.239])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm279495wrb.8.2024.02.20.01.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:00:18 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <a3a7538f-e839-41ac-959b-31e85f972f46@xen.org>
Date: Tue, 20 Feb 2024 09:00:17 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 05/21] KVM: pfncache: remove KVM_GUEST_USES_PFN usage
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240215152916.1158-1-paul@xen.org>
 <20240215152916.1158-6-paul@xen.org> <ZdPLmEeMhTaSiYrA@google.com>
Organization: Xen Project
In-Reply-To: <ZdPLmEeMhTaSiYrA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 21:43, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> From: Paul Durrant <pdurrant@amazon.com>
>>
>> As noted in [1] the KVM_GUEST_USES_PFN usage flag is never set by any
>> callers of kvm_gpc_init(), which also makes the 'vcpu' argument redundant.
> 
> The changelog should explicitly call out that not only is KVM_GUEST_USES_PFN
> unused, it's incomplete/broken (which is also partly why it's unused).  Without
> that information, removing the support looks like a somewhat arbitrary decision,
> versus a deliberate change to make it easier to support the gpc code.

Ok. I'll add some words to that effect.

