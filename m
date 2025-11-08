Return-Path: <linux-kselftest+bounces-45174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C3C42F9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A46A348D28
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B631275AF5;
	Sat,  8 Nov 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkMf05om"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F042472B6
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617725; cv=none; b=aywjhcOGqlRR9WX4Nl7AZ3Nbv1U7s1/A0oTjeC8/XR5aHE4DN5bhR59LdTPYYMcUS3CY/su5hS7BQwev1TrV81+QrD1XCZnhrRNSY6Vhhy3bpMa10VQJVk/Wqq4ELGYLFF+Zco4zAa0xQuW1DoYSNo7XMhQoXZ6ZWwmfe2/6Ve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617725; c=relaxed/simple;
	bh=oHgjWws1DBoTOYU7ER4ATIFMREmAxgb84D48zVV5FD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjBoQaoe0vj9iEEH2boHOE4nDMrp7mEHUG8rriKI9oMlM4h6fYfH2BT4twQ/dEkI4fetyXVUaxH/+zf+bQ3BRI8hUZi3RKGrLZp7sOT3lVd0HTthTyeK8MzYBPqiz7J9tBVXp1w6dtD8ma/0ba8T/QFJbvrKGMl7laNR5kwxhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkMf05om; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1088765a91.3
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617722; x=1763222522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=CkMf05om2Vg00vdJ06rUhgEfh+e6dwVRfhLlnYsa8Z5CtlplWPMkFWtPvn2If8z7WS
         +g+XeMeqp+cszK1pdutUhoBLlvrAGhujpZlNI/LG6dc21YGhqB7dDVepQ3nkwcwGpL07
         mMMBx/MTYs+ldOHIeafzi3uV8nYeFAjLU3tgVwOqSlzSD6X47sYlgWV3QsMPddeED21N
         ZCR4nGepg1o1cTgllW6sZpPxsMsXLOO+CgcIocAvXcvK4uGwcmDLdq1qA1ktDth0dRKm
         Ed9siiIBSO7s6E7Juq7y7ETuYcVVxhsxQbn8S/h3n0/r2H5YjRmEXu33lw7C5kvpEqCK
         bS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617722; x=1763222522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=VkuTYoHILFekoLwn3lJY96lNZ8iJMqA5vWDBKoVOnB0QjC43fdOUb+aekmgXrQfQZz
         wdF9Pp+0Ia2lY0sUkwnprZiO8pCY9SNlUl3pjowV+2T+Zds76nA7UIX5+c6eUjDDEbLA
         kpf+3KdyE+ggwReitCwUVY/rAFKXQrrHglfqyrRXnW59eJhSGQMWLieKgK+WDXVUBSzY
         EQJ7Fty/SCyBO376GKD6iYLg8enO1SsYn+gkJh9w1jU/ZyvHTJ6sOPji2J/S+L4Uhn96
         tm/b8rt622JIYSJo/bZYs6cA07gSMVN2a3n3ShWMJuS5KSvPWgr2kVwgA03HtARCj7A4
         Fs5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWepqz8I3i56iFNGTBrmrZWzuHEvOm+0NZMXvHwWdMzh+9eeBEDyKUmo7eIV/ilMISKS3jMy/yFTlg/37DzM5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8ymbESiwrfNECiMaEG6Vmq9BcYDWAFmk57mXTMrUhHwcxW9B
	NrXG1RjV9dr2OBHZh8PeWU+6Gv/Knoprf6FPS6/l5QlcoN7V59NdjSx9
X-Gm-Gg: ASbGncvZtcwe8suWc2qhV6rmPi3NXL3i5obeMrakBVTseoEoTYmiPvYgWAJcIGa2Gbm
	mhvCHItn9O4tiUFUQm9i+gsmRFMjRXE67KdFXnCho3QH83BG9GF0bHd0/4AoKcYYpmiAlZ1BoAb
	roioZ1T++DwdwbHr+vSAB8k1rsrHPb/pP2jbyoZljo0xWO2yCoZHlDOZRVBMdeYNv8nVQxZa2ZL
	uadpwXbzSsoDdxubmmJdr0kFU9HpMqNWFpJqC7Gd5qUo9al2HTmbi0l1AszXbD00fAXaj8G8/HI
	cGig/ycqbzYCsvmXqaaQt+7J5a/MU+qom7t9CSJYfqFUB6ePIl4/1PzVjWC/0zxWk1mDeWUALO7
	l2rIP1eFDNO0xgNTcmibbqte8fJI8X+IOc6R9JPiVWifkakrFFIKBvcjzFPvYaiCv7cdTHEzn+r
	1dnJgslrs=
X-Google-Smtp-Source: AGHT+IH+Vi5K6pMe8JfFAOXim3vTcOSLSn5qC8SzCV1Ipfc/i/Us/WTXuuK7P37jiIt7Ll9os7AY0g==
X-Received: by 2002:a17:90b:2708:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-3436cb89b05mr3302246a91.13.1762617722221;
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm2104024a91.19.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:03 -0800
Subject: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 and SC2119. These rules are being
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
index 42e155b45602..c7b270dd77a9 100755
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


