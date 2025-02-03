Return-Path: <linux-kselftest+bounces-25603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38CBA265CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710B6188674F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F2211495;
	Mon,  3 Feb 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmDEtDXn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39755211292
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618647; cv=none; b=SguMHKlHqKkhEtdRtb0VW+CLrPrFHIXCW/fHosb9gp/uyjhWDU3e2MQjeIhwg3FWomjxF2QxwSiMJww8Ki8zp9eB6/cSvNfB7J3F/56MOwNNUvbauPTXZ7nUvntDcI18h5mgpNJu6bmmKthbRjJd+Te7KeC/coe57vgYdqwC0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618647; c=relaxed/simple;
	bh=QLnx4/Rgy7zQOoI/TasPwiI6+hjEJs/e68fuOcK9rGs=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GfU9c5uTcbxuR7SfyLMFK0PY0JuBj8EfcjHzI2FsZLI0wTx3GyeQMvhg2qhGZDi+n5NsO0dO6vbeYspNRpz0cQ6yghhKpZwtdpQ5yq31rGnc4QjC09+doO5PL2a/QgbypG2YDnZHUXoaXUxDvT0DfnfLEv1Bw0LIZBkNd9bvHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmDEtDXn; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3cfe0ce0dbbso70985505ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 13:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738618645; x=1739223445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XEqP/YEsjQP6HXPcAZ+OLL0SnqZRyU2wi8fLU4Seg48=;
        b=qmDEtDXnc+drZ2rBsx5VwzDTo8GAidumBDsj/exrwP3oPPPzqsVXCuGF68aWe3gD+9
         fzEtf1YGvJojJQm6s9piBShclKbrI+4Jgs6yCx65MwpwhX5+dVpgfCWWVppr6fdpRsCo
         RvX2A9Q2z5mplQVC1RKXwMyBzd2Hya9FENjOS/qMpJqcodTv41OfSqA6J0RrzH1dsgAH
         IC572ulqisdDqw6RsKjq9T03zRi8lA37nIQLIcF85+S5qpQfUzeR1MlNsuCW910R3iEY
         BNZhhqwPV09n/lrMSAkB/BgVgOwAELzePUlvyo5s/UoXcjwQht8jFSgy2GItQ8b1fBG3
         qwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738618645; x=1739223445;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEqP/YEsjQP6HXPcAZ+OLL0SnqZRyU2wi8fLU4Seg48=;
        b=AjeB9polLFDoPN87LTfAuLKOPONAofAPqCDMdIxB+5i0D/YL+PKNmMjUv0arKpUeUe
         bFFjvcVlrE4xU6bE2gO4/NXqeHVCsm2+rZJHwoK2KTMNRI8WMe5uezkqVbBG9jVFgle5
         iDH2O6Yeq8XcJJrmZxxrl3wXPa7OSJGzsVb8Tvwt4Xsm4iXQmDa/5O73nFhAhr7Q3nij
         u/Xc0e2OxRHGrJ/yJbYtAQAoy8NkHes4akhx2kjY8UELLrgPrxlGsxxK4DMqwfiB616u
         Alh4gZ7jtfHbthWM+7SurC0cRLY8VU44olGhL7ZVT8Zo6Y6UxO3IykG6BK768GSXOkQG
         ARZg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Q6lHrsR0UtaRMlf9rRsW1uySZm1EZHUg0Uxpwg/t+8ZkUm6oTapqMnVZ5oHn9dsqAQf610VHbHLZHGDNAAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mcYceM4afxDjX/l6xqVUfpwwy00izqcTVgZ1ib7dq4dCUrRg
	y0Tjh/W3KJi7tyBFJokkOsCGGjQYEmizTj5M0KqJzvUES+qHoBJh76Do7t91jrlNRv849ASXTd2
	HFz3xPreEKpk6rU/y9xal3w==
X-Google-Smtp-Source: AGHT+IFzEQXFVr/GsJOoiYsXrEqAdOToUP7ubJ3+EUez4554ouloGovsV2x1HVo9oXN98kh3qBpaq5S0IrbbEWoKkA==
X-Received: from ilbby19.prod.google.com ([2002:a05:6e02:2613:b0:3cf:c127:d037])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:cd83:0:b0:3cf:b571:c08c with SMTP id e9e14a558f8ab-3cffe3d1bc2mr218960215ab.3.1738618645230;
 Mon, 03 Feb 2025 13:37:25 -0800 (PST)
Date: Mon, 03 Feb 2025 21:37:24 +0000
In-Reply-To: <gsntzfj91fbs.fsf@coltonlewis-kvm.c.googlers.com> (message from
 Colton Lewis on Wed, 29 Jan 2025 21:27:03 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntwme61zhn.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH 1/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: maz@kernel.org, kvm@vger.kernel.org, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, pbonzini@redhat.com, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Colton Lewis <coltonlewis@google.com> writes:

> Marc Zyngier <maz@kernel.org> writes:

>> On Tue, 28 Jan 2025 22:08:27 +0000,
>> Colton Lewis <coltonlewis@google.com> wrote:

>>> >> +	bitmap_set(cpu_pmu->cntr_mask, 0, pmcr_n);
>>> >> +
>>> >> +	if (reserved_guest_counters > 0 && reserved_guest_counters <
>>> pmcr_n) {
>>> >> +		cpu_pmu->hpmn = reserved_guest_counters;
>>> >> +		cpu_pmu->partitioned = true;

>>> > Isn't this going to completely explode on a kernel running at EL1?

>>> Trying to access an EL2 register at EL1 can do that. I'll add the
>>> appropriate hypercalls.

Ooohh. Making this work at EL1 is much more complicated than adding the
hypercall to write MDCR because once HPMN takes effect, the upper range
of counters that the host will use is only writable at EL2. That means
using any register related to any counter in the upper range would also
require a hypercall. The only way around that would be to avoid using
this feature in the host entirely and only enable it when we load a
guest.

I know we don't like feature discrepencies between VHE and nVHE mode,
but Oliver thinks it might be justified here to have PMU partitioning be
VHE-only.

