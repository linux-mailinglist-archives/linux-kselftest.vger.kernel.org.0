Return-Path: <linux-kselftest+bounces-17195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF496CD18
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E068D1F29993
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E8145B10;
	Thu,  5 Sep 2024 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcfQgR0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF222E62B;
	Thu,  5 Sep 2024 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505961; cv=none; b=UheWexuiqyYNd1iZU+yCN1S9WBn/ZVE/+ihUcKh4qpCtAlpr5IVpkOB1NrA2x4iMuAXF6/MJduiXoXObCnboWPhSTBZTqV3NlvLKeSl2wcKiEr+u5GKuxsjfp68gVNFK+aLLJcJhKk4up0LSrXP0owQ3SyoBVOGNPw3bJtftyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505961; c=relaxed/simple;
	bh=d8AhDdoglvtooKQv+WxQt6tXKFyK2xLVDySG8cEQWCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHY87y0ft0fMIckEkMcIoa1D8RIIu3GQF/voj4KXzpLcFZ1jb1JyW09IIQiEh6Rp8rR45jAAk4KPqrc/zFUn4+bwVkdYCu5/yW1eeCtFyEz1BK4N9l4BsCMqv71Kmax99FoHwF2RRZZU/aihfFicOZ6XcG8osUT3UrY8umC6A0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcfQgR0U; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-456855afe0fso1589621cf.3;
        Wed, 04 Sep 2024 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725505958; x=1726110758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4yLmSdW1x7Wh/eU1K+nbRedbO4GPtqk0jcElDx/XVc=;
        b=gcfQgR0UcRWgxLwYnAqX0YoU6ksmLiE2k/SSiQKvfLytDVVGyS6XQQISsQr4UZsr+Q
         sJIMbyhU5HF4vbtdV/QkqxCKVijgCOvrL1vtB6jKOJYI37uJF5mACs0MDWN4gB7aAP2H
         cR7bd473enrdaZ1Jo/pgBKrOjovkNx3dffH7oCYbCVE812QyM/JTinN4dpyDePG1ys/6
         kRqji8ASU0IrlmmYdQv4KsdDBdw4Iza7DEYlT9q7lvwybC3UnGnewgJxlPlrMV07/6KT
         j4gOBqzhP9MGDru06p3tYVI7Q2T9kmyq2vYZVIKbFlusgcbiMPnqwM+Azke3YSW2QAun
         GE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505958; x=1726110758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4yLmSdW1x7Wh/eU1K+nbRedbO4GPtqk0jcElDx/XVc=;
        b=Ot1bRKyzU1IX0qT0WkwNGyOnC+K6NrxUYme3cJT0xcRPpuxgh2oRCSUbDEwKY3tasw
         HSIPX7GEyrNBnPqx5lVTIYkE25S0NnTrdNUD9vf1vWKke5haHXUnX4Mz1WPuSoEjbJsY
         CCuncbPef5uOir+vtx9LBLVfo9Y/n2DzIf1cEYeCELnoVy0lOZ4HxV8bXu98UKY4+Kcj
         HoUPnZ+HgU87H6l93THQWHy/ie2uoyUo0c+lrTzyC/ixTVtXarTkkrjbYpg4bs00duvC
         53nlRsVZuDNj9DScd9HZNc0rGnSdEDtuRp80hWxOHZpwOOyHFoKOu+h9BNLNDaMzPtmb
         vVmA==
X-Forwarded-Encrypted: i=1; AJvYcCXDoQnqwFbPV06sVQQV3Tad1mljFUJYrhkE5JsVmLO6N/ZLML7nBnt8sdqWMIckNh4vgzHZOHbElGEEPIzWPDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnkSzeeKfpiRsWQvt3ROIPqTSiHlxmMOTousenhtyB+IdtWR3
	G9fgkLad4k7JQV/3YsCRnfL8Tc+mXTd68h+d5G70KD7ETaGHBsJvv0i1yA==
X-Google-Smtp-Source: AGHT+IHAH73LKizmkuvJqRtgG+tG5N5ez7QifCdaqkHv2x+zT6oGCWFBRTxgKvneVpHT7GFDIn3ucQ==
X-Received: by 2002:ac8:7f84:0:b0:457:e16a:b065 with SMTP id d75a77b69052e-457e16ab29cmr107252061cf.19.1725505958178;
        Wed, 04 Sep 2024 20:12:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a153f0sm3819611cf.12.2024.09.04.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:12:37 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] selftests: support interpreted scripts with ksft_runner.sh
Date: Wed,  4 Sep 2024 23:07:02 -0400
Message-ID: <20240905031233.1528830-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
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


