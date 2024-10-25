Return-Path: <linux-kselftest+bounces-20706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A39B1153
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA88281FA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71020D510;
	Fri, 25 Oct 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0EbxU/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528F17B4E2;
	Fri, 25 Oct 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890250; cv=none; b=BsgyiQKy+u/RynCzjNdhlsR1ChSbzTX5gh5TQUHXByqwzu20E7HKE4D2LJjOIJEu5d8yyoEAXR1ajVLTOXDUiisokE/uN5LQdXzx+/+hxm7dNGn0QyqKVW2PArBojVEtpfs8L1eoZ9fqySRSv0+dXpxbIVtAOZGRXEwVMFMQzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890250; c=relaxed/simple;
	bh=VJKV4LrI5L8DhuTg3MSljqrmjjT5q3geeSrutGfW3EU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VEnLtgwnQlbzsd37VRzQl/CDfk/21sFd35v7m2ZSAG9/risCZHYutZH0eoKMdlviDGwoU4QyC7icS20GZpyAdXbtZ6nnm2TWKiiS6DbtwGA0pOvBxgNBE021Z7hLtBT7QjOSFUdufNTC3y31PxmVFK5JEI2yG00hNlErjw2ze5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0EbxU/v; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b155cca097so213874785a.1;
        Fri, 25 Oct 2024 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729890247; x=1730495047; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCOUqGYGdXwZAD/0YHVIkmuyEJpONqidEVQgV58FvY8=;
        b=R0EbxU/v4GRvaKziqBZWzxSrINpApwyi/HhlUujlzF3oRGcn9bO8tmRlBMgC/SWby2
         f4ydzqMgduFJgDyB76T4bow46fkJMpVrF6iwpMN/r9GCcoHPQxOfqoKZs8Q0zI+jKmsm
         ZZcH2jq/t6E9mBOqKmsMfBswWSqOUWLzW9TMNTSFzZZU29FFwiJ1llNS/IEVhUJtzaJC
         JxZH/ShrvRWID3z0v6hcfdlhmiPFRXo3OshOvH0w0G00uBSddQawi7yXYDqNFyIV6Yie
         IMbfW1rY0rmkQ4IUs59uYyH7lGEW6SFXif0RvalqBpJSS55JNNhzec7Giq/xQDMxG3jl
         Vu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890247; x=1730495047;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCOUqGYGdXwZAD/0YHVIkmuyEJpONqidEVQgV58FvY8=;
        b=iKJnFQ7sARRnAM3lGshZASs7zamK/FV4ccO0iROG9J+XNUr76PdroiVDqMl2hqRPNC
         waEKYmbFhBVof7T53LbFjRubOmIWdRcGvJkOneAjiUXE3GG7Sz3/a6bJ+M/2FuJakiU/
         xoo7OhNP5i2+C+zprrBXvGE6w2Mimrac4TcbXNZs15MKhKUOHtrKNaQPPwYx/FOpizTx
         8/yfZ9be0ueYZ+sPoxn0a2EvhZstQUARpFsyoftgBIGwFAS8A7wCIbODyp7ns6+wQqy0
         xX3auXDLNSADEICpwW2+8qdRrcjzCsCshzYiwmxcQ0S2LFxmnpe9oYC3xI04bAwoU9GV
         kktg==
X-Forwarded-Encrypted: i=1; AJvYcCXlJB0nBcTrp7+oipXfDsv69BZbkjFXEDd05qm0PIwr7dPVoFMJim6v4q6cjZJm9/m4GL0IxCXVtTTPFlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVcn+9A25VYhwjKcxO8Wq3YEoy5KCzcahQOr7eLmirLaOm8Ll
	v1N8dXvzUtsVxYTojA3rcHd5cJoSc+7yaYeMex8uLLf8hiLEHdvX
X-Google-Smtp-Source: AGHT+IG9mK1qknus5DSITlS+DTa0v2eHN3Gwr320jPSMEeCSZSYlZYrS3oOTRZ6OJZyNY/Fjhjn7/A==
X-Received: by 2002:a05:620a:29c3:b0:7a9:aaef:305e with SMTP id af79cd13be357-7b193c69083mr173155285a.12.1729890247191;
        Fri, 25 Oct 2024 14:04:07 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27be4csm91036185a.15.2024.10.25.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:04:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] kunit: enable hardware virtualization
Date: Fri, 25 Oct 2024 17:03:52 -0400
Message-Id: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgHHGcC/x3MQQqDMBBG4avIrB2IQwTpVUoXYfzVwRrbREUQ7
 97Q5bd476KMZMj0qC5KOCzbGguauiKdQhzB1heTOPGNk5bnPdrGXyw7B1W8eQm6ZpbOO3iVHkN
 LJf4kDHb+x8/Xff8AzIsfF2gAAAA=
X-Change-ID: 20241025-kunit-qemu-accel-macos-2840e4c2def5
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series implements feature detection of hardware virtualization on
Linux and macOS; the latter being my primary use case.

This yields approximately a 6x improvement using HVF on M3 Pro.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      kunit: add fallback for os.sched_getaffinity
      kunit: enable hardware acceleration when available

 tools/testing/kunit/kunit.py              | 11 ++++++++++-
 tools/testing/kunit/kunit_kernel.py       | 26 +++++++++++++++++++++++++-
 tools/testing/kunit/qemu_configs/arm64.py |  2 +-
 3 files changed, 36 insertions(+), 3 deletions(-)
---
base-commit: ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc
change-id: 20241025-kunit-qemu-accel-macos-2840e4c2def5

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


