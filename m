Return-Path: <linux-kselftest+bounces-44301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A63C1BA04
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49369346C6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA83112A5;
	Wed, 29 Oct 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQHMBVSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCB325710
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751429; cv=none; b=TMU2Q6jv28epoehc61QlijH1zvuXqkkg9rAiqcyFXc25SA83P84xWqS7Hj+zrvzeOaiZUJDl0T0ZBkumQxQTFU5MbqsdA4uDC100YQGRICM+x8Y6/Dxk0gYywR0K2Ooauoa1PA9VaAO+bqRyWwXRXf9YyCYuTg9Qn/DOA5iVrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751429; c=relaxed/simple;
	bh=GnnlHMFRbVrpcnyBkNDcSZjt6llB0RXl0xQOlvsDe5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYaw2MO7rWsuExfDb4vMhuDspEpoTeJORB+I1Ek3pcYKo371AybfKaMpnst40CwN0HF7kWIsfihnzf0RsDQf+P7m2+iRhQwDVdZMoiOlvWYPBadUhsKJ1ZIPkKipDqvDAR1JPdHTyWG0GQ6wPBtBWKcMEMdAHavhpAKgayykKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQHMBVSM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4283be7df63so3630623f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761751425; x=1762356225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnlHMFRbVrpcnyBkNDcSZjt6llB0RXl0xQOlvsDe5c=;
        b=oQHMBVSMJ2M4QjAW8A7GtSAF9S6FkVCh2HHuqy3FhR5UzylxgotmNVkpR7YLWV6rfn
         VOutUscxHLqWLt0JqDHs8hixfx95W7FB52sKo9QYv9p3+f3eHN4QkMSW472X1K7TxxCP
         XjVWEtQPwThUR7pLHWxItQKrTQVRSrSCo6nZG4InGUYT/O4omm9oVxUNPc8D0u4R3k8k
         1wsrNT11QK2lBzx0qOtZd5gixGG1gG1sgc+CtA6+FrX7IJCFbF2O2e8OU+OzG2daQijI
         Q9hGbMmkbOzLxVKFQVFPYzqW3iMZvAgwtakzd+5/Fn/g1j3HHF3D76Yocm6VJZN+iWjN
         8a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751425; x=1762356225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnnlHMFRbVrpcnyBkNDcSZjt6llB0RXl0xQOlvsDe5c=;
        b=FryFC/hmr3jIXaXlzvVidlCbwaRnW8Xdo4CQAy0DqAYYbZVdLodrIjkmGapwvVaKiD
         ntklRpItVdmBBwvxmMCLfXq6OcdXgt5NyMqGkQoNkhySNe0NDUA0JQ5UO0cv1WSXH26D
         +d3VnSWENUWVJM0KB/p3rG3mF0nxMlB/8fmy9J9VPT1JVz1LzSgxjMdMmZaQfFtUvb6v
         sB+QTNRrcJQI1PRMdbKeKS+yyYtA1pXZgljPX33UCKTaBtB7vuuAdXTsyGuPYkHfA7pC
         dQCRNHXjwiB/AwUgtzr6fcWIMkmX6lH8GvrdXCDFTWIYGyUGfs45/IGxpuO3CIVoTncK
         QFVA==
X-Forwarded-Encrypted: i=1; AJvYcCWALe1nVRawe15nXKdamfZdFtrNGORHOyKwmzyj/XSv06uf2zsBhomkrsb3V64T6CusWVoIVRIPrxT4kNGFdso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kVn1IiaHyeN3FtX8iILi2aG2EpP6HTAi8SjwZGNxdWCJSADB
	Pi4daY3UHNsYGArHd4vakqBsTqGrNizYzAlnVEldZFAhu83Z9Zexo1SIcZzwmL508Jg=
X-Gm-Gg: ASbGnct7hc02+DJ9aIL0Rb0hUCa4brjLhQHtMArgLjOpnAKzpXZxSIHgKWFO9QyHwY4
	/BwkrGR9u8nHecek+KQHWkNOHMAvErBcobNhcw3GDauIsGS8Al4JZKbmRUKr0Hk4A5CZXtdcQUo
	W1mBD+4O7RgCJWZ2Q5iPR4n6RU9pGVA1/wp2cR/YKrZTPv3VZ/kmpmQmrMSYGxNycgGhMkgYG0M
	1su9MajUmDbuTkBGYyRPaKMWRs7nBZdQ/3s+wAAPhWVT0oLtXjKfVWBB52vnaFW5rCI2wf9AoQC
	mNOJTXbZFj+vWUd9IfszQx9tjJXpsv3ZHhPSV+nTVErK+kXOEXYHTyoEL23jJIRqqeQEs7fHldj
	6BO567Nf4ah0Pa/tb69wwLX2BllP7wfha+2enn0gctSl9HCbvSbRScD6BLUooHgifua/hfH5Q0g
	NBLgilFteESFIO3wM=
X-Google-Smtp-Source: AGHT+IF3kypRXz+lbNGUUJZxGE/9fLgsZ6x2lXzXuM2CaCBPkYTwY5pskZrBjx2J28zmiWA3+gROqw==
X-Received: by 2002:a05:6000:2308:b0:426:d54d:224d with SMTP id ffacd0b85a97d-429aef8b88bmr2958293f8f.27.1761751425212;
        Wed, 29 Oct 2025 08:23:45 -0700 (PDT)
Received: from e125016.powerhub ([2a0a:ef40:e8d:4a01:29a9:3ab3:ba86:f8fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm26823811f8f.47.2025.10.29.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:23:44 -0700 (PDT)
From: David Spickett <david.spickett@linaro.org>
To: broonie@kernel.org
Cc: catalin.marinas@arm.com,
	corbet@lwn.net,
	david.spickett@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luis.machado.foss@gmail.com,
	mark.rutland@arm.com,
	oleg@redhat.com,
	shuah@kernel.org,
	thiago.bauermann@linaro.org,
	will@kernel.org,
	David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v2 1/3] arm64/sme: Support disabling streaming mode via ptrace on SME only systems
Date: Wed, 29 Oct 2025 15:23:30 +0000
Message-Id: <20251029152330.155394-1-david.spickett@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015-arm64-sme-ptrace-sme-only-v2-1-33c7b2f27cbf@kernel.org>
References: <20251015-arm64-sme-ptrace-sme-only-v2-1-33c7b2f27cbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have put the LLDB changes for this into review.
We are tracking SME only support in this issue:
https://github.com/llvm/llvm-project/issues/138717

The PRs that relate to these kernel changes are
listed in this comment:
https://github.com/llvm/llvm-project/issues/138717#issuecomment-3456979166

LLDB's use case for this new ptrace feature is to restore
process state after expression evaluation takes a process
from non-streaming to streaming mode. We have a specific
code path to handle that restoration, and it was not a
problem to integrate this new ptrace feature.

I have proven with testcases that LLDB can restore
any streaming mode/ZA/streaming vector length
combination, starting from any other combination.

The LLDB changes will remain in review until if/when
these kernel changes are accepted. I expect LLDB
reviewers will be ok approving changes on the condition
that I wait for the kernel side before merging.

I expect LLDB review to take some time, likely a month,
due to the availability of reviewers at this time.

Reviewed-by: David Spickett <david.spickett@linaro.org>

