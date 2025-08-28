Return-Path: <linux-kselftest+bounces-40173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125DB39E61
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A411F5E3FF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A477311C17;
	Thu, 28 Aug 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O3YYsHa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D5311977
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386780; cv=none; b=CsHTO+iuXUw39f4OdLRnNiXtRFptjUeH8QvWibfXHnOSVsnVDV7dg/Hnxl2w/RynW0GOIcwByBFry1RZw6tF3uUKuctzOi7m0Pd/tlvAt2ebI79O/Nuz3eTh7rQ3uS+fw1WWNOBu+KcvlUmMm2Wbgof44i/Xb2OpKIzr2ZbUgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386780; c=relaxed/simple;
	bh=2N4zkmyqye7LBYfPkMsXA3H1zZ5ZsRLH5P7of8pw368=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J9EQdKCa3SKE4h58udnlrQ+oComRy117SaL2HmR0BUkxBP65QIHIHNBcBB4H0EYPaY9bckk/EGRKQs/JQ8wsKRvP+RVBg5bwI0KN17HScRE1W7lXOWtLzGoQX1TDkgVV6LHGuaJ1yNk7ke5/iZwBCVESehyIzH89F4MUyjD3iEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O3YYsHa7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so473822f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386777; x=1756991577; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaoHRMJOmlPZvNuw5zJXIt9WwLQFwql6jfGw43WqudQ=;
        b=O3YYsHa79TXCQ/PwN87lMgs4aqHy7lJApJ1wk5VrqPLp8s0M+k8sLQtqzKmDmBSSR3
         p1dnMApgno9C3s2L3H9A5QsrCAJIBVoK0RM1AwdsABqD0bZWQ/1oE18JG/Kfxar8gCfZ
         fQY/fPwEFb/aADZ5Nv2n4VeTIuJZDFI7/xsjsCV5AssZPKF8DjRUde5RUXARmDuaflj0
         1oHJv67PKcIe13uabc89oaeGddN4TumInfmwtSIYHf7OEtpLW6qVY+esKX86+vsYd1sY
         JTvYd0/Z0KA5lVejsPYEi+LLxywETZcD5fY8Ga70aA9hAGVzH7jcW0mnuMJv66q3rKyP
         B/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386777; x=1756991577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaoHRMJOmlPZvNuw5zJXIt9WwLQFwql6jfGw43WqudQ=;
        b=ExXlUx4oYLiLzf98DXU32e6gFJKIvnl+bdy3MD29Fc5b33B+FiuzoUtsJ5NoKjMP1D
         XBF5UAMqq9LeHidOoBpEk5InilHoLOsn/OSJugpz3D7zQBq4Mxi4qQX84yUgvnET/ZpD
         7191D0W6WJy2waNAKvg/kZpvgq+hEguG6b1LoucUPKPUL74OPbwFrgSAd6UigNPsHydS
         gYZNRTdjTz6JE0mf+oMeERw1yihcdElNfuBDogA2/tmZhUXbx7PIhGjvhsSJUzHjEphB
         2iOBxv/LcgfmvFdbl3+QNDZ6kwvZOeOKBqyhAoRvyQpcko1hMwKFqatX/eO1uLDcjT0Z
         lHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUTN8s6OTCbzS9XOIxfBizSmPjIvPV2OJey5DhWypbah27Ut7W2LaarEDQJQewukjjF+WWzCGo3TtvlfJOVbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4on9AODiew6SCjQtYmn4jLvf6bjNADqldAL+tM4M1w1Vt3oX
	CqZWcW8cl7wLHlagyQ+HZhO0FEW1tT16Gfe3wAhWe/4gGscdIo6MU5HOSV9pC/fAiPQ=
X-Gm-Gg: ASbGncuExyVHqTzx24zM2hBpjicgdLv7GsCYRQhbgg3z/ZSm/rQz/FBHLyWKC2qo2iw
	IrEjnw+PjvBDHoQlJpNNaox4C6WNidXVfPNEeDiBtgO1mxvIIcUaw3agorQLbhrhq3ZSzk16yiO
	Uyrp8tnPnOgUtsweMtrRvWO9Do68Ht/ogzH2jcqCXMRf4SQZf4wa2MFzzjaM75833o45GRfD3WV
	panIoy7Xh6kAtIET/icordFw58y7eJKfQfEbRopZ1uWDG+2UqB7X1FklhU0jZcJnZgjmh2QNIoa
	gqCRxX4gDM84fUKYYqRmXrjrIUupESvz/sq1zZN1eRmL4nnnUbUqeV3bGl7d2NIbrswcBIjL14N
	YlnsoU9d7rg==
