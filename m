Return-Path: <linux-kselftest+bounces-14711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A5C945EC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895161C2115C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D151E3CD9;
	Fri,  2 Aug 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZvQQuGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB788A31;
	Fri,  2 Aug 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605777; cv=none; b=WdwNnFtgQQhq/ZKHzxG56denjWqe1VuIAfjtcaeRWt+IvdEX7eGcVXQdw/j8jqnAT/ise+m46f5mo4ZM4fpYVTcIZ04ja8KnURG/ogWcqGnswMxmZl+8/rpGjYGOQ+P3Y7Xcjb5/tPU7JUiC0+XOJ7IN5iyX+Q3pdkQ72Wgq67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605777; c=relaxed/simple;
	bh=8StiAuH5ByNU4EjrPJTT/7UntXVKMxJ7YxtTnvcEyxg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/zlSxutmFlR1T2XUumjv8/QslXg3CAJxccXD+GpmAnM5YVwaB+tlUPU4v/JWFfmK6nTCFQXetGKuTd8NiyqrQKIlBndHlhWKeB+dV3qjxh6JvNWZdvntCbAFtlINPHlUTJX0RIHaZty9rLqX3qjxQUMg1F8aiQVp5Hec66vOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZvQQuGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56126C32782;
	Fri,  2 Aug 2024 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722605777;
	bh=8StiAuH5ByNU4EjrPJTT/7UntXVKMxJ7YxtTnvcEyxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LZvQQuGTvIpiS6crUIO6ngLx9lQpIgRiX6EUnj67z9YoAk3ZcDc4YZSh5pa0bJrEA
	 lsz5MvNfhcepkkPfA/pPSA8++iZDuHdD39m+/Zdo+8oAzBKsMuk5/ADyk/tVT1x9HD
	 UrOpP/ape23k0SGgK1PBIIdsTeqkjs8iJGMa8t+6Amgj4voukcZXv+iUX2xoLH0JT0
	 3OSIEcOqy1Vzoa0l791XIl7L4L8E8xULmAYLbAmDiuur8o1rz3wxgdA9zquKEaXMNV
	 pPo5YeXizEfmMhryhc1IBY7e30XYTZYtvzERg/Lss31EbRXrdoPWQi1UpGjqCWluKe
	 nvevFkc3EiipA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sZsS7-000APR-1H;
	Fri, 02 Aug 2024 14:36:15 +0100
Date: Fri, 02 Aug 2024 14:36:14 +0100
Message-ID: <86a5hv11yp.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list
In-Reply-To: <7b9b3ef4-66da-4314-8265-5947998758e9@sirena.org.uk>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
	<86le1g19aa.wl-maz@kernel.org>
	<811ea0eb-bc87-4ac3-8bca-27c787e43051@sirena.org.uk>
	<86jzgz1eqb.wl-maz@kernel.org>
	<7b9b3ef4-66da-4314-8265-5947998758e9@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com, shuah@kernel.org, catalin.marinas@arm.com, joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 02 Aug 2024 13:43:03 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Fri, Aug 02, 2024 at 10:00:28AM +0100, Marc Zyngier wrote:
> 
> > Also, the test predates the generated stuff by some margin.
> 
> Yeah, there were still defines in the main kernel source that were being
> retyped rather than shared previously which made me wonder.

Definitions in the kernel are likely to exist for a long time though,
as the tool is still pretty primitive and doesn't handle anything that
changes layout (such as any register affected by E2H).

> 
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > I'd certainly be happy to convert, though that does
> > > seem a bit invasive for a fix.
> 
> > Not for a point fix, for sure. And if you do, make sure it is entirely
> > scripted.
> 
> When you say "entirely scripted" here I take it you're referring to the
> list of registers as well, and I guess also to the information about
> what is enumerated by which ID register values?

The register list is indeed the #1 offender, and that should just be a
script that goes over all the occurrences of ARM64_SYS_REG() and
replace the encoding with something that uses the symbolic name.

For the rest (shifts and stuff), we can probably do that by hand
(there are only a few occurrences).

	M.

-- 
Without deviation from the norm, progress is not possible.

