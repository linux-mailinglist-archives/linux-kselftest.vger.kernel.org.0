Return-Path: <linux-kselftest+bounces-36822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C12AFE8FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F25E5A2548
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA6028F93E;
	Wed,  9 Jul 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4G0vOHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDD35962;
	Wed,  9 Jul 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064368; cv=none; b=r2F73qNo7dax4g3+EmunzLddeDtJgrVxK6qoJsQqkWwljehQ5k9kTe+dpjknzJkSJ4ikbi364BaZgRXUabpQVQufL9fsZ3zQNJb4eMElazl6jHIFZyOJVmuamT3IltYi1ii/4V2POy59xiTmzKPH7ZwDb+OTCGS4NzdfhvJaHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064368; c=relaxed/simple;
	bh=vUgZWXRD5r5At8FEilhHFTYoFodE4/T0JbQ8YS6pAyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSVC2hpKw73HL2/qU4vu3+mRj1eCkyZhkBEas/GtEetRyfuFYxoPIoyAPPUYhWPbLfbeGF0qwVzewwUlSp1DyTq6LO+opK37qbcl/vnIGGLF1I7z2EqHFpNY1zI849zKnQ42L7+G2CMQV2lBEB+7S035YAdW0QIpz2l1kRoWm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4G0vOHT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237e6963f63so36060525ad.2;
        Wed, 09 Jul 2025 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752064366; x=1752669166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgZWXRD5r5At8FEilhHFTYoFodE4/T0JbQ8YS6pAyM=;
        b=E4G0vOHTAqrm4VS7ADrX2Lcqy7DtNIUFkoPS57u6omdWVljVknuzGMlNYPGXyWIAKf
         Ctb1M7OkCZs07wcmpPfdyWhOrmrGwIjZ2De4DdFDgtICAA6EttzCsX/DduKVt6bBmf1K
         U1MgKIzjVtaJIEx7ZON72pkorq8DGX/BOQVZC1uJnD/vvPI2vRDqeC0o92AUK+GIujMq
         zvx74Dy77YBakj/dHZgxtB6lveNDXlolvZs8X1J6ihUf99dHOsg5m57oADl2ItlSHw/N
         rPGIeJ8qRYwZ15iZySgxOlMRM1kMNTycCf37gc84yuef1k7UGaPnMGgcCW2vdKTVpPM4
         FMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064366; x=1752669166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUgZWXRD5r5At8FEilhHFTYoFodE4/T0JbQ8YS6pAyM=;
        b=kedaIUuWeOM2noO82QtdUXojUndBujfi6Vyc3/YscEbV6KwOX3nsf5RGu04/HLSrTl
         /UaZ02wwz7ONkr5LOF71/1t0pKhRgWJjipW1PBykWUS+WQiMz+8zhno+PIgEwj4hIKDq
         3ZzBqA6o4umWuXM54zDKMEmGYy99fgkq7uLnSh7X4t5yj3rttiWBlXgD3aqCsUwvd4ml
         pCovFzYqQEq2ZJ+LIlOfDzF0myJnzV5VaoiQf+mDt/2IMn9kZEJWN3C9IBZSYOLICjOj
         iJ4WnI23gquPlfgWRm2m2c39rPvwAjrEIjCrWJTEoryb4qbFFHGdrjEMEtGCkjIZJztS
         ZFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUgxtn6WrQD2y7vqZpuAVhd7gCLTpJp+qyFCHt8Ebr8cv6bJFyAnlun215Fo2E4VQGbFzVwDdoDOivXjw0=@vger.kernel.org, AJvYcCVcoyfWhUFjAKON/bjxBzky6KLQdWVPXzic2MuWo3T0k5NI0C7/6iiMJGzSi+QF8gPGcuHppBitbcUWQAWTnuas@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlx8FEUT1QF2zMNnrcssw0s68OdKEhBsS1++Kd9tmb2hOqgOjp
	GlzekItz6m9Hsme3PBgamRB1GgulrNH4NocRj9TQiCmm1Ah7tjX/ROevJe1sjA==
X-Gm-Gg: ASbGncu8Z0cUd6BIRnwS7R07wzEkQXu2gahXH1RG3Q2IN1A/+NTehLRxQTTlcA/LcXq
	yGHW1DdUX2qmVGPhQRm8OIrDEyo5g9bRNmhijrrIt05Pm16pTEwhzYxRVgTthsjFYX2y8oCZWD9
	7tRHEzN0kOUzOqaPV/Dde04d4pefkIX7za7giMgQD86NM2i9QJlM6mG1LPp1a6VbOx/xWHF/SGK
	OEM/5JlF6wABe2by60hnv2JLlQXRNngIgPpUaO2KTQNvgmM/i8YCMSmKq87LcQMcCu+QmswGSYp
	hM4pUzWj3pAzN4rGGorbmqUsvgb3KNjzOUHV7qgFnH5l+3XIXxmt4aY7S/IO9ppfmFDftpu7gn3
	yp8fAEnWX
X-Google-Smtp-Source: AGHT+IGQEif0XEQzRRIUBjTfM8pgAviVputbdsxIMjf++GKcTd6bZgPMxBnWALMlHl3YMEXwVnVkxA==
X-Received: by 2002:a17:902:ef47:b0:234:d431:ec6e with SMTP id d9443c01a7336-23ddb1983dfmr37348155ad.3.1752064365748;
        Wed, 09 Jul 2025 05:32:45 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a189sm136381455ad.27.2025.07.09.05.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 05:32:45 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Wed,  9 Jul 2025 20:32:24 +0800
Message-ID: <20250709123224.6593-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zi Yan,
Thanks for testing the patch and reporting this build failure.
I don't have an arm64 environment readily available for testing, so I
appreciate you catching this. I suspect this is caused by missing or
older userspace headers in the cross-compilation toolchain.
I will try to fix this in the next version. If the problem persists, a
good solution would be to manually define the syscall wrapper to avoid
the dependency on <sys/pidfd.h>.
I'll send out a v4 with a fix.
Thanks again for your help.
Best regards,
Wang Lian

