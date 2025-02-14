Return-Path: <linux-kselftest+bounces-26661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C672A36173
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926C43B17F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13E267395;
	Fri, 14 Feb 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NknB5qQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D49266F0B
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546465; cv=none; b=dZBkL62I3SRoLQjA3BIIfJOz1kTqIEl9GSZ2tzbw4ZmwjwjUpNOBC4MK/bYtrcu75VLmW7RW3Jf806U0N+7ljygSrEEjqTOE+gazJhYo0X4DywIK3waf7Qw2ZTovZLFQjiq5qdPadXiIOu7HuNcm2qhZeHMsngFUKH0WlwEPfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546465; c=relaxed/simple;
	bh=k2ZjGztjrBRL8MdtA9H8+Fs2+gktoXAfXfoKF3hMIIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fgBXWLuot+c52Eavr0D9/+lEPMPWEDCtfZu2U+UmOFhEjprDw1A8iI+d31AlsHgjnzT1fAKGirT5XC4B2stvrR+hrJ3EzXTzf7/1ovHVtYsiwPfFfpaNjH2iGItMUlBLz+EXgKraKVNASbGaTSHRW1Yb0zM3AC/I1fwsYySJAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NknB5qQ2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220f0382404so16687765ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739546463; x=1740151263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06aFn+/vyp59RhN2ivO/weW44nHTsSDlvI5gbGhiN/w=;
        b=NknB5qQ2qYXcs8/M/mV4WHmY5oHtoC4iwdl04bwxNcZpcEaZze6Sq4Ssr3ivK/0cme
         iTFBK/L8HNYFbuuTri+cThaXaJQ/UYYvjSKk1BnG0IMxjxCcuqyScM0yRg9MUqv5r7EV
         cA3AKxUn/Ki4+gJjh9DXVX3P3XkpxaWZHsJNwIqb51HJ0RhlWlShwEimyQ0u1JdzyCHB
         Dl4FFDTFhFT6e/AGBfpqgBTLScHvH2pQbOX+T/aCrXnjMnM0/33mloi4kRsNFu5F0XVL
         seNIH192gryr47Hg1zyhN4xW4eK4vZjRbujOXIaTMzJhrjuHXncSXGiiXyM9yrLWoC2E
         qR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546463; x=1740151263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06aFn+/vyp59RhN2ivO/weW44nHTsSDlvI5gbGhiN/w=;
        b=SgThVdyEHUW7iFjBmgZNBU23EKOWg6V9XPcZZHIiDhuN+0ex7DIpsp3VQLSQGe17ai
         gDx0ZtjCGiEQHmxYntNEJLWPbmRzIsVL75gPW0daAppNxcxB5c3un1oVi5SilP//LmzR
         xRkblabLGQOpmNxqQ/RrRxDRTGXgRIYGnPP2XzB14JCWMypCuUmJ2R6CtQ9J+aOXK7on
         Dw2MFSqL5JYorj7/jfw0bSbaoUmQG3KBrkjLMb+DyN89AfxqRhMudqNbCEiBJW/rYmoL
         RqLdFDUHGStSoKueBVuCM9aaGaDAu3IlHw5RLth0rAe8Sae+KVJ8oBMHWUWm7efYNdY+
         O6yA==
X-Forwarded-Encrypted: i=1; AJvYcCWI1DElJ7P+8lsH2fetKBcrkx8Irh/25R/ZG3N3m/w1GRK7yR+KtuNo8ZaPtcAw5FntS2hgO3jz5WqpS0niuuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/UfKQqNY1yHe5Q+x290l3NwDiu6MX9qEbPrVi7aqHTA+pGXF
	1LDY+aJuPxguR73mgcTKX4tEdoyX+u0PSVhze/Y6eE4emlFwMEwznhg5nmugVoOAUOGvZfOj2vs
	AVw==
X-Google-Smtp-Source: AGHT+IEIuKmLpEOOIeM3cBT0i93rzCtLMoR++wEsyi4WcivIxsm6iGeEqERqPFc5PaEUHbMcfjuAWmNt/OA=
X-Received: from pgjl8.prod.google.com ([2002:a63:da48:0:b0:ad5:4679:1815])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b04:b0:1ee:89e6:30f5
 with SMTP id adf61e73a8af0-1ee89e6322dmr1845786637.16.1739546463162; Fri, 14
 Feb 2025 07:21:03 -0800 (PST)
Date: Fri, 14 Feb 2025 07:21:01 -0800
In-Reply-To: <20250214130201.15903-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214130201.15903-1-colin.i.king@gmail.com>
Message-ID: <Z69fXYWn06CpPK4u@google.com>
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake "Unabled" -> "Unable"
From: Sean Christopherson <seanjc@google.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 14, 2025, Colin Ian King wrote:
> There is a spelling mistake in a TEST_FAIL message. Fix it.

Gah, as usual, your spell checker is superior to mine.  Squashed the fix with
offending commit.

Thanks!

