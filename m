Return-Path: <linux-kselftest+bounces-16466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7CF9618D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D36C285837
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B510F1D2F6C;
	Tue, 27 Aug 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1hnEZpK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF915B115;
	Tue, 27 Aug 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792198; cv=none; b=RqN6u2jCzgyRe1GnS2k/v0cFbY4DqWQIAdxxYnl0oAx1N5UR4Lt5AEd6hDqSKFK64BG2XrExWc3mnAel4i2DtdE5sPfwSNonNkdQVt3JO7SqMGU4exeKjYLfL0gx4lp36BgH3ECMzq8oghmNJveR2JRZubKoUDprS24F+aMltSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792198; c=relaxed/simple;
	bh=N1s7elCnHNJNSlhr9LOhLRv5lq5GhYPY/MT7R5iq2+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkwRTNWAhz6NyUGEWdmQ4WE7CWsQbJvSibgWIAV9rxtidNEowkTLEas3yVTVKmAl/yMWo96ixBsrlHaN9Jg7jwHxrQGALtSBSFXpfosYDUY4NXbzVW5UzrF7lC4haogFyLF5eibV2fgWS/BHr699pGJ/nif9mq7gdak2zWGlaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1hnEZpK; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-498d0268541so39161137.1;
        Tue, 27 Aug 2024 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792196; x=1725396996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKUjhpWGzAhwCnQJlQGIriMIhdyBFH1jBwreh1yr2J4=;
        b=S1hnEZpKDoKLq2rckz4Oq8uo14FKfKRJDgGvdi4MDT3h8abG5o56BHcgKv4sLf7Bye
         cS2Z4MjL0f7Yj0mTjEcUgVnGObBQDsUjdy/Rm9eZfkmtxyF5tl1uh3lXPrKhxJyMpqUc
         M2obH2RfIWasv5nwhqtrda9NnrXwFR3ATFVoP5rL1fjGdxHQduu4TPXvf0aTopa09TFS
         xerYF309fj+YhPKv4mjKNbOi8zRHiZJcsNyol6j17NKQukfOIwF0xpHmb9d6ld7j5WD5
         /xFprPLVQgx5d0LaCHbgsxZ6UHshxWkzNEVdhTGjG9NOhdnbgSUBTiC+UV8ZwboJe5Uk
         EzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792196; x=1725396996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKUjhpWGzAhwCnQJlQGIriMIhdyBFH1jBwreh1yr2J4=;
        b=urTywrhtadHBhmBSw8eoDFUGvyuc2McMluxP9R9cfWtEGSghJjhNML31aZ6lofRpGc
         95/WlDXzMjNIhAffGAUI8IqTt2BYJgrKFNH5roiS0OC3BJnBhMgwSD/A8bTmsOTuPTUp
         DqTe7oZR2UOkQuULXfGdcBaxNEGFZoypWtR++wVRsLsv7NqAf87FiII0Hv3dlu1TGyb9
         ZtE3mIcmtJrgIY8Vw/DDctRGJraJE1YUvMukiblsLrvGy7opfHZhojPythVnaztx9++8
         rnWwoTHFsDku1r0+YPfqb6CdSKU1XXDZVs4GVjgA4lrYTe49NfYK9LO2ByDQjjKl//1Z
         Dfmg==
X-Forwarded-Encrypted: i=1; AJvYcCWs829vYBUabiU6lKEdxWoRcaVdaK65i/dJP/lxyi8Zmf6yQSquQK80WT0iL0SrHDg2Sr4CgY18bD446w+JEzYX@vger.kernel.org, AJvYcCXZg2EJg+pIt80QHCDJvgsnMZpjRxblhaa2HBkEZ8C9GHKnk03m+EygnRDgEyuG04f9KdMtSqARhgskg/0=@vger.kernel.org, AJvYcCXflE2APBDWBtOU22DWrzI7T28HW8ErlWAXL/6EUU/ZuzW5IoXy2hZGgoBOpw+6xDmq7B4muFXk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34vEjFYJZ+ff6hDQ9CY2hEIteSjqh3SJ0hJk18f+l4tYzuKIi
	xHfRJzwQ/Ow2A0IIrzgwh+E98pv1BYm3WOGil3aTzUdwRKuMG4yu
X-Google-Smtp-Source: AGHT+IECGLxcEgHHRyB9IE+pXGVPfrf7rt7RmtoKeBWWbbGeoJYWd2y73w0+zXrRyGDxr6+dHOqBAQ==
X-Received: by 2002:a05:6102:441f:b0:498:f38a:2c5a with SMTP id ada2fe7eead31-49a4e34da42mr13631137.2.1724792195871;
        Tue, 27 Aug 2024 13:56:35 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e4799fe8sm1639715137.6.2024.08.27.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:56:35 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: [PATCH 1/1 V3] selftests: net: improve missing modules error message
Date: Tue, 27 Aug 2024 16:56:29 -0400
Message-ID: <20240827205629.51004-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826085010.27ff4377@kernel.org>
References: <20240826085010.27ff4377@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message describing the required modules is inaccurate.
Currently, only  "SKIP: Need act_mirred module" is printed when any of
the modules are missing. As a result, users might only include that
module; however, three modules are required.

Fix the error message to show any/all modules needed for the script file
to properly execute.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---

V1 --> V2
	- included subject prefixes 
	- split the patch into two separate patches (one for each issue)
	- fixed typos in message body
	- removed second, unnecessary for loop
V2 --> V3
	- fixed subject prefix (omit capitilization)
	- fixed spelling mistake in commit message
	- fixed coding style based on recommendations
---
 .../selftests/net/test_ingress_egress_chaining.sh    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
index 08adff6bb3b6..007a5d04c3e1 100644
--- a/tools/testing/selftests/net/test_ingress_egress_chaining.sh
+++ b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
@@ -13,10 +13,20 @@ if [ "$(id -u)" -ne 0 ];then
 fi
 
 needed_mods="act_mirred cls_flower sch_ingress"
+mods_missing=""
+numb_mods_needed=0
+
 for mod in $needed_mods; do
-	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
+	modinfo $mod &>/dev/null && continue
+	mods_missing="$mods_missing$mod "
+	numb_mods_needed=$(expr $numb_mods_needed + 1)
 done
 
+if [ $numb_mods_needed -gt 0 ]; then
+	echo "SKIP: $numb_mods_needed modules needed: $mods_missing"
+	exit $ksft_skip
+fi
+
 ns="ns$((RANDOM%899+100))"
 veth1="veth1$((RANDOM%899+100))"
 veth2="veth2$((RANDOM%899+100))"
-- 
2.43.0


