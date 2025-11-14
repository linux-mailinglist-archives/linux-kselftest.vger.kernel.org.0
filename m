Return-Path: <linux-kselftest+bounces-45673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB721C5F3C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869683B2DD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E5342536;
	Fri, 14 Nov 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pikUzbE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBB33C530;
	Fri, 14 Nov 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151977; cv=none; b=sZ1pJ9j5OOn9r3M82uHhTklcTL8qGAfC2FbD8L7dNGNVv1VlO7P+VgfINDK2uaPv+0YvfjlZp5PZlkFgy2khi9z9q5IYfdqeaPJWzsWy7FZZHwbuXDwdxrxlAMPZ55gh94lbUjHdJ7oebLBmpdHCs10IpYUQk4FGRFJ4uB2SeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151977; c=relaxed/simple;
	bh=tbNTfMOZpk52rvNK4qNcSo5qJBKRDs2L51DIQLpStus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSHjRbIwsX6jBbQd6t+tVPqur9eWV5h4McM8lD0/OcKWsR+cQgSArOF2xu30qNTFw58UWduKocytX/tsX8iVinZERisO8oZKhzBSdpyZztS9aUTXIFeQzMncHtBKBKV7fI6xIJIo1fmjPZ4AlprPzEo/yGBok3bPmPQI8xz7NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pikUzbE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA42C4CEF1;
	Fri, 14 Nov 2025 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763151976;
	bh=tbNTfMOZpk52rvNK4qNcSo5qJBKRDs2L51DIQLpStus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pikUzbE4Uil0KhxIF//+6qKeX+A9yajj87UnySF61nV2S5wxP8oOhZr0GyFJCedhm
	 yiTZHUgb9GNy0S+Kd2r/nU7UpCssa6Ps/hpqQSgTeNl475I21XzpkvjLTXe35HMdTJ
	 EZgeCcVo5PnXVTnCHYY+Ej979HdnciAgvWAtNtAQm6Mu8djq3Hb2tTuH/LKbVo0xmJ
	 zFDVFmVu3sq3GIXxf5ZRLFAlP0Hhk1+bmVF7AGG1UrohSNdbgBOFkQbn4zIZOQAIbo
	 PXNGMNguqKyYvQAVc8NA9m2R+CdCaAoVgQkrb2EgX9NTI6CwbvYx03cDR3SydFSRBV
	 BTSfRQSKr0Mdw==
Date: Fri, 14 Nov 2025 12:26:15 -0800
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Maximilian Dittgen <mdittgen@amazon.de>, oliver.upton@linux.dev,
	pbonzini@redhat.com, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	lilitj@amazon.de, nh-open-source@amazon.com
Subject: Re: [PATCH] KVM: selftests: Add SYNC after guest ITS setup in
 vgic_lpi_stress
Message-ID: <aReQZ7VCOMYv9I7G@kernel.org>
References: <20251114143902.30435-1-mdittgen@amazon.de>
 <86bjl4tyc9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjl4tyc9.wl-maz@kernel.org>

On Fri, Nov 14, 2025 at 03:42:30PM +0000, Marc Zyngier wrote:
> On Fri, 14 Nov 2025 14:39:02 +0000,
> Maximilian Dittgen <mdittgen@amazon.de> wrote:
> > diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
> > index 687d04463983..e857a605f577 100644
> > --- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
> > +++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
> > @@ -118,6 +118,10 @@ static void guest_setup_gic(void)
> >  
> >  	guest_setup_its_mappings();
> >  	guest_invalidate_all_rdists();
> > +
> > +	/* SYNC to ensure ITS setup is complete */
> > +	for (cpuid = 0; cpuid < test_data.nr_cpus; cpuid++)
> > +		its_send_sync_cmd(test_data.cmdq_base_va, cpuid);
> 
> You are making an implementation assumption here. There is nothing in
> the spec that says that the GICR_TYPER.Processor_Number associated
> with a given CPU is the same thing as the CPU number that the
> selftests infrastructure give you.

This is already rather widely assumed in the selftests GIC library as
well as this test (ex. guest_invalidate_all_rdists()). I'd be happy with
an assertion in gicv3_cpu_init() that ensures
GICR_TYPER.Processor_Number == cpu.

Thanks,
Oliver