X-Google-Smtp-Source: AGHT+IHKcbqOWajx9cMRL5ztLf39tQDGmF7C1CKrMSZTAerPaPmDVS3PcCg6lRUmSNT4kED+aAopEA==
X-Received: by 2002:a05:6000:2511:b0:3cd:7200:e021 with SMTP id ffacd0b85a97d-3cd7200e18amr3609135f8f.59.1756386777169;
        Thu, 28 Aug 2025 06:12:57 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ca6240b4ecsm14435609f8f.43.2025.08.28.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:12:56 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 28 Aug 2025 10:12:33 -0300
Subject: [PATCH] selftests/bpf: Fix bpf_prog_detach2 usage in
 test_lirc_mode2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250828-selftests-bpf-v1-1-c7811cd8b98c@suse.com>
X-B4-Tracking: v=1; b=H4sIAMBVsGgC/x2MQQqDMBAAvyJ77lIb1Np+RXpI1k1dKFF2QxHEv
 xu9zRxmNjBWYYN3tYHyX0zmVORxq4Amn76MMhYHV7u27l2Pxr+Y2bJhWCI2LVF8UcfPsYHSLMp
 R1us3fIoHb4xBfaLpvJxJ4jXf46wXwL4f/+eAXIMAAAA=
X-Change-ID: 20250828-selftests-bpf-45ccf9c6e7d4
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=rbm@suse.com;
 h=from:subject:message-id; bh=2N4zkmyqye7LBYfPkMsXA3H1zZ5ZsRLH5P7of8pw368=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosFXU9biVjxEUfGoANyy3ge+FD+emJsoaxcbZR
 znAS3JTHhyJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLBV1BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZKGhAAi96BIN+czst4Ja7UBJVoY1FeQxgaqsf
 jQGL3+2DaedYNE8rCru8aWRwpjLBf6yk4Be/wSDmUKjAAecQLTgcw9n/NPALgVGkcNToQxeUXt6
 BTbRHWnaLNydPf077SqNAesxQaOiPZjBUpxDf1KB0nN8Whwmw8I+SULoLkwgO2/wVyd7SSB+G2P
 Iwt7U4aBjGyD8MS+64pP6qaK2DSHTliLOibivmNcT01mTjDnCMbt2cOV6suqEicz/QGBpA5LEZc
 ccyoHvIkqhfFW15m7fmWsbe7/4W+reNQ4mU5VCO6W329xkB6pnNNBvXUxl/uOwJxgTivT6LWc93
 JSqpF0gqAbHOdRQQNE/n8gEv5OBKPwqJMWB2bKzcciaqi5NrpsfSLmG3v4Ru4/IhGKBzRkl+ZsE
 CXPHHGyHpaHRIxl3U+Ym1MALfDC4/k40kX1VtSelbtqGBFErVqU4YNI6g7VAR16aBzjrM5Y9gzI
 rNhs3su/eFvZILXqMz3DYVglfHiDy8vYS20PdLz+cAFZ2zmXzASLs4rNGALPDL3EzORPL/TpEXU
 YUqIDBO1LFIUz0/hq7032MxFDWXDUWVd8FDG82s2FNwaHGxlGoM0IAjXbtHpBnTGqRtBHlNwTSD
 EGsPq6WBWqPk0McH2jEm3Qnp2V54uh4+hZlFuGYVeqcJaJfQMDEM=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Commit e9fc3ce99b34 ("libbpf: Streamline error reporting for high-level
APIs") redefined the way that bpf_prog_detach2() returns. Therefore, adapt
the usage in test_lirc_mode2_user.c.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_lirc_mode2_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
index 4694422aa76c36faa4afa8832e56040547dc7547..88e4aeab21b7bc37665d6fd3959006c5a83a81c9 100644
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 
 	/* Let's try detach it before it was ever attached */
 	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
-	if (ret != -1 || errno != ENOENT) {
+	if (ret != -ENOENT) {
 		printf("bpf_prog_detach2 not attached should fail: %m\n");
 		return 1;
 	}

---
base-commit: 5b6d6fe1ca7b712c74f78426bb23c465fd34b322
change-id: 20250828-selftests-bpf-45ccf9c6e7d4

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


