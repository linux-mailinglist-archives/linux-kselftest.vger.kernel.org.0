Return-Path: <linux-kselftest+bounces-29382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E08A67E8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16E77A2712
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F621F755E;
	Tue, 18 Mar 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7QwMq8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC7DDAD;
	Tue, 18 Mar 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332860; cv=none; b=PwJYO9pv8XOg7ieyK5lX5UykwTmsOGyITcKrBLTc4qXSjZLvXQEySvBJMg1GG7kGRtOKOaIBi+pI9dIom8b4tD3H8n9LMH0Q+PreySkWUXV5CRdhuXUhdlmA4Fppu4Ci6P0HHG3z4tppaj21j+4LzvKj5qRrIIuxjq09m6Bs1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332860; c=relaxed/simple;
	bh=WiRT9bHs0N/tkHiTl/aOimeK19vJh3RSlWvepRaoyiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aOR8aSG1cwY7wj3eAjDakv0I8JonffVNyTmRFMGoqDE+/fn4za+8s0LrNBvNC/HdQnr6kMUyP0ZqcNyXujk4YqjOaFoUl4nsZ9vUxtFe9lzsyjKRnCQD8r10NueYLPqp6EQ7/slR3dlcJkmzvt7cSX6il5Fdl4d7iVM6hYuoVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7QwMq8w; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so6375989a91.1;
        Tue, 18 Mar 2025 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742332858; x=1742937658; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ardKmeM3FvhOwNbF6mEr8AJRagvXxY7Hl+ibLRknpfU=;
        b=f7QwMq8w3TmrH4zzlGpsorJOeKmMevCGQLktozgMUbJEB9umVW+K3QaxCW6VkwkHLp
         SwqyzJ4KFVQQt59fztHZ8XGsBLOjS0Z6+/mL+mJphPij375FOMiR+svCmCEQJfHrnF2r
         OMfVOHkNXpnu9boE1GwTrYGtK9wJa2sezw4KlzF3pKJh8uJSMHlwYq8i2gBQFIvB/93S
         pLXKAkDAi7Bj3J/kf0p3UtjNsPLqQFvVwcXQ2avD+GzXUj1AwTS17Ty/ukvTe/xn1QJi
         R6RwivQgdvdGEejBTUlzSNoU5jQ3qSsnaKbk2LgFLVsTjpU8ufFn7GaJ2C43nyCpSD/9
         dD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742332858; x=1742937658;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ardKmeM3FvhOwNbF6mEr8AJRagvXxY7Hl+ibLRknpfU=;
        b=vQhXqn/UgOI7FWoIR3dC89cN2gHw+vdV+3lfEe7Cd2vt3xLVQV/n/QtwTJNSMRp+if
         DlfYLPR1wKQv7dOM2aX3IF2IX/ZOFv49fLQC8dl3wepXiVpyv0OgjPm9qJEN1vgtiAAo
         SRlNoVzH4VnBIfMh/0lmEAsC+tPH8OiioZGd6y885a7OqNs2/a32eV6wPGQxo8/SWQjo
         uJNQ3Znt8RWhWjGTmpFRa1qqZrABBXtUx7gXvCk3NXFntwbiiGAxj2I+a8grZq5LoUFE
         JWKH0nO0EbWOXXVNhPr55prTvcSZufKbZXLvguIfvhqSBlgEt/l0h3sKC0UB8gd9bYv8
         eppA==
X-Forwarded-Encrypted: i=1; AJvYcCVauDEDzVMG5SrmivzGrZ2yl1PceuzdYTe5UodhsxgCBru6KgrVbRn8li7vi3mNj/pNpd+JQz4axZyTcuc=@vger.kernel.org, AJvYcCXPH3r9tInv/Em8f0gwipRT9pyKA+IXs8I55Swr2DaipuIhc2vq4dw+pa7IKcOp3eUjjDbCE/AWlArBT1AK8daz@vger.kernel.org
X-Gm-Message-State: AOJu0YzskfwznIG8eFCzHuxQE/mkPa82acuyMz5IJifZhZ3yms2laj57
	aniAJNGPEBLqPFoukbGSb54WERS9kOscc+5nC3ddhjdqEnL4IvNiS+YMo4807Gc=
X-Gm-Gg: ASbGncvlfZXJM1z8MsgT0oiJSF6Mxbb51UtbPt3Q+12MDKqDSvRt/9/pG5O4KEch8L5
	2qyYlc8ErAjjCZ96fck+cVELHfjq+q985yy0QnLwmG9QrVC1R1D83EKZU6Hyd7EdB5s/YRIXo6t
	nGDk665rDRonYMYBe+Um7PUwh/oIoJq2ny3FOTuTUXSSPmubsX3ZFXUvKm1gLGGyiOVAMMYSHp1
	PMDkGYy+Vrv13EYfn5AHRB6XEcEZVUPxlb4ENYd80zd9LoTgNpcNjac5otEjuil8k5LH4RMkG1H
	dplPJiPERssV5sOgIqzK2AeMBLPVZk8hu6hf0ECyhqvj/ScRyGRv
X-Google-Smtp-Source: AGHT+IG3Y3teF52oZyArtun7A7gMMONDj7HmQM4FW494dVh9pAErbe1aEiJVTuiPnP6t/fYPzeV0cw==
X-Received: by 2002:a17:90b:2647:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-301bde53851mr252773a91.5.1742332858535;
        Tue, 18 Mar 2025 14:20:58 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afe74asm8771777a91.24.2025.03.18.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:20:58 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Subject: [PATCH v2 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Date: Tue, 18 Mar 2025 18:20:34 -0300
Message-Id: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLj2WcC/4WNywrCMBBFf6XM2pE8bIuu/A/pIiSTZqAvkhCU0
 n839gdcngP33B0SRaYEj2aHSIUTr0sFdWnABrOMhOwqgxKqFVp06HM0ljD5TCnjxIU2k23ATri
 7s7deKd1CXW+RPL/P8muoHDjlNX7OoyJ/9n+zSBRoOi+dt1qQ7J/jbHi62nWG4TiOLyuiADy+A
 AAA
X-Change-ID: 20250306-ftrace-sftest-livepatch-60d9dc472235
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This patchset add ftrace helpers functions and
add a new test makes sure that ftrace can trace
a function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
Suggested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v2:
- functions.sh: change check traced function to accept a list of functions.
- Link to v1: https://lore.kernel.org/r/20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com

---
Filipe Xavier (2):
      selftests: livepatch: add new ftrace helpers functions
      selftests: livepatch: test if ftrace can trace a livepatched function

 tools/testing/selftests/livepatch/functions.sh   | 49 ++++++++++++++++++++++++
 tools/testing/selftests/livepatch/test-ftrace.sh | 34 ++++++++++++++++
 2 files changed, 83 insertions(+)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-ftrace-sftest-livepatch-60d9dc472235

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


