Return-Path: <linux-kselftest+bounces-46192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8835C7771C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFA9535F660
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A6283C87;
	Fri, 21 Nov 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avlJ3HB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECA2FE057
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703905; cv=none; b=R33ZBykGgtwlZ3it7/rXisvloqskosLGxJS2Cyzj3MSQ5ggThXY4HZIQuaXsVt7KRUptrbUktoIMcc8xXgqcLF4o9bbZuDjlqnFvWaYR2kHFswYEsC1D9knCSoZkYAtN4tRDbc35fjVAYApxWLZYUpxFP2argY24KbngMO0NVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703905; c=relaxed/simple;
	bh=6ZscPf9/nWkvwyT/JpdFbFpcYi98JG+pA4BQmlsYrSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdUSeRQwBrqP20TCEh7DjjxY/ua9DuD00Vq2SBZ/V/lbBXKDn8RIIopRiojUcUakL5M7pr1paAXRVUtgGqk57gh4CiCeM33IkYXAG0k+ZHZPYqpY5IRWjecSCzFxHorwun8eciBjQR0RVtwL9UdlRwTIGCI2ej7LZnX1MZjA4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avlJ3HB2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e982506fso22341575ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703900; x=1764308700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM2Et2bNJKp5Ra2pKHUtM/dUKGxKia3TES/qjTZzw/Y=;
        b=avlJ3HB2SSmkGQFhN9cX354DE5YeOVa/cPzKR+S/YkNKsyG2Yut79nnutTbFb/wgwj
         sFkob0fS6UVCDlLEX1GYZ/fvegPtq4TV54hXDKfzSL1BcQKwcE7N30ldNWgBsF6I9KDS
         YxDnNG7A3nBLpfp4EOO/5ZDjqhHLPd/2w7mLF0NPi5dscLX4YWn6z+Y9hFn+D7Sx3ZUz
         SWnV0Lpba1aDOXbtBp9h5Tw+h++hi5oBoicAmaxeSiCca3UdDbkZqN/eBDARb+KEaeTN
         fBdmg6tSzYsuXruphKxKtz23asz5RCgMLIkZMeKIrh+LlQZVG+8NuPCnfJqqLhgieiMn
         Q5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703900; x=1764308700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QM2Et2bNJKp5Ra2pKHUtM/dUKGxKia3TES/qjTZzw/Y=;
        b=QG2/rmDX38r2FuCxsNQ/UNgFhBC7KOCGcCdrmZOtqmJzdHLGRkodg4YXuiaQuO8eqf
         Wh8lPiYYXNT8NTBoyZwHs4fpODgW2pPNBwNFZSIF1PVMzxmmCmFOC+vqGLSat0fcEBUh
         FHND2uAaQP/GqUqrdLojft7DElXxqYkoZLQm4BglfEyoerCVkNK9A452pcEpuriqVHie
         OSgsY7AA+wX8bd0KSc1GGusqlp6EOYxQd0D/ukNyst9xcbSY3/q90o3lcLIO42CGM0rD
         ByRR/uo6gsC7cL86RRyAybFBA63kbABirY+nGuEjbMQqJPtis8yN4EIO1Pmux7HQFW5B
         EFKA==
X-Forwarded-Encrypted: i=1; AJvYcCW28aq9giwnxSgdz9I63+MfKeUSD5ayay17DKGVPA+qGaq6k9Vfx4C82HxwiM14StGTduWw3Pbg6AgZOWRK4Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YTRarQ4q8zJwz56oGLerBFSVWOWDNaR4L3solBKrS7xllSq2
	F+HMTIhQsk2tWRX75K+YDbYnY0zxHKGQ11EHbsWqg6GYr0rCzhFdK0Po
X-Gm-Gg: ASbGnctHu5S+Mf4/kM6eHgq/LraACDqJJFAWObDu7Ch6SAc3O1JDuyEBjyl7e2gfWUb
	WAxoyrIIcQlQGB8xNT1jJipvOKIfBOvrgIy+Y3rpJ7q2yqURo0aiGcLJgiofiySsbA362yG6RyU
	K/rQtqCgXQtomXOgNKAbpqZkkZYL/EbvgGYxlfVfkvRfp1tcrBN3AWKKAu+rong13Jc0NepnYx2
	O4zWjSCWic69bJFcK8kwakD+AbvdRWrNGx7kfhsnpeqZ+b5nDOMAwY56vgBvt3/o1siKlYJ81qg
	ddeSif6qmGj6MfE/oCZvmDjVvVy1yNBc+muRF/pUoWHvXAsbU/9hqc0cpnwUMqevncCNtlPtfFS
	7hQdf1YXeUXY3Wd97kmgOxgGC/W9BR0CxaFjs+VqV3ni0Jq4gIDyQTUNpoiTbTNowE4+tRAwvlV
	jDTDPYOQk14IPGOFEr/fU=
X-Google-Smtp-Source: AGHT+IGFbL+cnKyAAC1irHWJ8hb+QO/2gEl/srsbm0MtCPfs6CQtasuEnk/8bsVIJzKyqjf5dYOUcw==
X-Received: by 2002:a17:902:da4d:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29b6bf5c107mr16446955ad.42.1763703899576;
        Thu, 20 Nov 2025 21:44:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm43195905ad.43.2025.11.20.21.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:41 -0800
Subject: [PATCH net-next v11 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-9-55cbc80249a7@meta.com>
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

Replace /proc/net parsing with ss(8) for detecting listening sockets in
wait_for_listener() functions and add support for TCP, VSOCK, and Unix
socket protocols.

The previous implementation parsed /proc/net/tcp using awk to detect
listening sockets, but this approach could not support vsock because
vsock does not export socket information to /proc/net/.

Instead, use ss so that we can detect listeners on tcp, vsock, and unix.

The protocol parameter is now required for all wait_for_listener family
functions (wait_for_listener, vm_wait_for_listener,
host_wait_for_listener) to explicitly specify which socket type to wait
for.

ss is added to the dependency check in check_deps().

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1623e4da15e2..e32997db322d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -191,7 +191,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -346,21 +346,32 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
-	local protocol=tcp
-	local pattern
+	local protocol=$4
 	local i
 
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
-
 	for i in $(seq "${max_intervals}"); do
-		if awk -v pattern="${pattern}" \
-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
-			/proc/net/"${protocol}"*; then
+		case "${protocol}" in
+		tcp)
+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		vsock)
+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		unix)
+			# For unix sockets, port is actually the socket path
+			if ss --listening --unix | grep -q "${port}"; then
+				break
+			fi
+			;;
+		*)
+			echo "Unknown protocol: ${protocol}" >&2
 			break
-		fi
+			;;
+		esac
 		sleep "${interval}"
 	done
 }
@@ -368,23 +379,25 @@ wait_for_listener()
 vm_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 EOF
 }
 
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	if [[ "${ns}" == "init_ns" ]]; then
-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
 	else
 		ip netns exec "${ns}" bash <<-EOF
 			$(declare -f wait_for_listener)
-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 		EOF
 	fi
 }
@@ -431,7 +444,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -472,7 +485,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


