Return-Path: <linux-kselftest+bounces-43348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0FBE50DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080114E63CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323D226541;
	Thu, 16 Oct 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luiJWRno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C82236F2
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639150; cv=none; b=WGNbg4I8FUgQWyKGRnrwx2aK4Lzz9rgnZhIMZlBrDho1n3IJk/B20Dv37w9M2seQMzv/StsF+9RjihsWBTMd0Qk8u244xCtF0SaS32Kre2A8IB3geXojUqB0XpHbl/IzKWwJyakm1XEYW0+qiI19jIhIphOrbPo9mlI+5fXrilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639150; c=relaxed/simple;
	bh=V4rgg45EQlkMjgrqSVdh1uwAFbU6ZcVY09d4AEkeWxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZxSgy4t0axFmtgz4f6MghitxL15PYrI5oRrcH1oxgGbOrUDOpA/CsVNykpWgK04IO1VHI/rkt/DcobO/6p61RWN+HnmZxKlIPCM8pm+TCQwtrE9xbDU3fk2HHqIOBzHqtMgtOZdiP7ii3oADvEP9VDTViYbgjvZSkWrASiHFAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luiJWRno; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3c97be590afso265413fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760639148; x=1761243948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTNTzsh8UwWq3gKAxJaQnoz8QnNDSoRjLqAKLOKrSJ4=;
        b=luiJWRnojfdkXN9/tOmB/7ICmBEvj80lfsx5SgR4yUOi/MUC37R0wx/oLmd4upAnYu
         ap8ouk1tsR6DnIBnqGGV2S5/2LQH3Dc/4NyPIjdlA5YL6Fr6/u2lfJiJJjkvIM1gvJKs
         yt/DMbY31QiMhwoc0nDY1J7pqS3jaKt3F0BQ6dsox3R8xMkiWPu1cUZ25Jn5jPkkbLkp
         oxGpIMbRog0A/VntLugJKHtfeuGD98oVdoHp8CVrF4iDC3dE82UNy/t+YYJBonMIKd6e
         bX7T17oI7T8q9ARTCLQ8bgDF1cROyiwcbedtpI2dNjj4y2zaaPlMbp4qajB6tVFMyWBV
         wacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639148; x=1761243948;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTNTzsh8UwWq3gKAxJaQnoz8QnNDSoRjLqAKLOKrSJ4=;
        b=c7qH4M5vhHmoWkQF1DUwaoNi+Aow7XKH8CLdGC0nCsHfu7mg2x+aPjksSvxSwNmuYn
         lr6iDbg5CCc6FjNPNGX/4+O7fcA6bQCe6nhb7pRStzWpmMXY8mem89f38hfpgdPAbNWn
         YdyT+wEF3dRtr7Gf6vc8SlxwSf2Gy5Dvf/kpI9iZa0KCmNBM/5nZIgh/ofQZYHhoDFSp
         xxSuYG+h+qsBYsq77/2TfHmV058Heh1Vmgz697vSJexdGTUeDyc4FgjEBsaCmY7Qpvio
         fydXx2mMSGzHtHsGkYX9/E/qlo4oziO7b/cz0O96rSP3Gom6TyA9gOGkC8rbcLgqe1mW
         DLFw==
X-Forwarded-Encrypted: i=1; AJvYcCWMn9yJPO0ePOe6J/9YTac4JXyKjDs286yK8EHvRaiIkrrq0+MbHEgiLqE6ZljW7Einq1rUvyrcfMjbjOBsbTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxlMYBCNqiZvlGG35bwTLWH1rGO+vDSmXBHqt2PvcafvbugG9
	Jf/gSI06TgXeNTDgdmI0G39Xr1SRF99JvRbVc+7r0XWSp341x3mcycpgvlEL0y+nIuPf0nzDRHY
	MWLuGAsywBA86pw==
X-Google-Smtp-Source: AGHT+IHORlKSlHZvzvt6CVNdFwUEZuO8mJlT1v1ETTjTT7HeBTJCEZWGKHssgZ7VVxf9i8WZAnDYnurNq1qOOg==
X-Received: from oane15.prod.google.com ([2002:a05:6870:506f:b0:3c9:810c:2ba])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:64a5:b0:375:db59:20e4 with SMTP id 586e51a60fabf-3c98cf4364cmr380239fac.13.1760639147713;
 Thu, 16 Oct 2025 11:25:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:25:37 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251016182538.3790567-1-cmllamas@google.com>
