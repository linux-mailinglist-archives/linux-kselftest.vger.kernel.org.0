Return-Path: <linux-kselftest+bounces-32750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B9AB177F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C749850E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A521CA17;
	Fri,  9 May 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF8VjHEg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4D221DA6
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801210; cv=none; b=BOOil6pMIybtl6t/89Rdiq038H1GQF6tUgrP63U1k+TRNGbBRfV/wrAfa4nVFg1G5e4Sz64S3wkfFHZraY2/mQTEZ+PZ58BFVnbpauOwPhD9iz4hmV+PxRWh3h1gOIMdgOzH05aiU9hIUopEyI80wmz7ZyvDUv+0m0LKuMzTmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801210; c=relaxed/simple;
	bh=FFvBCknd8IuGRR/pjTvYSyuDF4+NszF59ge0pjk8rhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzIyio0viyy5mx9iPCgAJa7Np45lLEGZHAjYE0XKH0sMD4dvS2VLdUHZ++ObIzrqfbT5a8HKrGfDXZrVFNFc2ER7fsck/i+XRJNtE+jPAAvnYXqhhNIgxkxclCO2iV7/pzqbZwompTXu6Xlg1dS2XmAoAs+tPJ9tj8B42AGHwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF8VjHEg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746801207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VL9vZro0BdFwyk98zVNm2YYJ6CabP26FrlBnQZyFPJw=;
	b=MF8VjHEgyES1UTUSqoku4vgaE+5u9wKOZiJelhpFZ01K+Hr9/DZF+1ZCmQikBrI+w/WGuB
	Sn12+RMALT9T7QzJ0PAbQCDt+IfBVKpG3z4uvEtjtUy643tq0dNcN37vteas665s66T6NI
	UbVWgfn+z54QppdMCf5p5dO6hFUQz5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-6lqTrGAUMqyOfbGKiDMqxw-1; Fri, 09 May 2025 10:33:25 -0400
X-MC-Unique: 6lqTrGAUMqyOfbGKiDMqxw-1
X-Mimecast-MFC-AGG-ID: 6lqTrGAUMqyOfbGKiDMqxw_1746801205
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so10541605e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 07:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801205; x=1747406005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL9vZro0BdFwyk98zVNm2YYJ6CabP26FrlBnQZyFPJw=;
        b=R5aXhCfLsI5Gz8ZAoUkbbSYimIIzAGjfjJ64g8JBQC4hDkKWZvTekCMprxgU/RJByd
         +tiOKcdZqAGmYFyVmIcWkq2XDkf/w2XFMMZuO+K6ecxwBlGjZONbiquhkJvxfACbbrxN
         WhXchGnU1vYqLUUoNndY1+zQikGZCBRWKULMk2Lpni3RisL7kSTxSz4CNBBs3DMW1Vnv
         ytgoUoOjrcska15Pz+H9sZ24WZELpsfsT/U77CUbe3M7gwZMDpKUw9lHBPvgoA9FIw54
         bEEq8WtsNm+zFXFjIe9qYc1NOhyf3HrElesBhGUBBqHywP+6ISpg9dfr+BXT2CcMmE4F
         7eZA==
X-Forwarded-Encrypted: i=1; AJvYcCWDRwCFVgsHgtVTJPUBXpVTYYzJpE/5jT68ZhxZggS0zNSp4tRJi2IBevvIIOHK2qMHD/n9fGrYE0YDjzuquNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrFQM6cw6ixPE8g13pP9fqGupyAWwCYhe1rCgT20XTSru59Db
	ZQ08yWARvgMgOiqUK4fbxEOunJd6rOCCxdGOo5+y1ofFvdj3XkSLbnZvqTxxGTQmwNtQbpPl+Rg
	asX+p0KwVFnfc/2D0H+N+u84l3nRx4mQnr6JGO7SOHcEl+TDbA6mNYDGBed7MewaA9w==
X-Gm-Gg: ASbGnculOB/VJ2ekdTIqR24rdlhMV9fm5q/dgq3PM/RF/KByKOZXd67U4zesZAZnrBG
	9T5LBYP84MXISVf/S3OsN1+S2Dd87GecYxyUOAr4nNyME2H5f9iWKimGjB09BG3bg+A72qYS3eg
	v+EewwvtK5nLI8634WorHyNhtfIoze4p3+sGMa5ukXcqg9ZuZBZEo7ufYLn3LlosmydeH86uTtC
	+zJznnSQ3UhBAW4fxLsMniQFlxC4Qg39DYRzx6wu7BntGa9Ln33R29B5hZ2/zg8EndL5EKy9iZ3
	zgWerKjhEzX87Hzj2Pv1qacfWerpEce6LGiiHiByH1Sis+jeK1iF+ZGs1vjTMIqsfEYMlbBOv0M
	=
X-Received: by 2002:a05:600c:83ca:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-442d6d18302mr36807245e9.3.1746801204811;
        Fri, 09 May 2025 07:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWDESg6zUq+whRTNp61iivnxaZlKkiv8gH+MG5fYiPl5xSd+s4VyqNCOQwrNmOxuB7m8DQQ==
X-Received: by 2002:a05:600c:83ca:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-442d6d18302mr36806865e9.3.1746801204462;
        Fri, 09 May 2025 07:33:24 -0700 (PDT)
Received: from rh.redhat.com (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm32150775e9.4.2025.05.09.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:33:24 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 0/3] KVM: arm64: selftests: arch_timer_edge_cases fixes
Date: Fri,  9 May 2025 16:33:09 +0200
Message-ID: <20250509143312.34224-1-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some small fixes for arch_timer_edge_cases that I stumbled upon
while debugging failures for this selftest on ampere-one.

Sebastian Ott (3):
  KVM: arm64: selftests: fix help text for arch_timer_edge_cases
  KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
  KVM: arm64: selftests: arch_timer_edge_cases - workaround for
    AC03_CPU_14

 .../selftests/kvm/arm64/arch_timer_edge_cases.c      | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)


base-commit: 9c69f88849045499e8ad114e5e13dbb3c85f4443
-- 
2.49.0


