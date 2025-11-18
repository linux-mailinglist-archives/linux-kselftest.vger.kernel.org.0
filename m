Return-Path: <linux-kselftest+bounces-45871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59645C6AA74
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3AAB3A564D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0835CB8B;
	Tue, 18 Nov 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhEbiA95"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5C328B48
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483199; cv=none; b=WWUX55IBvacesv8LNHEMMRIAhXc7Vg3YJW+1oUFxCx3SIjQaM3yGvAt4x49ZhuDtP1J59ZyUMMZyh8xXT0oJrCThl1dXbQ9GLFakTiJSB6P+oP67FWc44231ECymeLDtDATThVCdk+YchnOtpTxG46ykYNyUp2oLOj+Fr4Uu44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483199; c=relaxed/simple;
	bh=t0fyfdxYhNgBFmShehvP44pj6moSlFVVPb8XbdW4o6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMB1c/O3OKroC+KTT6e4FlCBMFuZdFptftPrLIV81mqjtjfZDmvnZK/IEaO+TKiQbib9Nz8JbSsm1xjVv3tz0qkqOMRpBmcGP/qSnI2KLi2VMtHtk2SKABrdJyJs0GZMLQ0O7kR8fBMRqfv1oYnsIYCnAs504V20dBmFqf+uu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhEbiA95; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso6474719b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763483198; x=1764087998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPQvf2fJRZLygWkfiBo5LquDd0bEFe+7G+i8V4JqB1A=;
        b=RhEbiA95Gp3g16qkDij7Ilrr2gqGQABey8QDlRHiH4FU62OMzvBzx8ir+OulfD5tph
         D52jBys8O1lOXmT0F42Y7NWaVBu/Xtq1CV/fq4IFjc8jUZcziQNFNjmqFb7rxNy6gLgn
         wK6I/fHTgUgC/vyUwiEfyfbZDhA6yI2msdYPYousKlrP8wiGxIV/tlv4JLqBk1a8ZSta
         QWq7uhuMtdUlwzeeilci19nODo6ovJxUnFDMaZqypygXl4wp00ooYqayRbXK2RBy1i6P
         TDM9+0f9hSqdlZAFb6Z7CVAdondk8tcUZUwmLrfne9EL/4/nfwTSAcE75LEttnPtxtkK
         FpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763483198; x=1764087998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPQvf2fJRZLygWkfiBo5LquDd0bEFe+7G+i8V4JqB1A=;
        b=ueQuVkk5fTZ5aKKtEEw5Rj3vEMT3JKNkYAVVI4fV+vDw+sUhp8enV0vNfL+fZDZIcm
         nttinE3KZxiCZX0KQVDa729qfw6sv7U8Px/hDRlDg2mJEfoWjQFOcVPjxZe/fijJ+A/I
         zlsTANCMGagVgt74Uvt0aOhaw9OiEL0zBPXBG1s2oBxbL83IblxdkvWQANWr52Xhs8mm
         cphvclE6pnFvYKn7vdxm85lv3wKQ2RkUTC4aCuDEmzvqa8iqbtwrPLTsL34M9Hf4PoIn
         sk9vEJOvoMLObREVY77FM9GvSh/5h790h+X0jySYweaiRKfM1q5c0Mw+1KnUOLa0V+J4
         nKOA==
X-Forwarded-Encrypted: i=1; AJvYcCUHP9FPrcXBZrMhbrpjHo2GBn3DjTBcWFrH/iKOcFxV7NqGxAvyI68BRhDjs5hoxAXTyc/a//gfT5dllvUUM8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSv8SGwFLhGmWGwfHtmu1BESBb9q90uauf/E1gKyspSR8IKTpo
	dmZzM1LogBygdXvKNeQq8Dqrl+A167pB4Wc6+ptQmLK8y38xY4RLjLF0e3XH4LcG
X-Gm-Gg: ASbGncufy5ZZuy1LoLuB5E/ThE+h0h21bxjMgId9WB667vulUCmEYOVZYp7Iw/PGmC9
	3DtonTq/7TvgiaYOh7B1okDLRXev9scFGVvjQW9ToOyhjhUX89hODRDc18ud4YGZrpB6Eku7+ZA
	kmAwtRHvfoDO/iP+aucIvJ/5hLj0WgnnHpGmQwokrs8vPFhMA9wK2zIi4MMGC4jO0fa0XeZtu5B
	kMtJRBPx+cd/F7ZEyY20+8Wi//OYzFGaPh4QGMePhCQjyMMaeq5N9txwIkk97xeBezOpoEmdz3U
	pYEIksdzRh8uLPVeohv/AMOmZ2ZhvQmqD6m2QuSdH7ZxXzTTRuUFpNxkvgvSAvkv2Bc6aPY+fzZ
	xPmQA2edvNVa9Q8ldlyUxB7q1YafZnLEYdsLgyufVxLuWKVpUJDWtM4RqIf6Pln75loAp3EoSCc
	k5BHjtOBA772Gs5qVNuZs=
X-Google-Smtp-Source: AGHT+IExnN5/CvNTXvJarfjTKsDl977Q2/s/AGjrE0qQoqK+RhFoIGWV/hP+DhY09MKJIFf9WsFWeg==
X-Received: by 2002:a05:6a00:2443:b0:7aa:9ca5:da9c with SMTP id d2e1a72fcca58-7ba3c4755d7mr17508039b3a.22.1763483197640;
        Tue, 18 Nov 2025 08:26:37 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cd969sm16992718b3a.23.2025.11.18.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:26:37 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	andrealmeid@igalia.com,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/futex: Fix storing address of local variable
Date: Tue, 18 Nov 2025 21:56:14 +0530
Message-ID: <20251118162619.50586-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=8
Content-Transfer-Encoding: 8bit

In `child_circular_list()` address of local variable ‘struct lock_struct a’
is assigned to `head.list.next` raising the following warning.

robust_list.c: In function ‘child_circular_list’:
robust_list.c:522:24: warning: storing the address of local variable ‘a’
in ‘head.list.next’ [-Wdangling-pointer=]

  522 |         head.list.next = &a.list;
      |         ~~~~~~~~~~~~~~~^~~~~~~~~
robust_list.c:513:28: note: ‘a’ declared here
  513 |         struct lock_struct a, b, c;
      |                            ^
robust_list.c:512:40: note: ‘head’ declared here
  512 |         static struct robust_list_head head;
      |                                        ^~~~

Defining the value with static keyword to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/futex/functional/robust_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index e7d1254e18ca..d1aab1cc5a37 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -510,7 +510,7 @@ TEST(test_robust_list_multiple_elements)
 static int child_circular_list(void *arg)
 {
 	static struct robust_list_head head;
-	struct lock_struct a, b, c;
+	static struct lock_struct a, b, c;
 	int ret;

 	ret = set_list(&head);
--
2.51.1


