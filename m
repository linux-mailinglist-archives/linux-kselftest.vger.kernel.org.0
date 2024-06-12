Return-Path: <linux-kselftest+bounces-11797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFF905D8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F24B211E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F28529C;
	Wed, 12 Jun 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5pqxlWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C184D35
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227146; cv=none; b=GEPAZjoW95AdXyTAwL54t0QVKKii3kyoYz6IOSYRGCBvE2MaXDdb/ZdMt16Usb/nxGxoVAkcUPsCT6RpzL1XvaT2SuYz7r++XOXCgZJIaqN0xdn739uKeI2VFCLzmnLJuOJ1UOQemgTe7G3ipgOdE+PX29MzE9o+zKf+xr2Bjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227146; c=relaxed/simple;
	bh=MLQYv2BaMO1JDh6FRxrn0183u2i/RhneG1bZBn24Djw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Elyp2zE24N9tof/8SLhnVBfEMmFoHs9i1MPXo3hIWUkPF3stwOUk+LnZ+EhDTesITU0syK3W+GJhc0fJnBfg5PIiwz777TRPxKV1EP2S8wuRQ0SuicjQZwnQjNN8kEYhqZNHZyyTJoM38QgO8fn4p0Af4Zvs7wjCKiLBf/wHVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5pqxlWO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c72c8b9603so196455a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718227144; x=1718831944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgahXDJi4rwKNqUUVFC+2hJQOZ9hbHHAlaLc98a2hms=;
        b=G5pqxlWOVTlPvxIPYTb6ajek2CMU9ErhvUwqRFJ98IjN9n4GVFiqbemxT4129b9puw
         dUnJ+7k7avpS5B/6VXMJLbrbkOVSuuDBYxpKHk0AnTyy1CC5oL315PbVcPB8iFpuQcLc
         9uSjNDPPhxVHpINbPujkEq9OvSWd3Z2c6smuTXPDUMeUy+vPSy+W/aUFQD0XKMGk0IVq
         51xIfLhIxNaVeEBFate14JJsLqDm1YLI7Pqg/EYbOUZWlsVkZzsb28YdLr4Vw5uzCN1O
         9MIXrZG8OqsAbLdfkQzrzW4ixYOGNEHNrHq9YR/oXdwzpMRpFbfb+VRlh4wVLAzOUstq
         ZPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227144; x=1718831944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgahXDJi4rwKNqUUVFC+2hJQOZ9hbHHAlaLc98a2hms=;
        b=TBC9yEnyWDRctaV2K64XJtH7i4g56gQE5FGXu0McshKXp8p5x6yBCPJLtwtRh44f9x
         zS4f0iH72Omw+gAocy5vtHgobZ2sb5mZo95J3kTxWFOHJcnFHOROEfwXQGXAogdTjHzv
         VV1W3Msg1rk7x+ytX8b5YagYWKWtH2x/kACYja/x1PCGphUXuZsBUqFOQjdle/Yn/H4U
         Fln3XFsdVBC9UzIW3ZVqWmkOdXfnKWAzozrwfuWGL0FxLnwZQVG7JWYSCS33yrgQmkTl
         GFstyKbkgY4nYyZ6F29nziBHU2kskM/JDKTz1mZ9TL9zMCOykYgjzEk3BajnkXg8yhMh
         2GCA==
X-Forwarded-Encrypted: i=1; AJvYcCXPEUwrKVkG3eSFmZN9UMVCLbRKEulHZ6d3bfnU9DJOxGgHwnbVIqIsekAcfhcLUfSOi1q5/igethmoxqYe1CtNEFgrZmo+wV61vp8bIPeP
X-Gm-Message-State: AOJu0Yy6n9jSBFDuGGSISGg9Pq86lfRbTLDhWtXLpVMIL8btyWQ+eVQ8
	t0Gq5dZ1XJAbKl28ScEEZrWA1YuhHGF7kTihHCtG1b0fmZvPmtbrzhcPoVsbxxp5RoscuQ7dSlo
	T9g==
X-Google-Smtp-Source: AGHT+IEyX+BvqryxMRr9G0bMzgAJHpudMNKKmYw7eyQeJ8a3uw3AhkQsT+dsqu7wlsIWbs8crlNnEDE965o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:451:b0:6e9:66a5:408d with SMTP id
 41be03b00d2f7-6fae27627b0mr6025a12.1.1718227144135; Wed, 12 Jun 2024 14:19:04
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:19:02 -0700
In-Reply-To: <20240207172646.3981-7-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-7-xin3.li@intel.com>
Message-ID: <ZmoQxjksn5bWhlBA@google.com>
Subject: Re: [PATCH v2 06/25] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
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
> Clear FRED VM entry/exit controls when initializing a vCPU, and set
> these controls only if FRED is enumerated after set CPUID.
> 
> FRED VM entry/exit controls need to be set to establish context
> sufficient to support FRED event delivery immediately after VM entry
> and exit.  However it is not required to save/load FRED MSRs for
> a non-FRED guest, which aren't supposed to access FRED MSRs.

Does this actually provide a measurable performance boost?  If not, just do the
unnecessary load/store on entry/exit.

Generally speaking, the only time KVM dynamically toggles entry/exit controls is
when KVM wants to run the guest with a host value, e.g. with the host's
PERF_GLOBAL_CTRL.

