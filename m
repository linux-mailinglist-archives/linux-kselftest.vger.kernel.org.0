Return-Path: <linux-kselftest+bounces-23189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640899ED49F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A9F188B234
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C8202F61;
	Wed, 11 Dec 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eJwPPod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B6201258
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941237; cv=none; b=YelSynUOQSiKG5t7hwZPaAhMRqXCymSSAwPfATHe3Md2QHFdxNORpcJet8vBGnh1VvwUHh1b7P4vF5cXYyO3QgvZ2PeN1YNmF5GmVj6yvJsfF79sKsDkUuegA6SHkk7MIaliscr0FsjOJvmJBSurbg7z7KwIkWowU6tbY6hVsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941237; c=relaxed/simple;
	bh=eLQNLd5wRv8SOWkCMUttN5dD8JyVnkMs9ZHP4OQrzcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvDHX2QDfZ0FBrjKC9naIl130EypSyjgZKdr97ETE7Jw0NUvYygW4LEFBVcDQ33wxDj6DHidbSyrT9gEUGkbCSe3RjjPxh9z8Ux4LyhpENeLUHClNt1na5rva4rNDTXactHrcrRJV/wYbrNx5aVnvV6RhBUKfL7vNwW+/M+l2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eJwPPod; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-728cd4fd607so1944720b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733941235; x=1734546035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Ox1uza8Q79A6RwFeyGkXs+VHW6BnofeA5s7qSYG3M=;
        b=4eJwPPodg6mtnp3VFSBnHN396zCQKMsddDlh5NS8jZqSShPHLqM4mHxNfqXeBygMwR
         lVAQ38m9BzqChj+byZ21K+XX5JjzRVaR7vxVUxiTJ501mVPAt4PYdX9hzN4xobsdi1UI
         g+I6lYegvVJjlKWZZVTVu9uS1olmtiNsW6h5P4lBBYSSKBDrgJzx4dWecfcniPExwY4o
         BGJM2II5ziQLi6OY+xeOiJAIygxIIRzl1ycWylY0G1NVPWElZ8lcGi21tdiOOb/fM0OB
         PmEHHu3L2Q0yHk5/YVTTNnj1j5AixR24thMLxMNu0FJwhpCcjsv9ygJa0RqLPl2aMXs3
         hVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941235; x=1734546035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Ox1uza8Q79A6RwFeyGkXs+VHW6BnofeA5s7qSYG3M=;
        b=HDq4Dd60eC+DhDKEuCCqkvxZg/LtR6E0q7nygUnKaBv3JcoxpSqTQZyVJDQenTfUSB
         0txG5hY6th8/xX4f0SCLQmMofsFzA9jdbw/U2y7A7KLyzvAo0yaUXRn2QJtrB8iiKJ11
         BsPuS9/08EQFdIwJQnowCaUl96cvjevQDf6S9eUikmfngaIzg60k3lJlh77MNm4nROhv
         i6u/uTubkc9uiM1mI5dI6F8EzFEzfOv9Kuk4mzH7xf6gkUfHzAk7Jese4XI1DO7NEhQ6
         YFsYdMW4J41rVovpmSM8ADSSpEd0BvWzJLlGUIv38iFJ27N/OvJ2A6wxjZIvh5Hi8TBH
         nlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUIBjhOkKROAT1hjU+lB1mH17AvjQxVB9MBJhdfn0jbJJCDPVhD+SxJBJ4hoiLm2U5zZDkrz/L6WzY2tPVwo14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG8xaI8/OVA7gktNHKFWmMLfTx/EL+abzG6NoNrkoU2b4VaxP
	e2E5Zocl9AS7XePuzh2YJ8TQKiqnfm5G9QkTvmbwuT0Y1BFD2dzaVawBYhFVH6XnjAOAQlyxfXM
	32w==
X-Google-Smtp-Source: AGHT+IEZfd8RpvX3OL8+D64SC/c6EBzqjS61c4iGRcc1nCHXG9qtDFB2g/ZbpKx2mvqm2c2s2Smm91XqVPU=
X-Received: from pfwy4.prod.google.com ([2002:a05:6a00:1c84:b0:725:ceac:b484])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c8:b0:728:eb32:356c
 with SMTP id d2e1a72fcca58-728faa1fcb5mr375468b3a.11.1733941235183; Wed, 11
 Dec 2024 10:20:35 -0800 (PST)
Date: Wed, 11 Dec 2024 10:20:33 -0800
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com>
Message-ID: <Z1nX8aCfZMvJ4co4@google.com>
Subject: Re: [PATCH v2 0/6] Enhance event delivery error handling
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> Currently, the situation when guest accesses MMIO during vectoring is
> handled differently on VMX and SVM: on VMX KVM returns internal error,
> when SVM goes into infinite loop trying to deliver an event again and
> again.
> 
> This patch series eliminates this difference by returning a KVM internal
> error when guest performs MMIO during vectoring for both VMX and SVM.
> 
> Also, introduce a selftest test case which covers the error handling
> mentioned above.
> 
> V1 -> V2:
> - Make commit messages more brief, avoid using pronouns
> - Extract SVM error handling into a separate commit
> - Introduce a new X86EMUL_ return type and detect the unhandleable
> vectoring error in vendor-specific check_emulate_instruction instead of
> handling it in the common MMU code (which is specific for cached MMIO)
> 
> Ivan Orlov (6):
>   KVM: x86: Add function for vectoring error generation
>   KVM: x86: Add emulation status for vectoring during MMIO
>   KVM: VMX: Handle vectoring error in check_emulate_instruction
>   KVM: SVM: Handle MMIO during vectroing error
>   selftests: KVM: extract lidt into helper function
>   selftests: KVM: Add test case for MMIO during vectoring

Minor nits throughout, but unless you disagree with my suggestions, I'll fix them
up when applying, i.e. no need to post a v3.

