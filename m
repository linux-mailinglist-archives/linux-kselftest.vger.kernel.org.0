Return-Path: <linux-kselftest+bounces-3639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B318583E364
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 21:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F3D285F5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62F23750;
	Fri, 26 Jan 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmguHJry"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29722EFC
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301142; cv=none; b=apgrtuWcYHjCqoQcKIiCw58SBSvkgSFBs7XPjpxzRBlDhwdcoyabrQ4tmfRAzDegrNj4K1YeDm45zv6hOOJuNTtTiUT7qJ/0uyeiZeYe2OQ/UtKSG11wqLIv15KAin9TQ7/F/KiY9DeDN8E9jCmQ1yVNTBDdUa0sC9zuoJjkPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301142; c=relaxed/simple;
	bh=SFib0KiekjrLD8wcJY8L7d4ExRDyCFVGTi65Fe3iBQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbZ9CM1wveQF/tDTCsEYAL/fyHCLFQom3RHJBUHUAPQeR7g1WrBSPhQrYTuFErHFc/45jnBhpdIm8pWiudSlQs8t1u/iFm9aT/oSeBwMXhaU12vkMtsfXe7Ipd2QH/ILm6f6uUaNoWqWsaaaSk7Wd+HQq2/0LDZ0mLUCpBYTxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmguHJry; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso770983a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706301140; x=1706905940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=khTRnTM9rQ9XNgg2MeAsdPMur24bOv6XznsHlkn8x0g=;
        b=LmguHJrykGozB+Rm8hqImcDxTucI0eh7FcEbBMB/vtD5dEn/Eyq3o3hMhIPt21Fjfu
         h5Z6e12lp/7OPjwlMgo4NwF0hTiR0rMXC3OblJLjphoLl1Bzv5u7E7tdz3rgxwyflrQK
         cOt/3QPQhHpWds8LNlz7LIH6Kc2As1LK4d52FiUWqH5Ba18EqqWRTorrQASBFsCVfX9i
         JvqsV0tJe2gwoP0zNTabAjKbQEwkg8/4ISMgaJWtwYN3TBu1SfC11Qlj4kfILQaLpTDK
         T6eqJYTOmQbun4o7mNHqDa1jvmgOJ05hRcYlW3iAfSqA6ajtNfl8YzMG1UoRZ21I8KGB
         TiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301140; x=1706905940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khTRnTM9rQ9XNgg2MeAsdPMur24bOv6XznsHlkn8x0g=;
        b=hJzd+E1O569y8AXLv5cWHRRW1Oqr9VKciug8z1rEeNRPKGOh04rqvspLOYXcl6vSQH
         sral/Cs+31IlBb7Dj06hpXzlGF35RCPom+c/iae4JESlHfYwA3nOwe4VJvkgK4en5MFb
         K3l1LJvLqnhdWpxhr+H94QCWRw/1sJ3fHOomWWico0S0/lhVKugOLcyg6xu6DM0J0bG+
         pQijNz9aAbcz1aUxRvOWo8fLZSXSUwMvp2jN9MeqaRfE1wgHFsCZk8O34DEoJmib2YX3
         PpAGVWnFaVYyCr6rIp0TEtQSDTY6YkADO8LDo83KyuUpdNzw75EQ4sYgaAx9HxzWf+9a
         u+uA==
X-Gm-Message-State: AOJu0YyKGACA68FnsUQodzMwV3CpNab2OjzUOKtKG33r3s89jXJ8cn4m
	T8t4EqPbiLTm5KZ1LyzYIqORtBpg96Vr44a/qfEjd6wwbL/C9QjzxvsGm8ODsmHwwlNDu7qPa15
	ILQ==
X-Google-Smtp-Source: AGHT+IHD5o9pq2Tm1Yf56JTr5JwG33a2+qbUQ+STfhE1ewZfpJUWm5UZX9iC3wjEL7rnY42xPcJH7AdNIcM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6648:0:b0:5d7:d631:202d with SMTP id
 z8-20020a656648000000b005d7d631202dmr1912pgv.4.1706301140652; Fri, 26 Jan
 2024 12:32:20 -0800 (PST)
Date: Fri, 26 Jan 2024 12:32:19 -0800
In-Reply-To: <20240125015420.1960090-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125015420.1960090-1-maobibo@loongson.cn>
Message-ID: <ZbQW0yfI08qwXcfQ@google.com>
Subject: Re: [PATCH v6 0/4] VM: selftests: Add LoongArch support
From: Sean Christopherson <seanjc@google.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 25, 2024, Bibo Mao wrote:
> ---
> Tianrui Zhao (4):
>   KVM: selftests: Add KVM selftests header files for LoongArch
>   KVM: selftests: Add core KVM selftests support for LoongArch
>   KVM: selftests: Add ucall test support for LoongArch
>   KVM: selftests: Add test cases for LoongArch
> 
>  tools/testing/selftests/kvm/Makefile          |  16 +
>  .../selftests/kvm/include/kvm_util_base.h     |   5 +
>  .../kvm/include/loongarch/processor.h         | 133 +++++++
>  .../selftests/kvm/include/loongarch/ucall.h   |  20 ++
>  .../selftests/kvm/lib/loongarch/exception.S   |  59 ++++
>  .../selftests/kvm/lib/loongarch/processor.c   | 332 ++++++++++++++++++
>  .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
>  .../selftests/kvm/set_memory_region_test.c    |   2 +-
>  8 files changed, 604 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c

I did a *very* quick read through and didn't see anything egregious.  I really
hope that someday we can deduplicate much of the ARM/RISC-V/LoongArch code, but
that's no reason to hold up getting selftests support merged.

