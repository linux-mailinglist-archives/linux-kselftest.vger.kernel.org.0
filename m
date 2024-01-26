Return-Path: <linux-kselftest+bounces-3613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A683D1F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 02:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335E91C21AA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28FEDE;
	Fri, 26 Jan 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCsJZkL6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69964F
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231999; cv=none; b=n8JscooI9lJSq/MrNvCBSe2S1J9ApW8lB36y5P19tVMvQU8QDTt2//np0zJGZmRlLI6yFma/sK5yCwfAkr0OybC5/A25x1m9wP0lutQP+OSGiih6e22wF2s0qmco2z0aVqjtYbXZLnNlYBjm9nmk+EWqP67rNcp2svkLyf1MMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231999; c=relaxed/simple;
	bh=O+ISzNiDeEkah3Hw3HoidwKq5p/UbFijfXglLbQfZBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V/wCwi1aBvqRORKc4fuUnvOJfDLNV4BwZ6zQaFzihxp2TdDv4dwangEY4A/ELeL/qbSbPd2MjSlqSwSAH7p2JswMpniRTlSQZkOUWpAe3rEpuWfZ6LCM92kxMXJeTMpR1MRpgSsojo8Np+J6WUIRwOGme6igaoVBayRlPNuk4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCsJZkL6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f0fd486b9aso95156287b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 17:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706231997; x=1706836797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHG1ZSD8JrDcka5NqVhNUxwoRtm1E+uIuqNOvvYJ6SE=;
        b=DCsJZkL6fr0saIXsihcPapgknJE0lKn04IC7lcLMMZlJVPFGT3ATnpSfY3dq4W//jl
         3RoQDDg59GppQ/gpSmoAKAyLT1FXmY9hAP5FHHGdXU+VAvH/K5xGgeO2WdQC0LuZb544
         XSRmMeUnQXbG2eZcFHG3Rj+RIkIxZngpbQ2DVl0pYOv09ew7gp4G7JcqxzffkkSEQthu
         0AvTKmPJNkNq/WoMqSMXkZtFu5t/T9KTK2qx94olY2M3quGtag13jPIt1P+D/5K6dQNY
         4jtiJzyCzNvit9znOBGiNiSS4KTo/BUhixsL2BnzTnykPkTkZ8QwWM2VxS//R+uZ1kTv
         rWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706231997; x=1706836797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHG1ZSD8JrDcka5NqVhNUxwoRtm1E+uIuqNOvvYJ6SE=;
        b=Hp8lL4oFJN9JQZLmfPfZhw6S3Erc38ZAh4EmB8xeUYQmzD15vlUYPe9K62yPG1UMWm
         zzuGBAX6fyYLYgMEZh+nrV/ysfVLBZ8oJnwjkP8Z3HJl64pso/o8o3G4CopwnaXJCwFs
         +TZWGve9rJYOizb5F+vCDtI8ZqnZDgTKpSKwpP5QRyA7Ko9S7esye4nXLy+QZLC8hJlb
         yKciruh8iLLcVl3pGIHdYnbLgtKpr9KsDhH7qgC5zKVPVvVE9BDoK1GO6lII3G0h2hcH
         fEZk3XlYLKTLIbT9TfX9L1ZYU0gMpti0BAqxreIm1tPa+CAVfLF2tqXseWKX8us0TtdE
         6S3w==
X-Gm-Message-State: AOJu0Yz4Q/31/4dxpeybQDVRzgRhZ6+lYuGsK6N/D/o+IZqQmoKmmPa7
	2tApeMdoN/t/hF9fSQbh7RLfjpAY0X0j37p3doOXnbdLG+MzDE4/jtHUquemC0EWUbnMtmruRrP
	nrA==
X-Google-Smtp-Source: AGHT+IHLXKe8GGe5tsEa+OhFYDBbxSYWI6FcMBfKCtGBbLWVOaSELCB0u0zyOphLvMaVq7WfVLhu2EXTeNQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2309:b0:dc2:3a02:4fc8 with SMTP id
 do9-20020a056902230900b00dc23a024fc8mr87710ybb.6.1706231996798; Thu, 25 Jan
 2024 17:19:56 -0800 (PST)
Date: Thu, 25 Jan 2024 17:19:55 -0800
In-Reply-To: <2b4d020c-08ba-46ac-b004-cd9cb7256bd9@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <2b4d020c-08ba-46ac-b004-cd9cb7256bd9@xen.org>
Message-ID: <ZbMIu84Zi2_PF9o4@google.com>
Subject: Re: [PATCH v12 00/20] KVM: xen: update shared_info and vcpu_info handling
From: Sean Christopherson <seanjc@google.com>
To: paul@xen.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 25, 2024, Paul Durrant wrote:
> On 15/01/2024 12:56, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> > 
> > This series has one small fix to what was in v11 [1]:
> > 
> > * KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
> > 
> > The v11 patch failed to set the return code of the ioctl if the mode
> > was not actually changed, leading to a spurious failure.
> > 
> > This version of the series also contains a new bug-fix to the pfncache
> > code from David Woodhouse.
> > 
> > [1] https://lore.kernel.org/kvm/20231219161109.1318-1-paul@xen.org/
> > 
> 
> Ping?

Sorry, I have done basically zero upstream reviews over the last few weeks, for
a variety of reasons.  Unless yet another thing pops up, I expect to dive into
upstream reviews tomorrow and spend a good long while there.

