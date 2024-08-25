Return-Path: <linux-kselftest+bounces-16225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C910295E465
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE6FB21029
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395D14F9D7;
	Sun, 25 Aug 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWjZdXuR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9412B94;
	Sun, 25 Aug 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724604400; cv=none; b=nSl6yKVgPCPFkKp8hwVVuwdNGuyURsZo/JSf76Q3zhgpOkmvUSllbScwtPEsEUYNT89dwKIeGxotzAVs9Uj08foXXNNprgDuO7/FDCct/FqKb2x7uINYEydwAzNx5snxMEFZnGVqzvEpFnFHyHCqehTE7/G8CtuDXFMeVpQgZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724604400; c=relaxed/simple;
	bh=ZoCeY/nGvicUbwynsgEk0MCHr1pxhUGttHarltMd2SI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlnMOJ3eU3WmFt6hRi6Wy0gD4+YW/iJG4zqR/GAlnrxcqZ4Nue+g6XbUrtHxRZ3vYzPkylLEoE+KKPGzN9LxbHjgZS3sfEEhVI6zXlfdwfW/HVW3/xwrV5WxWrqm54TKALNMZf7hkOZlWiLQw0Ady0rJ2hJE8ql9Um9N5tEt5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWjZdXuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFF9C32782;
	Sun, 25 Aug 2024 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724604399;
	bh=ZoCeY/nGvicUbwynsgEk0MCHr1pxhUGttHarltMd2SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWjZdXuRTUyYB1URlqmOJ/zJYqVlPvVMAya7LMyigSuhG2hAdd1DGwLhYeH+2U/S/
	 Upi5M5VQjSixDrsUeuHA5EKmkUQhqJpI0tVzgNwEO90OnBxPe+65VtWjF3tWmXQGDB
	 4pt8JtXX9u4392jHkqXvv5jXHBFB0LZ+yPDekmuLoUmKwvnskdy8XQxb2aeyq6rR/+
	 0/xCsSKjpzkDieAxLxJE1CLtkTHOpW+FVVGBQavEp8cPvICv+6Q3bb/504Iwohvj+g
	 RtuMRRfJg8g0UERzMqCOdGB7gwU88nL53a21o606rFVfdsvDP/WvrBrtt6hvaTlJbP
	 9W/uF2g2BKCSw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1siGNx-006hAo-54;
	Sun, 25 Aug 2024 17:46:37 +0100
Date: Sun, 25 Aug 2024 17:46:36 +0100
Message-ID: <86ttf8wnwz.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	kvmarm@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v5 0/4] Allow userspace to change ID_AA64PFR1_EL1
In-Reply-To: <20240723072004.1470688-1-shahuang@redhat.com>
References: <20240723072004.1470688-1-shahuang@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: shahuang@redhat.com, oliver.upton@linux.dev, kvmarm@lists.linux.dev, broonie@kernel.org, eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, catalin.marinas@arm.com, james.morse@arm.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 23 Jul 2024 08:19:59 +0100,
Shaoqin Huang <shahuang@redhat.com> wrote:
> 
> Hi guys,
> 
> This is another try to allow userspace to change ID_AA64PFR1_EL1, and we want to
> give userspace the ability to control the visible feature set for a VM, which
> could be used by userspace in such a way to transparently migrate VMs.


I think this looks OK now, thanks for going through the motions and
doing the right thing.

What is missing is similar handling for 32bit ID registers, but I'm
not sure we keen on going down that road -- machines capable of
running those are on their way out. This can be done later anyway,
should anyone care.

>
> The patch series have four part:
> 
> The first patch disable those fields which KVM doesn't know how to handle, so
> KVM will only expose value 0 of those fields to the guest.
> 
> The second patch check the FEAT_SSBS in guest IDREG instead of the cpu
> capability.
> 
> The third patch allow userspace to change ID_AA64PFR1_EL1, it only advertise the
> fields known to KVM and leave others unadvertise.
> 
> The fourth patch adds the kselftest to test if userspace can change the
> ID_AA64PFR1_EL1.
> 
> Besides, I also noticed there is another patch [1] which try to make the
> ID_AA64PFR1_EL1 writable. This patch [1] is try to enable GCS on baremental, and
> add GCS support for the guest. What I understand is if we have GCS support on
> baremental, it will be clear to how to handle them in KVM. And same for other
> fields like NMI, THE, DF2, MTEX.. At that time, they can be
> writable.

I expect that Broonie would look into this as part of his series.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

