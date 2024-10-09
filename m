Return-Path: <linux-kselftest+bounces-19359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8260996F12
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1612E1C2118E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED91DFE24;
	Wed,  9 Oct 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAEebPt/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55741A264C
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486003; cv=none; b=e1tUgLTsV4kM0PWnxv5Swy4karAUH8fgSr3idcSFk71uTC80BFGWVrzlYxHG/hUvCi+ZtfV1R/JButpgzTcTPuH2dwAGQpzCVT+qOH2Qj9VDayE1+6k4abWpwspeoAIn6/re0GWb+IdHby48Ywbz9gVX6YAQWW72uNmrJh0ouJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486003; c=relaxed/simple;
	bh=LGY4oUqQWryGMKVmPMGwdkvn25gik+HeWTMLPKKxQyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NP1wzWPONZJ2gaJgw2D0HQAwhw+1b7owAmoD+ujTd79LaojF+h68F6coq+bPhpWh1PiihFfO004F1klE4n4J4c9ozcuunCYKFoi+jV8Fs0ZIy+yfmTmXkTxnb7IrH8bQC8b/NuaWIaUU/gsTLxDvxoEDBPKOuN3+DycNkfCkjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAEebPt/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2d287f944so81866177b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728486001; x=1729090801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0uUBPQSFAQQIdkTMB/6iIcqnDNVMg8rmlOcTA+5BoE=;
        b=JAEebPt/5nRYD7wkHEjunlzSc5DGrHq6y7KbEhM23jxI2b93B1PGtD21vN0A0EEVbC
         vr2d8RoL4Q27UK+xbfI4UfCoZEjnrXx8CNBicAeyx/bkCahvgnkubFL59xwC8AWzbvQw
         1jV8rst0TYI5ciuxXjU2my/nlJmse3MWLYL88lG7stXBpMrBiMnFgylI0KtLM5klbmPI
         j0wuJ7gS/weC+qSXBaPrO/D0M+zzAy//mX4E5DQFRh/GfTQbkdbpeLXZm1sF8LnNJc4u
         1Dvz8hVIv2Yx7KJkN9onxlTqxY6UHuXR1VrPbzvjaP4lFPor+RIMUZ7XoNsc0vJquPrQ
         2Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486001; x=1729090801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0uUBPQSFAQQIdkTMB/6iIcqnDNVMg8rmlOcTA+5BoE=;
        b=gRNfCukNulxi0xBQM+T/LYrilRW5RWsWFxq+QWHiTq9I3PPd8WJrWHYPSe2rBIEo5q
         yUqLZLO1rnTHU8Nx5D9CipmZ3tWIX8WpdlkK0Yzrlt49uBBKGGCcwr1GW+3znHw2fWy7
         uRWomtK7WrpoLtDd382zdUKw+B6fKpMKHQKScNom8w6tlm9V0uRSy5SRjRu8pc0IUV4y
         42XGRAXKxqHnImyk6WTH3iSmaGinLvUs+All+n3PIwj6icYbgrAirK8kmrCGHmxP+TZo
         0EXmPTbttIFjvumYgq1aqHBGDFyuE7cfCoMbE10NJ20lEcHlVAIKX2i1bmVtIWu77KUw
         G66w==
X-Forwarded-Encrypted: i=1; AJvYcCVBLbmM8rxbYqyt2ibPBaq26ZK5UjYy9fusDigRCiZUsO237QEvOCrqcypREFLJkJpLtBghGcvTJuqFKRKveRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4CDsz/c9QCX9LGD7C6E53VHx12kaC4vIBWggASRgFBPWSGyo
	1Ah21G7WaC/Ln6mOJ0CFsSg3U+l7K+Q8BjuHu3Rn/ymvFl9DR21u619zGRbDxDVJkcc//wIcO0g
	+7w==
X-Google-Smtp-Source: AGHT+IF/nkuM8mTX6eEIPtpXC3uFcim6/FbrmSBU5spuO/mMq9bhEb/S7uXyfA/6mqy+WzaQwvCHjRh5kYw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a0d:f043:0:b0:6db:c6eb:bae9 with SMTP id
 00721157ae682-6e3220dbc31mr347747b3.2.1728486000856; Wed, 09 Oct 2024
 08:00:00 -0700 (PDT)
Date: Wed,  9 Oct 2024 07:58:22 -0700
In-Reply-To: <20241004220153.287459-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004220153.287459-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync timeout
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 04 Oct 2024 18:01:53 -0400, Maxim Levitsky wrote:
> When memslot_perf_test is run nested, first iteration of test_memslot_rw_loop
> testcase, sometimes takes more than 2 seconds due to build of shadow page tables.
> 
> Following iterations are fast.
> 
> To be on the safe side, bump the timeout to 10 seconds.
> 
> [...]

Nice timing (lol), the alarm can also fire spuriously when running selftests
on a loaded arm64 host.

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
      https://github.com/kvm-x86/linux/commit/7d4e28327d7e

--
https://github.com/kvm-x86/linux/tree/next

