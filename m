Return-Path: <linux-kselftest+bounces-48829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE06D166FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C08A3051F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CA335086;
	Tue, 13 Jan 2026 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ07E5TU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BD3218B2
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273987; cv=none; b=YRAmhIZ2p0IwqbJFENlqCM7Kr8pnGfqXKsVWEEZdfTKnmtsIkIu3/pcyJaeOFfHIhfN77HWkAblUTnj0kPWXh4bDVg7jbE0PcsTZpfzSQI5juj+ftM49uYxbEr2Bv32V6HKNJeSuGBNrfQZEX+ri0e+Ot+9haJH8JL5VDgny2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273987; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZh8Wmi13ZpbQAzr4y3Dj43seYJpfg8foNFihVrKIfNCwffTTG25NXAsBouR1KskvkwhpjK4tAWZGAJOd8DGbQk/vrXKpPPT6ot6FvYdr/UT20CkuMwVIzSS3sSWDKja6JVnxKmkq1QsiYENQFA1/btxCsm/y+RcAkyNsBJbXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ07E5TU; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-646b8d2431dso6066138d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273983; x=1768878783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=jQ07E5TUF+iq7ZQq4zL4tCTN6CrcH8JW6G48bdyazJklg7S8tQMr1vP/zs7ARR1U/c
         p2VNF23O4o7+Jbyssy4a+RUOomF1LlkXOkGIVJWC/Iz2dDThJ2Vl8bQxZrxqDZv9glvw
         bG+d0U5e/sArs0hQdYGCAFLwLxt/anZo9jeqPOV4QAT2iT4PnBeDrawtXD7FsjHe/y+O
         91dZ11rtzVxaEhh5X+z8PRhcxoizPTzv9Ql3jPGakgUgU3qtTxz1T99/NuMkld/ToC49
         14wY9iGXDd3ESHYljU5LxydYYGFICXa3QpXr0YnLzc4g14Yq3MM6Zzv2Cc7p0aPpdyHG
         IZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273983; x=1768878783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=jDoqCPleyivaxHfq9eunWI2tZcTYy2uO6kiwbO4tKx+gkj53A7sZ7eJpFS8tJ/r4Kf
         syY1MKX+w3bUBizQsAeH1lcMLFeMXH24FnN6ZCz/nESh6AHKPTxIRdREggheqMFqCJjb
         wVcnTTFk7tmdT2rRALlMXSafQ1Xr3Cc/4+s0h8ERJt8Q99lv45BqSaDtinAjnJGe7cho
         l/pcP6pA1vtqsfQU4na4l8fku1X9w/Df4DXBulpljSIkQwB/vL0XAQXnrCgpecThRY29
         dMJ2jUR/7Oxg95XWTrPxJ+D/TodTEoKAiJ+UMkjyuxzkVQMz/A0FrHbBtRXzPBCkJlrY
         Jnpw==
X-Forwarded-Encrypted: i=1; AJvYcCW+hV8WIuz5Q1EiGgI9TXYLPeMJmIGa23oCtd7XDB+shBfdoLDX+EsxvPL7HXvxDaI2I+jUZ8tOnbPKdcOhmBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhtjveYhlTjBZZ8N9YX/iBB0BcZDEOy34Z6aRjZUoIhWImm1E
	myjt0eCkoQAtkBko4R/uBxtmDgEXzZUTVQ0FwS1rlC8kALKKY5KmEd1B
X-Gm-Gg: AY/fxX4k5ApbXU/Yak0XHQvLFkqabEdzezrLZY8CfkqgxfpYDmnbLKtKF5DHM9Rg35W
	NotuGr/kuWCbOPvLYiS3RxwYblqXeXkR79VT3RjalIYVLr1NtzhYppGbfCDJIatJjHuevqXXkua
	E/ZUYwJ1CR5MLu5KX379EE3OyDALJEO4EjW+0QvNX1pGEW48WFDcrWOaaDciaWMQ6Yn79ovkv7u
	d5INuMhPnXcuIImIJ9TF2wXNr6jkh+tcPGAZ2xBpNMmoAazMLZ4KPYSQ6Vdinb1Q7o6NDcTCB3j
	ksC0iQySXy8xilgkOvcDBat6O8AOPt8WOJ3LzlFZCnUJvtr0Vj5BaBv4ePX1dG/hWCxU0HXZVmX
	3mSGH1XeRkHQ6QU6tOZ0oVLXfvfFrjiADtS6dr5+S1Lt6pxo7I/M5sXx4xpU1kyGZUXj4MEdWvu
	1yZdBkWD5b
X-Google-Smtp-Source: AGHT+IErvHvsN34Y4EeiTfc/QvQN5Cj16XfAwMvouHBrxnnMT8gw+lZ3jiDdXraGFB4o7lMM07JE3w==
X-Received: by 2002:a05:690e:1686:b0:648:f70e:2271 with SMTP id 956f58d0204a3-648f70e3129mr1251005d50.28.1768273983606;
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d0c3f72sm49159977b3.21.2026.01.12.19.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:16 -0800
Subject: [PATCH net-next v14 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-7-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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


