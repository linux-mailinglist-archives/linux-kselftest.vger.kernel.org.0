Return-Path: <linux-kselftest+bounces-44757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE901C331BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 22:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F1D426CE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E193469F4;
	Tue,  4 Nov 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmXKYd5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7334678F
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293061; cv=none; b=CKgjISuHFn1kVm++oNkSMgXjVv3VqRaq5/IHOpdyEQcAfBYVdOvEHDg8tYusWCdzeIRFYE10hxrVjYJTFBPRCG30VfiwhJ6YEuN3lGqgjLukr3T8dRQqpP2zkdfL7lzYFvpQ782YMNrhc6M2avJvppWZIr7vCpRn0c+cl+dz9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293061; c=relaxed/simple;
	bh=DXUYPNNuTgtHcCDBcDsgLmjkqRHOB4mn9bzaBjoa9ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZKcQPhbPCGnBjjM9kkWBH7aqYYNHhaxxNSvt+4MVqUxGh9FjJyLy1uIswoSSh8vI2tJmbS5GOLqYOhB3E+pKccb+s0HCqB5PMOw2JxKy55yPeg2TUgS6GbeG/xcKSiHlrg13kZ4hHCWYLMZi7mpqsOJzep4Dv7VsDdx40W0ul0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmXKYd5G; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34101107cc8so2778892a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762293059; x=1762897859; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4qMVi7Ntt7sxkPeBtv45SX1Ju34QY/CHb+4bSpnhks=;
        b=AmXKYd5GTokXZWFnKyzVfJiXx5PbN0ZHDE9iagQ4u6T/+3c6BrmkixKR4ROKiA4SiZ
         k+WkA4APWB2HVU0y02lBa6KLVh3WSI2XwY4LWYaAaRFYoLlxlZL8bIaD5OBQCJ3yVisl
         Huf4er+aYgLg2/8UxFHsACrJlEPkBTUgMmwZ4ExeYcon9rDUhMoLuJF6bC/cxvT7OExZ
         aUNKCo8kG6wZKcuakDlkaw7dWW3S7Uf3gQzAUR46Yy0qj0oePYU/brx1KOIqVb/Hw8Qy
         6wJqOZt+Qs1qzaXk2F6KtjBsxHS1uCJ2ESNiNEtbLBTB/kdLhY9yWdGJOH1K/6mkUaVy
         RJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293059; x=1762897859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4qMVi7Ntt7sxkPeBtv45SX1Ju34QY/CHb+4bSpnhks=;
        b=CYzCt+f+nxuYmaz3wfTnBsb98jKPqXg4A7GYrBK445vZJtaCKeWrOLoL27vGnZsi//
         zIgX7UT/IotWg84PcCOKQjaX1LY4K0dVJQPOBb7feuP0Rpr6wDkAu5Xz47kfCRC6zgxa
         nlNG40pRGEQ8nNbwkrxbB0tVgeVT0fIW4zocujfk5ZXl8h8XnbFSmYtGhN/1qpKLezE3
         9lZGBEjTXDaKoq31lEu4dbe9SZUuqju8TlY2bQz9vaMSoRqPehux+bQTUHqske/iOrOs
         ANQMAoOQTFlxzf3MUNFxeMruFD1GD9g1A+8bgrzLbH8l9RWfTKBHxg3GkwZaNdpjQ6cg
         M+6A==
X-Forwarded-Encrypted: i=1; AJvYcCWy3UiWqPWaVAYYcIa7dHdC0b8IumByHnHsQBJnwmy7t0rduMn33n0il54I5OOYKazBKv4+yjNJ3oM+7gvVI9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72W/GEoIJmK/LzLPstwHHkH/3o01PoYZZ7PBbhN7UATADGtc6
	81MePYZ1CQo5Y2iqNH2R9AY3xyothaSWJvLUMza/2TD7K0/wIRYibXL4
X-Gm-Gg: ASbGncuTXDOnvkyAzYfktTVG7N9KER+6AvJMKPNKp841xuRHlb+PgynKS/oF9W4NqWq
	qYsjKSuwRXUMFJP9ckZWiktf5UyqBK8oDLTWb5Zp4RIfhRyyURoLAZJYqk8v/7YibdRZ4IQudrz
	n2gg8vC+FlV/jEc97QwomZOZFNPx+jo/ekXbXWEA43GH4mkgHLPSkz3g6U3nQOL1TQuMqZrfos0
	P/UGfopD6n5PlDa62Khb+bm0oehkwOphEuMsjML9vlAw7q42MxpuJ2J5ByAIDraPGVpkiM3G5eg
	NhGl61tya0FHfy9UIF/DbQF9WE2tclLb7AsZ4sUlHts6iDFyZggGvv4mSoOVwBj46AG7t64tiI1
	/ob7r/GcGpgu7IP0AI7B07I6P4o6FwpFlPYOg9Xyr6q2EgKW01QYC+TjCsAbv0wiJvXFfd2vmAi
	DuarW8
X-Google-Smtp-Source: AGHT+IG4BbWYnk20z2z4/g793VR2Hfh7SdkPN9v4GeXv79P10NM1Wo+bQlbkbGGW0rbOYQrtmo+WPw==
X-Received: by 2002:a17:90a:e7cf:b0:340:c179:3657 with SMTP id 98e67ed59e1d1-341a6e0d9bfmr853384a91.33.1762293058733;
        Tue, 04 Nov 2025 13:50:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bccad85sm1765781a91.5.2025.11.04.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 13:50:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 13:50:50 -0800
Subject: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
X-B4-Tracking: v=1; b=H4sIADl1CmkC/x2MwQqDMBAFf0X23AWTKmh/pfRgk6cuxViyIQjBf
 zd4nIGZQoooUHo1hSKyqOyhgnk05NYpLGDxlcm2tjem7Tjr7n6ctwRN7DfowrMc/LWuH2H86J4
 D1fgfUfU9flNAos95Xp98blVtAAAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Previously was part of the series:
https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..e1732f236d14 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,9 +389,9 @@ run_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -403,7 +403,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


