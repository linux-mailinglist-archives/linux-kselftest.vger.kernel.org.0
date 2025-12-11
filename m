Return-Path: <linux-kselftest+bounces-47385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3BCB4BC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E143011012
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A148293B75;
	Thu, 11 Dec 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SgciTSnM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAB27990A
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430198; cv=none; b=aJO1sKt2BFy6ogwWylFFrk6M4v8Gsz2DAutf34RrVUSfSjBVcWFhC4X9NGEQE4hF/cVpHfyx+VnK+P5+7ti7fMP+JMgxFB4/825DmldiavHrCUo7/6FzB4i9RqNn1HKg8/TFL2nQKir9Vn1yRSp6zzs/ErknvccHEsEshdCfyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430198; c=relaxed/simple;
	bh=acykySZqQaZB1IYcjmApohtjhjnF/Dlf+Coyd9uZ2H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmrI9kq2pkbbLOFM6DSGIQSkd5tKn7bzMS3grVnWV7t3BcRzsfvpQ6Utg3nlh9Yyp+9hXeo22pfIRs62JUmA40APQshKHn/6jm+9B0VIekFI1Ee1aYmIhbaygqn/dA7DoObfEUKWBQHYWmKDVtqaz/kKEWTPy5gLn63GW2rIqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SgciTSnM; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7bb2fa942daso104524b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnVfufvIYEdI8+hFNgHbkUqJ54wEbcXzUeKinX5SKcw=;
        b=SgciTSnMLWNdtYoA13frUMQy15TNmrrlUCCSfxc2A99pR9MJKfJq3KAFNOmL0h+xh6
         nYgxDvhlhpoC5+ZeeGztXpz41ww4zYXigvnXPvVSyiJ9A9smMxoYRcdPleqiC8dn7Hhz
         19VcudtbzvqDYxeTV56SjSokKMFhRcqswgHDK64AyIDZPIzAZs3NVzL2hueK7W4p9Epr
         A0M+DlQPdrIfw3kC+PH+zBvTb6HyujtE1GgzS1Zi2k6TJ1q1U0dxCxgSU8DS4R/L4cIP
         WHt2dihC47Q2mmxCUp6WOlQt/4ONFltxksTKFMc3zOuxNpBbuTpXfIOFv8k6bdVwhLuk
         nNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnVfufvIYEdI8+hFNgHbkUqJ54wEbcXzUeKinX5SKcw=;
        b=jFPeFBW4zvJPs1OHqf1jCRRYS9pcohLaEm59QBdCioQ5Dsx4FksXTAA8HiYa11I7Bc
         y9cW2xzBI2cWKJTi4YqF8EwfUigWYzVHWNHWxUFZDGEnugT5E1T4bd0kJo2rdfP/uMFi
         ttrIe0aV5N1z9hvqm/GrR0ThWmaFuBfn/dIRmqbxgye/GNsyrvi4rambbvk4oXW0Mvch
         tB4HobvMgwsSlRAQuInYTnpaq3nobj0EhzUYKbVA9THmeHmXaVsI+Ym7oQ96FqpM7U6+
         I62VmSR2Hgs9y84F9uXcLXAcLezA//BLfUxvAeCKRyUH2T7xp2VT1xo6ieWYdlPJKdod
         x18w==
X-Forwarded-Encrypted: i=1; AJvYcCWOijrfOmCWCbJkQvI9GkaJehjlWVgE+9EOLkkTZCMSAxjidA+eZSkx5zErqaVbljhyvLpb4DwqAWYqq/nB58E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCqilS9GylpTjq2E4Mt4+9s4dLL+rHg8vR72Qk7hY+DAB1yLv
	uAAotygDtNmEPJ2FIjsVtUenCAw3e6CVMBHKWptP9PgsOPVhX8u2OSMlAa5jB8fBzTddChLWOdk
	0hCFaFcFJy2FQIZg4PHPDSBTlwX/JSnTijzQVydiebUD/7CoEtaLI
