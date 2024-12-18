Return-Path: <linux-kselftest+bounces-23527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BE9F6D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB637A4213
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C81F9F5E;
	Wed, 18 Dec 2024 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfC8+9Pa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5371F0E21
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547309; cv=none; b=bPk+4P0n2SLbB2MsnzBNti3UHKs7Wwei6lLvetPVagyiAYQuETysGuRr6wGhjiar2/4Eq73q3rLQxytpjOquMR+3wFhggIfKKbu1WnnKzt461TcCA8NljlfnvyrTzkcRrKvTj0w/ao9XRC6Uk8ZqGzHX3QinLi6z6VRyTE5kDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547309; c=relaxed/simple;
	bh=AmqPUcaNh3SrzGKuWPwOKQfEtsOw+9MdHoJtyldfcY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5WFuPrWNm03eJrAS9EP76wZ5MNBoofcyWa0zpKjZJNsLJCMd2GrljiT0M3Ll/2BcKdX2VYOnPOtmIqjpOgQyfl1COvnrBOjnloL+20Zk6h1bGJZ+dpUsD302ehtbnwkq9yWImc9ZBOsHIDlfndisiAsgVsuLJBcHc/rDSVbgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfC8+9Pa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-801c27e67a6so7394264a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734547308; x=1735152108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmqPUcaNh3SrzGKuWPwOKQfEtsOw+9MdHoJtyldfcY4=;
        b=GfC8+9Paa8r/xXYF6o7jCideMgdwemlEMdhbXA6HZXx/aBZJNBjKcXADGN4AgYAve+
         2pVF4tORe0kKzpVsFSc223+P/EqtBYjxWnmEgUJIZcOrTH3b1Mvl7zr4ieczUDgvl4dQ
         vFjc0CiFyaVNQq0HxENPPyjnvGcuTfrfsKV6eAFxdUCl30rUvMrTMMSdPqiJx6QkZYYT
         nYjtBNqX/8gWsX5KKPVqYOnQAN26MSMEo4Yyf5LKwKgL0J/CvBQ4iFTnyqdRNZXySt9s
         +65L2+oAdbN1x+/EXl+866p6SeuVLjfEMFv+j+4IP6o+zliu2GpDEdPzOHCYkdlPn9jl
         cFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547308; x=1735152108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmqPUcaNh3SrzGKuWPwOKQfEtsOw+9MdHoJtyldfcY4=;
        b=INppZ282PvDPJdr1YtUQZA+NqWpdfN53ybb4eCmjwWurxaDH3DhWwmyFWG39sH3oTL
         yOCz3idubuj5FChIVNzTfu23Xk+pG/kvTXfyxralvFpP4nD+J/V8hamDUo2olqe/vxAT
         Ww16W4OxLEn8J/tkE96NJ3C1PIihjHr+6HjvHMs51M3cQZ/DGGHl+Cl5xJbwbVjsNEAs
         yxNQxUDf7OBf/QFzm5nt24F+jBwZFKnQFNKxZbeRqzuYtXVGjrDXpHsB/8TS+eYg1jOm
         DiInk3oG3OzsI1ACkbp9/qm+GfhN/QnraOt6WB6/RXCB2AqTI1qPm3EoJk3Sy/JANiC5
         R+gg==
X-Forwarded-Encrypted: i=1; AJvYcCUFJDxLQZE4AX6xRVH7CTDBD4f4oubyW56XqkOyVXHZwyXE2dp8bpD6ugvNW3y5yzS/zQmIpD8e7uqWmsL6Zt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5bk4R4FbWE5bquBj75BX45YKsVegT6LWiNM+1H5WXH5TbGjNO
	/v4ng68skXCQ8FxrmN9dS/0PLJSmY2A7Og1DaNCQ6mSXASbHCEQG+WwxIincIKVgPnyt0VUXkDh
	oow==
X-Google-Smtp-Source: AGHT+IFFoI5MIImj6gtjgu7VSnwwPtAX3zR1BOO5BRZlHWotpSveP12krxH99geELMyk+gXO8F4TGnUpttw=
X-Received: from pjwx6.prod.google.com ([2002:a17:90a:c2c6:b0:2ef:78ff:bc3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5210:b0:2ee:ad18:b309
 with SMTP id 98e67ed59e1d1-2f443cd36b1mr481606a91.3.1734547307730; Wed, 18
 Dec 2024 10:41:47 -0800 (PST)
Date: Wed, 18 Dec 2024 10:41:46 -0800
In-Reply-To: <20241217181458.68690-7-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217181458.68690-1-iorlov@amazon.com> <20241217181458.68690-7-iorlov@amazon.com>
Message-ID: <Z2MXarq2lpuNh_nv@google.com>
Subject: Re: [PATCH v3 6/7] selftests: KVM: extract lidt into helper function
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk, 
	pdurrant@amazon.co.uk, jalliste@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

KVM: selftests: is the preferred scope.

