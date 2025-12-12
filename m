Return-Path: <linux-kselftest+bounces-47527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D754CB9A18
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 20:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5421A3089023
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D530AAAF;
	Fri, 12 Dec 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmmYAWCd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AB30B50F
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567325; cv=none; b=MKMyzHxu65Yk2oXFlNO3MTehaNpBtOR7sgBZ8Sz1jt/ZMmxbtTRshxxbcXLGn+nP4x2W97ZOx2ITYK66mx7lkjZ+PB+6lyCwZBkB395NH1hnQbNCcCwxR9KahJovhOmaC5G2FexK5GyivlrTK0BKKwXdkmHtPhJDzGRdNUQlez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567325; c=relaxed/simple;
	bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MEuA2w8QV1b/15kb/Z7yTJJr348BLLENSVosbHF7lX9k7LyG2xizyNR8j2iAHggUraZvXRFlXd1miRaijhLgRS7r+GZ5q5mmEcXkavuEzjHJ9cuHlA8wk/zubb+LafiNAH/dyEfcxkKILeXz07sF4Il+joL6JXV4R/5tJz4gz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmmYAWCd; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65744e10b91so1251061eaf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765567323; x=1766172123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
        b=JmmYAWCdFQD6/8IWEfycH1cp3NlAxj6pn4RMlvFzYLY+ifb+sgZpxAaXHaD36odD2J
         QahRxKnOdovz0UUzEezQO1nJZOUBXpaFUM+Ts1sL86RoOpnvjcUJJABUXB9l+F9un/ao
         TB/PoJw2zL0H9tZLNpLoUE/Q8fLic5Mu3FrWxGtpjZKa4sdwMHECCsXsb9ZT46lwJEuz
         5YxZLRcup96IBF5wt0UVghZs3zH5ewumbdC69rUCH6kynavZlvLbTN87bUr3859zYMZY
         yvmXz2ZV5uD9i1yDn08zAPuIG0X2s9JAD1OCOmfHNXEBtx2L6vYZx+eOVWJGZ7xF2kFv
         GjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567323; x=1766172123;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
        b=WEdhwhQ1U6A7n9WlDSymaNVKSROxzlXdwark89cHPZlfe/pWwKG9F5AGKh6vlGGx9m
         YEckbS0ZCoARdvtTGdqXEoEWbD83CyZxprFv4p+Bv6EASuRJNS5Sklq4vZjF21CRMX1r
         NHkUIDQG6pkAymYB3+7PHHMqbyd7SgKn5oAqdzmS8ysZhjU0bZxlIs+d3lTvBR70nvq5
         Ieybz5WzrS263uMjDYSiCgZePUmkpomhQ51LNA5A0mDQcRnbIYs3B3EWzWwCeMKWadIV
         CtCAGljNSuWOKMWs0otzQ9xGLpYJsKpKbo08plBJ1nIvUnIZTzefDCAAxwa0haXVWho/
         94bw==
X-Forwarded-Encrypted: i=1; AJvYcCWINtlbFFfIn/l+N5/iCAinBeR6H3NiTy1A+LEJZtowgV0nttJr/bD3F1Pqivev0RoFFwtxrnBGi2QdSGZKLnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUcQ6knoDKAYyy8SsMgp+cWrWt5piAjGmy/Lk2GvOR/YW0PZj
	1LVTaEzs5Wbum6EI9ko1ARkTvxa9nZzlo3R6diZ69AHp9Sv81+U8tr/BoyS6F3bZuyEWrL4XvVP
	tPokouJs3ZsTQly+FpolLqgP2pg==
X-Google-Smtp-Source: AGHT+IHUbVv4Jy2gEZEkXkuyNos7MiNpoCrDqCxYPzir5lZi9qw+P8UnFJM3AYzANnUq+aZp9M70/ycADG43mzjJoA==
X-Received: from ilbeb21.prod.google.com ([2002:a05:6e02:4615:b0:438:317f:a956])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:290e:b0:659:9a49:90d4 with SMTP id 006d021491bc7-65b4523a33dmr1491761eaf.83.1765567323163;
 Fri, 12 Dec 2025 11:22:03 -0800 (PST)
Date: Fri, 12 Dec 2025 19:22:02 +0000
In-Reply-To: <d3e946ec-787a-424a-9a7a-f04aeb490ba6@arm.com> (message from
 Suzuki K Poulose on Wed, 10 Dec 2025 10:54:10 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt7bur4iat.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 01/24] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 09/12/2025 20:50, Colton Lewis wrote:
>> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
>> counters reserved for the guest.

>> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
>> because otherwise not all the appropriate macros are generated to add
>> it to arm64_cpu_capabilities_arm64_features.

>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks Suzuki!

