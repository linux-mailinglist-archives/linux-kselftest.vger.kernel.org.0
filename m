Return-Path: <linux-kselftest+bounces-43565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5DBF273D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715A318C0346
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871819F115;
	Mon, 20 Oct 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O08gzrWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18719234964
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977972; cv=none; b=JiZsjgGgPhRbPW6XKg3RIjfaJYsjDlvzkXVAgkiZUaJfFdbRIHc/i30+hv5juaNb87duQtLgRDVo+3S1r0ojTG1ZfWyGReksRFvcCf/RQFZ9aBvQDzYcvNueYwztGLUqKWCb7y/efC2SPdTkTsU3jfclVA62ExkwKz1dC1SgkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977972; c=relaxed/simple;
	bh=kHu/zwUbCrQZ2tme86OxuUxLlfikNWjv8AaS4WsjHQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Db+zXn+8X53hBAH6o518+Z4uGjCX1NeQ2f/+ag00ue6FN+BEIl/oFrgDYux0Sy1cFyffY9+QBDeA23P9qBDEqRHBzaz/FfGYr4IFRpt97sxORcXflrC/DV7DgT6Hz4IXHmkAiM5NQVc6QJlVjDxfQjLdgOJROWR6JzwZicuQjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O08gzrWL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269880a7bd9so49206695ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760977969; x=1761582769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Diz1lCzHvuhLNBvdbjp3hmbn87n7UqeGb+eLzgGMNx0=;
        b=O08gzrWLfmGPK/lAeZ3guB94XFV3FO5ZHTPXFTZmfk4BijFb5i2+tsWEmscjVnXzPM
         36nR1W0u3qA1Ld4xPzSjSYHrk5rlJcefT3W9NnkNqiTlVALJX1GKpD/1zABOCb5q+Z+l
         h1JpJeqYr3LHICWNBKwTRJYBPL/kKGocKpAdPeIFJeSCpSk1z/qcLO7MZu7n7oUp6Xd3
         J95ng2iRGpggiyj/Xlomwd0UrO7IOVSQUXUQQcv11+5ZNqKwriGPxgNBY53sZDUCVp4+
         MP7QqxbieJw1lnf6KfJ4nLWpfFYyyG+xDGpruPAoKbwKv4RnX/gGYO/LD4Nn9SicvYW2
         tNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977969; x=1761582769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Diz1lCzHvuhLNBvdbjp3hmbn87n7UqeGb+eLzgGMNx0=;
        b=Gp4ujSQgERDqFSysVGu3XazppCFFB1LgG2xgUypU704uCZ0GYXiqukmKqfi6Ipq/kM
         EOH1h2gEd70Kyb5R2GeLduKDo+/FEgGi7opIBgZs8PAhc+X6w6AWFlYjTtejeMQ5WtPB
         cOScqFIbnFZ4zyz2DTK74f0SJDL1Kp3ZOWF5GKnhx7gQHxTHm3/p4mPjZ6LKAoqGQLIf
         YcMf3xNsqgRMMi/grdMEftj0p1Lq5M+MF5LhGIq2mxIj7/YJDEz+iJ389nCs4pAHRNLE
         rUE9hwCMf0Q3J6K2kuLTJFIIv45g7Q/FbHMy2gTtQxgYK9xC9i7H/kGQ3uLluis9aIqj
         2YmA==
X-Forwarded-Encrypted: i=1; AJvYcCVKaWKLXDx6TY5lXjkifPrwQFwWgo7EnsscV9GUSdiKcZZXpCZBfZpV1x+wk2p+TwZiSOutjyE8iEO0hCllgf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5elIphDVRKPpqAKhVl5fL4Xs5lCl1D1qkSjnkqtN+/GlVrp7
	atTGlw2YE5ymlqC7YmKAss6Gx/20XQHml++IM6zEPZSLw/iNOzGIw5vRSJxbL5GoskJAuYTE4W/
	Pnp0RRw==
X-Google-Smtp-Source: AGHT+IEBssmEK7IRnbhmUgh1LvtwLWzxveFfoJwgyr9fXBCvprfyt2fJMMmtuyxeI3YpRV0rM/SKweh7WoY=
X-Received: from pjww4.prod.google.com ([2002:a17:90b:58a4:b0:33b:c327:1273])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f543:b0:24c:965a:f97e
 with SMTP id d9443c01a7336-290c9cf2e68mr182575675ad.2.1760977969344; Mon, 20
 Oct 2025 09:32:49 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:32:47 -0700
In-Reply-To: <176055119471.1528900.16047808072294975428.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007-b4-kvm-mmu-stresstest-1proc-v1-1-8c95aa0e30b6@google.com>
 <176055119471.1528900.16047808072294975428.b4-ty@google.com>
Message-ID: <aPZkLykr3L_cBeqN@google.com>
Subject: Re: [PATCH] KVM: selftests: Don't fall over when only one CPU
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Tue, 07 Oct 2025 19:12:31 +0000, Brendan Jackman wrote:
> > Running this test on a system with only one CPU is not a recipe for
> > success. However, there's no clear-cut reason why it absolutely
> > shouldn't work, so the test shouldn't completely reject such a platform.
> > 
> > At present, the *3/4 calculation will return zero on these platforms and
> > the test fails. So, instead just skip that calculation.
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/1] KVM: selftests: Don't fall over when only one CPU
>       https://github.com/kvm-x86/linux/commit/98dea1b75186

FYI, I rebased this onto 6.18-rc2 so that I could apply selftests changes that
conflicted with fixes that went into -rc2 (yet another lesson learned about the
dangers of using -rc1 as a base).  New hash:

[1/1] KVM: selftests: Don't fall over in mmu_stress_test when only one CPU is present
      https://github.com/kvm-x86/linux/commit/b146b289f759

