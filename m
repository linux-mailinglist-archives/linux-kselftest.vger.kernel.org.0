Return-Path: <linux-kselftest+bounces-45040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27690C3E080
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D903188E4C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C82F746A;
	Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqJyFPpc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D6C2F1FED
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476600; cv=none; b=MD+h1Pig9z0/3MaGjofc+QOvqCoaFulDyMgr/JwquF5zGys9CmlOGANd9Q+bZDCwGbUhBu055CsgTPHQv1MvoKP4nlzom/yHSqKazUaABu9xNBUP5uu8fo0C1hFvOVYy8yM5TLDO1vFxm15h/26IN2UYZQ74bwh7sZuh4ND4j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476600; c=relaxed/simple;
	bh=NjhEgtu5medwkPvG2Enm9tK5HgLlZ3KE8dn38aGAOtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1G3AZcWBfzFYEN3sHGvJyhzcCiv0xA8FTAM/ZTwNhQ/mB4GK1TT757hWIeNJMxNvNWMVfXJ9rgzloELCwo8b1kUq28YdpEnqc/nwNnQ4jMg9FyXOo2GTq48DtNgPXizgMLa9e8wmPiCnYrQAxphzmGf2GGkxU4p33WrIDflBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqJyFPpc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so166215b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476597; x=1763081397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=AqJyFPpciT/XLz8cnmY9iVvQF+xWs1lXU4cw5fA26gNRVpFdfzYOC2wmBDX3ja6Lj0
         HUhHkZ9Tnn9R4kFrARXJGdqLMM3jC9a6iKvub0+vejhA7e0nd93dAqXjvY292BF/DGhb
         U+jNYQ7tS/wN6ZTcw/ELQLJVZV8b169Juifisa/jflY88RFwY4R48FBFd1UcGC4f30wk
         k9XszumA63tne7hLyrImUp8p5g/Jy+xi+P2j9/OYS/b8LMBrFz6G3Y90pDDrRbHIXYKx
         esIbELi671CdkhCbkNg8YNc7ipg4Q1tLW0jFKbTpJHW2RFVe0ZCvMfxpJAjcIq2yM6r2
         x6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476597; x=1763081397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cB0jrnxyKvtVXOL0SkOCiQy/hsJ1kDvUYjzNG1+oTMw=;
        b=OtxEK91c+E7AEOvi2geuCeCOxoWU2sytiJH286OjY/efULFrlf4O0Cq3FBBq5lB0U2
         /AaPAIMIDoIGie/5TS/82WkAtBiwxbT8MEdtAhWkBJf4QPsDfTHoVBuf5zGteJPp+Cm1
         h/6SKxvwtEcx2cJ0+BqUFgGMvNk+yY1eJaAG03Cb9Y28LafVzg0QpEdkNYQTgqR5nvHb
         y8/bQTGitsyc86F9tnRyrsUAo9rKoTWW3EMmb/sjNX2GNqsEJAiNARnSBVubGWjwCLPv
         MpmK++tPEVsacSK38SBLT6pdDBCEMe21Rtg/sz9f9l7VLG0LGayCNipbta65IfOyVQvL
         W9CA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfe4QA/77XYE+jRkCcpO2iBeVIIUWstPQGpEYA/iUzXYJ3x59Dt+iDA+2Vi6VhR3ns9uOYAsc1dbSrUIAc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiOvZLBGn8/8+nmEbYStWsqkkZU+LUKEfaOUM3c9Ilsn0K4KF
	12g5Ksn1Gp+HgjUxEyvaKQmqEES6NqSiEu2+durHfto1522Bd1iQuwKJ8EY5xA==
X-Gm-Gg: ASbGnctCF1PuZ2EqIGBtnT6kw345gcKABZlfOtCLHTdZLlR0PODkSt3CgygsAhFSFvZ
	Kqx83U9mMqZI0M0JmeNBpbqQ7Rv/L4KQMIRWHNFRd18yMtO6H4xTp5eEcwwHWezi3aVT/a74nNN
	7zzmmwl3frIbFU8F8ZmcVa0WYNMMOgCgNXOyWmmJrlThTBCPB+iDsjaWefKj2BYeJnPZUCGphgn
	yMr8ppfTFayLAg/fqL5CdAlptHuFzhOluDnbvupa7Z41SGgPf+P9+ClIReDX1f+tfUnGqDXiqKA
	fEwANaHlM419Ch4C/orhfNPo1Gu0PLW31zZSNrDa78VAM7o0C4l+hLMCiQc+ulRrPIYQ1Rbj5Ft
	4rkz1XnC9ND2SNbaR1VpqybXZCcW6QKxaSXmUN6227YJIval6B9c0/+svFcm+5nPbqgyPTOVs
X-Google-Smtp-Source: AGHT+IHEjR+tD3f5onmBvKNAdZ43ttTdSjninDQiFysSI8E3D14rKPjUX1v0eti1pW9Okz7YIsxP6w==
X-Received: by 2002:a05:6a20:e291:b0:33e:6d4b:609a with SMTP id adf61e73a8af0-3522806bf44mr1924302637.6.1762476597267;
        Thu, 06 Nov 2025 16:49:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm875993b3a.2.2025.11.06.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:50 -0800
Subject: [PATCH net-next v3 06/11] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-6-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ede74add070a..557f9a99a306 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -a PIDFILES
 
@@ -246,7 +246,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


