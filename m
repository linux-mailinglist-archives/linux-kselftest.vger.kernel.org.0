Return-Path: <linux-kselftest+bounces-19685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675899DA28
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 01:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7419EB2198B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003FA1D9A51;
	Mon, 14 Oct 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5Qbr6Ma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3331D968F
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949015; cv=none; b=ek0nGhyoBii8epVcLct/8FJaiAyfS7TOAfLYqcxqhVyKAlOIfLIW25lqLJdtf+R4GVOekUDV+2OMt6yd9DBOsaKUrxWPisEo0bQ6geS3m1qbhD0UYtGGMpMRctGMVoAcgbr4+8K2qMi/Wj1q30RzRElmXvnucDIkxWM3qZ7KA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949015; c=relaxed/simple;
	bh=9lQ11KBt43uQ5J9JR5JWrhkSeYstXcy9pl4223UHEE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hk+DUGeI+FBEhWNJTOK5Uh0HqXBYbRFmETXfcU90+QtobYVx0GPpwE/J0CCLEEZgPTMlQp3cb8CfR9yt5sri0rfilw9kpLN3XXugowg0f5+LTqVB3HETkoaVWOhdkzuXzd9JgmYaY/GnpPtkIBMxL+Q/14tUyyFUz1vc8VQ2iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5Qbr6Ma; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so7474388276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728949013; x=1729553813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6GRvpYVPkv4rqmcHo9pBIrnZWQHVu3C3S3LK/OgI4=;
        b=q5Qbr6MaqI7zz/3A99gTIAbvhpULKJUA3yL3NQotwIJ286dQE9tiW2xwSkioFwixiG
         16tXjs+9iN/bAC8aMP2ms4c/2UmYVhUSUSCjFsQzuzrWrIRgb7W/dI74V/fEwS4tq8Ix
         wVhBELhd2r3XZRkahlrfO3rYWd5nrGIrG1rrudcNoaMBbkLbMvw7DHwtr2S+E/vK27hu
         UB7UxMfYszMXhIJ3W3gQDv7Yee/PG1PH47q9bTD3yjpWEYIaeHCbVN2w17XPhneJtqvn
         ORBrIcZChjtwhSHR+TCrrxNV9Df87tfejS8gQmMbZXR7o0cMGX04NhjXTJxFccvw6E0n
         n59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949013; x=1729553813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6GRvpYVPkv4rqmcHo9pBIrnZWQHVu3C3S3LK/OgI4=;
        b=MpRhoXi+6EwqaIl084NjEH1NuHZ4zWFEctLJG1dYmrSQ4R3Q5w5doa+z/AOb34TPuv
         WNDyyPhdTUvoEqrH2AEkdTQNNLJtKztmFSLIIdgls2iYjQs+re0b7YFvTQ3MpKSsc3E9
         fVqGouf1/qvm2/7cSN6RQiyKSiFWd4UJbqcEP8lLajey+DKYeXkVFyrjiYdVizBh+p8Y
         u7N69ziNcY6eGMw72gjw2Schm97JLgtSx6hrrm/zGvtxawLPociItusAZQLzLhrE87k6
         uE9CyTvPDv5cqkMkXVsbLv+N1x8SHeBXWUk92lEU5zVTyiai4D/DwbTAiEb79c0bvvdm
         5toQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4uWisnWcp7CoXnNVvToSG91YiFPHvQKcjUCmMoA3mwOmUKwLw2ZuQIB57Mr9btJxvh55OOuwxYCXV3TRtG9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwctNLYYjJgx9DdVlmmFk9R/iPMnaRzCChNo/tQNemtZAehmfTS
	ykv0qEeoNHQdzDXCTlASF5ykHvxH9emd+gnZEUiiKtLppKzPafXL8az3RVJiyPMPgJ78VTdR/RZ
	U7A==
X-Google-Smtp-Source: AGHT+IGrlmmIMbrq1eDFzk8slt5Bv/bjfFyuOUS+xM//3TUnJKMB1jMjboz4gv8IycU3lIMwe83TEFFGqyA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:2e02:0:b0:e22:5fcb:5e22 with SMTP id
 3f1490d57ef6-e2919d75c76mr8304276.3.1728949013311; Mon, 14 Oct 2024 16:36:53
 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:36:51 -0700
In-Reply-To: <20241004140810.34231-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004140810.34231-1-nikwip@amazon.de>
Message-ID: <Zw2rE7-ZTCFpNE5G@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: Introduce new ioctl KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, 
	Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, nh-open-source@amazon.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nikolas Wipper <nik.wipper@gmx.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 04, 2024, Nikolas Wipper wrote:
> This series introduces a new ioctl KVM_HYPERV_SET_TLB_FLUSH_INHIBIT. It
> allows hypervisors to inhibit remote TLB flushing of a vCPU coming from
> Hyper-V hyper-calls (namely HvFlushVirtualAddressSpace(Ex) and
> HvFlushirtualAddressList(Ex)). It is required to implement the
> HvTranslateVirtualAddress hyper-call as part of the ongoing effort to
> emulate VSM within KVM and QEMU. The hyper-call requires several new KVM
> APIs, one of which is KVM_HYPERV_SET_TLB_FLUSH_INHIBIT.
> 
> Once the inhibit flag is set, any processor attempting to flush the TLB on
> the marked vCPU, with a HyperV hyper-call, will be suspended until the
> flag is cleared again. During the suspension the vCPU will not run at all,
> neither receiving events nor running other code. It will wake up from
> suspension once the vCPU it is waiting on clears the inhibit flag. This
> behaviour is specified in Microsoft's "Hypervisor Top Level Functional
> Specification" (TLFS).
> 
> The vCPU will block execution during the suspension, making it transparent
> to the hypervisor.
 
s/hypervisor/VMM.  In the world of KVM, the typical terminology is that KVM itself
is the hypervisor, and the userspace side is the VMM.  It's not perfect, but it's
good enough and fairly ubiquitous at this point, and thus many readers will be
quite confused as to how a vCPU blocking is transparent to KVM :-)

