Return-Path: <linux-kselftest+bounces-23529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646D39F6D8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43332189036F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A431FAC4B;
	Wed, 18 Dec 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kiq1TdhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AF1F75B2
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547494; cv=none; b=nFdJLzyhcHytLfOC8N5/At6b3G6AG7hgXnFrSL7dTOfRT8wicAClukM0otAwtWrRV3bgJD7ypSi98cupKeJxXbhezmqb78SCp6DVGeVoTPlbyxHA9qurd4M+JVkoLShS90Ij7KFlBAV/AqwT7hJ/A2PeLhZXHVdmaPa9gRhd64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547494; c=relaxed/simple;
	bh=9N1nw5pDv+lDvi7BeKzhIjUt9l0WZpYj+8WvPGktrTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSEo/xNqNn8cBb5njMlfCwhqMt1Uw9HmCtTnk2XmSQEFYcPR9jkmbe4nl8HE3bZZmd3DK3Bniu3Gx/aup/azWFBAsBhJ089Fu+s+oEtWgq5k4Oabb5GuJz9zvYbhgvL2PJDbXnrqzGhuyIKZsaFIHu2oEe55aRcztQw/P9jV/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kiq1TdhH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f71e2fc065so4403373a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734547492; x=1735152292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAiuyQN341JkpI4EyBxh+99WaLVM7eEU9nP2zLmsuDM=;
        b=Kiq1TdhHidnc4A//NzLJne0SvsBj5ZP4gzPCRsrN95BrhNbNomhnFJWvRX+3E3qLOf
         7KTrPJws4xD0+vSbUSsUbn/lU9QWZHUbd3sVgfvfjRNnXuLwDOk0j84zBnuXwRa1CIO2
         KienbbW77DzFUj6dLmWWdg+Z6S52oMnCcF/pia6T525MUzZlCPs520QRvTmJfEFnv0ks
         I81KYPGmYHIqe8WLJHpKpkUa+iT9kRe38gNWUSNYS0wS+KcaEgI35Dyv/Q81evkhi496
         lVP9xkVUIoTd9b/UH0irfG3cTGhtuhnAejNkb3pZuuodgTqtbZEIJccxXotchxSQkN/M
         /8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547492; x=1735152292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAiuyQN341JkpI4EyBxh+99WaLVM7eEU9nP2zLmsuDM=;
        b=Bw6yP4AIDBNO8ViCR3TP7sNGM9abzAJol12vATYfpaNaH7cFnnI5NIBGta9DWxbVpm
         PfSV6nEODAUbKbstT2V7egGUO+Ujah9Bj7bd6w8fQSNzjGySx0etmzEgmkoaP8uepiv5
         jVNfuQMNuYhwfYA4gIr5IGClDB2dZaqCeLdzifmhIlxfORwMx+aCt7Cz69YX8bCYTyA3
         8lp/J9vFnrVuuLJh7/c6L5QjgHProKaShGjJk9q9sYypaUeNYEcM3r4wQO/pHmn1O+97
         QAqko0dV8VW7S6ptERiIujxmlSFh01UzUc2JLw5IFWe7mKt20cEjviHJZbdI2NuCWTJg
         3pYg==
X-Forwarded-Encrypted: i=1; AJvYcCVGkcNaiWdyCEAtOnEvk7HhaaynI6dws1IIkWTVG3OQdHigC0JpYCgH0wTyeJBwzXZuOd5im85TF3Go1TTZSAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuEOSx/wTsKz18STO9Db22ZOSHIKUjgehsKCXTIl1BQpeY4lq
	AwzGklLNeUOslFDb9/+Biukk0I4F2ojYt/eLGHWVu3DnFxNVMJE7WRIh2pbsLugjtJO7jJ8EZeN
	hwg==
X-Google-Smtp-Source: AGHT+IH+sl+v/O3EB94NvcKnWSkH0NdBBH9kGuVv5fLPWor3f5h3drQQPuJCwiKgIop1mJ7cvRHthevdpiE=
X-Received: from pfbna12.prod.google.com ([2002:a05:6a00:3e0c:b0:72a:83ec:b170])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999c:b0:1d9:3acf:8bdc
 with SMTP id adf61e73a8af0-1e5c76f91b4mr440300637.46.1734547492547; Wed, 18
 Dec 2024 10:44:52 -0800 (PST)
Date: Wed, 18 Dec 2024 10:44:50 -0800
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217181458.68690-1-iorlov@amazon.com>
Message-ID: <Z2MYImBJGSjmBOII@google.com>
Subject: Re: [PATCH v3 0/7] Enhance event delivery error handling
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk, 
	pdurrant@amazon.co.uk, jalliste@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 17, 2024, Ivan Orlov wrote:
> Currently, the unhandleable vectoring (e.g. when guest accesses MMIO
> during vectoring) is handled differently on VMX and SVM: on VMX KVM
> returns internal error, when SVM goes into infinite loop trying to
> deliver an event again and again.
> 
> This patch series eliminates this difference by returning a KVM internal
> error when KVM can't emulate during vectoring for both VMX and SVM.
> 
> Also, introduce a selftest test case which covers the error handling
> mentioned above.

A few nits throughout, but I'll address them when applying.  Thanks!

