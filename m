Return-Path: <linux-kselftest+bounces-46025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DD9C714A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D72E4E335B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53F304BB5;
	Wed, 19 Nov 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAR4JFIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60B2DE6FF;
	Wed, 19 Nov 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591731; cv=none; b=HqpTaUBAdBEqS2B1ceE0d404lL7sfOzkjda1G4MuwCMCdHbkHAIzt8e4S9B+UegNuiS57zThIGc3VlaT2d63oOBlcPStfa6BHU/iz5Myi1Ged15w2atYmm7gI3Uj8tZDeeH7goZ2hFouzEJThDP0zfvVImW5FMLLjeJVfZ8oR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591731; c=relaxed/simple;
	bh=gtkw5I6XWLCtMEVkd6b/QRRhgxON/maxlA2T6Gp457E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqWGiSTInG2ZevjbD4bl227MxFbTah6LtBBCIKr7DzAo9j2WTrN3lLh35KjiHhnMOCzwcdOiF3cgiNbJg/6KyoQaf0cnKB7mnUHkTGjRpjUriAhW6dWZpK6X11dI8xAsGAXOXoCup+6Fmgo04pltv56jX3YJ4BeFJT4+f1mpjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAR4JFIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B44C4CEF5;
	Wed, 19 Nov 2025 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763591731;
	bh=gtkw5I6XWLCtMEVkd6b/QRRhgxON/maxlA2T6Gp457E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAR4JFIl4a1/kGUdxiL57yHPZIlzEkEW8XgXreuOVre+Bs/lhVWxAHSBMjdK/yA6y
	 gnOLQ7W+OQ+/gDOLooBlbD7Ms9P0L4GBSrPLeDt9MgAIIYnleNa/UcWbY8daNMXw4R
	 dCwJLdjN7mpKmGRNQJTzI8rEM2sHtZ6mr2T4XciJCCJR9L0Jo01gVBnKqlMp+QW1YP
	 uFZK6cYd5kkWjLc6gdKbZD86YAbXVwH3yE32bPpXZp2gnlyIMNUry/o6K3bKbRBgsK
	 XyhoZDI/n1NU971WytVE1rbKaDuXkKIXinT0SlmO0g+eYS/1mUQxrJBc08e0EKoP03
	 lsdNz8uIFNiIg==
From: Oliver Upton <oupton@kernel.org>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	Maximilian Dittgen <mdittgen@amazon.de>
Cc: Oliver Upton <oupton@kernel.org>,
	pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	lilitj@amazon.de,
	nh-open-source@amazon.com
Subject: Re: [PATCH v2 1/2] KVM: selftests: Assert GICR_TYPER.Processor_Number matches selftest CPU number
Date: Wed, 19 Nov 2025 14:35:26 -0800
Message-ID: <176359161122.183996.2358688818272311431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119135744.68552-1-mdittgen@amazon.de>
References: <20251114143902.30435-1-mdittgen@amazon.de> <20251119135744.68552-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 14:57:43 +0100, Maximilian Dittgen wrote:
> The selftests GIC library and tests assume that the
> GICR_TYPER.Processor_number associated with a given CPU is the same as
> the CPU's selftest index.
> 
> Since this assumption is not guaranteed by specification, add an assert
> in gicv3_cpu_init() that validates this is true.
> 
> [...]

I did a small cleanup to patch #1 to get rid of open-coded shifts / masks.

Please new versions of a series as a separate thread, using a cover letter
for anything more than a single patch. This is helpful for tracking patches
on my end.

Applied to next, thanks!

[1/2] KVM: selftests: Assert GICR_TYPER.Processor_Number matches selftest CPU number
      https://git.kernel.org/kvmarm/kvmarm/c/31df012da496
[2/2] KVM: selftests: SYNC after guest ITS setup in vgic_lpi_stress
      https://git.kernel.org/kvmarm/kvmarm/c/85f329df2931

--
Best,
Oliver

