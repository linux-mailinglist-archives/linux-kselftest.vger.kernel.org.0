Return-Path: <linux-kselftest+bounces-38714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42890B2170A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D74681713
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243A2E338F;
	Mon, 11 Aug 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOXhcBm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FC2E336F
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946439; cv=none; b=TFwMuOjwJ6XdvOP7o9PXs/1JvMpMLEEuySOTvlXdxCKT5xR+dqnN22iy1ZQo9I4kabQelevTDuaffVcdUBm7pyNe+Pzf+0JAIdddrIvbd/Rb0UqP9xmuJLNRiOmUA90VFD2pT1CULE6vO4XltVr+fPzkZWc6Dv0meC8BjuUHWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946439; c=relaxed/simple;
	bh=9UHhZ1f5P1CfRUJPW4axdf/Dd2kBUyMHpEb2juaUkjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4wRnQAue0x40Rh684Ig5liwINnz+I6mna73Atjqpal8yjfXJA/lu51C7evGynJcSDOJUXasMt2W0ISam1xdro4tGyN9tXRdfL07FTrltrBB7TNfAav+VpgHkgMLtkCiSbJsjcyC5tmQJo1spe1IVb6OUJhMRzljMwChrHniUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOXhcBm5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so10153866a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754946437; x=1755551237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk5Q+GgLWE57K5k8hPV5NoOhqeIKKYX4ebtfJIRSNY=;
        b=SOXhcBm5z11tU6ck8S5DyX4kr0SJM1IdfsMMWL06r2XaaZRpoiuufJZ7718F1GXzrl
         IRbhdGUWYxTgwd0HM1NIcn3rJWMdLW91BK3x1WX/vpDhENJuRQdjYBtsMux0+k6MN7i9
         7BqJ/Co0O8UsDokKeTrnmiqOD/2R0/y+9hVImHg9NUr50xMT0xHLp9xLuxPHwrMNoHoe
         h2V4nTKC6C1oMoyo9DrOkSZQoSC/2wO2nZVWQEOnMuipwcIhk8bIRAiVC/4CGidGpHd7
         Lhuzf0g0YSpdD0L0Aho95sMT/Ne8FTlraRh7VsI0Lwi2VD33VuREYLNxuAXxwEMcH/2S
         uFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946437; x=1755551237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk5Q+GgLWE57K5k8hPV5NoOhqeIKKYX4ebtfJIRSNY=;
        b=awXUrs3nNBB62bwuYrszkWyBKlhjJNMoUw91JnvANOEYNFKlDBsAH7ei2L+mYaWb+g
         hWwzK/G/58tYDS90VFPAkgNGA5qC64DOKJaOve+5MHI2Az12RCfGFp6lB82Uc3006ZBa
         dhwAfb39QNoxhOCBdwtUKCy1NBruZN8jMjmJW42lOTQY9SXnC7HqYeDjcYhbX5llTGPJ
         wz1dHrUi8sUBcRTiM8dYxKP2h/+crNDG1xvZTKX5U/v/yuaKVLSdDdAVnx2RZyLAtUGH
         uSDGrdqOQxJmfSgTiYE1tbc9OOtART1Nr6eOaVDSwY4X0wnxYC/nuy4rfFAla7XNq3cw
         gatw==
X-Gm-Message-State: AOJu0Yz0zMwWBWQZCnbabWnQRQG0lSRb2aYVlYshqfXTMIDfysu77Uge
	MTuxPulfwT406v8ImUUHEqAQlg1jE/zt1BNPhM0bKBlKJ0+lNhNFmdTtorx9sQx4f7oPSO4BzbG
	bMXxqsA==
X-Google-Smtp-Source: AGHT+IF1TYyL40gu00BNbXFrUtZT7DsnlgGpf2vyCUJAoQIA/twn+A4VFtHoQ4UokfA+skRyHSiSWxnWB3I=
X-Received: from pjbdy8.prod.google.com ([2002:a17:90b:6c8:b0:321:6ddc:33a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d883:b0:321:9628:ebf5
 with SMTP id 98e67ed59e1d1-3219628ebffmr13741990a91.30.1754946437652; Mon, 11
 Aug 2025 14:07:17 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:07:16 -0700
In-Reply-To: <20250807201628.1185915-26-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-26-sagis@google.com>
Message-ID: <aJpbhBO53ujqkbPT@google.com>
Subject: Re: [PATCH v8 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> vm_vaddr_alloc_private allow specifying both the virtual and physical
> addresses for the allocation.

Why?

