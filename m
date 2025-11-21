Return-Path: <linux-kselftest+bounces-46191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F4C776D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 82E5B2B080
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AB2FFDC1;
	Fri, 21 Nov 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIGiNvYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925D2F6920
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703903; cv=none; b=brGHJ8d1vKQayqaHlcbqIhZ4XsQL+ZcL1UKqsDn+PribKXG9T7rBdwmctWIrLwa178vd9mvnVydTU67qPYPhPdyn5MeS6xpqBRrYei18abcZhhKTiSV//MUPknYxDOU+Jfeckku77FwOpSlsxEF90fS9LkD+i8C/9GC7ReOwSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703903; c=relaxed/simple;
	bh=nx6UHyycvOx0nOMJPrniexSgcT4f8Lew6DQLvX17eQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDKHeSCLX1tDy/je9WyJOXlufCgFv/dBvbQtvGn/nTmqVfue65KJNhzpNmnKME9YURDTf/2CO4zbrBm5p4AgiYMT4+f6soT+W7xZ9K5s8BOq+h8mmz8JedJSik/QWxqzYzx1ggfDiFqDBHU4QS/znEuyCzhf50m6/TTiNgb0xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIGiNvYy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1978770b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703899; x=1764308699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=XIGiNvYy65++kSc1B1HqQC6TtCuiv5nxOxbFE3MP1nSN0Rn30KHMSEoG6W+f1pf5fa
         vQWTgyXdxY+RvJeCvEqPXSgtpjN/cb/DvG7ZMDnHiw9+LOaktknE3zrVLKMRZxyc4TGv
         15XuW1+Hjh/yi9t2cj2dqFPCP8IYlUPXZtMG/+1zokdyGyi0obrfvY8aTyX0cDQlKUx3
         FEDnidpQyx98b/LkBBl19spwy36Karcm3JTKxCPoxTHWCtosijdXCHddeSWWdDubBBdQ
         bc8E+oQhbItA3wSe2BmW0fUdaMskfmFzS1DkKOcarxSzD9ITLsqx0nPCmYYy82Kz1BWF
         whvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703899; x=1764308699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=CPQtNLdS0TOKOzgdlhifgwMulxkfUaApNjgaITXn3mE5yV5AILKcF5kz6gSf/kHshq
         7+V8zOPCK6Mk85zQ6Ts8U84hTP1KqYJHOHjItHhs74U9h7Af1DWWONXD1QFh2xmulhoq
         Qha9SVY5Pk9b9gv9E6EtDEG8NcaLB4Wpx/wXsFfXWeJT60OV7k94AC/9MxdcbrDLAH6H
         aymUbRE+dVgm74t2oh/OFTkjztiCtZX0iyLUmnpUlepu6HI/qJR2lEIU/R+VcoaY167Q
         /1b4/Q44RUd/mdmwbFUHxUhkw9b69/3HnQnE0lRh7m6aWy7pjCqAvdFVC8Te0ywz5mQk
         vOZA==
X-Forwarded-Encrypted: i=1; AJvYcCVtngA7AUpemk5Z4FrUf2u1xfQWHsXQxKBRRuKH+Y1XpcMsSipRisGsNzLgNvaSNFFUvhRiVE16JDPyT89G7Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQdZ3YBx23zKgdu0Ig38yswQRoaXO3PfudJxYMAPQhKI55uUm
	/86cvTdRnYfYo4sLEt6LFpfXWzTB/ZmyRDTxOfRFbk9vzweNL+st8FoO
X-Gm-Gg: ASbGncvHfwbSS1hlbtfCWDKTxlWaTrZpMUAOFdH6nPrswVkHXeIUD05M44zXNa/nAUa
	3SaYf4Zo/plIIPMVsM+o57Gp7TM/Bo44eS6q+ZdpsMU5aKNpqPmOWjJEJldK6+Dgw4pZWui7fGh
	4oPCgIuKwSJclKw/5zajot631NWKhEulffP3oi9loVR2TgyHUd6X4LDd0hkPBvVdhu5i6cEPSd5
	JGsbdlFOAR4Yti9j54tRtv6DpfFT0OKmCpIThhm5RnZ/7qNF0TOH7Mez5uv4hjY51ESOw39mSzI
	9A2iP9d6cA6i7g4DLSKiQM0HgoSLTETYtqb/6PBaB6A4yKQzrGBZsLYk1IabR7Sptxzkfu2RfGd
	NTMkFpIyszOjjPGiHgLKEJq77HMmEz2GpdCBgAkQiKeT59PjpYt27tMbb21iRRRpG0TTp4NWC1E
	5G15Dzsh893aOAF/E2KQpZn5kfMnbFEdc=
X-Google-Smtp-Source: AGHT+IHqyE0w19zDPkaB/Ash2VMSaGraMj87gNleVuj/tN2LhZMjdzS2nkC0fyQfEaBt2i2bVW/KCA==
X-Received: by 2002:a05:6a00:1ad2:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7c58c4a4fe3mr1123886b3a.7.1763703898643;
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm4627465b3a.50.2025.11.20.21.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:40 -0800
Subject: [PATCH net-next v11 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4da91828a6a0..1623e4da15e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,6 +389,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -596,8 +607,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -615,13 +626,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


