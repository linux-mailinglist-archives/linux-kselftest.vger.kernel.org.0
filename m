Return-Path: <linux-kselftest+bounces-44433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C4C212E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448331A22D57
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C863678D9;
	Thu, 30 Oct 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiBhWSPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F73678C9;
	Thu, 30 Oct 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841402; cv=none; b=rFPl+wPEfNiTnce8k6kH5x5FuJ6PPj93Cp/nB1fZTw0CbIPfCuAHeb3c7zjWxK5SUUH9bjScU+5EAuU1X11iP3oQiQqdXDC6MVGXoUFB6Q/Cyy1/Rz5xhfyDbrlptqCiPC/EPGbUnDf2+9UdO91vWbTxbELdTHrtX/NTYiEgw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841402; c=relaxed/simple;
	bh=3mVsFGRun4oAv1HOPwIwD87Ig8SOJjYpKQmEns43giI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opm9dkkZe5PwNEuxtumdsUTcjWrbn9k6LbHQB9cuCHxm/INdBc+4oNl5G4cGS1DtHED0zoNP++OApCPS/D1Y7zx8bCbtH7Gwyg7UyrxvI5VbEkyhjwlnRDWFK5epL2rzbfzToWPQwQJvCM5pie309hxM0hdzG+B5V4Pv5v4PG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiBhWSPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40339C4CEF8;
	Thu, 30 Oct 2025 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841401;
	bh=3mVsFGRun4oAv1HOPwIwD87Ig8SOJjYpKQmEns43giI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiBhWSPLCAflTXcjYiLkGgfxYC0FbDSyKDcmjufpBBBTgkzj48TmUwH88BC89j6ac
	 o0E9JagAXeECXemcuookI8berrAYWgUQVoXCpi2DbplEgmuhllFALmby5liZ9gsfm6
	 +C9kdgNU1wnrf6iwWgoVz/0rCZknIDHdUObAnlxTAXxh3c+UeAAkSuP4s2B2bkipqj
	 rRPIZVwmV8avDeeoqs1G+Rn/nVn6aDRMtvn6PCosvufatZgN25l5slp0DhyionzZfB
	 MloNM8tswWnBE2uzph0RfHjpZf+quZdttcxPTMTMwi4ht9hsmaEUdLMSpOhAnVzZZK
	 UKG7x9MJUrH9w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vEVQl-0000000139m-0ABi;
	Thu, 30 Oct 2025 16:23:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: oliver.upton@linux.dev,
	Maximilian Dittgen <mdittgen@amazon.de>
Cc: pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	epetron@amazon.de,
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stress
Date: Thu, 30 Oct 2025 16:23:16 +0000
Message-ID: <176184139607.2037623.16277571869059317798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020145946.48288-1-mdittgen@amazon.de>
References: <20251020145946.48288-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, mdittgen@amazon.de, pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, epetron@amazon.de, nh-open-source@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 20 Oct 2025 16:59:46 +0200, Maximilian Dittgen wrote:
> Since GITS_TYPER.PTA == 0, the ITS MAPC command demands a CPU ID,
> rather than a physical redistributor address, for its RDbase
> command argument.
> 
> As such, when MAPC-ing guest ITS collections, vgic_lpi_stress iterates
> over CPU IDs in the range [0, nr_cpus), passing them as the RDbase
> vcpu_id argument to its_send_mapc_cmd().
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stress
      commit: a24f7afce048e724be072bd063ed864f124daf81

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



