Return-Path: <linux-kselftest+bounces-46612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A57C8D37F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 999AB34F03F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B858327BE4;
	Thu, 27 Nov 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1bzQGbi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277D3254BD
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229676; cv=none; b=t4L0jIKBiS7w0wpbpgtVDEwV2Myx+ZpVu2jI5eIsgqsNTMncIMAq3bHXzNwXGqbBBRqrl4mAlqVeIkS98ktMLCdLP7kTM/fvTb4BeI10T14FYzTjyMl0iMIYEFAL63mIPazRj7cDQ1fQu2lUcM71AlGH0r1dMEl844aNte3fDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229676; c=relaxed/simple;
	bh=czzpcNHjlEeOECy7L6VEuIsFXHYOopcrm3f9fwHEjh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPSusA+/b5v57RKZF/f3Dqz1HypTC0hNfnhcV+9Avc7oXwQFHDssDG+XdId/l892Pd6ri2SfrLGRC/1CAGU6c6Au7IRZp6owWmlUQDX/J7KC7A4P8XvHGNlT7W04XuMKoBta6gdt/QoK+h0YEat+SGfBiNZ+Jt2SfJ1ROXT8wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1bzQGbi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso893877b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229670; x=1764834470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ4JZaUoTsMQYrL+kuRb36qxz+zHEzB26FSI/H3YBMA=;
        b=O1bzQGbiuiHCoQa7aBJcBJ+b7+e+Lsreenxf60zxvObi/ttUxG0Z6G+5yEKYtMFt/Y
         dnijsJgbkDnoQ1Y3FyKHHfnXlSio2eZCvE3raBKTeAqUKHGOAdzMqACjDkVTCoePXK07
         hj3QRqFXBjjo1BC83lzbpP7opxa56zdCYtN9AWlRaZIyKojORO8s3GTwK4cmuqjIexqy
         KTwsGtWgGbXx3OVBpY9FdkRQzE4E1I7xi4jzM4FGIsk6++eLTBzVdFtkks4iP0ZdT0+d
         GIJDoGsKKOw3wly83lWWZ1tZTaD82SOY1OrLiZk+iNw+ZbO3zCtffL7jb9DiS6bHjPo3
         HZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229670; x=1764834470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQ4JZaUoTsMQYrL+kuRb36qxz+zHEzB26FSI/H3YBMA=;
        b=qKyTLHTTmQEqiqrWQOfciAQNC2YP1X9TLRcOsrcmnZwaqP7N8DRiCOJAjiJslkSZAV
         k1Qjte1nSlFgnjQP2GiWtZEH+t+WiBxD27+9FpLALTyrW8vuDP7cUBm65efXjycIsOeg
         yPDauQ6qBi+pPABNSSuv1kOESWYgA9RPPv6ukKU6UJsbsxE9T8QEEYnUG8W0nBpghvVe
         qRrekU0JptIfCpiE/zdFaZgMRPTK5UPgIMJemH+nFBUVeZxRAeGUkUTwFvnz56Uy34GT
         NoolwsrGt3tRNpG9HyNOXdbxZrxmPk+nAu5UmIWIveRZnB+yAmPeeZz+/pYS1yD4i4NM
         KXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9WGWAuThb+qyESJ6FWPdUbD/qYv+rUew+6oMX9rnmHIiztFFGglwZrHL1prje5Qsi6kTDB398KWfRm6PdhLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKcOVLjohdjQvXAhlhp8U2DM9CyAmJ0cKbo8x1N6Nl0jvOSrQ
	hJfe40D3JsYQXVWMo5ggVnxCq2BSSpZ+ZkFL1K+eVSJfGHjItgQ6Nqtt
X-Gm-Gg: ASbGncscnynLl/v2lJYu89Kxl3Y55H5VqF6lLf4D+acGfwpiJe/sMQSekAGOiZBOgg/
	tEk5m60SNYNPNLmlQngEbvRNmRjt6RHLB06mSo/sZJiF8dfEMh1+EH4SelRxLR4M1BHu9jzyCj9
	CBGWC1/qQzy/VL/CsSA2DHt+06vX6z+RdFYZN+qSBNL9RhiGUMcBlp6ydc/MEQOCh/AXpZgzx4G
	utLzmp7E3lF/axkR5Y63tgcfxEZHU29n6KvbzFJsTGpCGPxtKsfEsuxCz5xRn+T9sD5siv5jXno
	i33bi8xX/urYG+hS2MRt/OcIAEgypQNXKPccEixCKYDlMi3nPE7cdgaVDP4D9rqhUMDOqCaBrNG
	2eLU09sxmtyenMKR23SU2KKWDecUjReNmWUS5i6PDTRsl4WHvmC0F5cE9LPm1QToD7OHB5qCqTu
	hhvbQTh6Rw56/hRJ69sjkn
X-Google-Smtp-Source: AGHT+IG/QkipgDC5/9P1526ujkoBXHGm/apxd0sZKMmlL+0mQ3lVcIPyxsJBx47IADm7h5JzGsdVRA==
X-Received: by 2002:a05:6a00:2d0c:b0:7af:19bc:ca71 with SMTP id d2e1a72fcca58-7ca8975f7c1mr11555824b3a.19.1764229669761;
        Wed, 26 Nov 2025 23:47:49 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e6e6df9sm918997b3a.39.2025.11.26.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:49 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:36 -0800
Subject: [PATCH net-next v12 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-7-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