Subject: [PATCH net-next] selftests/net: io_uring: fix unknown errnum values
From: Carlos Llamas <cmllamas@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, Carlos Llamas <cmllamas@google.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The io_uring functions return negative error values, but error() expects
these to be positive to properly match them to an errno string. Fix this
to make sure the correct error descriptions are displayed upon failure.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 .../selftests/net/io_uring_zerocopy_tx.c      | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/io_uring_zerocopy_tx.c b/tools/testing/selftests/net/io_uring_zerocopy_tx.c
index 76e604e4810e..7bfeeb133705 100644
--- a/tools/testing/selftests/net/io_uring_zerocopy_tx.c
+++ b/tools/testing/selftests/net/io_uring_zerocopy_tx.c
@@ -106,14 +106,14 @@ static void do_tx(int domain, int type, int protocol)
 
 	ret = io_uring_queue_init(512, &ring, 0);
 	if (ret)
-		error(1, ret, "io_uring: queue init");
+		error(1, -ret, "io_uring: queue init");
 
 	iov.iov_base = payload;
 	iov.iov_len = cfg_payload_len;
 
 	ret = io_uring_register_buffers(&ring, &iov, 1);
 	if (ret)
-		error(1, ret, "io_uring: buffer registration");
+		error(1, -ret, "io_uring: buffer registration");
 
 	tstop = gettimeofday_ms() + cfg_runtime_ms;
 	do {
@@ -149,24 +149,24 @@ static void do_tx(int domain, int type, int protocol)
 
 		ret = io_uring_submit(&ring);
 		if (ret != cfg_nr_reqs)
-			error(1, ret, "submit");
+			error(1, -ret, "submit");
 
 		if (cfg_cork)
 			do_setsockopt(fd, IPPROTO_UDP, UDP_CORK, 0);
 		for (i = 0; i < cfg_nr_reqs; i++) {
 			ret = io_uring_wait_cqe(&ring, &cqe);
 			if (ret)
-				error(1, ret, "wait cqe");
+				error(1, -ret, "wait cqe");
 
 			if (cqe->user_data != NONZC_TAG &&
 			    cqe->user_data != ZC_TAG)
-				error(1, -EINVAL, "invalid cqe->user_data");
+				error(1, EINVAL, "invalid cqe->user_data");
 
 			if (cqe->flags & IORING_CQE_F_NOTIF) {
 				if (cqe->flags & IORING_CQE_F_MORE)
-					error(1, -EINVAL, "invalid notif flags");
+					error(1, EINVAL, "invalid notif flags");
 				if (compl_cqes <= 0)
-					error(1, -EINVAL, "notification mismatch");
+					error(1, EINVAL, "notification mismatch");
 				compl_cqes--;
 				i--;
 				io_uring_cqe_seen(&ring);
@@ -174,14 +174,14 @@ static void do_tx(int domain, int type, int protocol)
 			}
 			if (cqe->flags & IORING_CQE_F_MORE) {
 				if (cqe->user_data != ZC_TAG)
-					error(1, cqe->res, "unexpected F_MORE");
+					error(1, -cqe->res, "unexpected F_MORE");
 				compl_cqes++;
 			}
 			if (cqe->res >= 0) {
 				packets++;
 				bytes += cqe->res;
 			} else if (cqe->res != -EAGAIN) {
-				error(1, cqe->res, "send failed");
+				error(1, -cqe->res, "send failed");
 			}
 			io_uring_cqe_seen(&ring);
 		}
@@ -190,11 +190,11 @@ static void do_tx(int domain, int type, int protocol)
 	while (compl_cqes) {
 		ret = io_uring_wait_cqe(&ring, &cqe);
 		if (ret)
-			error(1, ret, "wait cqe");
+			error(1, -ret, "wait cqe");
 		if (cqe->flags & IORING_CQE_F_MORE)
-			error(1, -EINVAL, "invalid notif flags");
+			error(1, EINVAL, "invalid notif flags");
 		if (!(cqe->flags & IORING_CQE_F_NOTIF))
-			error(1, -EINVAL, "missing notif flag");
+			error(1, EINVAL, "missing notif flag");
 
 		io_uring_cqe_seen(&ring);
 		compl_cqes--;
-- 
2.51.0.869.ge66316f041-goog


