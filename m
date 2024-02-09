Return-Path: <linux-kselftest+bounces-4452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F180284F904
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302FC1C221C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C076058;
	Fri,  9 Feb 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ih9WpT7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B987603C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494343; cv=none; b=FonsEUk03EZr950dQemCz6objcdGGZRIGhzJsyQ1SAHJxIUEzKnou0X/Iv/B6kANup0/yJ4GxzUMGAkNdBJdwrEoQqbf20ngIHXW/J+LOBT5LiGXskJ/QF5PZblcn3PTBii6fb/KTcf2x1f0blRKEjBXXdF03gN5Bk0mk60WImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494343; c=relaxed/simple;
	bh=t8AOFvwk4ZsRfte4mt6qy5Qnrh895ZKYWxZaGpnZgQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s4JOlMYbtLgJH+9W5WIvirBNl+mHUWhXRBl2h21FfPFePhnACZNohqgQC/dE2/swIB7FbwVlwwSrFibS+QMsKl3BtqX4SE1FKlDM9GyPlWT5ZFLTCKGaNhW7LvWKpXEnh6Gr4kVPZcXZYheVJZdY/7VZCo0C9zTvLOxr8j7DJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ih9WpT7m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e05f5ca521so1225853b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707494341; x=1708099141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmU1iVHFMR+KMXCRooeSWvSlFqesJV4w6OG3Cfb/DYA=;
        b=Ih9WpT7myBDsTw1jCpnqGE0Abm0wEd9RUQQPjCsGBaElh0R9MIyqVn1LPzcv9ZNrCo
         7W7i75Reo0LFMMvEJWyTGisjp+fpPTxUsv3/BtEtoIf4WH5rlJ/vMsipamEpE4MqYn0N
         gtfuy/GKlvIDB5ldu0rIIpNqn1qr6JhQxcyP87hVdfTJnZLd+Lo1KVIPylm2rvhkdeGS
         S1JQAi4SrcZQZmEI8ndBLebmKftD4grQTNkD9lgCPEa4w33In1WzS72Opy3RZRW1WHXC
         /RLlvgb/prfQoY681Coz1OYc1fuJ+w7UpHtch3g4e7jcTsSLjjM8RcE4WRrFP3rn3tHE
         iNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494341; x=1708099141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmU1iVHFMR+KMXCRooeSWvSlFqesJV4w6OG3Cfb/DYA=;
        b=C1TAkbceC6pyFKb+Jzw6C6gcvaM4jx1o9U4sxqYb7Tj0JG4kKe66f99P6SDeLll9UH
         SFrG8/nE20VBGe4//oopD2sxt2TzITySr6M5aim0+jfze7an4eWttVvO47dzwuqdbAmh
         HzIGYXHm0R/Mo/Ul1TbM29ESauJg20Rt6XrTImBOVtyHmWsqWRDJ5g9WGq3klzwtJlvR
         E/RpL78DSs+3DZ6TQ0pdyUiKCEPZV+0um729TBaWeiulF1gyFvziL3DGTGU9ohkJ7HnY
         1d0/zQOgdPMmEUg6ZyNvN95z3fKR02YQFoQlCF0iv3J3NRZiiAQAqzCMGS7F3dpqjLgO
         q/Lw==
X-Gm-Message-State: AOJu0YyKM26KAbM1ZgtDtVRBFQ6Fx9MksNI81IwhhrCoP9BmcPXeBT4V
	wdiwYU6rHqhPkW/tnvCpIzFySPc7yhDHpzYgYx2Jmj8wS/6r7tNIuuFbozuCiXcwIc/IGph+NEX
	5jA==
X-Google-Smtp-Source: AGHT+IEqw5iMxlNZ/6HDdmLqiij/UuhrDMLWbn1BX87m/Qwf56HYcCS7HuDzUgtZIkwG2a7Juqlewppc+Dc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:c88:b0:6e0:3e0b:44eb with SMTP id
 a8-20020a056a000c8800b006e03e0b44ebmr132321pfv.3.1707494340657; Fri, 09 Feb
 2024 07:59:00 -0800 (PST)
Date: Fri, 9 Feb 2024 07:58:59 -0800
In-Reply-To: <20240115125707.1183-5-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-5-paul@xen.org>
Message-ID: <ZcZLw1KGje61A9Yl@google.com>
Subject: Re: [PATCH v12 04/20] KVM: pfncache: add a mark-dirty helper
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 15, 2024, Paul Durrant wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7e7fd25b09b3..f3bb9e0a81fe 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1399,6 +1399,17 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
>   */
>  void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>  
> +/**
> + * kvm_gpc_mark_dirty - mark a cached page as dirty.
> + *
> + * @gpc:	   struct gfn_to_pfn_cache object.
> + */
> +static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
> +{
> +	lockdep_assert_held(&gpc->lock);
> +	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);

Can you opportunistically have this pre-check gpc->memslot?  __kvm_gpc_refresh()
should nullify gpc->memslot when using an hva.  That way, you don't need to
explicitly check for the "invalid gfn" case here (or you could, but WARN_ON_ONCE()
if the memslot is non-NULL and the gfn is invalid?).

