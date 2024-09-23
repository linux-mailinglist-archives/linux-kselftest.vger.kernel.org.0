Return-Path: <linux-kselftest+bounces-18243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1A97EFBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1341A281BAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8219F104;
	Mon, 23 Sep 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lh51dFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F219E99C
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111097; cv=none; b=CGSoTePG+npIL7EwYuwoC81oia2rlI7uJhG9ZLHL7sPmGB2AbODTY8Wvaqv7MjhmmOoYeK7FtG2r90Z3D24ND4yoR82mxLrAsKOLfK6v0zwdePIcdk/FqGom/lqTuRTEuZLQxeL0UsHZsn79OgavNZrsjfv2ulgGv2WgonF+fZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111097; c=relaxed/simple;
	bh=vJbtWKItKqWE14H3NBVh/niuTdcSm9we5iEkrkOBEac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ltLZT3wBb+cruA0rwMSpQk8tyqC1yOAMQltw5ZiXE+/lOmAnCDxaNHwtsOj6sZA55ERwo4JG3psZWFjyXz8VaiX84k10tDawPJw4kYo0n+JHTs3DPQPzc1A6OrTOznD0zEKzvokjVi1abaJ7uPEHGiuypiiHXlRet8Qglec1M5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lh51dFR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-719918ba482so3425068b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727111095; x=1727715895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LTC4QqKWucxBxnk1ZrnUFF7oEi+VhIK6z7a3jLf3KE=;
        b=1lh51dFRBOCPVwpfUnOQMu53PXfEZ1yoG6AD8RODpHlRqc8xusjrfPdFJukDYMMg0Y
         w0fvGlogUtjfFxbsZgfeBsu0OskjjnnwLRRiuPCmbIgTS+4Qpy5R7BEz467KaGQXNx8C
         IhOXNCotukd1+t14ItEKgVTBRYvWRAT+NyBby1hWp/OluFE+GjD5wpWcvNImh/ZRk44C
         FpVLXtcvJ1cm/wN4bfb85D9nuqOBuRgY/UzB0tGsfuG0sPmtu9yW2eyFDJgc6PYPtCMk
         /qC/BUVRTLPLqoPsDFWo8eM5T+jtbO9KznoJrqSyZyFpvq9Oqgh+jm1Lw7OpcMku/REZ
         EjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111095; x=1727715895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LTC4QqKWucxBxnk1ZrnUFF7oEi+VhIK6z7a3jLf3KE=;
        b=vpZN9g3Jfir/UghZ/jdTODQZFticn0QT8cjCZljm/5Ji8O/Os9l/He0Rm/lJSKzHHB
         2BuK2srIPGjqOAuKoV7IVqoIJ90TLuQY1YUCH/bn7jx1FF1U47SOi94bh+pU0IH2mmjF
         1XaeDRv9jOHAPORXf8gBaEdczl7QRHB1ZHsv9uKL/DhkBGHxURSyNkw1lXOBTog6oLLv
         g5/+QO2NIoVLPOAgjO51drdBDqCVNOhrmAM8rCjFHytq8RYNhvntK20d3DpvD1ezci6N
         S5vpRUi6iF1fWSQ/dz6pX0vh6j6KKgyexUD5jrxrj5TAqvoyLdsc0rG+t8LFflAodAZV
         xjuw==
X-Forwarded-Encrypted: i=1; AJvYcCW4SYso1P9Ul5YhD15lFdIEV8SWAE/nR8IaQ+QSxWTOdnDcm46a4DQ+pSz4mkPgRqLPjIYfLdIthLK8YXfAO9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNjV92kv1SyCHV6DP8IB26Pqhrkc8rxFLcFbkCAuBKoKW09jR
	wGB9V7iReebLOucwWnklpLbp4p45Xj0UkH3cQcZ9egrZMRkvOWe8ZSf9p1tS0BiVEmZw2aa4ssT
	dAQ==
X-Google-Smtp-Source: AGHT+IGIWxxwhZLXYVP88tODSZuBGhUt9N+COq1mKE0YgBtKzP2xBkCYCTi8v8lqsj5RFPeLr3njweGVXgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d0a:b0:718:de57:dd29 with SMTP id
 d2e1a72fcca58-71afa20c38amr561b3a.3.1727111095079; Mon, 23 Sep 2024 10:04:55
 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:04:28 -0700
In-Reply-To: <20240923141810.76331-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923141810.76331-1-iorlov@amazon.com>
Message-ID: <ZvGfnARMqZS0mkg-@google.com>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: hpa@zytor.com, bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	jalliste@amazon.com, nh-open-source@amazon.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 23, 2024, Ivan Orlov wrote:
> Currently, KVM may return a variety of internal errors to VMM when
> accessing MMIO, and some of them could be gracefully handled on the KVM
> level instead. Moreover, some of the MMIO-related errors are handled
> differently in VMX in comparison with SVM, which produces certain
> inconsistency and should be fixed. This patch series introduces
> KVM-level handling for the following situations:
> 
> 1) Guest is accessing MMIO during event delivery: triple fault instead
> of internal error on VMX and infinite loop on SVM
> 
> 2) Guest fetches an instruction from MMIO: inject #UD and resume guest
> execution without internal error

No.  This is not architectural behavior.  It's not even remotely close to
architectural behavior.  KVM's behavior isn't great, but making up _guest visible_
behavior is not going to happen.

