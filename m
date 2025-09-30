Return-Path: <linux-kselftest+bounces-42643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FDBAE4E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6881941F33
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08523D7FC;
	Tue, 30 Sep 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GjjgyAaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6B238C29;
	Tue, 30 Sep 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256806; cv=none; b=ihJRZo4Qm8ThhBjqVaBtsI3ZhpDB2E0AOUVB69jYAlbSuoDNNFozCv2REboEGXvD1OJR5BGQnoapU8p4SSRoGKrji3NYXisN/4/f7fq+9ByHk9va+Drh06nZ3S9aqTBegAGmAj/gneDQcdyqG9g2Tciu+829jIO8CE3SvI8FuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256806; c=relaxed/simple;
	bh=+w01cPD8O7eVtrUVh5g80tOvUnjgLfFSA6SKM9O5mws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA1DFvp/M/u5EnvN9at+YpFUBSCZeEXiuiTEtf+9cYYFTXGCHdHjRxKo/6kUaPfbNMfoB988B9rdnS6iaY8OYoUyP/hLpeV9HSONyS7k4Ca+Bi/+fJgchcY33K6IML3ifWZyB4NAWaY5AYLIImKcjy69VsfGX2g4irMdoS60ZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GjjgyAaz; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Sep 2025 11:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759256792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhHKw0pzbDR46tJQI3Ux7WnL7dk0DaLdajKaS7DX6zc=;
	b=GjjgyAazbsEJtaL+j8NcYbztIem62zUYAZjrq0N8tPvGiuU3ASmE3dksu8/GbO27YOTshJ
	OujF0QeeXZG94FcxFbyLqi6RiO+Mq0eIVsBOYad0wXAu93UJ5caYmvK4ccHnOYCCXp31sQ
	raDWQ5Cdjlpna+Uq9IUmalwI/7BNNUY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
Message-ID: <aNwgyhZO0BXQVExn@linux.dev>
References: <20250825155203.71989-1-sebott@redhat.com>
 <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org>
 <aKzRgp58vU6h02n6@google.com>
 <aKzX152737nAo479@linux.dev>
 <aK4CJnNxB6omPufp@google.com>
 <aK4J5EA10ufKJZsU@linux.dev>
 <aK4cAPeGgy0kXY98@google.com>
 <aNvzy5-lj3TBLT3I@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvzy5-lj3TBLT3I@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 30, 2025 at 08:14:19AM -0700, Sean Christopherson wrote:
> > What about providing an API to do exactly that, instantiate and initialize a
> > barebones GIC?  E.g.
> > 
> > 	void kvm_arch_init_barebones_irqchip(struct kvm_vm *vm)
> > 
> > Hmm, then we'd also need
> > 
> > 	void kvm_arch_vm_free(struct kvm_vm *vm)
> > 
> > to gracefully free the GIC, as done by dirty_log_perf_test.c.  Blech.  Though
> > maybe we'll end up with that hook sooner or later?
> > 
> > All in all, I have no strong preference at this point.
> 
> Oliver, any thoughts?  This is causing noise in people's CIs, i.e. we should land
> a fix sooner than later, even if it's not the "final" form. 

The lack of a default VGICv3 wound up getting in my way with some
changes to promote selftests to run in VHE EL2, cc'ed you on that series
since I wound up walking back my gripes here :)

  https://lore.kernel.org/kvmarm/20250917212044.294760-1-oliver.upton@linux.dev/a

That's now in Paolo's tree as of this morning. With that said, I think
irqfd_test needs a bit more attention (below).

Thanks,
Oliver

From 4d0a035fb7e6cead74af4edb24fbcfdec076d321 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Tue, 30 Sep 2025 10:53:14 -0700
Subject: [PATCH] KVM: selftests: Fix irqfd_test for non-x86 architectures

The KVM_IRQFD ioctl fails if no irqchip is present in-kernel, which
isn't too surprising as there's not much KVM can do for an IRQ if it
cannot resolve a destination.

As written the irqfd_test assumes that a 'default' VM created in
selftests has an in-kernel irqchip created implicitly. That may be the
case on x86 but it isn't necessarily true on other architectures.

Add an arch predicate indicating if 'default' VMs get an irqchip and
make the irqfd_test depend on it. Work around arm64 VGIC initialization
requirements by using vm_create_with_one_vcpu(), ignoring the created
vCPU as it isn't used for the test.

Fixes: 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify uniqueness requirements")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/include/kvm_util.h    |  2 ++
 tools/testing/selftests/kvm/irqfd_test.c          | 14 +++++++++++---
 tools/testing/selftests/kvm/lib/arm64/processor.c |  5 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c        |  5 +++++
 tools/testing/selftests/kvm/lib/s390/processor.c  |  5 +++++
 tools/testing/selftests/kvm/lib/x86/processor.c   |  5 +++++
 6 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 11b6c5aa3f12..8f23362f59fa 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1268,4 +1268,6 @@ bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
 
 uint32_t guest_get_vcpuid(void);
 
+bool kvm_arch_has_default_irqchip(void);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/irqfd_test.c b/tools/testing/selftests/kvm/irqfd_test.c
index 7c301b4c7005..5d7590d01868 100644
--- a/tools/testing/selftests/kvm/irqfd_test.c
+++ b/tools/testing/selftests/kvm/irqfd_test.c
@@ -89,11 +89,19 @@ static void juggle_eventfd_primary(struct kvm_vm *vm, int eventfd)
 int main(int argc, char *argv[])
 {
 	pthread_t racing_thread;
+	struct kvm_vcpu *unused;
 	int r, i;
 
-	/* Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. */
-	vm1 = vm_create(1);
-	vm2 = vm_create(1);
+	TEST_REQUIRE(kvm_arch_has_default_irqchip());
+
+	/*
+	 * Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. Also
+	 * create an unused vCPU as certain architectures (like arm64) need to
+	 * complete IRQ chip initialization after all possible vCPUs for a VM
+	 * have been created.
+	 */
+	vm1 = vm_create_with_one_vcpu(&unused, NULL);
+	vm2 = vm_create_with_one_vcpu(&unused, NULL);
 
 	WRITE_ONCE(__eventfd, kvm_new_eventfd());
 
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 369a4c87dd8f..54f6d17c78f7 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -725,3 +725,8 @@ void kvm_arch_vm_release(struct kvm_vm *vm)
 	if (vm->arch.has_gic)
 		close(vm->arch.gic_fd);
 }
+
+bool kvm_arch_has_default_irqchip(void)
+{
+	return request_vgic && kvm_supports_vgic_v3();
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 67f32d41a59c..40d0252f146f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2374,3 +2374,8 @@ bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr)
 	pg = paddr >> vm->page_shift;
 	return sparsebit_is_set(region->protected_phy_pages, pg);
 }
+
+__weak bool kvm_arch_has_default_irqchip(void)
+{
+	return false;
+}
diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index 20cfe970e3e3..8ceeb17c819a 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -221,3 +221,8 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+bool kvm_arch_has_default_irqchip(void)
+{
+	return true;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index bff75aa341bf..0d3cfb9e9c3c 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1281,3 +1281,8 @@ bool sys_clocksource_is_based_on_tsc(void)
 
 	return ret;
 }
+
+bool kvm_arch_has_default_irqchip(void)
+{
+	return true;
+}

base-commit: 10fd0285305d0b48e8a3bf15d4f17fc4f3d68cb6
-- 
2.39.5


