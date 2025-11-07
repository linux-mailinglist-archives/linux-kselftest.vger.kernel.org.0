Return-Path: <linux-kselftest+bounces-45034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2CC3E03E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D93A5742
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC22EA156;
	Fri,  7 Nov 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3lbuwiX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE261FCE
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476593; cv=none; b=FX+5MeKS/QixZJcnjvCMKN6gsMTm+wFhrFNW5JEdFpreDxMuOSOr717TCCjaRvVTyafxKgOvKtGWDD19OXFZGL5jucNXLJV76PzbJBwqjGYfRH97XnD7qxPCi1DdubTowGdivIzFA08q3UEPxkW6N9lU7lyjiQBCpcNC/I7HpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476593; c=relaxed/simple;
	bh=579y5r6qisDyc0vXZIHMWG8pM549D8gpzJUlycZNzkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ev8BolSux+mj7iNCjL06ZjkMeqxVPOSQgpcnfxZQigAenrVZp62md6trj3EqSqFggZJx1f/x3QiEoufK+OpQ8SbJvQ8XAFp0JddpwgmUIgqYCoMB6rGL3oMeh9Y2PQU8yGMnnWgc1e256O/sdeJNC0Lm9paqfk3Wmf+UvubyJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3lbuwiX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2951a817541so2353005ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476591; x=1763081391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=b3lbuwiXV2SKO59OSxe4pgmw2CXcRfVDsYj0NUYp+xFaSEtiDSYYuMmnimTI62ubtg
         ABaA3+/bqEJytzEMM3XpYnX8TSbMNZFqM6E+AKa1IHEYSn15Q0xjF8z5BrELURpZMF86
         rY3N9J75x5OL5m1AplPK2gaj4e9vJGvpG2l/hLdHpycC0N1KoZKXq+Zo/5XcYFGuRui/
         yuyAXrBkEZGDVUx4axURtQaNeY1g7lKJ5IIM0RGVkOgHIC7zG5d4Ff6kexR7Bj/S80G8
         K7B/eWtgT6VmA/6wWoM7XRUqYaZOXKvLckGtKO61mruAfJQ2i1J7f+X+eIdl4TKAro+S
         U8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476591; x=1763081391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=O0GvBs3O63wJR9Mgk4DWVqMhO1PPBNPJfhP/eakw4AS6K8ny1sNGy3mxRUZU5Bg6cr
         ZLHvbYo+S/V57EBPykQ5UiM9VNK/s1mQQrI0fkv5vWL1Zt4iXV1QZWIcVwb3YUJoSw7V
         oSVcM1GLVyUJ+xi5+imor+y4csV7BF2ckMnTf7Xj/j0g94FkE9yI+Ii54O/X8M6s437T
         q8b63zAmBM6jB37WkDATIX7509/cTfxQCVj5EIFhJfzIwOUTAx/hfMBqa5EBzIkBP4ws
         OYUE32Xuo9be6k9rXDHyctGfogFYnx2Tbg3JTFgXHd4LB5RRSKWc7ZEqlBNBTpaQh2fn
         i8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWUWf8aviFx804I7oi9aaWDobtDSJD81VGyHn/+NDOH9CLjI1cviDK8F62F/Amq/UYedY9/aFy/i7CTOfYdcfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsOre9f9ELE/DefAVGxVPs8DoIYJvN1aLyWfqE4xk0d8frWV1
	S/q34oa0sz8F3wEvtfjUYJ6l0iEYCnN8YuzfIWrc0ezr5EqGmPaw5xTX
X-Gm-Gg: ASbGncukKNpjXYIYglx73jEzDwntP4f+p5yPMv4SE5NKH/hWBDTkeJwbcBhhtSgzRVk
	pmG52tKohqZ8Gmwac6fecQc4yLO6cwqDmLqpnrmN139uIiyAn2ka6giuvHknUk2fytQaqLG9Dff
	9NElJ26ogHiaplt7JsY+cN9P9lwRLTj2kX7OpZkL52gyu8IPNYKai81SVmiagQvia6OJeph0MkP
	2usOgFZ6Rztr3Pw9pJqGWD+NvJ5ynGB3q6oLPdaky4U/QzDlsATG74y77MQB5XMBxATvnesBix4
	jw2PaRT7jx5pePI4r8W2XgmVUAJwcTPKNcCfyXboJFbCfwAYcQLwiUiIZVGDfCHJp4aseGJqOVM
	zzwz62abQnzwoEBaUct7NTqqZZQ8/XW6TM+piJYLe7BduhQ0nvSNinHEMk30CXJZo6S1tvhIGAg
	==
X-Google-Smtp-Source: AGHT+IGVbNnnCv/JKP0L4AJIgAT7XYbbLVjx7tiV6GHUi/PF7nRC7D/K/BXQFE6YswbPc0qA9n+hkw==
X-Received: by 2002:a17:902:d4c1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-297c03a5f63mr17937825ad.4.1762476591127;
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm42074815ad.78.2025.11.06.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 00/11] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Thu, 06 Nov 2025 16:49:44 -0800
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChCDWkC/52OwWrDMBQEf0W8s1+RZCcmPuU/Sg62tWpEYsnoC
 ZES/O8hptBr6XmHmX2SIAcIDepJGTVISJEG1TaK5usYv8DB0aDIansw2hqukuYbC+6+QIqwDw8
 Ij9FxWNacKhbEIqwPfddp7yfrR2oUrRk7SYP6pIjCEY9Cl0bRNUhJ+Xt/UM2+/8TsX2PVsOYOp
 771zs6YzHlBGT/mtLzT/7LBYTL9yR27Y/tru2zb9gLV0w7oMwEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v3:
- see per-patch changes

Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (11):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 355 ++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 112 deletions(-)
---
base-commit: 8a25a2e34157d882032112e4194ccdfb29c499e8
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


