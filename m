Return-Path: <linux-kselftest+bounces-43162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91FBDC9A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 07:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AA53C6C8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26DC302CC0;
	Wed, 15 Oct 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N3ukWesV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE514B96E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506286; cv=none; b=SNttqxoIQhY3pIH8quqeHg7HNhxyCnZgsDwJ+1c/yLH5b9E/+WbTKDT3vC6hZbUy4KPXqPUi6Beap/1sJJl3MFa+bZQViQSsRh29zmjX9iQYuHo+NOH7BCITA4wPnLsFvjR/VV6RAXyeP1I9df5eBtzLIw4P2l6gmvkS3i2fKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506286; c=relaxed/simple;
	bh=FC2x9/tDvjdm6NlGJ48dWxXsYmuCn6FstQTJWM2NJk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oaUhgZtPsdUMb3igp8Gl5sHDuZ1vIUH5VT2NcYwmCCW9tdPfuRw6OryOhlwOUFOgkm/yxQBQkfSPYLHjm+HWN+NlNaZmC4F67nmMpLwWBO8DCmsbMwu9oirC0CjXzI/SWH6LAvdlOZeqDIMRfyl5uLputhKNkAG/tjGiUz9mJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=N3ukWesV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-799572d92b0so81639736d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760506284; x=1761111084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ks0TQAnc2WQfMRFVV4u+78N4hNnTBxLoURgsapwl7yY=;
        b=N3ukWesVTltoMTYiIWCEBoZDLoJDSLAedyquDPHHnK+I+zqa4qMNKEVYcEsrVmqSOV
         THVHeHwnEMk8+FEh5AyjZmF6g3XoTwY5bUkKvFd4NIjjivNVAAH01jzn6SnRI5P5lSYT
         3VjpsmmXjYPjhe6/Ar1OZnIxXmprb/mHIwkDMxII3L6yop0CaF0STgcwAiBsnSd4dxTO
         MnrAqxAMZ9altr+vZqexLvV9lEPnxr6E2qOhAnBcWarDNn47Dd/MFkAVmRtD9U7GG3bJ
         54XUlmQ4RCwyDcjCotZIjRMmOKHh+xceoRfJB3s1Y1tUsKIVFuS+fxJVMjlDQyhpe7hI
         pYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506284; x=1761111084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks0TQAnc2WQfMRFVV4u+78N4hNnTBxLoURgsapwl7yY=;
        b=aSWnG9VLOH+2m/uCnY26EqhtVWDGrXPuIZYuZQgOMX3F7QtvOE8Ch4x17qnpsHlRuD
         /3ICiIGhaFaDNXc/QJmr+bdH+grfly55aYQ13asd8EA6QMaC0CUB0whDWedn4TSxo3us
         uUqA5L4ob8zU9emzmGry4mKCKVN0bMESskNCmLQHvQfA1DRlDvmn6cSmvMUI2itvdwVP
         BlMfRVFqkTYIXbXwN/U+JZVkZw6zCiIhT3gtXgTgVakxjdth3x9IPFhVvAkXHkg43p7v
         aPUEiJB7cvU9kv4Iv+6S60g8Y443yRQhhsF33+Rh14E/CEDd7M6auhEL82gqFz/vnkv+
         KdFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+pXZ4/wTMFhO/xd/KUPbFy/yMrlTkeHHpHGPNUfLLSxbWlceTwUFJqafSskGRdwD8qcM9TTxDJ8KEQHSaYw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UDtbV65ocA/arkWIld78yLVxMkR7fMY6QWnt+mgAJrXrbhNX
	lf0NA9mJEVPOfRHwZUqjANzMNhX1CL9VYQ/nnNphKPIeQXnwFrBkuMGk9uKv+mH2bpI=
X-Gm-Gg: ASbGncuqSmSSso6oE/9MXn7Fvo5u7AVCFRSUEXpXgQihbxFnI0CT9jhxVUBce8oRbzU
	ilBKKmklREx7P2dl8CEs5Tb9B3CnYtgV0wYLG9EcQ4TbEQQpMcWib97byPp+/J0ugfCQe9z/cPP
	mTkz756GNSA1b9JeJGcdNuy+B6FkxNCz9vkpjOdU9V5vUJbaA9+ZFWMV3UPz9g0+yjCh7QaWA4/
	H1Fwgz9Kj9Z025dsLtl3MXsm7aGDZToN95dQYR+uAWMx8V3WuBve3fTenfVpWhd0/J4XmuLNLal
	jEOrZQ7yRxSnnDEBvVturrJXij5uWfguEWDoEmWqt4nJJgLACvCgxnlMHklr1YWf/ANy/NpuFHA
	6/Vp3YkdeabObFXYQxgfGBI9oPfRk3yLRLFe6a6Vll4J7CAkRnEabUUIveG/DS06VY1566RpXc2
	wbEMSWXK0HY+OBR3kusLv2AUrppoVWZbcd48BWj+lrtWRMmqjBAYyx9c5qG1I=
X-Google-Smtp-Source: AGHT+IFFjRfzxETp9modlQvk46r/Xd97DWmwBK2yN4Skk/yXeTLEsqZNHWkGihrbcaSsTXWHRc93BQ==
X-Received: by 2002:a05:622a:1a9d:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e6ead754ebmr314014531cf.80.1760506283865;
        Tue, 14 Oct 2025 22:31:23 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d01f5asm12572661cf.27.2025.10.14.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:31:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH 0/2] KHO: Fix metadata allocation in scratch area
Date: Wed, 15 Oct 2025 01:31:19 -0400
Message-ID: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a memory corruption bug in KHO that occurs when KFENCE
is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area". This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict. If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

The series is structured in two parts:
Patch 1/2 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
that adds checks to detect and fail any operation that attempts to place
KHO metadata or preserved memory within the scratch area. This serves as
a validation and diagnostic tool to confirm the problem without
affecting production builds.

Patch 2/2 provides the fix by modifying KHO to allocate its metadata
directly from the buddy allocator instead of SLUB. This bypasses the
KFENCE interception entirely.

Pasha Tatashin (2):
  liveupdate: kho: warn and fail on metadata or preserved memory in
    scratch area
  liveupdate: kho: allocate metadata directly from the buddy allocator

 kernel/liveupdate/Kconfig                   | 15 ++++++
 kernel/liveupdate/kexec_handover.c          | 51 ++++++++++++++++-----
 kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++
 kernel/liveupdate/kexec_handover_internal.h |  9 ++++
 4 files changed, 81 insertions(+), 12 deletions(-)


base-commit: 0b2f041c47acb45db82b4e847af6e17eb66cd32d
-- 
2.51.0.788.g6d19910ace-goog


