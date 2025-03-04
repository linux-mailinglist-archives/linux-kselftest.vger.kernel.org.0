Return-Path: <linux-kselftest+bounces-28189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF2A4D76D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC21888AF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EABC201261;
	Tue,  4 Mar 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IEIpI7Mr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C521FDE1B
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078700; cv=none; b=qqsg7ocIZpo2/5dRUsMlwDlsP3IWXh/BpXJrGRdo6Vkdx/O5Bk1DBI2OqqMI63TUJkdnBiKvyWXLSRP9QuAJciylwf56AcaonXnOFmTDV+0s9QtrvaYQh39Vp1g+nO5WiDFOSltDnqSOhvt/dMQ5to+I82j0AOZY/FbNAu5czf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078700; c=relaxed/simple;
	bh=+xt0a9MOKxcngTL6D0NlkBxMF5DrrijsvR0wGk0H/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJOe2SLtwcmT0JMciWFFd9DIdCfCAk8/sxeHK3TW0c/+ToEDIIRsYW9N5MjJkP04z1zmFOrIQQZCLZmIsxrNpfiPTxhGkFe2knoGSXdzZYV5NGhhRSzds7bwbYMiCClb46XBCXAd4YwM6Jvns/8j1bgnRfifEb1uoPWyn3HGkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IEIpI7Mr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so13269195e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741078697; x=1741683497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+xt0a9MOKxcngTL6D0NlkBxMF5DrrijsvR0wGk0H/sc=;
        b=IEIpI7Mrji3V5JToFgifBnmPzuPqpxdbGvSG9pgENAij336vUAkJffHrNwUihyARcL
         0v1PXvSnhe0o1yIziQIpnZKt30TE3D7RJoIgwLK2Z6RUELd6JTt2WWS54GmnIZcE1GUs
         czZ9fqN1WNmC/KP4yCHQLUuPqdOMofUI+weTDMvATao3TkqiK4XIqq0QEDW98V47lN4+
         LRNICUzQmM0r/H2cq4USqOTrLdeN5Tp0lox5l7vI5YQvnGJNd2hMw9truppO1QWOXBZ4
         kVDeb0aRqFUGAKZlMINb3D6kbPTo5b94oiBjGcrLDwJc7yWGzG+F9f7jwmD99kidVLqF
         CqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078697; x=1741683497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xt0a9MOKxcngTL6D0NlkBxMF5DrrijsvR0wGk0H/sc=;
        b=vsKRlXt9qQC9Xaq0CUJ9U4K/DjLJ/w4dobvNYxUcDw8wDSotxVTbwKgACw5hNW+QHP
         jsLIfPKpS+HBMhyyjitYyYYlfEq1JYUGl4Ts5INukMyorN+aO6H18941pUUJT4YtSWMz
         jmsv+LvHBk88sa6QU+3XMcKd6YBbmEL1v51r1BGHapFMGFcEeyU9+fxTI/BhrUNg+4lP
         ddNoXy+k6ozZmuEKlj3ikbODLFEYQMiWYEOXteORkPYiqUb5u/eNm9JMXyNzoWeDxTEy
         rWA0kEuASZcCd+3tkQGuLzETrTZTjxdlty2Sv4H9I5nm/c/saKhS+jBabG197iuK5NvL
         3lRA==
X-Forwarded-Encrypted: i=1; AJvYcCVP7zPkFVgZLWPF2krIfjHFoN5+WErXjRGd3O8wfKd7+Dmq33MR3hmuV8X2c2KojjkopA8tYO9aMcjU2iJf0vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFCZzinn08UbqjPZmQKX5OABi+d5GcP6Cd0U8CvMFEMxewOGh
	YSruy9/TVhudDqwOeSrK4X+pyIntUKR/QwHblrvsHnpjo7UT3ZndCruon1ylEE8=
X-Gm-Gg: ASbGncuzg2kofACv1hyStnAVF8Ebd87Qrpise4oFI780YNDUvt34OI0KKvXIxzBLDl6
	32HymaevzmIu9x0YuvxePzD7SYmis36hypER7TxllgNUa1E6o1y0fyAvUcpG7ioyD6VJJnegJsZ
	P0lT2b9pjDFSbBG+9/q1+47knEkqUslHI1aRVcHsKUrspAQX1rknm6U+njpZ7O1o1jdJ3Ecgbew
	HyJy96hygGuLqnK3zM/E49AZDjxEi1fHnriVrZtjPvY3MnVME3aWHtEh7d8hQK14/F4MSbxaIN4
	+rIdcQMMrl4w5R/VyKqYAskhKKcVUu24
X-Google-Smtp-Source: AGHT+IH6MvxZS60faFjjSE/SOwTs7ArGKMS/DI+pAYNkmL1uwIQZP3dtDN6thfBALwaicYstcm9hQg==
X-Received: by 2002:a05:600c:5111:b0:43b:ba52:bcaf with SMTP id 5b1f17b1804b1-43bba52c199mr77383595e9.5.1741078697098;
        Tue, 04 Mar 2025 00:58:17 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e03asm17306599f8f.95.2025.03.04.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:58:16 -0800 (PST)
Date: Tue, 4 Mar 2025 09:58:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Allow number of interrupts to
 be configurable
Message-ID: <20250304-5a85b3a246f14f60f61a45e0@orel>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-4-74c058c2bf6d@rivosinc.com>
 <20250227-f7b303813dab128b5060b0c3@orel>
 <CAHBxVyGGw6Ur4Kdd8Vvwp6viKWPx64w7gNvNiUzmAGeXF2PGoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBxVyGGw6Ur4Kdd8Vvwp6viKWPx64w7gNvNiUzmAGeXF2PGoA@mail.gmail.com>

On Mon, Mar 03, 2025 at 01:27:47PM -0800, Atish Kumar Patra wrote:
> On Thu, Feb 27, 2025 at 12:16 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 12:25:06PM -0800, Atish Patra wrote:
...
> I will change the default value to 0 to avoid ambiguity for now.
> Please let me know if you strongly think we should support -n 0.
> We can always support it. I just don't see the point of specifying the
> test with options to disable it anymore.
>

I don't mind not supporting '-n 0'.

Thanks,
drew

