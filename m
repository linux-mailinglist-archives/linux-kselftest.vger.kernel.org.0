Return-Path: <linux-kselftest+bounces-43826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B3BFEC57
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F36B4E6E5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB31EFFB7;
	Thu, 23 Oct 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Zg7hB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B287175BF
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181228; cv=none; b=fXSF6H6HYHWCXp+38RMgn5M0n5B+CnvQrusuR/mLAcEFqX20b50ohkyCOhW7fC+Bm7TKrd9gKxWbB1O2k78K2HeSxUohMolAODQJ3teCraXJnzEo/AayNk6obh2OqNnsZHrIks+lKAtTvKPFJM56KqtcTwAeI8xVYoAweq8MBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181228; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYLbe1TlRKoZ1xg0Li9Av/ar2rb6KnEd5QSY0Mi19ekqIvbNmM2cinfmNhLO7m9+73w7lURsL8+K4j5grY8TBsByvToO4enf13oSSvQwWWLh7NcVOLUV4h4pY/+GVMJRGS3nVO0psPrGd5C7w3vJP0TR5HTaGW1eJPRgGZHOFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Zg7hB5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781206cce18so221190b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181226; x=1761786026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=G7Zg7hB5B5G45aKO6sGu+HGKhvFnVHLdPiId/ttbkZ6v+Zll3y72h8s8Wr665LO85B
         I3iw4/PfcphvrSF8G7cnjKKMP9RXmlgEDHF9uALyCBg+OdVX/SOpEap6o0Ui4SMkc19U
         obrFFAm876jJwFx1VLZUOrAEfoHIxP+mlxgukO45L+pqlvsU5uM+tui/zOeB02cd+0Kd
         nkNBUH/W5ocT+Zn0Vw5ZPmz1uwVKxq19dVrS8Qr99BhNtE/01ftfMkOvOVukgWeg01oE
         TyTzaIOgfN96ex5WoTh6SZ2UW2A5Yeb6mM6gI10AyKAsz1Acx555DTNINgeT3vFn0KMD
         V7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181226; x=1761786026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=ZXpwKzcaFFS2F6sGkasMuu8tuE3UzjdD0vCdDyNQjA9o0/Q5AaXdHQpRlNitv1st7F
         DnfUE/y/+MAIZCD68kJ/xiTTOpTyCEEGRI0x8umt2nqcYOUhqDscac3WfzqHF4J2OEJY
         14rwdzopmQiigl4ots37imYqoW56lFXgetMQWpebAbZejuZVPEb66Uy6QxWEnIaV5R3g
         NrUh/3LJkSrO/Seo6g7XgbqyW/kTtA5obx7HhccAkXz4Y8G7NX+PAwUkuL/aCB/i9Vcw
         QCE+WeJ6TO1xcssA3OiVLINdtGO/sGFnv+Dslp7l8irhuNJtjmx6VKOGYQzWxwkIsNBZ
         /dPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJjvDNkQ9TeJhDhGDCU2FRPyWbyJa0G6Xz5JlBs2MaEdV+UVn+jGlfFRH72D5pUFXrdBM+AdxtaTxmV3f6wSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzeLLXeJKhcwl1YdHZQEwYZ4PpKl0vnn+t1EsS6qb5YMxqWnK
	PBrnVzgwvSJ7n/cCALK4ScOnoQE+Vq0+iTnO1IWvh/9LrnVHb6NDpw57nDWsmaie
X-Gm-Gg: ASbGnctkJjtalkB0I2tpwd7zdly6Zx3lbEFTg5lll2eBQ2SOKprXj8M42dKH+7F+Osg
	TzefeWe26rTOksd+pcrUgUNem84UFeg2QvNG2zgi/mNHffs4/RcGHPsnC8XRzYDo+IW0k8VGGgo
	+VGMb07UGg8CSqithnqQ6TGeEPx3fj8LwSILYPhnKEDGmpHBUMCccCTGroEg5t6/U15m/zsa68w
	0kQS7q7oqp56yNtCESGsqe7X0WmmeAv2XLJ29lL+XcAv3POPS+p50aecV60qAPJ26Ca/aZPROmO
	BgFJUfXyG2Fi5ni2PG0AIMmaXxp5liti0IdAcYqeGA9aztraWXnHmH1pBnQnDZKCzvusV1ANx7K
	I4iRaBS55WqpNb9d1KJeYEpEhXsPf48BobmqOKvKpOba+6rsBEUeTM65/SYKM6a8Yi2KIe52o
X-Google-Smtp-Source: AGHT+IHg3+CWJSd/e6BOgzi+f6DN5y9Cs7OSFyBJFrkPqO6Uo3OZWXDmlV8rzUOGTzBmE/tvar48Sw==
X-Received: by 2002:a05:6a00:859d:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7a26b3137a2mr3513332b3a.1.1761181226239;
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ce15sm576231b3a.23.2025.10.22.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:06 -0700
Subject: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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