X-Gm-Gg: ASbGnct+yw4FIt7wTqLNN3ofR31m9AUVXujEfB60kFmoumhBHXW5xCb7CTGs2VnRoDC
	defeHN+4TVeD/vdbLpptTROkLUe4e2+vwpn9eZOBRvgcsxpwM6KZgDHMeTbYMwz6X/jQeIkFOLr
	utx+41rFG1PrmWIoSOHmhiYJ5lSqyRXuFHCijWN+3ZtdArds0YjLOj6pTKnPwk0GJxy9/1LMD2K
	mxbU8VWszro5c6kxla95U1m5qBK5TiPqSkBu8XDRKq1axy61CQ/lVne6FugFJ7Tix0jAeTHIFIP
	jTslFWzZ0G9A/m3xe+wR1qcdsN/qwsNVOc9pOUqO4qwKe2zvAQ7B1g7baE4B5Z5c/tDix82bg+M
	vBOvfrnahmGFNQZ/uAI/wWBKxB3E=
X-Google-Smtp-Source: AGHT+IHQphv4vwSDxzX++wJ7dkwR4fY5PmWaSMm5edn3a8fbf06IH7XN7suyTmn9yIsdflhRFlco/RysUZSQ
X-Received: by 2002:a05:7022:ea55:10b0:119:e56b:46b7 with SMTP id a92af1059eb24-11f2e7f076fmr445366c88.1.1765430193256;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e30259bsm208476c88.8.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A5DF83401CC;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A2B4BE41888; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
Date: Wed, 10 Dec 2025 22:16:01 -0700
Message-ID: <20251211051603.1154841-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kublk mock ublk server allows multiple data copy mode arguments to
be passed on the command line (--zero_copy, --get_data, and --auto_zc).
The ublk device will be created with all the requested feature flags,
however kublk will only use one of the modes to interact with request
data (arbitrarily preferring auto_zc over zero_copy over get_data). To
clarify the intent of the test, don't allow multiple data copy modes to
be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
independent feature. Don't require zero_copy for auto_zc_fallback, as
only auto_zc is needed. Fix the test cases passing multiple data copy
mode arguments.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++-------
 .../testing/selftests/ublk/test_generic_09.sh |  2 +-
 .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
 .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
 .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f8fa102a627f..1765c4806523 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
 			break;
 		case 'd':
 			ctx.queue_depth = strtol(optarg, NULL, 10);
 			break;
 		case 'z':
-			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
+			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY;
 			break;
 		case 'r':
 			value = strtol(optarg, NULL, 10);
 			if (value)
 				ctx.flags |= UBLK_F_USER_RECOVERY;
@@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
 			optind += 1;
 			break;
 		}
 	}
 
-	/* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
-	if (ctx.auto_zc_fallback &&
-	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
-		    (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
-		ublk_err("%s: auto_zc_fallback is set but neither "
-				"F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
-					__func__);
+	/* auto_zc_fallback depends on F_AUTO_BUF_REG */
+	if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG)) {
+		ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_REG is disabled\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
+	    !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
+	    !!(ctx.flags & UBLK_F_USER_COPY) +
+	    !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
+		fprintf(stderr, "too many data copy modes specified\n");
 		return -EINVAL;
 	}
 
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
index bb6f77ca5522..145e17b3d2b0 100755
--- a/tools/testing/selftests/ublk/test_generic_09.sh
+++ b/tools/testing/selftests/ublk/test_generic_09.sh
@@ -14,11 +14,11 @@ if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
 _prep_test "null" "basic IO test"
 
-dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
+dev_id=$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
 _check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 3ed4c9b2d8c0..8e9f2786ef9c 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -36,19 +36,19 @@ wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback &
 	wait
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 	wait
 fi
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index c7220723b537..6e165a1f90b4 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -35,11 +35,11 @@ wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback &
 	wait
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 274295061042..09b94c36f2ba 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
 	wait
 done
 
 if _have_feature "ZERO_COPY"; then
 	for reissue in $(seq 0 1); do
-		ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
-		ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
 		wait
 	done
 fi
 
 if _have_feature "AUTO_BUF_REG"; then
 	for reissue in $(seq 0 1); do
-		ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
-		ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
-		ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
+		ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
 		wait
 	done
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-- 
2.45.2


