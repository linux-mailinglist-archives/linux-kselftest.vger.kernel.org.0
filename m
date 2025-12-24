Return-Path: <linux-kselftest+bounces-47940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39807CDAFFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 01:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BA830AD5C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CDF28000C;
	Wed, 24 Dec 2025 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8fMjHsA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE272528FD
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536148; cv=none; b=gX+vsZqv7mMRWEjts5rfC98nuBmJiE5POcSkd8sOr0HvUXfq02qvbxpScMuZCWrW0DmkXOKtiOqbWzJeO1ssYMfUekqClN5Sane9osyq9It/gCSr70zzibJqMj6WcTXe5nP3ZXCKdqX46lreixWwVudU8ze6zipAFQh7cgNIAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536148; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CScwGtxM/ET0fTOvkSL1sduzyfyjACOfyZWrJWSkljUQYgplmd6HTaIM0d8y5G+yynsiK/rHpkwF7P12e95J/va+LHyeLZ63qP/JA6sbKnjD5tS5gED1VaHVJG+RiuZ8M6yuLLUZRlDXAZZwFNmXN1YGv6DSyRzpWvfRB9Dz9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8fMjHsA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c27d14559so4369757a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536144; x=1767140944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=H8fMjHsAx25towwQhk2P6R+pi/xlIkqcpZvyc0mNzU0wvU5imLLUrEWf9nxdsuN0pY
         oPFe0ZCRO6kwbmzJCoG50upAov7xFyVA6l3fSOerC34EP4hZAiRGHk7P+0n3k02jXwf6
         qccKtI1RLQrkz0tKU8OlEjt4cGuAw5bF8f6uHdPTFGmYEtXBsy0LZtwg363btwRMBXPE
         6bSQV3eiCRgVoEG5E5sqj3zN8l1Uv+/eKvRUMHMKInUVtCTYb72NP8yrbB0suH8A30k4
         8O3BSumm9hH0SqwzGqFIt3ykEFTfw7fqwJWPBZWUbea2aNqmFn9aN/2948vZeYyWo06L
         GFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536144; x=1767140944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=mqwZyx65xuP89+gF4PFtn5DGBzEdhvjkWHj3lefLhWiKHqdO2ifLsHYP0rMg3pojy0
         qAr1Bt+uiIC5U9lnK26+zE+2+GeSb+o8eY8htce4v0UnGlxoL1TAXZo5gEv3K8h5b7Dz
         htCMiu9X7LS/X6bZIK5KXOpRXE234S6vSPdU5ZQIwh8oH+aDwTDd/spalzmv8kkRFQnH
         wJIqna/aGFDWILznlPcXeQ3fogNumLiEjZkeok5TZZRw8+3qbWG4pOrNcUBUlzCC6AnH
         Ll8dWtob7u7oj3xss9wU6ckzPqjN8/Ezl4HTinglHWvJtQ758JvbzHoN5OlnaZdy68a+
         ppKg==
X-Forwarded-Encrypted: i=1; AJvYcCVI1ybFSs3vncMjYDfAsnJaw/lVXQyHCLpXKyNLqApvu2iIlTSuIilUIbG9ArPHJkxWSnblOITJOzfCuuq5zY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiI9qerPYZjGaRi2Lo9bE9xu3kWsiPKtIUS1AqKVc5E+v/Wadb
	RzY4k4IQYjcHgBvHP/RfEo724u6L9wReWhGkmDSATO+HYS4C5HqYW9E/
X-Gm-Gg: AY/fxX7uP8G5jIa/VwpmqBs3U+xN/32RN2edQpK0xXAW4sAaaLrKRcIfO3YoqkoXpnN
	I7yQmdgLnNeIANuuGbSg1yW7j5cuxbMSxK+WTxLUkw7G9LviGtWFirJnEfXC4h47dSm79Lk1+w+
	UkUE9E5VMNHyk9MwTzHHyAOZEEwceT+GQrdxiz4+A8eTFb3U7uqyOlKy4uZEqnuF+jWW9kJcYeG
	jyWHftFiKNeCr08ikKHBUj9YuHBlBGr2D/P8qJHoq3jw60GkyCxfTgRLCZ8Z1gBY1mHK9p/oPsg
	FZQHoQIJMTHgUhBTaCULoFXMyjWSd801C2ySC7A/Xzij4OHtCyRvEdiJVrthyLrWKBR1hmHKOVn
	+8yawbLGHCpzlwgzpHCg7COQ/x4l/zmWNhdOT8lMLxXv7Mzsdfum6UKe4RNBR/8IJJcuxQScbSA
	/op7kKS3lvZYkbNZRL9BlJwJ4PTKPh5w==
X-Google-Smtp-Source: AGHT+IFTZDOw9eAnRPi6bhVcftRHoSFo8lIyLrFNox+dzS6NcG5frjB7IyWc5r2SL/GNBjuoB/j/Mg==
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-34e921af98amr14188558a91.20.1766536144065;
        Tue, 23 Dec 2025 16:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769cd8bcsm9008694a91.0.2025.12.23.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:42 -0800
Subject: [PATCH RFC net-next v13 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-8-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
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
index 1d03acb62347..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
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
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
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


