Return-Path: <linux-kselftest+bounces-24162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91583A080C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 20:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9776F165094
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4D51FCFE8;
	Thu,  9 Jan 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIxAaGbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98C1FCFDF
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452104; cv=none; b=MZzMPCJpK04NJTaXy3gMW78IaiZGLeSKAmIFA0RrrFFH9mTvAUG632+XYOhF/KPzD66LgkhgquO9CeeIs9DAnFhV/BS2lVz3m/NyFYDRVJl3FXQS1b066gDWT3eEScngI5EI1/GbtplhAfRAWZ2QQSpRHeO8ZST9UWIrPa/D37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452104; c=relaxed/simple;
	bh=i3rDKA0F09JEJTZwLo+zdVEcG4ixuVm35C+F41EWN9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBUKYiBO2c5hZwbltoI0n89Qz+MABcuLVNnI7x9ySKEQ7IF0q+rrQ71SOfUJL0p6hM1Tvqonatkj8+wztzJOWv0oz5/QwWliSzwFIeF+kxqYXNCMi3KBAhcvKYpaNygr4vQpb0bThODglmOHAA3p4fOMC/E2VPmn2ZbCELMYzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIxAaGbs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2162259a5dcso33448575ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736452102; x=1737056902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYk3UMg30Ej09kAh2ThRZhDb6n/cWhL70JOK9UY+H0=;
        b=bIxAaGbs91iMVDc3ULgyllXc5jGubLz14coJPVlIF3kWpDs3wOfsBCqh1XHi4GTa6p
         LaWYedZ04fMYYp0SVGzkIEOMXrbd6jM6kpK6zvdmByf6rrNousTo2m/bAPaUrrtxuEQ9
         5WptqLkIyh9YRckG64U8Xe9oaso7eK0q02Ux4Lgp4A1UTTblEUEH1CUfP1SW5Ax923k3
         /d+qufQsvSBc3Q8NLq1OO6lqA+goMl3BRARNDhX6OxyXTCQBzKM7faLkHbMrik2vfEYx
         ABrRB4aKukWZoFIYqLGfDeaslo0vPZBrk8FNL3es6pmvywUDkXl2bq8G7uMnk1aIbksR
         vZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736452102; x=1737056902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYk3UMg30Ej09kAh2ThRZhDb6n/cWhL70JOK9UY+H0=;
        b=wBLmDaQwf650uGy2wmUW2/MJVpwk6a2CcCeCoYx/0Uz6yE6xVm3W9u1kymGReX41Xg
         bzJNPtfHwVF+Xvc7GeqZC0mcv2XHWln0KnFtPLBvaqSMbwV60JiLYmqGVQFKS3xgj0MS
         tqH9T98dGJk7NCs0mDGfp13MdiRiHu58hW4IkUczPvfjZ7OAjiNShU+pM86R0XhBM7nc
         55PXOQvinAQtkX3KG9WoP6QKG+BRihJKDxSstWtmJMtqDkYUNJzMA1Pkpm+iJM6G1Bka
         Mb94ctzGMDW8JIbd8aLKoGw/K4mzCGUn4am7gcWcM7r+sSM9PcVX27ViaQ1uBo5iBfyA
         TVlg==
X-Forwarded-Encrypted: i=1; AJvYcCUGX4D4sYzDSyWLN7szq9/KdLNQ9G3//9hD+7KG58XEUflLnP+TX7GtjN8CiEZhA3rTVwlHThqU8GaTgsypFgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eQVzlqR3eRROyOqBxL8KIquBFETmuylupkGC3SA26QzNNBZo
	7TzJu2Z+QaELzIDIInQuXpiWo8aGF1z9YBsv0m/n6sm3Grxte8AV4gBvK1yVOlckMQenwB+tA0P
	nIQ==
X-Google-Smtp-Source: AGHT+IEZS3ENK2nghLtlyDpbzxyRo1u1A41iwyMmacck2Wt5ESSVJoxAMFXh7M0PfZVSXCbHm38vIILs4Ck=
X-Received: from plce17.prod.google.com ([2002:a17:902:f1d1:b0:216:1a56:4a31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db06:b0:216:725c:a12c
 with SMTP id d9443c01a7336-21a83f46a4dmr119296495ad.9.1736452102127; Thu, 09
 Jan 2025 11:48:22 -0800 (PST)
Date: Thu,  9 Jan 2025 11:47:11 -0800
In-Reply-To: <898ec01580f6f4af5655805863239d6dce0d3fb3.1734128510.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <898ec01580f6f4af5655805863239d6dce0d3fb3.1734128510.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <173645119179.885604.11668508135105687384.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Add printf attribute to _no_printf()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, shuah@kernel.org, 
	Reinette Chatre <reinette.chatre@intel.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Dec 2024 14:30:00 -0800, Reinette Chatre wrote:
> Annotate the KVM selftests' _no_printf() with the printf format attribute
> so that the compiler can help check parameters provided to pr_debug() and
> pr_info() irrespective of DEBUG and QUIET being defined.
> 
> [reinette: move attribute right after storage class, rework changelog]
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Add printf attribute to _no_printf()
      https://github.com/kvm-x86/linux/commit/bd7791078ac2

--
https://github.com/kvm-x86/linux/tree/next

