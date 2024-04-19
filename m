Return-Path: <linux-kselftest+bounces-8448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F9F8AB257
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C5286084
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA05130AF7;
	Fri, 19 Apr 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9+9WSiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84B130AD3;
	Fri, 19 Apr 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541795; cv=none; b=qwKY/WrIa/x/KibvROiHLIGs8oUJdZf7n9VFj8A7djTxaCrt1wXykdE3F57ROE/PgfcMGVGO6R90lDDafJvzVKWarKvlFH7peLKtr2vsx81H6LXP8VaxxOJLgdwmP+LdzKlTyPu+XBIokyzI27KvV/xK+jOLrmFcthbn2O+Aluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541795; c=relaxed/simple;
	bh=3RFiDxez2acLIv9fQtWjSUCFeGh7FTIM9bGr4s+3eCI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qUSxvHI/1CW5KB3KQjEujEF5T0YlJg1bAj1W31iANjLrX3IMCHhz9xLrvw89l0we/B7qUxkZtEATfKfxSIGNpEq7i73RbtT22G9t9S4ODNCQP9Ae0/ElATczoYSacrscqGHTdaEYSaoi0OneMi8GKrGJsEex47HPifOZYEPFihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9+9WSiP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so2852118e87.2;
        Fri, 19 Apr 2024 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541792; x=1714146592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTjTrX8k/OV8D/4FwhpKGos9bwoXHtumU35pP/xvPFY=;
        b=e9+9WSiPH9Xp00OMES6T9bIfFbA+p4XB4/aF18gPHZtaoqHUMrI7ENdSb/9riIad4t
         4g2X6iwSeAeOP7Ep2RTxWmcVP1ASFCkmIlnVXFbVzfnho5Bio4wS/cey1wPXP/Vmw9ag
         O7q2iXVpnbOuAzhIqNL7ORnq4L7KrKEefuQT9XxEWldIrT745qkcQOLAwDBYn1WWlUMQ
         zypBi94DBiT9THsrMYxGh3y7rzpy2RiXjeG84i7ybbcbvMWQOeF5O/BKn4sp7duBWqe7
         u9P6kyNUA9YvW5N3PIr9+y+cgdWw2BrA20TPcov+OuaN0k87J1gqdx3uSZjy36tSStKT
         FnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541792; x=1714146592;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTjTrX8k/OV8D/4FwhpKGos9bwoXHtumU35pP/xvPFY=;
        b=CQLwrxZosoD/E56Z5dKVgl6xwxSFklpQO8kJN6zQiZ6VXu56+AS5hEN8+wD2hxr0oe
         vUrzdP5sfGT5Yv3xkIW30G7tL9Cn18sm/6C9otQ7tmyBcf99vujx9rXeKAjLVzocznso
         8Hrq4ecMcLiTaGms7Iw1y/2wy23R6Y2L+FnFLArqUkAOHmcY41HCBH3ssn3TuZGb/aTf
         GnPGb/1LDGJIUyocWaUH1QJIXJWzy45LPCIcV5e2UCNDuA+MSd+chyaDKeCjPwWAktz6
         XwFw/0oSbzvHUKUwRG2OpNBU68DkENaP9yMTmOQFHnUfILM1eslmkJbIEvp2gBhLR/eR
         TEig==
X-Forwarded-Encrypted: i=1; AJvYcCVN42plrEqGTrBo0+3xrrvb3ZtOAvLjNMGSTTGJTZef43naQrEgK6d5FNWq7kl+elJMJleRAejVXvqPkx/yRo7K+Yt4wcuJdeXbzNd/Qp8ffhoDWPTog1Jg2rV2yTatv1bcoRPa+mUNclA57OYhAOWFdrWar8hcJvUQSvdFiGizHZjIcHqKN3FOKCDS/KiqVFzLv/oWIFYaCjZpPl44
X-Gm-Message-State: AOJu0YxGZDJ79oCFyXmgjfgRfPGOo2cqnBOz7BYzUzJSR4I84I5sAoje
	Fgwf6/7lQ9jOEBR/eBe56dm5nfY3BsCaR+glqKF8nowFqIu9j9/Z
X-Google-Smtp-Source: AGHT+IGcX6lS6veqQqFahWGmcR+WcN6ooev8tXvu2kdoTkGGDXWaB4LRz/cu4Z6BuJpEFCW9f4FolQ==
X-Received: by 2002:a19:7501:0:b0:516:a115:4a4d with SMTP id y1-20020a197501000000b00516a1154a4dmr1601293lfe.68.1713541791631;
        Fri, 19 Apr 2024 08:49:51 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906a10800b00a4e253c8735sm2357376ejy.52.2024.04.19.08.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:49:51 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <21bc05cf-0227-4d57-8cfa-81097b95535b@xen.org>
Date: Fri, 19 Apr 2024 16:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 06/10] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
References: <20240418193528.41780-1-dwmw2@infradead.org>
 <20240418193528.41780-7-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The documentation on TSC migration using KVM_VCPU_TSC_OFFSET is woefully
> inadequate. It ignores TSC scaling, and ignores the fact that the host
> TSC may differ from one host to the next (and in fact because of the way
> the kernel calibrates it, it generally differs from one boot to the next
> even on the same hardware).
> 
> Add KVM_VCPU_TSC_SCALE to extract the actual scale ratio and frac_bits,
> and attempt to document the *awful* process that we're requiring userspace
> to follow to merely preserve the TSC across migration.
> 
> I may have thrown up in my mouth a little when writing that documentation.
> It's an awful API. If we do this, we should be ashamed of ourselves.
> (I also haven't tested the documented process yet).
> 
> Let's use Simon's KVM_VCPU_TSC_VALUE instead.
> https://lore.kernel.org/all/20230202165950.483430-1-sveith@amazon.de/
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   Documentation/virt/kvm/devices/vcpu.rst | 115 ++++++++++++++++++------
>   arch/x86/include/uapi/asm/kvm.h         |   6 ++
>   arch/x86/kvm/x86.c                      |  15 ++++
>   3 files changed, 109 insertions(+), 27 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


