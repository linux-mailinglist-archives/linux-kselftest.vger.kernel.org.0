Return-Path: <linux-kselftest+bounces-46613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62304C8D394
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68AC3352DED
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EF328608;
	Thu, 27 Nov 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WikHZaK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369132571F
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229677; cv=none; b=qmu0gGW+GT6/hLePU/mNDmRg3GGbo3bnx70TFe9pBmBLh8ZGNgG+5+tTuupqWxaYTvsLKsCeCZODb6RrfooLSGanLVDdgllkVifw3DIrbPMJjhJmEodQHEv/RtH9VHipSjwY5bCR2Wc1iSP7Vm5T7LBChkywKGjxd12UKIyekwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229677; c=relaxed/simple;
	bh=VXSznUA/qrGw37DlDQ/ITpl+vbnJQhBZAvRQarakHeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huFAkGBHGXnuYj9YW/DwHKJXKXycmxRrpVjKpbHQ7WDnrV7hQLSf3i3fAcpSRKqbHdetPdR/P2igoxvy+dnHdA+iDWS4p+4JdzCUyS/DZhwmQkAu3X5gz4CIRLVToc7b7J/IMp5jHOHv+kMpR2wxkR8GBdUVp/k4+mqF5LA/9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WikHZaK9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34585428e33so628569a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229671; x=1764834471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=WikHZaK9uCb14sc9tWk1a8ahDKOQyP5MPHTQTTvBDi5x3sUPb7U0JOZRLNS5T0fKdv
         7Yl5tInXpO1ZnwaO/cmAkRQ3YIcCRZRfELueqV2YwpDOLKlkSEm/NA1KMa1h026h1PYD
         QrjmMSLDKVFZIyPue1ElrVhA8L6B/3Ax3o+XOfIY3U8GpPI6CHlLlxItXVa6WINpVrmy
         3nu/f/yncbUbXh/iMp+7XAN3CP3/kHXuuHIf6ibWBdFeDqnKuX480DQxAxHZM9zpBn+p
         Z8hdNBq/XGmEBjp9rNP9w3ZoepkYXgmil3X6/0CVnrR5Ve4F8PVl0eQ8OJ1+yH74JIuy
         vmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229671; x=1764834471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=k+eYETM2Rh2QsH8Q1Te0YQXveimToqUQ7HrSmYmJmNY0a+A4vtm/YTQWDBtsmOScvy
         w83w6PZyJFbNvUl9wuV5EmTHo6MpI1aSBLYjbLdiXpWsQABzmGg4Xc5zW+S+hpL+H9ow
         I3eJ8bHh6R/Br8ckPBvVjNp48rNHa0IzT3dpUTeFF7/kOErQCig2kV7o2wmL9JFNzZ6q
         SwlYyegPZkqDEKXOfZEbXp8igzsG9OJXYK58mf3gpeBWmXiFnErvac6xQ+d5ggzIuA+0
         Dfu/fO4Jm9p81OebqTENxNLJETo/TkXpSiTtrNlU6rYhGBVk6FDTn8kPytFc6Y6mz0T8
         9eaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTtm2i9LUvbq1tW3YKCOrmTYfdcDlb9OqzbeQv9nsu/Qcbz/OpKoKaBbTDKf6AS7KHsEynroz/YWvvOcpLF2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Nujn/yiWTak10soYjnEJouSwgbxEeIDiSw/4BMZv4R9BQeh7
	bAUPuA/gMtaHrzOQgWQ4MRoPDR2cuk/QYTGM9+1Bv3JGdI5B2Jash5fm
X-Gm-Gg: ASbGncsHO0NIIaL/Y5/+OKfPoARHfxLArf3f5jjeJQoDA2CggfjkDbhc11SlUk761BE
	UiSgUXorCRwymkd28oPjj//Clinz2EJsq9jqFJbgkiE5CK4UEYnXlsXNfldEFVq5exbuRHH4jlU
	oYaGhEirHcGu3FODw6f4zn7zIESvGBKusut0TjIv/R4bbw+F1TBuBpgxV2gNP+6JXeO+N2kIIGA
	47cvFzq6PmNqZEWjeR3BTyuVDhm7qvpuGObMlVCt2edSNiL/3RxVGoplMYsGqr0KeumlN5U+Fxi
	Hy5/J1eBhdz9Pt2wkQ5Z1JxyfLuhu4vOLfP0GBAh5UU7xOvynzb8UbOSZb51jNiqENeaH0AHYA0
	/nFJLAvrWosj+43sSo8hkJTK58nGU/JqX8Uh4J9xhwn6D48SEBD+KYnYEsigqquTecwSdrefHnh
	QgVb7JEzXWcIAjUUmtZ/Y=
X-Google-Smtp-Source: AGHT+IHm9n1hN/MXgqh8Fst0OOiMbfzgNDndic/dBuz4wSklQZaHZ2bC0MkEgH2q8ls+YwLmQfHTOg==
X-Received: by 2002:a17:90b:4c48:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34733f3f6d5mr19204188a91.36.1764229670667;
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a0e65sm989665a12.27.2025.11.26.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:37 -0800
Subject: [PATCH net-next v12 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-8-257ee21cd5de@meta.com>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


