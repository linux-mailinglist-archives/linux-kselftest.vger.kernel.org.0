Return-Path: <linux-kselftest+bounces-17338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365296E621
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 01:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BD2286D10
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E01B4C54;
	Thu,  5 Sep 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbQnRdVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8E5381B;
	Thu,  5 Sep 2024 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578221; cv=none; b=jkeJzWaV704fNhwLZruJ0dBtjROLyAABBJL3GPQBRCeDahd5SU/5zp1nk4GCgjRnNr7jr1QRO+NW+kzh1XVzE7af5PVSUeiEIWOZlI8qj8F7JyGnSgf/wvOozYxQ5DpbUvNht4d5NvH9DwH6du67lmUBprFput+7vMmtaE/lf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578221; c=relaxed/simple;
	bh=d8AhDdoglvtooKQv+WxQt6tXKFyK2xLVDySG8cEQWCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6FyZfbRE2w9RNG5uhQMct076kazvcNztHrjWeYk8KB3pAGMStdZm2/Vb+1dnzLm8DYJmi5SA47YPE6PWySUc9MMK61PVmEuEchrNGs+9DkRGBNuFhx9cefPbKu/FxOhc7d+qYCrpkoqmwBmJz+XRp4104u9JREpY+gHP+30GNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbQnRdVb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-457d63d35d3so8523241cf.3;
        Thu, 05 Sep 2024 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725578218; x=1726183018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4yLmSdW1x7Wh/eU1K+nbRedbO4GPtqk0jcElDx/XVc=;
        b=gbQnRdVbYKSC/wMmjpHgBcXHW0nne95b3LlAS13oeHGUNjM0DtC566ckaMzql+aA23
         Ou2dowiHeZeR9W+etHY3mzUdQDEY8yLErjj2V6tBLgW675/cCs83fVWKGUBH+k+Njtz9
         vI9rUD9le6qtTxvrzrvr8VzY6GI9MIEwtg7XwtmSl0Yi1xzmXDIFNKshXQMV3V6VhY+F
         PdLhi0UV+3G4mnLR8Wn8CAQ+Ji3jKiawyKqby1ePJaD9BcU7ZXU9gvMCIrXGnmK56lC3
         ENw3WIj0hC29jlHHV+65Hux2IlEkuE+rer6N7sdzEvRMRntBnRVUlmJhovBnvjsS8Pu1
         B9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725578218; x=1726183018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4yLmSdW1x7Wh/eU1K+nbRedbO4GPtqk0jcElDx/XVc=;
        b=if7b8FbGjlVFcsz1LMMZ0CyNrU9FTjO96dP+H6lBsWlAea1TeCrapTq+8a+Kc+Tw/j
         JRgwGuM44ickfzo+9xHR/+uywf9wuobgjA+Rd6oS5vjyYOdJBvMF52V9Ngl89CArDaE4
         yuo5vkwp5liRLk6vIM3pW3XQC3li8VkeM5kldmTW7f5FdXmr5mByBLdtklac5gJIfN1B
         G0sfNhp76RaECtOunqzW1mL+2jOR4u7v4dB2qWPIqTEWEhmXkPt9025KlI/P5cBNvC1L
         TYVXma8VW0+wkvclrKQH4H6gUwE9fU5T8FNZ+lc6oLyYprgljA+TNcvO1etmpYX0/f1m
         T4eg==
X-Forwarded-Encrypted: i=1; AJvYcCUT9p2hv30ixKcfK9sUtwG3es/kjenw8LdEbOsMINSD8PAR6k4qTahOo+FjTSaEr5Vgd+cetgiAeaq0nASiHEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL+MOeT/yXseir49OvcTEHamf1xiJ0DNCw0eeU4PMGtIrF5Jf
	6CkCJOk0RSkqdHlRLElJgdCvgNFZu+hamW+IEYnXB8yrPF+UjI+3bLE8ow==
X-Google-Smtp-Source: AGHT+IHziqAh8heS/wHTU28vyMDUVYh5E8tDzxvxMUqYux9wFI/frbftw27sHISAKpuLQ3/bihuK7Q==
X-Received: by 2002:a05:6214:438a:b0:6bf:6375:397f with SMTP id 6a1803df08f44-6c528506a0bmr11207236d6.25.1725578218262;
        Thu, 05 Sep 2024 16:16:58 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52041877esm11909666d6.123.2024.09.05.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 16:16:57 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/2] selftests: support interpreted scripts with ksft_runner.sh
Date: Thu,  5 Sep 2024 19:15:51 -0400
Message-ID: <20240905231653.2427327-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Support testcases that are themselves not executable, but need an
interpreter to run them.

If a test file is not executable, but an executable file
ksft_runner.sh exists in the TARGET dir, kselftest will run

    ./ksft_runner.sh ./$BASENAME_TEST

Packetdrill may add hundreds of packetdrill scripts for testing. These
scripts must be passed to the packetdrill process.

Have kselftest run each test directly, as it already solves common
runner requirements like parallel execution and isolation (netns).
A previous RFC added a wrapper in between, which would have to
reimplement such functionality.

Link: https://lore.kernel.org/netdev/66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch/T/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/kselftest/runner.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 74954f6a8f94b..2c3c58e65a419 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -111,8 +111,11 @@ run_one()
 			stdbuf="/usr/bin/stdbuf --output=L "
 		fi
 		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
-		cmd="$stdbuf ./$BASENAME_TEST $kselftest_cmd_args"
-		if [ ! -x "$TEST" ]; then
+		if [ -x "$TEST" ]; then
+			cmd="$stdbuf ./$BASENAME_TEST $kselftest_cmd_args"
+		elif [ -x "./ksft_runner.sh" ]; then
+			cmd="$stdbuf ./ksft_runner.sh ./$BASENAME_TEST"
+		else
 			echo "# Warning: file $TEST is not executable"
 
 			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
-- 
2.46.0.469.g59c65b2a67-goog


