Return-Path: <linux-kselftest+bounces-45045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E8C3E0BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A228188E696
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDF302CA6;
	Fri,  7 Nov 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtWXk78j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39C2FD1A8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476605; cv=none; b=Z3PRcYgVc8uaNq/EW8aILOv69fu/Jsja0kuv4bXrGPjrQe3qtNUywY5N0G3xxSQ8w9EUqWsMxvqPwpFt/6kDo0KnhryQn38DS/u4a1/TbxPHTZEBdIkVISDw77UqxemPJCLD5RzF2MErpgqtwYp9AVJZBRH2WCJQw/OtMpkaep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476605; c=relaxed/simple;
	bh=iMU473kfbxLIfx41vDd7YtatXvonwJ3nvGqIOn/zk5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kssXzk0kYXa4/NnfM8VNYoSR4VfraYb7744qJ6RIWtpQ1ZcWGaTB8Be2SX8qKIoE9JYZoR8ncqzw8UmARxSn3ZqdJ9rANlaYQaNlGfz42caKvbS4fmohzl18ZB1+byUf7ABM+nd1niaBOBa3ABwACHn9Wu+UG3AsnN6kwgbT/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtWXk78j; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29568d93e87so1773825ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=RtWXk78j34yrafHbvKJq76DRJx2KD3ljRmGfybDyf+nVnQLpDf/QfXoN0MEDTd+JMo
         h2AFksiRxOdEIZTL3VpL+fGzwjiCtJAWWjLhEFR3L88neL+bgN/9cYVkCMGmMe8AD7JK
         S+0eg+k6M3LshYM5/m+i5PL1Zo4+XiYE+kiSiyruhmjnhEYiNaK882XAVfX3LG6cpzyA
         gZP3uaRSMs1fV9s6QrGD0byqN+7YKIl8ruouw9CI4eo8CTVSmGcgueaL9Cut6m13ZKC1
         Gynp7APdpH/+ZxqvpPeLoPQWy1+DdcXfqTXj8HiN5mqxPvtPL0XHxfYbLheOvBJs/Mtv
         sr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=Rjrtzf6+KhWmt7TSaqXPnCBSx98dBZ8et7E5E0b1ug+oSSoLY9jbLE3yeTUw9IHdxN
         UfPGEPZLY8tBknKwcf2v8MH3NMSPbe1qlehk0aBLsWU/soWd/b2fX/GBrGzzKUXgrYtX
         oNfwGUNxinT1NylEvYg3EflbVgIBBcRyqRLJ4uJOlTNG95//1bk1MTgwmg4LDfBtbW6f
         oBfjQKG5KIizwvb0sgTqMWEGJ5OoX2lLk0DLfpkzAfw+9p8knc2hipKwgq9N+vx+7iSw
         IoyksH+gTmoZaKrxpi7r/SxJeyU2lxsJxez1SNKwIvkVf0BR0RFKuWy9eSKnL1ZfZQ8f
         p/GA==
X-Forwarded-Encrypted: i=1; AJvYcCVv+QSrFtHqTuyjHgv0ngacCk8jFwS2pL1eHVeDtr7xZJleiUL72EvTCvbTORwPWL/1uYHPJcHOev5qoIsarxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EGpKgOrzp3UXT4AuTIhYzNA1oVEkKFd8eX3pTCqAN/0dnlq1
	oOWq7eRgewiCcgI2TaOi5lIO4fuG36VGGj/O2Ft2bEXWBn5jBTmoA6y2yBZ6gA==
X-Gm-Gg: ASbGncvK+c4ixo5ubk+4vc0F3EV/YcCeP1Ebxan4NnJDNQ8bVsa1gKHN2hlYR3hFuX0
	XQXN5VsA44AKqlY1lKcxzpFvX89MJIuPkbEDWbudKgV9W82JiqYLqq1lBW+ujb4asFTIfS5+Fuk
	Ts65NUwFy193SQGE07Wr/nRyCWGo7C6zW3pFtSFCzcOqbIjgIbzrqLTVfYSfDCEBGWdUWjHl3zV
	dWJMdktUc8mn36ReJjU/opnR4b1pzhengf7dTZVZ0HXP320PAXC1GJe4MCREj1RfMlfkD2fnyL8
	1Jk4d0ANcT6P0++0PlMgObiazkr+pYU1msC6BbsabzZo5FevQg1LG9RYBLkMQ3B48zS6v/gIRzp
	6ojG3RW2QzH4Ni/Dv3xYFjiAO2W9RHlKxs8ajO+GMUWc468NOYD+VAWgdbwGug0uMNDXf2Oh/
X-Google-Smtp-Source: AGHT+IEn4ofaJtpDiBFAzxzfLcnblypBsnuT/tfNp8v2pmgiedvOY3KtH3CWotZWmHCTlxnnmEILUA==
X-Received: by 2002:a17:902:ecca:b0:295:a1a5:baee with SMTP id d9443c01a7336-297c03d28dfmr16719935ad.4.1762476602405;
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm41166315ad.73.2025.11.06.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:55 -0800
Subject: [PATCH net-next v3 11/11] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-11-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cde048bd7fe6..bda1ad173ad1 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3


