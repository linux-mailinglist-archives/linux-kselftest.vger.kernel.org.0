Return-Path: <linux-kselftest+bounces-5015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB885B73C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288271C242DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1D5F555;
	Tue, 20 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ignlrRqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093715F552;
	Tue, 20 Feb 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421008; cv=none; b=MUtMRJktlgbfg+JfAc/Zgs3sTErjJO5UktM2C/pFETrjDvxdFAu81jVwDpKX1P6u0x7aTtQg3SzzDvTb2QvvxmJyis2UxKm01AqG7ElWcSnK7z2pXMCw2C82qAq43YHrDfvbbT9SoR4CNk3LXhbmbhjhHd2+2GIaHFtN6fCmFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421008; c=relaxed/simple;
	bh=oE9usEZm8Gkp3CztCxfanlaxoA7z8FsMATKom3DsKN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WXFW3I/7FThjbIU1v7kpi7TgIpxUY9gOpiHMAmquCtB2DST0kcaIL3KV26kzBb3eGicxj1TLjPqO0pyvKLpbdjTvKbVXROlbQ4rGTlBdjZRWB2dJ25q/GB5O3jlsjzzrxFNYFhma8WXFPynALb2r/1W8wTL4oqIgdp5g7U+GM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ignlrRqn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512be87a0f3so1488256e87.3;
        Tue, 20 Feb 2024 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708421005; x=1709025805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvk9b5FrIPa9pQNkAPaUlHUg45CZIFJBTlV1pT4Cxk=;
        b=ignlrRqnShGwgmsxAn2R+6Ycs3urQR0z4JQ3Y6Xad/z72deg1UtRSEfOwJWeZ0Xzgk
         XRa1KEGzvjOjliSmdDkZhNSDEsG00Z1JIOU0sqdGv8cki7XaqpGx2xahLkIrlyjPXuAb
         rJuzKaPcHQSF8UYju5nJb00WgF7/EY9m7CTbRhh3zJJQ94wdhqTehXs1NbeIJGmW5HNf
         pJi26+943EoVT/cbur1/6socf2c6M7CsToJQ4p96QZZo5dGilJRBV0K/pHFu1LkLAPpB
         ONyn2UbbeFagPW6CJoFA5hBVBWb/DZvjnFL02Xi8uHZvq5DPjJgOAw3dO/cuxk7xbzbD
         3jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421005; x=1709025805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLvk9b5FrIPa9pQNkAPaUlHUg45CZIFJBTlV1pT4Cxk=;
        b=C/YwqVzRq2kWor/3jN11jGQwojRp3YTlHVmIx/+Rnz5VJABvW8QlcQuSJFpjAS9SyX
         fc/9H4Ugbun8vY7ob8GBN6Lw5X6FP4vaGjOrSC/E7AIaLJk4CqaKe9XXCeDGo+YIzESQ
         ext6mWBwVUE3iBfy5c9kpaVtJKJNNK1R33t8uMQPFE1qNMtFCbP9ku0bzvq7yy3Iemwp
         7ltULBB82+MsnuU8B8M4e9+gD45V5Hn0JlBPMOYqL6a4axNAzy+K286aR+X3tPkM1sdK
         xpRFWyOK3LFjZTszaL3hUmDxmFk5KbyNZTWAANCIdaxPF32J67B630xcVBOkQBwshc63
         mYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX4dgNUdZH1HJ9hlZiyN0yktpz0xnJmHVgSTsi4qgwJ42lL/BJTElX05XoGM16aF5VL5vuGNgtrZgeCNpJUxBrffKBfP/Ijwito4NAcLlkpDZGSdkPQboAAzEfcqTVAZ7QkD52oK7sBHG/cUZu
X-Gm-Message-State: AOJu0YyS/ZnJPoTuJumKbdiHxFccSwozZwAErWcU2lG0IIwUC0oKIbp0
	aihcR14sCBjSnDmhYu0g7ohugGyFOpWDeXMiMfVCOOaSfbzvZLYmQ/DMO8oq+o8=
X-Google-Smtp-Source: AGHT+IGPiNJIo/RM+pfOcyAeGRF3Prk8bkLGVYcuh9JnZgt+oXGa8pSyuAQqK8HQq04q9jCkAqILvQ==
X-Received: by 2002:a05:6512:23a5:b0:512:ca34:6666 with SMTP id c37-20020a05651223a500b00512ca346666mr612055lfv.0.1708421004952;
        Tue, 20 Feb 2024 01:23:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00412696bd7d9sm4094405wmo.41.2024.02.20.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:23:24 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: sched: Fix spelling mistake "hiearchy" -> "hierarchy"
Date: Tue, 20 Feb 2024 09:23:23 +0000
Message-Id: <20240220092323.2677156-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a printed message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 7ba057154343..62fba7356af2 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -276,7 +276,7 @@ int main(int argc, char *argv[])
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
 
-	printf("\n## Create a thread/process/process group hiearchy\n");
+	printf("\n## Create a thread/process/process group hierarchy\n");
 	create_processes(num_processes, num_threads, procs);
 	need_cleanup = 1;
 	disp_processes(num_processes, procs);
-- 
2.39.2


