Return-Path: <linux-kselftest+bounces-43721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC7BF9616
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B23019C33F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F482FCC12;
	Tue, 21 Oct 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBdMP7dN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C412DC782
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090451; cv=none; b=JPW1fW2+1r9FHodOnGcqdeG3KmzjRGQc+rst0JW91JQb7QgCygYRkg1u1vGyp6JI0/eapTsBtxzfcd4G4IxeWQX9BO4SDUyzDbY0HPlfGRwzGaFB/xt1SjJKti5Jp3mrDKz+A0a5EWvlINS1dk4VO5KnnEFC2RsN/xHHubwtW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090451; c=relaxed/simple;
	bh=BMoDKOrhS66bBpIGFuMcrxO7gUW03URrQ8nNkpSPZhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ci2cDebkn6kAbmZJniOWNpXEFctemov1NPvLxQDqpT3LCpmPIs8RsEmJ6kvFEQ/625NTKdNMe56bz4m5TNmSk8h+zx9f9RGCloHUvsmAdw5d5tR1lBr7gWD968Y6a+OcWX+3saw+7pTrDffuB2gLnIB2e6DHEQ7WNa+A4nPqX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBdMP7dN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so5739809a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090443; x=1761695243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=NBdMP7dNyeOytmB2rvy/Yxg5bJ+F7cyedwstBr5tbIxXbfnQAnrRwwyYzF+xECSSyN
         9RfXd4KOI/CJWLn2lW3wYqAvCS1Mz5u6AX2JgigUZRTQOzdWxZWjkYc/eRd0PZNtdtSN
         dwsz4jMxNfDGPN+XQZSLjWxwXqsflbyVG+DmDKMNfTWFZ5AIhLVwMuIJeF7gTJ3ClkWK
         q/vi7/iRl6+sfSx/nSpcF3YbQCkT1N5LShAjn+aKIL5bjUl2H2zgCOQ/n8d80JoKlFEk
         nwzYeyo95tosg82ihqt7uyhz3cqdmntdVD4xHvcENRoF/FRYVeWC8K2G0hKe4fErfWAN
         DT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090443; x=1761695243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=aGKHe/LyXhP8a+CYMVudPH4AZsm+bZGId4CBbTjF2GaD7W4EWPLsxPuRTg2iyWIDe0
         2HQvmi3efIoxVRDgY7ZTb6Uy1LfSCdw/Ep3eorwv8rbzqAqJi3e7dyd2DTV90PE9LEab
         hEUFCNl7tF+Lx5C2bIIsdCKDJRGvahuEvfhCX0ppHnKOZrKiLAqeA9aWixcvlHFj21oA
         /5+bb8+c6UgyVpj5HU9VU7eAWTNwyB8e9bejGdwv5nR0ButocFX8CqK9JvNuBWg75SYU
         KLbdtgY+MWlqroWYhQ6p8ZN2j3A922z2BU6v0NEzA/QJE6iL9+YpsPh0UT/jf+ywUXLt
         sjmA==
X-Forwarded-Encrypted: i=1; AJvYcCV8h/m3jkFhnv89mHm2n8oV99pnN0F7gUq75bhUi5KR2H3rBo6rBuz9TvDe4J70WkMWrzlGz1gB/Dlr+bYj8YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqCZJ328ZTyMVu5Lhm/PppK40/ZsNiobcNDJN5ZFANMmfMl+O
	yU2lDpRW2xKqdx0zf0bFyUCjn8rzRrjwVBqe6gPOi9pM/eqPxBDgfWDu
X-Gm-Gg: ASbGncsrhri+xAi4NKBY9FUd1i/culTzf+9czpFmxpwUHoULUAR5wTn+fDYIyav4II8
	V3k1LxKos2SJcfgORCXzLOHX4XyNz9gQ3X+664w0RGX7Gf4zcKjbt5JbeLxr4qBnIFt9iSaMF1k
	Op7bOS/JrcSGOdyDzhs4pJZTnRAZUdykZOk94fwT/PNKZyQcXqJ9i18EaZm2GpowEgM4/nypbK4
	8YdG3ZO4c4SgYEHZpL+9LHI/9t+nR3+o9Ol/lECdLIRpfRbZr9slNko1f3Qzetx7FFVAe6u+IhC
	rnbN2NAspLOKpR0AjHreqHU+ipn+vZp0+7xK9WU517G8OB2gELkNgVAoiDXwmD+/5QZ4X/6Jp+H
	fMiYP1Y/QCOfveR6e2fWqfL2N3SgOL8TO0HXaQFLfr4F/xKJ9h0wRNjCB478QNUXCFu2gzRK2MS
	M14W+ng8i/
X-Google-Smtp-Source: AGHT+IGaqRNpMxUjoe2TEEOGYZ81AJdjcRS3PZQjYosVwq9rn7Rp/cmS0OGVE01pd5g/Wml0FTdNXQ==
X-Received: by 2002:a17:903:22c3:b0:293:57e:c8a7 with SMTP id d9443c01a7336-293057eca74mr3060095ad.23.1761090443407;
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm120489125ad.63.2025.10.21.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:09 -0700
Subject: [PATCH net-next v7 26/26] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-26-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36
1..30
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_ns_mode_write_once_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_mode_change_connection_continue_vm_ok
ok 24 ns_mode_change_connection_continue_host_ok
ok 25 ns_mode_change_connection_continue_both_ok
ok 26 ns_delete_vm_ok
ok 27 ns_delete_host_ok
ok 28 ns_delete_both_ok
ok 29 ns_loopback_global_global_late_module_load_ok
ok 30 ns_loopback_local_local_late_module_load_fails

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 648ae71bf45a..d73fdea886fb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -338,7 +338,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


