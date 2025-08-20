Return-Path: <linux-kselftest+bounces-39366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB98B2D8F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A45EB615E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B998D2E2F15;
	Wed, 20 Aug 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1aMRGgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FB2E040D;
	Wed, 20 Aug 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682856; cv=none; b=SxA0lwWC0uxFpFJpfnaZLyd7/urjOx6lrNO7x92u/5YdBIxdfxNVBWzKXWmfDXvVxunh0of1RuzfAiCoGVd9GL+ZMuXQNREsVjZU4BJwyjfynYZoBcKRkQOZFS8qLMquwuIXux9/yHqe+VFL3fN9joUiJgJNNEqaiUcwodhbMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682856; c=relaxed/simple;
	bh=xMPa+8Qn4mu18QhDnLh2TBRIN1AH7lNj6illVJiSw0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U93iUv0UGa0HhQ38+AskA5drKccky/JMpIfRgpN1qemUvYLACNHacq1h9AYGHER8IEs88MUNRVJmfB2B7a0S6S/D2hBkNEUECZ+SW8Ew3/BQ0+uww8sA/JN/jrPvSoMr/oDjii2Nv3xvQbx6K44s3C+YJyLAzDJjXC45iRwcG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1aMRGgh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61aa702c9ebso70206a12.3;
        Wed, 20 Aug 2025 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755682853; x=1756287653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaU4VZUJUriIOWDjZuxPqvHN376Nc6Yxil/qOWrIx5I=;
        b=h1aMRGghhe9veuWnsV7JYp6jPhZuwXlAYgMIB0mTzu8FxZufCVmauOH6bNY8L/5ATp
         n8gqaRvj4DYU7vgHaMqS5/wo3msVe6SUvEacJm+44QMedS/TkNR0CCh6o66L863FCoAv
         OgCe4/+U9/BU6Mnre/ZRyv3JrPKYYR4Fj0ybqhgOdMNRx5RYifhG5+zDh3W1hNJlZCmO
         +fMJaFZhD5J/KYjdtR5CJ9CEBAk7DFr5RKY810M4jY288nI97Y6mPxSlcLRdgbZ4ltPX
         HpItiWNgdl/rXpvVfTmxOOXH1QtID58sQx+4AKf0CXBTSDopHiF2PaIKPWMYZJRr66b4
         gmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682853; x=1756287653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaU4VZUJUriIOWDjZuxPqvHN376Nc6Yxil/qOWrIx5I=;
        b=BCbZJ01CVgnhTT+mSSJlPHNvFbPNH7mA2/9ScyrVpcfGmw6kwyuuatwdAGzpZkl3ZP
         K6fwbHPj5lIRMfb5mDRsrzYSbs2MazfjyGjXVH5WF4I3w3OGJ5aqxuOkxnO3FXyArq5I
         zj/KXYM6+6imqyPxH2ldDrTpVOQqxR3XyclxlhJ+i+zqcs8wv7/ZtNPzqUicFohlNWNi
         krfPKb+a/W0H1crKiee3TlEXyfXSyIIqpKHytWY0nAhNhSI85HdvZA7hhbYdTCmulK2g
         kTIggzrjxyqlAlq8d7sScOmkKDWpTGojRDVrcABEcbeSGt8qHKVrkN+8neE9PEmZ8ESd
         UYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFXFOMoCQo0hC/Mvsqs6F6X/WGObzwGmaby3y3fIXR/XJRyIIEjaSxsBDiLSX3J0L+9AntBH8A3RR5/BY=@vger.kernel.org, AJvYcCWewfuawHpX/F2G1HSPUegxCRmH91Z7PgXEJi84LQHgo34Zp/e3FWJroSaeaOljqRDBicE8MrmZtyFWUaEjbt3f@vger.kernel.org
X-Gm-Message-State: AOJu0YyYx9ENQKmt/oXnmzrXzS+3UZNHUOIUu7a6jcMAO5xdIQF85jym
	X2DY4at8zdfFjF7oVmD8q0lUubtZ6jfXeC/skJqQCO1akU5v6VbwN2f6CC4hXI2Zi2c=
X-Gm-Gg: ASbGncuC8mxLupwANF++ZdFYzyBL6iCeUQI41A6bEpjNd7AYfFqbyObRB8Sn8n7dHh0
	1HJFxKBoOIV/NHa2KfXUpKPgcqk8mAU4We3o5uhcMIJtLCnrNJRMaMtRq86TRdC0sn45sjoZzyR
	112DclRpSdfX73lOQlkAfX4PZ/XzEjv4bsJR5mHuL9TXkyGZGbh0sXsYeQLki7m/EqbtRLcMqQD
	NxhDNHCzc5V49FvfdgFWwbiXejACs0XBi49QSoSLWwjjr5TEDONOQ7XWorRiyBRFwf+bWr5QoZU
	27tR2+bv7C7YlwFres5Zwqg4PJjdo4ximGrHbnWLZbbOe5Jptc6v9uG/8qucL8ua+niXP6L7yQn
	c3agPEgAz4BKyl/GRUduAceTonPAFQxyClCKmKitOKWM+zt8pldGBTvpnTLq3T0HPF7AIjVjSnt
	DBVN8=
X-Google-Smtp-Source: AGHT+IF+jHeg1blhzus397KbMO6fpg4RfqSldoscVcwuKg6PL2oN6QYbuUXPW8t4wlcCO5RFZ0LvkA==
X-Received: by 2002:a17:907:1c91:b0:af9:6e4a:3b2c with SMTP id a640c23a62f3a-afdf0200d09mr189014966b.43.1755682853046;
        Wed, 20 Aug 2025 02:40:53 -0700 (PDT)
Received: from localhost.localdomain (user-46-112-72-61.play-internet.pl. [46.112.72.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded315e39sm147081466b.48.2025.08.20.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:40:52 -0700 (PDT)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
Subject: [PATCH] selftests/ftrace: fix spelling mistake
Date: Wed, 20 Aug 2025 11:40:48 +0200
Message-Id: <20250820094048.140823-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in return string.

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---
 .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index aee22289536b..d2a7da7bc87d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -102,7 +102,7 @@ clear_trace
 
 cnt=`cnt_trace`
 if [ $cnt -ne 0 ]; then
-    fail "Tracing is still happeing"
+    fail "Tracing is still happening"
 fi
 
 echo "!$func:traceoff" >> set_ftrace_filter
-- 
2.39.5


