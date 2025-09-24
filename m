Return-Path: <linux-kselftest+bounces-42230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB301B9B68E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A328B1BC1B1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D03164CA;
	Wed, 24 Sep 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0oMAR43"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06C31A550
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737442; cv=none; b=jiQ87wd0NEXL9BD3kuzs4IHCzgTQa2pqm4hJK1nTGJyVl1A/nO9uiLQ7pKw7qYUYAtfVUrwAk7fzR+5PZOxTnvSpHQRD5n288pZRxMjULtyAe8/6BRydvqXp5t5qw9F1Jz3YkRrxyhbe75f7gHjo6f4N256pARSDttLx9u+FdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737442; c=relaxed/simple;
	bh=HnbCbq8xUoSPL82EWmkwrjtcy/MfRTsomun+NPlhkOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G6LN8jC6O/wnm4XxGmo6/lN+nfv8X2DTqhflvQ8LVoSq+kWjD+VPA1EyEFINKs46LBjj0quP966BlNsfWQ6d5fZ2a1r8LfhQPFwPYRqgs9iX+zKpsSFkKoQXyTcUfe0KTGjyGG8z9xstP1vuiYvjoQavjm7EvDmSwa3oKYnEBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0oMAR43; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso48128a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758737440; x=1759342240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTEo27w09QsleqdXmAFAASTfDXHnOjQN5vy93ATVo+M=;
        b=e0oMAR43B/uFQnYTpsZrJBNrTTe6hp/+IA8mEUv2YrQm6434zFjel0io3RTGBxfRhB
         nhcEIRGsmOFIhsxiI+VrPZ4uIPjFdzQaGvhcECb/thDTU59r8xo7eElcb+7fa6XtTh0P
         i+asCrY+LDPFzcAD6+S8eHpvokU9P1CfTdAWyQNTOOhb7F6I9pAc7GwaaM62Tlyfa6L7
         k0dkPg5KFH96xC73MW58iC43av/ryCKJeWVn12sX3rcfzraTbbebNNxmDhMsLULl+d5o
         RkBeKIMLkMa6Ds2nurNyLOJN5Rqefvj0HL5bhont44Rl9ydOFspOE/ghCpIUfXvncmXt
         zLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737440; x=1759342240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTEo27w09QsleqdXmAFAASTfDXHnOjQN5vy93ATVo+M=;
        b=e5eelpgyzhJPyLAHWXFrm6pzFdDijm3xUI6OJBe50K9i6pO2swlzPyXMZ/77ETfeQd
         JVh6+EeFk8mPhnqo29+TpnjcRviWdS7NRU9XqqJ+LbAEePwYYXrf7/Dut8LSsLpUXG/w
         hVo2UtOJRTKu67W6r/KWQY07zsrbw21N9nAfLShTN3YtNZUCbDPHxhWNe2jQQ2izCSeg
         US+8nE3rGcL99AtbYrYsTxpsoBXZ9N+5DZI/LuatEAvvWtLPKMFds7rsKlvkEJFt5EFw
         zcYPWrmFbzLL77XJTb/MfDuC+QWTkvyRuLf4+TqXYV3+3YNMcOg3AeAP+Dv/ESmiV9CP
         zYYg==
X-Forwarded-Encrypted: i=1; AJvYcCX0hCzO6PpPgkocRFizF+jyS1G8sRYmROK1ljExaD4vmYI0+NTkelQGYbApCsU7v/97o25RLvcBmEs90i2OzEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT4ozuL7lsDavsqClyF4jYp70CZflvybccB2DsLv/q0K43Oim
	KgHqI5inNc/RF4U5flGRrLAZnBuByQX9O9IEnoJ7uGklVM3I0WQndWL4ieyaBT9RRH5RylpKEn6
	xvCBBjA==
X-Google-Smtp-Source: AGHT+IGy9UhUhJ98F4R1K3qPDUBkNCiqaTPTXyTbsgsjomOe3ENcTeNXnn7xs7rFzLQlUBH41tSk9/xo6jE=
X-Received: from pgbca32.prod.google.com ([2002:a05:6a02:6a0:b0:b54:ac4f:20f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d84:b0:244:facc:65ef
 with SMTP id adf61e73a8af0-2e7c7ea5c1bmr631932637.19.1758737439691; Wed, 24
 Sep 2025 11:10:39 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:34 -0700
In-Reply-To: <20250908210547.12748-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908210547.12748-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873638301.2146431.11936191215737388089.b4-ty@google.com>
Subject: Re: [PATCH] selftests/kvm: remove stale TODO in xapic_state_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, 08 Sep 2025 23:05:46 +0200, Sukrut Heroorkar wrote:
> The TODO about using the number of vCPUs instead of vcpu.id + 1
> was already addressed by commit 376bc1b458c9 ("KVM: selftests: Don't
> assume vcpu->id is '0' in xAPIC state test"). The comment is now
> stale and can be removed.

Applied to kvm-x86 selftests, thanks!

[1/1] selftests/kvm: remove stale TODO in xapic_state_test
      https://github.com/kvm-x86/linux/commit/ff86b48d4ce3

--
https://github.com/kvm-x86/linux/tree/next

