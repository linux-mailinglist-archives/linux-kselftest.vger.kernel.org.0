Return-Path: <linux-kselftest+bounces-4453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8284F90D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823D81F25D3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD676042;
	Fri,  9 Feb 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4EplVMy4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB667E83
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494501; cv=none; b=Rxf1lOZ4S0dQF6JJUItnevfW3IL4zfQaIjDIrxF8LgCkNK0YeM7kPcJTX3KUxOG74BJEnt9tS6aH7wsmpKo1Kc1bpfxJcTnvb0GyJ01cTEbCGrQg6AIIvPTM2fMuamm7beR6+EE8YmrnEi7lyoafsKMnomdpT8uM8Xt6iR9c8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494501; c=relaxed/simple;
	bh=A0ppvdAEssQ0RgSYaqSvMhcfnozN/meETnSjtqFC/tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCyKez1zsIFaiOK6AUnh8ZZVroz3FjvHQjIclfKieAERV7iChNZI6dnHYXc+ikk9CC3oMTT5UAHP5YffRWp6ay6+/Ht0Fmrn8VcKpbXu5t1jPcx+xL7pHr/QD7uUdCcZEzh46anXBFyvHJPQXCIDdOs8S+/OKqzYFc8h7kcMpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4EplVMy4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso946135a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707494500; x=1708099300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbkXeYUaDBncgeOsZac9v7h/OYs9uDYhnmPMW2APu84=;
        b=4EplVMy4iyA5l3qKCK/51jsJKeEElOoEZRUasbbSiG0izQEILpQOILYbxCQzAKKLPc
         LD1RbJI5dGagCBD4yMfXdUG4O3ObMeVnfKoxoolzEKS5CAPsat2yW1TBqLdRPsViIKHA
         ez6NA5PGp4106LAXXHcANhSdGE8fPcwpQMCyH/7wzrBRhBXPr1IRveSt+LwahkOKPvgr
         RzpfGqqZ7GP/Qir5+oeir3f40HP10hFCbkfb3cfCwtIiPZzQEiC8Akqqx5hPceMgFqpd
         yvDOOIHC5YaGOYJZ/1fclQIOfnq3umsuS/GpBsdchhcmNRW6HT6STIEZ6IxitEX1KyLa
         qA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494500; x=1708099300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbkXeYUaDBncgeOsZac9v7h/OYs9uDYhnmPMW2APu84=;
        b=BDH7ZE2c5XcJENVgBsiaJkIWt4HvDpfC25B2QL8XHlEuybW94Qd14DKh625RiyvvTi
         BlvoDbkHVn49Qtd71l/+Kl9CFpmUwPQobe7r1NHKDiLFOT/+xxNwCYo2xcVad6WRzBIl
         XH/QEaE/g9/XnlNrbI1xWaXUFO5zJ0H4vqqDhJ4anNH6rqZLCj1P0xMo2sA8QTcjOjla
         r60GbaZxOEcFNMSXgZpTXzeRQ3Di5askI4atGbhPHhGRKJ6mGmI6kEqEs9A5QczNS3In
         O4IA75zTzIZcgGzCoOFhkRUUAe393AhM89AuXTXGFfhsX2RYJityqOOrArx2Plk58/1b
         +wpw==
X-Gm-Message-State: AOJu0Yy7GrWpM8jHhb075ek/VYVQnjD4J+D4bU2nasn0cgWXZ8aH6PWk
	memM1R4ba/G4oCc6JjWwmW+JLzN/RRHOmB+DqSvuXZQzgfWL3xiV1OX2XPCgHGBizoXXJM16Ox/
	YMQ==
X-Google-Smtp-Source: AGHT+IEyKu+Do4l97DjvOFOUv97OY0Nhkddwujr8IqjGCIn2IxgeG40+kn6W+CdStGVDgL7zUYgHlJTuOeI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6e8e:0:b0:5d8:cd91:44e4 with SMTP id
 bm14-20020a656e8e000000b005d8cd9144e4mr5426pgb.12.1707494499773; Fri, 09 Feb
 2024 08:01:39 -0800 (PST)
Date: Fri, 9 Feb 2024 08:01:38 -0800
In-Reply-To: <a2cfad68277cae67791f07646c842672593a8dca.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-12-paul@xen.org>
 <ZcMCogbbVKuTIXWJ@google.com> <92918ee8-3cc9-41c3-a284-5cd6648abc05@xen.org>
 <ZcUF-TNbykWvh3r7@google.com> <148d903c-fcc5-4a6a-aef1-c1e77e74d0fc@xen.org> <a2cfad68277cae67791f07646c842672593a8dca.camel@infradead.org>
Message-ID: <ZcZMYrM_A7UAVIJv@google.com>
Subject: Re: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by
 fixed HVA
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: paul@xen.org, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 08, 2024, David Woodhouse wrote:
> Using anything except NULL as the "no value" value doesn't make sense
> to me. It violates the principle of least surprise and would be a
> really bad API.

I'm a-ok with using '0'.  My only request is to check for "!hva" as opposed to
"hva == 0", both because that's preferred kernel style, and because it better
conveys that it's really checking for !NULL as opposed to address '0'.

Side topic, I think the code will end up in a more readable state if the GFN vs.
HVA sub-commands are handled in separate case statements, especially if/when
xen_lock goes away.  E.g. something like this:

	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
		int idx;

		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
			r = 0;
			break;
		}

		idx = srcu_read_lock(&kvm->srcu);
		r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
				     gfn_to_gpa(data->u.shared_info.gfn), PAGE_SIZE);
		if (!r && kvm->arch.xen.shinfo_cache.active)
			r = kvm_xen_shared_info_init(kvm);
		srcu_read_unlock(&kvm->srcu, idx);
		break;
	}

	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
		unsigned long hva = data->u.shared_info.hva;

		if (hva != untagged_addr(hva) || !access_ok((void __user *)hva) ||
		    !PAGE_ALIGNED(hva)) {
			r = -EINVAL;
			break;
		}

		if (!hva) {
			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
			r = 0;
			break;
		}
		r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache, hva, PAGE_SIZE);
		if (!r && kvm->arch.xen.shinfo_cache.active)
			r = kvm_xen_shared_info_init(kvm);
		break;
	}

Side topic #2, the above requires that __kvm_gpc_refresh() not grab kvm_memslots()
in the "using an hva" path, but I think that'd actually be a good thing as it
would make it a bit more clear that using an hva bypasses memslots by design.

