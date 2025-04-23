Return-Path: <linux-kselftest+bounces-31422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA0CA99225
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A859165751
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24342BEC2D;
	Wed, 23 Apr 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMx1v3yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D42BEC2B
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421765; cv=none; b=sjkcWmQzmzyd7B1uSfz0m3ugYVeRl7ik+ENgzOxDRxReuypPvDsQstlBoJtNZGHGZ8ufVR0lxyFUhLuIZXjyOAL2Jjbs5tr9RFGTa23fF4kXjbQmSbdTWLCCQ1V+ZZxmQotSZiTKCHrwpuInYbmXr3d3++YrDkL5xSqUsyvauJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421765; c=relaxed/simple;
	bh=qGYrbJEGHgU6iYHbwXx1hwhCyrpckM7Rn+2DfIAAWQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDMarDLYSesxfhS9z/dJuEwZFWAowBWei8Cz05BYsdhalz/rlSUIuE+o5KqdEqvveCbwBkr3hYoylwvQjMUINYUhV0U2FLmkXwseYRM43u33AL9M26C2NJTEwdM280L5jGoR3vjblEGzdRb7Ot2wKAgnMBbYzTMDguZcdcuOvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMx1v3yl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3087a703066so4978735a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745421763; x=1746026563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=10gxDDjVQ3jQFK/sycvIp1VIp9JSv6VcZlvfZIbEvNk=;
        b=YMx1v3ylxhmF/6OT1yOaJewhBQWwgrdSNlyGfp/+ApdhAGbtdkoXyoXjaiC/85M4YZ
         Ah8INXiWtEGsZ10+ft+F71VdCf/iA0L0m/Xfd23vpxHE3BStwZZLZUbjxqNKex144qOR
         chLWECe3tC2SCACchTLSrxifT9AqzYDQ1Mu9zUXG/cxHO6jUiXaMthylSzXO+gxlv6eh
         a0vV/1PLG8NHziUbz16DnZ+zAopAvDbclCEze0YdnHLqeHvNm8/Kk2Uut6J/qKpJXhP+
         cB6GGYL9bPGyTftR61ysf4kyqt5RSeJll/PTJYVYdqKGWfvhE9QmfRyQob+KM+l7x8N/
         FCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745421763; x=1746026563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10gxDDjVQ3jQFK/sycvIp1VIp9JSv6VcZlvfZIbEvNk=;
        b=nfsxBmOMszBuUclKXVxAdy1UCRVH1AReC1GLM+LJ8hZncil1Ch/N2ONy28bRk2YiX2
         xfpJWDw12bnCrMGpO5XWQHMaMBVG5VQ3bCQT0CWr4wmpJXbJfWMovGktaNjO3Ezgm8tY
         UkDviPEJFwZ5QpwTbocBieLQ+byAeAId6zzTiihGzCsfRt0J4PJyBr82JlKAVmr2DVxK
         huRXzHmuqVzYvBMuq3FOWl92IhM7b27AAIOZ2CIGDqhI2p6/vUI1dIqlABb4Kv4R1tQQ
         uPPm6xRrNs/Vglid6AaRqLIdG70HEdEQ0LzAZ9K06UN1u2L3I+rH0S3N6Nei3ZKm7Lk0
         0IaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhu+l3GQSBmBxn/kd5xq1qeZbBWmIRH2k5pBbLCJZf1tRmUzdUCpcC27fr/8BeqxzQ5ywCLRiAgJvzycjmRkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxoquAd4GfKRHWmrzu5LCXmVu6nX4NG5HpGUEDdspUHdaMLM5
	IpL26VYyyFOqq3Hf1gI4289VcIf8bCtEPT9gzU7RxxDNv+ejmYuiXADq0l0nMMVi4b+xk+/G9wf
	QMA==
X-Google-Smtp-Source: AGHT+IF+ET0GUPEJ/rWe+DxfVSU9qs+SQqsqxY5vnYjMzQzKJPDQ52u2GWTNU8VmERU7wJImRLl0saRKd9A=
X-Received: from pjbst14.prod.google.com ([2002:a17:90b:1fce:b0:2ff:852c:ceb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5443:b0:2fa:13d9:39c
 with SMTP id 98e67ed59e1d1-3087bb53262mr33371151a91.14.1745421762765; Wed, 23
 Apr 2025 08:22:42 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:22:41 -0700
In-Reply-To: <20250324130248.126036-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324130248.126036-1-manali.shukla@amd.com> <20250324130248.126036-2-manali.shukla@amd.com>
Message-ID: <aAkFwT-vX4rqC8N4@google.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: Preparatory patch to move linear_rip out
 of kvm_pio_request
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	nikunj@amd.com, thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Manali Shukla wrote:
> Add a refactoring prep patch to move linear_rip out of kvm_pio_request
> and place it next to complete_userspace_io.  There's nothing port I/O
> specific about linear_rip field, it just so happens to that port I/O is the
> only case where KVM's ABI is to let userspace stuff state (to emulate
> RESET) without first completing the I/O instruction.

The shortlog+changelog needs to state what the change is, not what the human that
wrote the code is doing.  And the changelog needs to state the motivation.  Yes,
the behavior of linear_rip isn't PIO specific, but the field is obviously specific
to PIO, and has been for years, i.e. there's a very good reason why the field is
in kvm_pio_request.

  KVM: x86: Make kvm_pio_request.linear_rip a common field for user exits

  Move and rename kvm_pio_request.linear_rip to kvm_vcpu_arch.cui_linear_rip
  so that the field can be used by other userspace exit completion flows
  that need to take action if and only if userspace has not modified RIP.

