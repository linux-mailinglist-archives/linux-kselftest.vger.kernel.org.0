Return-Path: <linux-kselftest+bounces-44817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00389C36909
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64F524FBBD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCB331A47;
	Wed,  5 Nov 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQKTB0pC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13C32F774
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358367; cv=none; b=Zd6zwzbC8FiAWWmS6ZB4oslLqwG0KvSnsN5n2GvIVc0KLQuyRfuua8hlaYCVDDIvPzlTtUIP1BDeas7kP0N5VdMaSg8u83srqGXDeIaf5M0QlqfyIguF8S5qwj5WiolpKhO//Gq6Ls25HcfA3FGteXswC/4AbK4iEQFHOQ4iphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358367; c=relaxed/simple;
	bh=pVSfoO/0UIFMSnMLr516HI0z/z9lVuUNXwJAeljB520=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rf3RRLSbyyEUM0LJWtvY/bb1Fol3PHRIybKJj4IaL/4UhEqYQhAt2jwZm0VPFZhFPJdH67Qbol5FfHoqFFkiuHe7BFSCqMAaDCb5XjJxeNDJQYStiLGZ7dwmI08LbZ+zGokQAZa/6IiamUGiVyvI7gIL7omdNG2TumnLV2QuynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQKTB0pC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so6594862a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358365; x=1762963165; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=JQKTB0pC7LcRg+weqNHESVw7FKSbK+2Wwr9uKEZ7mcOBbceGl4i8i3W9LhA3RW7rZ1
         ybebzcAlmQJ+u8YiWK/xizL9PUg42vcN5BNX6oYEA1fpK2SYm3SkdF9QGBP7teuHuuaU
         X/F9HT8iq9fw0pQb2fdIUAqiJU6Tf5sFxXX9SLz4XZ0KUTcSIuzAISgR0JolF3zH9oFC
         7hTnSoBM7Cw7E5vm+NjQW8itTFz1HLpmK+zmTnHXRe+KGWhbG9ZPA+OUgScTeTdkj6Ne
         xEnNsd3GN+iJBrPV0XBTRXvCNby3wpeQNlf3WlyGGPq20Mw9cLn4MEbabymca1AwNhxM
         0nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358365; x=1762963165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=KvNmqen1NBHSgQZDQoFdamiZhNwJOrpgfwnY5t7b7r0cdD9dC2PFRry3trHU0SsAWy
         BMsQDFuBH+NSIfne5wCdyuZQVlxRaIZKsHFxl8s8XqTa0OVua9/fwozXTzTBhAZtuZPz
         NITD/4KIHj8ZOj2H0XaAYjRYLJ+Dvbb8gJhMySt8VrrRTpXk3aZcfka+UCSpPvym+J/F
         nJ9qvqBZOdzyS3f5URLq5Pcj6qDg/d6WPjyPdorPvYJpSJFbi2ZyHJPAIYA+1q+vochW
         0IRdnIzqmhAo+qcJZ0lNcf2A4mIY6HdjgML5e8ZaHDxU0BBSpJixwHwmhM53yr+9jrRV
         gr1A==
X-Forwarded-Encrypted: i=1; AJvYcCXVzQe2gXu2kNNzP/Q390NnTdi25zKim/vHHiirFUtRr3GENpkLEA/DMAZdFzwmM7iSszTrp+pmXjddeHr5ijE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/YZe0FHpTv+GUc40gYapOJ7aFoh2SMBekSfJ566Gq5G6HcPv
	WasehIFbDTgQRfnApp3aXb0tYfJoz91GuVhedomXF2f028wPtbEeIhLz
X-Gm-Gg: ASbGncvvsMAdheIyyYPju/WmLYsox2yrh20uPV9CAOssvYJ/C4K6Zrx+1oFchnA08+5
	nlR7GvTChg5czt+ULVlMxn6kFYMP2khwFz1dlV4ClFc88EMA4Bn21w0TA+K/KZINdF98jSGqYkv
	XnDRcbg0XRF10S72lUslmfjLrGX9svL111OaZk6jkxGwXJwfGr31B9Tljd6ys8XRXyUv91B9cHF
	e39L6vCxnjV2ncUmIgKyl+0aKE5wVOKnUvWb+9wCQfnBiXf5rMqYUDbZftwuO6v3i8TW9KpY8BR
	DwjPI+03hFabmRgwLcXI5WQTNe1T7tbW0l9wuSUeK2PfjmOd01LD0K8UUX0vzgDvTLPQ1MON3G3
	q7WS4SR9V5TZ92Xr6suw2bnRVr4QAG0AlqqgjhGLjzTggXYvzLuE8gybliaLIptsuDJp2kqBinw
	==
X-Google-Smtp-Source: AGHT+IEe5YQ6JeJmA49ewbcYItDVFikNimAbp/SS4l9S+v7yYwjF6WuYS8I7WYaQuTYcUp7f9KrD4A==
X-Received: by 2002:a05:6a20:958f:b0:347:5ce0:6dda with SMTP id adf61e73a8af0-34f83d106fdmr5164430637.14.1762358365064;
        Wed, 05 Nov 2025 07:59:25 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5859917a12.10.2025.11.05.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:24 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Nov 2025 07:59:19 -0800
Subject: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
X-B4-Tracking: v=1; b=H4sIAFZ0C2kC/4WNQQrDIBBFrxJm3SlqKpiueo+SRaJjIsVYHJGWk
 LtXcoEu//v893dgyoEY7t0OmWrgkLYW1KUDu07bQhhcy6CE0lKKG1ZO9oU1FuKCLhIv6MMHZ2X
 1QNINtjfQxu9MDZ/iJ2xUYGxwDVxS/p5nVZ7VP2+VKNEIa9zce+08PSKV6WpThPE4jh995KsJw
 AAAAA==
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
Changes in v2:
- use consistent quoting for vsock string
- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..8ceeb8a7894f 100755
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
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


