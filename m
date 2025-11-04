Return-Path: <linux-kselftest+bounces-44758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DBC333F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40B324E6317
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5F3148BE;
	Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYS5PxKW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C84304972
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295951; cv=none; b=YmLyHh3qr7E7FmhVyS4qkwCRcsV3JMlqb18S2NgTeSeCn0bh5lp5sf2By/8q3zLGqcJXwmMhxJzbBE/GZF5MeWZfZCeLTX+3eA3r429JfwwKdw8swO19eBV4Rw/KHxdvCRNQFAEXcLVMUtCpS9toAioCuk8BDUC/LKQBJmLd+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295951; c=relaxed/simple;
	bh=ZR9/j052YDNAkFJ3hHReoZQ9gREe6fypHqzQIW+W8y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVhoLe8IG6fMa42H3QlIHH4n4lLw0YjdDiRAiZd8GRcMHXLpgVqX+lhvQEFcCkjhily3bWKgAUgicv0qq44XcqrPHpNS2kwsj6Wb9EAoQ/zHQT/XxSmQN6+9G+936GA/ZgIznNXVbJN/Z3OEKkHubIv1sJa/O+3WyH58SABUyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYS5PxKW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2953e415b27so39533575ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295949; x=1762900749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=jYS5PxKWCGC96YVaoEPvU/GV3r+WFCWDCkjEsppc2/g9tcCb8RJKJUO/Ol7iCNIiNU
         AS0W/WifMk0vbSaXxR2AhrAyf6G1X355l+R/mRId9n5ZviHQlhji6s8BQtC7TYC36hOh
         SDi7f2iwH1uFJzhC+Cj1QVs8d5AFlbxF41RUqTw+4SQyOW+ll76vVxGVuU7lkztr8l2v
         GpgQRZoxWFtDRlg/nAHdLt1ydlkIO3aDAnFRHemGQnMD0YFkAxGodWtRUQdtzwZ3hmMv
         hUERZ2/yXIgRMmlfaXAB9kkz/9amrb8cC4OO55rrn0g1uyy0HKC11wyVKfxIeqpYh7Dd
         CJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295949; x=1762900749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=itSkYKEvBDIPx91O3rUJlRoH2BXt8FZSHOnPdkwL3TnuhLZZW70/gmufA86KxfKswV
         lDTiGE8UbRuBUqMmnctxNqdQh81A80JDyqc9hVxBIdto6RFTs8TKMiUpKS201+PGkNTw
         nSpMwXKTJofEYeLZPv9rOR21Ru6jp7dV1INAAy9+uRX0BQyh54AY9t+ipr7oNOjKFRLJ
         7N8zkN7dow0ILoLUYK432pt7Jt0edzWSdJvWGjpmzPU3TL5VGN/8IMdOYzQwl1g7xi7p
         /VgCdXglNJjV+bUIxbPZf9AeI57qez9n9CaUlEUXF9K5uiuPfPfO6S4rNCxTEfKJVbrr
         Nyxw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRlhr0Fs8nw48/U2mLlK509UO32NCPXECMA1O/Oc407YMer9qRbtvdKbgBBbt3Xjt0CcGGItbD4hLYtDTpHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2d29W/c2PO1B6WaMV7aYVkAsCqT5lLxBRgYRRhJQDNoDDthJy
	Ar2w0HjBSqFXdPo705Db3DoYEosU/ISwkdiIjPfSiNIXHpj2/XTYmMd0
X-Gm-Gg: ASbGncvlCfQ2ltyrGDQZ+10PItc3XSDuIari2UIcu23WvdoXwnrhlDqNoYoJR6lUKhV
	JhmDJYm6M7VHwO5ZwIMIFGgc8/DAi9WH/GRehB6mYHAmBeYGWnGrxMmn2z/ps/XUp6+mAELWbsn
	+OWASjwkqdP7ngAD6m4sfz/YTS21TjckaeJpBAhR2aXS5ajDXYYUHQE2rZYbQF2qoUEcFDaIA86
	pN0FaY0FuxJdPrPMtwInGGQaF1wv89ljInLpk1gs+G9MI8/Wptu0IbatxVk6v/ZgPFj3pigxPG/
	k5bR5ncR70KxkhvF2hNZo73EK9xqfWtk/RayEZeqxwwuFLkPx0SBGBTgPdp1FcSaRQK/8965sbx
	kfmI1xm5UOQCX4sTFS3RMXYV9qylGJovVGnxNpCm7GCjnWnAt79PggmUiEprr27t8+kFZAB0nXw
	==
X-Google-Smtp-Source: AGHT+IEf8Nrub88wm5PzVqxHEp7+fQp/JKH+iJ9scU23Jg6FQodVkNNRoH/TfsmpGm25Zf50pWGuAA==
X-Received: by 2002:a17:902:dac2:b0:272:dee1:c133 with SMTP id d9443c01a7336-2962adb20f8mr14797755ad.22.1762295949382;
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d174sm39069295ad.77.2025.11.04.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Tue, 04 Nov 2025 14:38:50 -0800
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqACmkC/52OywrCMBBFf6Vk7UiSvtCV/yFdpM3EBm1SMiFUS
 v/dWAS34vLOvZwzKyMMFomdi5UFTJasdznIQ8GGUbkbgtU5M8llLbgUkMgPdyB8mIgUCYxdkEA
 5DXaag084octnXrdVxY3ppVEsw+aA+zKzrsxhBIdLZF1uRkvRh+f+QRJ7/5HJX2VJAIcKT21pt
 BywF5cJozoOfnqr/6Khzpj2pJuqKb+0btu2F09HTHczAQAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

---
Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 332 +++++++++++++++++++++-----------
 1 file changed, 216 insertions(+), 116 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


