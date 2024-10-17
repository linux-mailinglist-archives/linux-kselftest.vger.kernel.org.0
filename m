Return-Path: <linux-kselftest+bounces-19898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E79A16DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 02:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9351F23624
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A7161;
	Thu, 17 Oct 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuugg7X4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1D320F
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124597; cv=none; b=sRi2iP0wveN5JNihDolTMn4YkMfMjrtvUv4wbPJTPVvKECNxXwO8zSy13xlg2B7mi1qptHiBiU4udfXO1Y5Rcwky/8D1U5LjI9xLqZY1J9qAX8mdUkSGJVadtjiSZxe1UNhMN+JsgDqpthoNyV7u529ycCMHwWs9jIE+cJIyqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124597; c=relaxed/simple;
	bh=5bW49bD+EKSiVYlir+v4FtgYuuOeWvwSTqfDO39iuXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tg5GwZacj+q+aloaG7TicRNP608fQQrfA9X2uj92q8q1pQsY5BLKKt8jJFPJh2TKKU+jXfIU1fRzXDsZTEezTMH/xazUGZGrnI7LoeTmLPOko6QCSu2cboAgnX5eZ7P5J0j0dRE/1MJ/vvF8azKxTPpIB71cz6e+lQRzKXnSzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuugg7X4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so625010276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124595; x=1729729395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDOAcCratkcKDtlnVKA6PegGNWwglEUHg+hVzvt764w=;
        b=nuugg7X4lPwH+k5zVajfCWMu8uCF91wMVQOSk6i8O5LF6i+eeGQo30Lp6XghoE86OB
         wIzLVJ6r0AVn0vZRjKM3iGZpWcacWfg0m0ZzaObM3ad1PGuUZyA5IPUzlA6QbTvdacS3
         FzocCOoaZc37ytyz6YIbE9oKWUaTOI6u4wX6D3PsZFdhfiz0tI4iH2lew1fWveKT0kk7
         r6aK6SJG6FNHojf7s1n4c9oMshvtxVE3opnYPoMBOt0qksT/H+/54HDZ8FybiBBTIDgm
         ZUbYMGcE2e47641jEZvhWyWFR+BgrRRtVPzbNP4ASnzaMBxffg8Q6jqtvgbyeqJ5Xydm
         TQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124595; x=1729729395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDOAcCratkcKDtlnVKA6PegGNWwglEUHg+hVzvt764w=;
        b=mnXShNmPcJGaDsuROKJRC+ZAyc7XH0hzHqAPJkfXm8oWwoXyNyJra7HKKesauARAxR
         HqHVazp32M6ma9IojU/DqI42r4Fh0A+1VSO5fWqhke+3bLotKRKJidnXdqmgtHk8XkC1
         vbGfBw0uv4b7my/5mgnl0CNDP5ZV5trmIPuhL/wY/b4ITV5jPVJ70RJ/uIavfXdYJMHz
         o9QWLdnHHj9v7SqUM/khRL4Nf02QCxSR+98vFhwJO8Det05ePkGFi8qfXJDJDCMHJ0xL
         78v7vf7xfy81FptEpHLBDHGleQWmc9kXBsrLYeO+U0wOQ4U/MpcjDRCM5DjEA5vEzeAq
         XTbw==
X-Forwarded-Encrypted: i=1; AJvYcCWsG93ackd01GMVzKqKlETlSew1LB1oJaosImldM+5D6eog2fcG9lLKKbz77fhsuBoCY5HY1WiVMHVjQRAhBwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXG/TGo0B0VhbFosmW7o/7cYr5bEvQsB0afqSESclQBLs+A8v
	aexcABMBVUYMbGB1H4okToT2FA5HRPS0fGWh0sxhBqNrbggQniSwtjey6NHf9+zAwI+VBM18x4r
	P0g==
X-Google-Smtp-Source: AGHT+IE4l3MvTYNAOyrgYg8GdkVRXTmVWgsHaliM139NqF14S6D92z4C9+5nCmagCDbGXLX8HkyuisI1pSg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:aa6b:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e297857f664mr5460276.8.1729124594453; Wed, 16 Oct 2024 17:23:14
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:23:13 -0700
In-Reply-To: <Zw6Svts5hqpIoKwN@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926184546.833516-1-dwmw2@infradead.org> <20240926184546.833516-5-dwmw2@infradead.org>
 <ZvwWM7rQd075o6nb@linux.dev> <408b137dbf60ff4d189cbd98b7cf8cd833579f61.camel@infradead.org>
 <Zw6Svts5hqpIoKwN@linux.dev>
Message-ID: <ZxBY8S6wO7tymIeC@google.com>
Subject: Re: [PATCH v5 4/5] KVM: selftests: Add test for PSCI SYSTEM_OFF2
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Francesco Lavra <francescolavra.fl@gmail.com>, Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Oliver Upton wrote:
> On Sat, Oct 12, 2024 at 10:28:10AM +0100, David Woodhouse wrote:
> > I suspect the real answer here is that the individual tests here be
> > calling ksft_test_result_pass(), and the system_off2 one should call
> > ksft_test_result_skip() if it skips?
> 
> modulo a few one-offs, KVM selftests doesn't use the kselftest harness
> so it isn't subject to this comment. Since there's no test plan, we can
> skip at any time.

FWIW, I have some ideas on how to use the nicer pieces of kselftest harness, if
anyone is looking for a project.  :-)

https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com

