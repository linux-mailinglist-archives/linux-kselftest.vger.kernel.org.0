Return-Path: <linux-kselftest+bounces-9462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27C8BB9D9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6AA28357D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAD1097B;
	Sat,  4 May 2024 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8777W4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06636FC7
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714808656; cv=none; b=HmMU5Yi2c7HvlY12xOCDUtrR3mKinOsD+/npr3NHsIZN6cWaN0sZMrR1TRgIvYUkY8SbdXWVj60J7lx1gLzYTOoFoF6Zorl+f1soTqkRoDWMTwiNFfQGwKnHADyWSUf/Cbia66rUQpXdUIg8XuW7pBdFMkCM8Vj1WXbugMum5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714808656; c=relaxed/simple;
	bh=+CN3pnC6QWhowtu4+MVaqdx3fIV2fqPHQVc21m9r/bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRXR8AkSat1PinDRA7ayEk8ZCSQfqqq9R/8TB17EYE7fGx7uqB6az9RqPohWWAqX2BuAfXwWYAnNQVW0aamIlrxI7F9HraQcTARa/EBPUH0cqk6ZFl6jEHJXXTTpbCmxUP/uVBfZMm9/L/wMLnx0EwCn+JSRZepY9witv1Z0BUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8777W4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714808653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xU5umL+P+Q+gcA8Y/3yX0AYaEr9mECnJdAoU1QaQSxw=;
	b=M8777W4cx/hrBegz2cDTWtlgpyJ1vJ+w5abWjFSBhYxeINYokf2HWtQ18qxoqpgMWIh0K4
	AfDEiqz11sYbdBqR03DiAEGbF1NdVqPlrLHeaPHld+4O0dRK2WldjGr2xkSyUKPh+Rf11C
	kLz7VVYkBe5dStbHhBMDlI5T6Rn9xh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-mQE3_v7uMwijUuGdmrozOg-1; Sat, 04 May 2024 03:44:09 -0400
X-MC-Unique: mQE3_v7uMwijUuGdmrozOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053D11005055;
	Sat,  4 May 2024 07:44:08 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA31AC6B;
	Sat,  4 May 2024 07:44:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 5469F400DF404; Sat,  4 May 2024 04:42:47 -0300 (-03)
Date: Sat, 4 May 2024 04:42:47 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>, jalliste@amazon.co.uk,
	sveith@amazon.de, zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH v2 01/15] KVM: x86/xen: Do not corrupt KVM clock in
 kvm_xen_shared_info_init()
Message-ID: <ZjXm9w/y3/NLCxLQ@tpad>
References: <20240427111929.9600-1-dwmw2@infradead.org>
 <20240427111929.9600-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427111929.9600-2-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sat, Apr 27, 2024 at 12:04:58PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The KVM clock is an interesting thing. It is defined as "nanoseconds
> since the guest was created", but in practice it runs at two *different*
> rates — or three different rates, if you count implementation bugs.
> 
> Definition A is that it runs synchronously with the CLOCK_MONOTONIC_RAW
> of the host, with a delta of kvm->arch.kvmclock_offset.
> 
> But that version doesn't actually get used in the common case, where the
> host has a reliable TSC and the guest TSCs are all running at the same
> rate and in sync with each other, and kvm->arch.use_master_clock is set.
> 
> In that common case, definition B is used: There is a reference point in
> time at kvm->arch.master_kernel_ns (again a CLOCK_MONOTONIC_RAW time),
> and a corresponding host TSC value kvm->arch.master_cycle_now. This
> fixed point in time is converted to guest units (the time offset by
> kvmclock_offset and the TSC Value scaled and offset to be a guest TSC
> value) and advertised to the guest in the pvclock structure. While in
> this 'use_master_clock' mode, the fixed point in time never needs to be
> changed, and the clock runs precisely in time with the guest TSC, at the
> rate advertised in the pvclock structure.
> 
> The third definition C is implemented in kvm_get_wall_clock_epoch() and
> __get_kvmclock(), using the master_cycle_now and master_kernel_ns fields
> but converting the *host* TSC cycles directly to a value in nanoseconds
> instead of scaling via the guest TSC.
> 
> One might naïvely think that all three definitions are identical, since
> CLOCK_MONOTONIC_RAW is not skewed by NTP frequency corrections; all
> three are just the result of counting the host TSC at a known frequency,
> or the scaled guest TSC at a known precise fraction of the host's
> frequency. The problem is with arithmetic precision, and the way that
> frequency scaling is done in a division-free way by multiplying by a
> scale factor, then shifting right. In practice, all three ways of
> calculating the KVM clock will suffer a systemic drift from each other.
> 
> Eventually, definition C should just be eliminated. Commit 451a707813ae
> ("KVM: x86/xen: improve accuracy of Xen timers") worked around it for
> the specific case of Xen timers, which are defined in terms of the KVM
> clock and suffered from a continually increasing error in timer expiry
> times. That commit notes that get_kvmclock_ns() is non-trivial to fix
> and says "I'll come back to that", which remains true.
> 
> Definitions A and B do need to coexist, the former to handle the case
> where the host or guest TSC is suboptimally configured. But KVM should
> be more careful about switching between them, and the discontinuity in
> guest time which could result.
> 
> In particular, KVM_REQ_MASTERCLOCK_UPDATE will take a new snapshot of
> time as the reference in master_kernel_ns and master_cycle_now, yanking
> the guest's clock back to match definition A at that moment.

KVM_REQ_MASTERCLOCK_UPDATE stops the vcpus because:

 * To avoid that problem, do not allow visibility of distinct
 * system_timestamp/tsc_timestamp values simultaneously: use a master
 * copy of host monotonic time values. Update that master copy
 * in lockstep.

> When invoked from in 'use_master_clock' mode, kvm_update_masterclock()
> should probably *adjust* kvm->arch.kvmclock_offset to account for the
> drift, instead of yanking the clock back to defintion A.

You are likely correct...

> But in the meantime there are a bunch of places where it just doesn't need to be
> invoked at all.
> 
> To start with: there is no need to do such an update when a Xen guest
> populates the shared_info page. This seems to have been a hangover from
> the very first implementation of shared_info which automatically
> populated the vcpu_info structures at their default locations, but even
> then it should just have raised KVM_REQ_CLOCK_UPDATE on each vCPU
> instead of using KVM_REQ_MASTERCLOCK_UPDATE. And now that userspace is
> expected to explicitly set the vcpu_info even in its default locations,
> there's not even any need for that either.
> 
> Fixes: 629b5348841a1 ("KVM: x86/xen: update wallclock region")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---
>  arch/x86/kvm/xen.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index f65b35a05d91..5a83a8154b79 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -98,8 +98,6 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
>  	wc->version = wc_version + 1;
>  	read_unlock_irq(&gpc->lock);
>  
> -	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
> -
>  out:
>  	srcu_read_unlock(&kvm->srcu, idx);
>  	return ret;
> -- 
> 2.44.0

So KVM_REQ_MASTERCLOCK_UPDATE is to avoid the race above.

In what contexes is kvm_xen_shared_info_init called from again?

Not clear to me KVM_REQ_MASTERCLOCK_UPDATE is not needed (or that is
needed, for that matter...).



