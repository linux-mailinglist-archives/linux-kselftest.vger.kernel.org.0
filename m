Return-Path: <linux-kselftest+bounces-43704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C511CBF9502
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8993A919A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3102EA729;
	Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isRGfygX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F9261B6D
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090432; cv=none; b=oPB+F3OEY0lAQnma+HgfiyCsChVWvWASdwuKV2qBv6t2lOr2JgGNNsbH/k/Q+f9FN/BwRDssdLAQMTFOsLP1v8CdYivoJKSfmk3eQ2UD0zoKOeB5QKAKHLF5sVSDZuiS6ZPEFCKd/RpwKFLEzv/sPjqI5RS3Uf3DrwILLx47/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090432; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qihNN24HEQ7J4C1YRaXcICJiKYT67IcCGJ8CmiDVojtgVVu4+WsKVw7OPdIYZuteAlLfTWhbzyyi8D0x70RzCkWbWhapJwIkpUffGL/OB0QMhg7Uhygqj1yN6miGKxIkM+/Pj+/WgpAamjTqID6vW3jS82+137H2DZepBfvuzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isRGfygX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781997d195aso4740919b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090428; x=1761695228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=isRGfygX3j3kiY9X/b4OtfvTwWRvJM/VJ6cfmc/v7sH/L+5YBWxqGOIarwcO8xCJyk
         QXIiM/pCYVIbiAujF9qK//A3Sj006l9IYbDfDgPXINjzmRdchl5LCHumRxFKPLbkiGG3
         OGYMruJUyIqmbFHhlMtARC0wST+P1gYQCcIC/KCU9iOxMiLpPr7+I5dUd0aawRVWFqNL
         nM43YRXl/+Rv9Jf3iChLrMf91XTatMhHShIJOHp/Outx5iIbPeS1EGt1O0RRKYHZH5kI
         IGSs2qXy0N3M2sd1aOEaWzv9bLkQcUwy3Ksu/VePPRkbhDJrncH1Cx9rk899OC9MP+Hr
         431g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090428; x=1761695228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=JbaeAui2kmK2QYuiPu329sm4IfnSUvaUs9pLNeh+ftVZphc4twBvmUoY8L2in2cw3c
         O0XMFmAPeg4wLbzCOkaBQRPf0gsK9/yRIRmWWk34a8EnIFTrm9gGqeKm+WTokXggxgrG
         TspBYUBCl9tG5i1DL15tq+4hPVgjGOmgZB0s1npshNscgnuqKpv9Xwxw6XMRSOdPqbFc
         TbkRdeZIyPELPrzbo4bhPE2LYNsxuAv/CvpzLAGYPHMpv8+0woo/NzTOcvpA9E3k5LIh
         OaP4LPdy9dttHHGgITYyHA/GeJs//AXjMLdkhjk1U6L3JTutlCZj7JzEFsAz3T6yxNQd
         Oodg==
X-Forwarded-Encrypted: i=1; AJvYcCW/+tUD3cL16LqaNpzI2Wv+c7XHuSlVIEWHhWJ0ok7Tt2TeuUzVgHu1olR7QWU/70kyFFhV/a+wKdAkxTb54V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK80I//bOLJeTiNFWAvz//8ZBoSWWVVvhV6yZdQ+W0n9E0oC5O
	XgKl9rO5RXB7joIR3fUywsYji3+j2WSocJmHIRurLcSiopgUy8CYIaSa
X-Gm-Gg: ASbGncvdgcD9f3NbnUcw3fihpGrzlrIUD3jV1VT7oGZPZlHXeIntD3HrsPu1eqehOKm
	IMKY2TTe0eNDxSoz71X2qYcWA3/YIkKtaDJaTgQpQGs8xNg0tLB/oH89AstKF+UfE6trNoq/YAS
	96rmijXA1DGMe83oQZ6x5TQRKIiR4c8fN5p/SmSDS9qLQVwlcm6513ue2Uda8BqfopSxpeGHE+1
	sRle+PPCEEgsu2gT1o1hMZSghvDcPpkYjwQenuFw14jSAln4xCCI5gL8VJp+3VDn/ydY2rG2Fmr
	sO4pGbhMYhblaFH1EoSgh4k3ir9cYzfbEO3/3uKZQBA9kGCygMrkac4SOLHhCqXotvSivdaYesF
	UREl49SaL471qVErEzUkmfFGVJXrHZUyd/ScB6eNbvlv+vJC+ZEjJ4ympjfyMt25mLTvHsEuQ8w
	==
X-Google-Smtp-Source: AGHT+IGw80QlQNTM0vsCWt4Xrwj7+OMB8f2A+GUNehs8ToYoF6rhSNtapD7Jyv42u/TS1+BhlWruNw==
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id d9443c01a7336-290c9c897damr245660295ad.9.1761090427698;
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm120683495ad.115.2025.10.21.16.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:52 -0700
Subject: [PATCH net-next v7 09/26] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-9-0661b7b6f081@meta.com>
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

Save/restore pipefail to not mistakenly trip the if-condition
in wait_for_listener().

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used. This will enable pipefail usage, so that we can losing
failures when piping test output into log() functions.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 561600814bef..ec3ff443f49a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -243,6 +243,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -251,6 +252,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -258,6 +266,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {

-- 
2.47.3


