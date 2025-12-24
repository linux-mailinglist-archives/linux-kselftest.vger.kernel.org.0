Return-Path: <linux-kselftest+bounces-47942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F829CDAFE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 01:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45D5305657D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCF287263;
	Wed, 24 Dec 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhgWFr08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822A20E334
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536150; cv=none; b=tnZIC4A0odvqIwFjd18AcywVDy8vvgp433u5gqiu1h0g+JLKm8t86H5o1xSUYD/vfgVTA8vMdYSGvxmxfm/xaU72a5stCOGTm1dcI/LJQYEb2AU+AmLMWBMqJRfm2gsuem48KvEWtZ3/uKR0Rcff9Vd5lrp9hlbFWkp3S9ykOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536150; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV2uzEhpw1kiy9ZOTVf0hYETLTlhjczHocFs6NKeoxIMW/x7o1ZYHraH9kOEObMPfMKOJ2qkCKvnj32RmC8pzuniuprE3X8fqH9DBiDkdXhB1Tv/UPwN5gbmIzOqN2MucmrtJilyXwjH9WbBe1LtZPtbsujTJTSriatUzfof9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhgWFr08; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5179170b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536145; x=1767140945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=dhgWFr08MCIgXvO+gifjtNO0TYYNX6DbBmamwC8C85tyREKMzR1iL8d+VPOIb+EUWW
         X7eV2K/Jm4KBGdxT80Rjpaa33zOqAZ85w9RZMtmbok5/sUYPEuyzOQiPh/D8phn3TBhc
         ex/qhdLdsQbofksFkEYCCAuHC9UiuvfsaJD43qqavKAdQ8P+Qiww2OLVMFSQu+Nj+LEK
         G/E3+RfWr8N+OezmWLmBPdk1xs+Ae8sKY9qKZ7fxLxNH/L4FQ5cJ8VJLcObmmo5JoXlz
         EfAf9rIhrVc+g8wVcdxJuMHrHyU5qqNw1g1i2girPLHP50Pu/w7Faj+yTuE2EWV6+qYZ
         6RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536145; x=1767140945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=cJ8TeNRA5T+foH5TmslR0+BFKbZGDw6BlOiyYbEyVqyc+D+jRye1eO9JVNI+QKWrCH
         ArvYdueO2INSGi9pizrIhb+Dmw5la993fml8R2i/TiQuwF+hbooojkVRC92MXP6LTEJP
         y/5ZLqB443UArrDGs3rNGu/wdDYnUpAjjdPejKxisy64WEMGblrmVhsnysUDQSMapDrB
         4aiDNCSxlEAfsZAQwfgn5cYoyzu3F+HoK2BhwVR1HZYlie2O7bSssjdH6+1OtE3tz2JD
         pZxmwDS+k4bBRIl5erioVgyuM9oWo4QjvIJrs2+yqa27nSIXZasZZ8riLwp5jKjvo+iM
         G2gg==
X-Forwarded-Encrypted: i=1; AJvYcCVr1gnZu/ebaPvj0CRzjFHWyQvC8rLhnF1SnbkkjSsY1pbLRr7TnurtMYPeAjCtr0Sbw76w5k/V5fVnXrPCtoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7JspjsPmsfKmevGj911O0XTLgkhMvMj1fnKfRRFD596iY/le
	jlqsVWDkEscW4ZCTMix16Zvx2gDCn5VbTv5rCd5b3OXiPK5bnV6rOF1K
X-Gm-Gg: AY/fxX4/1Qd+Q/dqjks+EntY2A33PD9PQe3U5rA5OptZJiJvH3XrApFfRJLibKHs/n3
	1KFMxRdel/qnYne+43jNvyhezSoY74wEz0EpEbVqulTVsJQgNCo56+WO/ndwkbSJz9jMpJSPYG6
	G5UddOYOimB6bcXp2l+ZqDRZ0gtQo+mc9aCt5VnwYWeNqnpuwxkLfNapp8MoQMllIsGHLsoAD31
	INBodRw5YvIdO/mcruRsmCLjH2y0Pw9e+H+OeFaR6DmFHYSGZltQp8WKON+gXY7uTYlp/vQhze2
	wLVC+cfIe997MSlRirTqfriZA1xpntaly9GQMyztABvkvvxFaQy3eXOLX01TTw19YUsWcsyhxA4
	pQb5jSP/1bMOaT26fp4JNixHqSdc3/b/o/a6O3Erfi1jv8Kl8ZO71SjkcZirZRjrZalnXZ0J6jo
	m9tOmHIC4HHVtdYrihIy0=
X-Google-Smtp-Source: AGHT+IG9bM40+23m7ksLXlbMaHJ4J5fajkInG27QTdkeyL6rIcjmRvm7kMrKaaEMk9caXe/lgKe2eQ==
X-Received: by 2002:a05:6a00:6ca2:b0:7a9:c738:5e88 with SMTP id d2e1a72fcca58-7ff657a1298mr13744515b3a.8.1766536145181;
        Tue, 23 Dec 2025 16:29:05 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm14802196b3a.26.2025.12.23.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:43 -0800
Subject: [PATCH RFC net-next v13 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-9-9d6db8e7c80b@meta.com>
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
index 4b5929ffc9eb..0e681d4c3a15 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -182,7 +182,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -337,21 +337,32 @@ wait_for_listener()
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
@@ -359,23 +370,25 @@ wait_for_listener()
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
@@ -422,7 +435,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -463,7 +476,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


