Return-Path: <linux-kselftest+bounces-42779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59625BBD3C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 09:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378241893B1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4125785B;
	Mon,  6 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsBXezeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A14257820
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Oct 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736601; cv=none; b=PSrN5lzxOik6Qy2Hk4Ny9FwnWoy/DuYXESgmaB+ripTuynAuzJeObV27irl+VCG9PPGS50j8IB0KOpMTCNlhIYaEEYXGGMjsc4glmVnVq2CmSA1RuITuFIYp+t/hfAmW+VBg9SUZPZAV25R8E/HWc5HzABdE/+C52u6Jw3+4vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736601; c=relaxed/simple;
	bh=C/mZn+WHYcVqu0T+c/x5PT79Zv6hxCKk90h2Bfu7lJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LExbDngp3yU2zYCk3cpGpUsMRCDyZOmfMEBHk9tJj3Zl60i+nJZb6rEkNTq7yJqBosdKxkMeHok5Z5W8gd5MENOyCU3S4SxmkOCcyYm/y8Lp7kZ/4LspkC4SOraFuhgr8MnZTMYtO3h4o4ibuc/G7QYRj+mFMRvHhP29fnrttVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsBXezeB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-776379289dcso348700b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759736599; x=1760341399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw/9lPWHfMPkffQmkaSdCiEp9p7tCzCfQj89DSw96nE=;
        b=PsBXezeBPjtNKFZQydDkaSEOoVwb8gMYwStiQMFyIn4rvT2IusPOgz0dp7JM67eDiv
         RYefwi+HLiiTMUcHNYPpQj8sycZlkgcF2rlZ9eRHFq+1v+VIlauQhRPZsabSsU4X89lC
         +D15vfJp0XEUYUir0KlByxYEDCkFVAs+sgwXXq1uJRtAROGhpwdTw3eStK7qsjoEmO14
         bejL75YKRlwgPA9JhgPjavrK2+h7nKXP6ua+EKccxucQ27Kuw51QNAeJIG9BieeKECrC
         OTx8B4HBRnYGJNCNokUjyvhTLPzxisUfJNA5hYEG8X9NdhCdf0vCcrC/bQgEDzcuDfTm
         AUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736599; x=1760341399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw/9lPWHfMPkffQmkaSdCiEp9p7tCzCfQj89DSw96nE=;
        b=NuB8YUSqnhuk9Id+puSl13PSKC7rjjE9i84bQV1n87F1oTkRAFjH2JO1Hy60zwMDal
         ZCRkaEBQK+RQfO6/DLj8ISGZa31+wpyB0RhtBSlshedNw/WUzaPgl6e2A87HvBVX3rfI
         O1dZm5vQ40ZLrvKMBjykCWhtNQE+UmEWDePhKP0eP9NeI6YpEHZVwZAoJLbys2fESmqs
         Cv81wNahjgc39fM45c5yp30DvGynFg2LoKgt9CFWIQIQsWyofa7YuOVIBNywt6dJWQ5G
         9Mbi+Nd0I1nduTAzJySPGYiRFIH2Rxemf9SzruY0dRJCVAgse4S9yQsw2dh/+I2zgLue
         biWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQuwG2y/+zz8VpHNSag03yrchhYFIbEFDZb/mFNOTbxVfkUYK1flFvwss81H/acIgnMZkj1uUTb/oa3jmM5UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn2+GVpfy7ZttCLNiRVW+OW6zSKEWIUaybZnlpIdJYYZMhJgd
	PjVaA6iiBIW5cIa3JPoeHPG4lO2JCuHGd1+7QjumqdiF6d4yeVpXIc0IS3HzTGrv
X-Gm-Gg: ASbGncu2tG1bnd7E/fhl5tVkQawbSLITq93pbsIn6zRRiY6K829ku1F2LA2Y8Nyv7nI
	danZQRhsjl0uaXELjIlIFK21lvLKxiFTGiJZOzZnqc55X2ukR90h9BB/6EWLZcuUS6RXmiMqxCs
	Nnl2azN5B5y5ebsLv8PigWcmzrtCWM9h+lZiC06IA8a0NngM7VlF5A4leWjFHl55/8WvwEx1Y7X
	PsmWY9iUrRVA4USRm9yIaAQ0G9biIJ1/C5zZAeE+kAINOEAovYogF46RFs5F1cfxMhQmFgZWYcW
	2e7ZYFCfGGujsLAGwVw+llrVxUKVUo785Ca5UCy6YOnp/A9Kcxty9SaVN6SFBjpD89nB1T1ierU
	q+gyeBOaFU/XAb8i1YjeOLBOvyMAlhefNUQw9jKnyhJ8qRamC94b/pT0=
X-Google-Smtp-Source: AGHT+IEMB07ViPSEotVWrOcwSD9ma9t+HQ//zB3NHR8w0pPltXfnUy8JcwvN3opxQHM+UsEYUSNjJw==
X-Received: by 2002:a05:6300:6675:b0:2bd:d83a:d1b3 with SMTP id adf61e73a8af0-32b61b2e1ecmr8038240637.0.1759736598836;
        Mon, 06 Oct 2025 00:43:18 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:f9ad:a206:7416:2450:6aa2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f58ac2sm11231639a12.35.2025.10.06.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:43:18 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: brauner@kernel.org,
	broonie@kernel.org,
	jlayton@kernel.org,
	shuah@kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Mon,  6 Oct 2025 13:13:08 +0530
Message-ID: <20251006074309.4348-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919104948.67953-1-vnranganath.20@gmail.com>
References: <20250919104948.67953-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>clang warning null passed where non-null argument is expected.
>
>anon_inode_test.c:45:19: warning: argument 3 null where non-null expected [-Wnonnull]
>   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
>      |                   ^~~~~~~~
>
>Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>---
>Adding missed mainters to the patch
>
> tools/testing/selftests/filesystems/anon_inode_test.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
>index 73e0a4d4fb2f..f796dad679db 100644
>--- a/tools/testing/selftests/filesystems/anon_inode_test.c
>+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
>@@ -38,11 +38,13 @@ TEST(anon_inode_no_chmod)
> TEST(anon_inode_no_exec)
> {
> 	int fd_context;
>+	static char *argv[] = { NULL };
>+	static char *envp[] = { NULL };
> 
> 	fd_context = sys_fsopen("tmpfs", 0);
> 	ASSERT_GE(fd_context, 0);
> 
>-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
>+	ASSERT_LT(execveat(fd_context, "", argv, envp, AT_EMPTY_PATH), 0);
> 	ASSERT_EQ(errno, EACCES);
> 
> 	EXPECT_EQ(close(fd_context), 0);

Hi Christian Brauner,

I just wanted to kindlyfollow up on this patch.
I'd appreicate any feedback or comments when you have chance.

Regards,
Rangaanth

