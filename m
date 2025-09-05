Return-Path: <linux-kselftest+bounces-40815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDAB451BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B273BA90A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48A280018;
	Fri,  5 Sep 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaT3H2ES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BB27F727
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061598; cv=none; b=DEQPwdMUs27BNtUjy675MMumpFuPvRQUB99PXNU/jAAyOtEMhz/6Cp3TETj+bE0O0uGGEzUW0g3SUD3p2LY3OBhYpHk5UISiyuISXC67gQpbFOUjyLy+rBCzUT4q4692tthq9vDaWzfushw7FRyghSRFNmhJhuPHPr6XmQg5Kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061598; c=relaxed/simple;
	bh=2uw7HuzgrJw6Tl3/iFOPwWaXxB3idEJMwXtoGqGnLec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a6FoSXdRUH+JMfagxx8ePyXMWDq+1NXZG5GBPaDOaGCXckMjQaDxvb/O2RCo24PebBecGLZyk70Dg+BBeFYA019zuIyKvem+4+B+0kEwfBeDsKcoJXg7rcK/SslGTaZ9nGiFdHBD8mjXkS4axNK0Tb3Obyn6HjfH0QcHVQxlMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaT3H2ES; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so22894645ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757061596; x=1757666396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGaAkM61h3VIdibL8CNrJAlZjHRjWbnHUBI3WLmTg+w=;
        b=oaT3H2ESt6P96BRnWGaynTcLVctNl1avg4xfFHk8s0LONtl3QPZ/1+dNBgJSVaKbb8
         UmJhkZFe7EQTepcVu7vbVlG/YKxfD+f1KcQcso3UqnD2vAf1YmqWoEIvWd41bPIL7Gup
         P1BJqA2YhJqVbzKze2NKgKIwJSYDz2nIddh+jZYarV3zgmPYFVEOd07Z1tkknUqmAL61
         uH69+3gHiMMrPGZyWG5AEvb7fvwO/1LNf8+w2IRD7u2UWkW/dZDZRslJ9YKA+fFHqTlt
         aq3YTNTqjBy0UrQHc3Y/yU3Ii0AfsG18k4ESHHiApMhArdCTeGgi3CkruXokMkFiNCgD
         aTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061596; x=1757666396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGaAkM61h3VIdibL8CNrJAlZjHRjWbnHUBI3WLmTg+w=;
        b=A22cW/2Lvtyb8mFkqibQGIFyN+iLQqRFVVvbOZZ5uhB0YJIFGcWYykzE+/07qdnOOL
         UG3uU6qKKLHPrH64EVVLLKUdLHJrxA2CBkbMzw4dHekm96ixV90STh6SuWgW1jpyuDLV
         tPMTtzZHSjGSmY260yHdxLZFSnrLHZa12CL827Ae2WqTEZuz0/Md+wBz8zUiFv8dHC+w
         fwQdFheuxD7nPRy3EFcwSEThWoxiSI6uZs0gJ2Lc8wnPDXdI6zrOoO5yjZgIXYMejtwD
         7Xmf0w2fZk+yMIRF3Gcj9wU0RYW4ARWVzVFjJx7i0wsKBp0TYllbhzu6+8fXI1NPAwQ6
         j65A==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZdK8rxLH82mfOSU04QQAz27br/KOs/S+vrjiSDSZb7LfJ0PinLOQBeEU7iptMsxtmZvk13AE50+ThTdkRsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TGjgJASv+EG77B7hbEQj/+NnmPUwdhYAMA9/TlWcADv3brdK
	TM/hI19IiE3K6KR4mJ5uzy45z1tuQQCgbDX0CCEtN2+Kh5+yir8C7tnRHPK9d+4xVhwe9nO+sqQ
	vQOvI3w==
X-Google-Smtp-Source: AGHT+IF9Ey0l0Twra047lmw7Mv180RmWg4iz+sNKmRb5BvkP839d48enj0OX/10NKGQmanskpRfLbSpQ8dw=
X-Received: from pjbtd4.prod.google.com ([2002:a17:90b:5444:b0:32b:6e12:e965])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:24c:ba67:95
 with SMTP id d9443c01a7336-24cba67045fmr65288585ad.9.1757061596257; Fri, 05
 Sep 2025 01:39:56 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:39:54 +0000
In-Reply-To: <33701547-13AA-467D-AC41-A1A05963B1DD@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-6-aqibaf@amazon.com>
 <aLIPs7eqA_i75Bgy@google.com> <33701547-13AA-467D-AC41-A1A05963B1DD@amazon.com>
Message-ID: <aLqh2ojEpZZhjheT@google.com>
Subject: Re: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
From: Sean Christopherson <seanjc@google.com>
To: "Faruqui, Aqib" <aqibaf@amazon.co.uk>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+lists

Please keep discussions on-list unless there's something that can't/shouldn't be
posted publicly, e.g. for confidentiality or security reasons.

On Tue, Sep 02, 2025, Faruqui, Aqib wrote:
> I suppose a fix for blindly using PAGE_SIZE in subsequent macros:
> 
> #ifdef PAGE_SIZE
> #undef PAGE_SIZE
> #endif
> #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
> 
> Is no better and is instead blindly suppressing the compiler's redefinition warning. 
> 
> I'm having trouble finding what causes the conflict, any advice here?

Maybe try a newer compiler?  E.g. gcc-14.2 will spit out the exact location of the
previous definition.

In file included from include/x86/svm_util.h:13,
                 from include/x86/sev.h:15,
                 from lib/x86/sev.c:5:
include/x86/processor.h:373:9: error: "PAGE_SIZE" redefined [-Werror]
  373 | #define PAGE_SIZE               (1ULL << PAGE_SHIFT)
      |         ^~~~~~~~~
include/x86/processor.h:370:9: note: this is the location of the previous definition
  370 | #define PAGE_SIZE               BIT(12)
      |         ^~~~~~~~~

