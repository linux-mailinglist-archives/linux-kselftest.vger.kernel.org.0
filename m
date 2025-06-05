Return-Path: <linux-kselftest+bounces-34364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC3ACEDC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4986616FDA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E2217701;
	Thu,  5 Jun 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qo1wvTxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F420FA9C
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119825; cv=none; b=UYU503L6NFWSI7fL9lhx+vUpT5xmwqkkCN3X6O5o3Jt6eOsXmJgbYYv+lBwqKLB/OR55bQ7aOKw1Ir1qXRNlf/eAvizj9+Pljk9XkEmWBEm0DXVXnZ/QJMjl1C+GnOmHemg1mF1n0E7+47a0Q10gY8egXkD5BerLx/em8zq7Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119825; c=relaxed/simple;
	bh=HvbmQ8S8Xhki+213LburIQLRhHEu40jaB3IQomFM2a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F47eHTgAxH+lQ5Ls5gu04cW5OgXiEgvPhYIx5wwhqj5q/i9+j40ldugdz3jCpwv5Uft2VZ2VwU0zIbFf2fcc/MUIhzX8GhyZxubWscImUfNIJh8nOYIWeyTDxi9lSN7AoOF0M6B44nv8+kRb7LotfYE6KcjiWXOAmeKZn5/4fNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qo1wvTxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HfZ+Rq3UxyS14Y2YLAxAGNmm5WZCXoHrHzmHr+0WtKs=;
	b=Qo1wvTxVQpkZShHAYtm9Lxn+jSkNZt5WzuzAzZCboF+IkIy1F03ir7yBO2dhisJHW1qB6k
	NsMvm8TMZDY6Hv+iNnH8xhfne3itKP8HwqbtGmBw6cyjvUrWSzZoM2Db8Z9lfY5DE5VMtb
	pTj3SXw4iK9li55cIt7hPEhbhYxdMj0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-sGRQIOX1PqKqDc934vLWFQ-1; Thu, 05 Jun 2025 06:36:59 -0400
X-MC-Unique: sGRQIOX1PqKqDc934vLWFQ-1
X-Mimecast-MFC-AGG-ID: sGRQIOX1PqKqDc934vLWFQ_1749119818
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so5051175e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 03:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119818; x=1749724618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfZ+Rq3UxyS14Y2YLAxAGNmm5WZCXoHrHzmHr+0WtKs=;
        b=Yvyhin/CLeyXhHZzdiaDOp3i8NyjlwFnwoLwpAvGMrxYyOxNYUG9D7B9moQeAbpbaI
         Dp33dcG6GhobBjZt4bygxWaaKYctyDSYI1kUC3hdYWKIcnOQm+7p+uWEEMY1sY1qz3dy
         CPRM4aOTTCPcfRV42lwsfu3KENRuoGB993/nO7xPubCdx0969suY2vVGeQNBbr/1GxqQ
         nRAFTxt0vAyZsejOwJQssF5NAlaDkkfB16lmGQEGMeN7MIm5Q7IYWjD7Z+loJQJoMTnQ
         dQRg0A8EKRPvLKWbUK4lC1G2NaEU8AMJOZc7LLHgkYAL4oeQjjQbgwn+IJwFnFsh6YBk
         p46A==
X-Forwarded-Encrypted: i=1; AJvYcCW3obMu+fK8AzQMRULKQZo61vpflihBH/VPIQ5HhG2AmKRNkgWDZ36bV7RyIRrV241T3j1Ts9ePKxPLagJWUkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwiX7UZChCpSF7MaMRQQNbHbn31kGsp3Bz90/rSBwc9FUNqp8
	dS4JtISulf2hYHGpp/Q4bDToFvEqBFqcluST1+nIKVjEAQqQw+Bqa4oHBzFgPf1WX15yk9SUBIL
	9kwFP4HIAQQQ8dHwhltIc+2ScfbwAad4ob0sfxriSOXw9pzRWFwzvNIQfsVVsE5QenKWCJg==
X-Gm-Gg: ASbGncvBepAwetXl+ySGWslvb7d5UOVSpHuTz0EOGqFgMhx+Frof7UsPetLpiZzOj9I
	6HV/NBXLc/Vjhuq96LGXCPuANIKBbd8+s3pI5VyweYrZH9Z8t3WBZcEjLC3VDQGrWTKxa++W1fo
	C7cxtRV4krzo0KbPXQATMjg0Ah2sOr5iGVw6LaR1G/IryWyuE7uOlX+6M5Br2qQsOMCqqfiyHsL
	dk5tbZUBrrp2oqARlipljkIdvKJ/8QIA2yhfnqHrntO3lfugHNe39YJ/7jVF9md2L3lqcvCOoRS
	QUy676Nx/lEFcNZing2H8b+p3Zh+MJUg0u5rLWSrx+KYkUTS/1h/VKXWWpg3f84c+DJJsCwF3Q=
	=
X-Received: by 2002:a05:600c:64c3:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-451f0b42832mr62125215e9.30.1749119818008;
        Thu, 05 Jun 2025 03:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1bx8suhPbgO55wHNgDBL3CiHw3bkoX/59SOoKYKbZiUG9FMRz0rmV3itW+HwRwGTHenI8UQ==
X-Received: by 2002:a05:600c:64c3:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-451f0b42832mr62125005e9.30.1749119817668;
        Thu, 05 Jun 2025 03:36:57 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:36:57 -0700 (PDT)
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
Subject: [PATCH v3 0/4] KVM: arm64: selftests: arch_timer_edge_cases fixes
Date: Thu,  5 Jun 2025 12:36:09 +0200
Message-ID: <20250605103613.14544-1-sebott@redhat.com>
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

Changes since v1:
 * determine effective counter width based on suggestions from Marc
Changes since v2:
 * new patch to fix xval initialization

I've done tests with this on various machines - no issues during
several hundreds of test runs.

v1: https://lore.kernel.org/kvmarm/20250509143312.34224-1-sebott@redhat.com/
v2: https://lore.kernel.org/kvmarm/20250527142434.25209-1-sebott@redhat.com/

Sebastian Ott (4):
  KVM: arm64: selftests: fix help text for arch_timer_edge_cases
  KVM: arm64: selftests: fix thread migration in arch_timer_edge_cases
  KVM: arm64: selftests: arch_timer_edge_cases - fix xval init
  KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width

 .../kvm/arm64/arch_timer_edge_cases.c         | 39 ++++++++++++-------
 1 file changed, 25 insertions(+), 14 deletions(-)


base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.49.0


