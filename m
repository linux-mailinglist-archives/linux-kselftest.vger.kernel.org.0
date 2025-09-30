Return-Path: <linux-kselftest+bounces-42639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D98BADA46
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38793B44D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609A30594A;
	Tue, 30 Sep 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoyu7XAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA10223DD6
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245102; cv=none; b=FpcRNMUkI45TJiMyKA5ZUtjjJtJGOhVKDphRH5584dngDxDzC8jtjcXdMwPDI03MJIaJ7/rSnPONF2U7NYGv7+rX+BvtBc8zbZuZjEjOGGNSmLPVrZGeMLYNMhdQJ+axx9fZVtPfMOHhgdNv6K0DOaP/m3vSBhmkis6vvyMdZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245102; c=relaxed/simple;
	bh=EoQoC9gmyDFd04iDE/2CPVDmTENmOaGyZ91Ul897hi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OLeHHIg1UBX3K+gTEtAuaD3CkcVzDaiecJhMkCIe9VTn66FuqAaImNZe/D+d/LC46VTMdLkcPFoUKGvCA6F6UVCnXcQEPwmWD0GeiwDyPpDBHWSuk+z31c846/SJ69B2Z5uT1D8pNwvUVM8eOFoUFaDDKj2inB7CawfuoncZ12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoyu7XAx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f86568434so4259868a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759245100; x=1759849900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRw+IQDxMuuhxFprgh+nTQeMioqYSRGrn50nIsG9oms=;
        b=aoyu7XAxUwoLK7wIlffUYIJEI/1xFiKHxTEIzO0Y81xADl0TcRuCrZM1tvnvUQYsnX
         Mvb+VIDph920gD28T1LkJpJcwibWN9oadUCCOJXLxxljQUaVadk9sek3UKYCXowJbluJ
         C9yeOun1arQR5ivB3jI7AmfEkylN0ujlKY+FMrgYroN3axq1CTRUlK392ZYZVW6BP21O
         maYqs9yqhLr8uhGDFVkESSbwQhH4TjdUrA8oBf4WLn9R//QABiKCDnyX2Cz7SYhBXcal
         UX6hDp2OcJlYueEe8m2rXH6KLMz4tKn6vTwzqU4Dg4FU8XuBIgFp9xPAoJFTw0pdr5j6
         O0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245100; x=1759849900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRw+IQDxMuuhxFprgh+nTQeMioqYSRGrn50nIsG9oms=;
        b=Jf4cBnasvh55ezwV5+2AnvB86wBZTP7WJu8Xku6GtmVXxJBdkQ6gTSgg4dYZ4bHz7J
         S1bHE7lu922O3pULsNsi5Ms1gnSnn+qY59VKYI/r/ac/3LDrku49YjvzgDM9ao21/oT9
         kQtgUb5OO73MEDlAOOBEpHCNk3vI8lk+C4JF0wkPbC1Kg5PXaLHmf1tZTnLITGj2NezK
         fRfakA1rX4oNPSzxtZQfOeo2bx0iztFr0ARbGr7Yozl4Naqswyjr87u3EBmLAPwrFv3a
         rJklQFnM08fxLo0K84onab78Cf4DZ1jgOV7/G2/MRnfa/O74XLilLFaKHvgyo/QhOUDu
         awJQ==
X-Gm-Message-State: AOJu0YwuM5n6H2DCBAfqHQjP9QjQVz6ZQlOcWTWwPIjDCivQRlaymmOl
	6A+I03fND4VO09BZ5l+nu5522zHN9FeOqA0ccxfZuT37N7wDPh/Tf0DlLIvGBE/5z4+VA/UtCUx
	1r5YzQw==
X-Google-Smtp-Source: AGHT+IFBJmhE94WYrCLM6s2PzvuRfYNTdKgTIJ07w4Sqgez2h3b8qceYm4qVSWPiyT7z6wceIMRCZp20cTU=
X-Received: from pjzg20.prod.google.com ([2002:a17:90a:e594:b0:339:9a75:1b1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4a:b0:330:72fb:ac13
 with SMTP id 98e67ed59e1d1-3342a22cc80mr21528295a91.5.1759245100148; Tue, 30
 Sep 2025 08:11:40 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:11:38 -0700
In-Reply-To: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Message-ID: <aNvzKq7itcc3ZY_Y@google.com>
Subject: Re: selftests: kvm: irqfd_test: KVM_IRQFD failed, rc: -1 errno: 11
 (Resource temporarily unavailable)
From: Sean Christopherson <seanjc@google.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvmarm@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, kvm list <kvm@vger.kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Naresh Kamboju wrote:
> The selftests: kvm: irqfd_test consistently fails across all test platforms
> since its introduction in Linux next-20250625. The failure occurs due to
> a KVM_IRQFD ioctl returning errno 11 (Resource temporarily unavailable).
> This has been observed from day one and is reproducible on all test runs.

It's a known issue[*], that I think we kinda forgot about.  The underlying issue
is that KVM ARM needs the test to create a vGIC, but the fix stalled out a bit
because there isn't one single, "obviously correct" way to do that.

I'll Cc you and ping Oliver on the other thread.

[*] https://lore.kernel.org/all/20250825155203.71989-1-sebott@redhat.com

