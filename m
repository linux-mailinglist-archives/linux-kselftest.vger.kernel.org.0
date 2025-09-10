Return-Path: <linux-kselftest+bounces-41194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4FCB51FB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD04840B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04D33A01E;
	Wed, 10 Sep 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxNtZegD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7203376A1
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527593; cv=none; b=RC1EvwzrRntOXZTYe2wuedb2pMtuiM4QF+FRa5lwynPPdsXtI2TgAWDU2s+u9HF+gOmH2AfnoZWvdX/xNWgHxToyD+xuwidb9OziFH9OBEiEUkf0xH+Km+V2UqwvjXpE7z4vkrtMtdMk3gPThr/fS00MzuwSyljEN22ie07xfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527593; c=relaxed/simple;
	bh=p1K1r7QiSjUuPGqQLi4Dtbb3OFi1h0fLaBfxqHPJQcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el47CyYKf6IzLbDplbPdgE7CSf6IqF6KR8O+4itD94wQHMxPFu3Enmg+JRj+EzhvNytCUNb7LAuQGCccznWeCHgmutirPPQ0mQ+gZeheXPLiAk42MD/jQgc8NCaK2QTE96v8WhOoRIdbsFU2cAxqipoDLiuQgDC7QLdzhng37Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxNtZegD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32baaf13944so866683a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757527591; x=1758132391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGGo2FqzU3GfR0P/K8YS6WMuWrLlPcudWZNlFzJbBN0=;
        b=XxNtZegDm6GNBs35QuoMYQ5zD/WgnTH6obcTb5lOfuVgoVpRmjZWpEcC2uZkfR6D4v
         Kno/wDxqp74EKwfnfJb/zxaTbvfj2LzEWLUV0tIxrYthwR5kHdRGdOA9vslnaNGhvxPX
         cxXyglSroDn2yoAdRXO9mrvy0oL74011noweqN9BGK7S1PdtLyESypDaIJeRu69H3QMB
         5CeIpmgkwaKSJGRB6/L6vQ4lSWX6iU0lzecOoYc0Dwx0iksYGtW584wbTBSf3UrwiXAq
         JFWt9pK8jznBTwYGIbkxgDuUrKLlCIkYN24CPOyakm8A/4YkRJTxhIu4Em/aVRUT4f1O
         mU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757527591; x=1758132391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGGo2FqzU3GfR0P/K8YS6WMuWrLlPcudWZNlFzJbBN0=;
        b=nJo3EJe1JSZpc0q8pkEEnmNaIbIC5nJGeFLWAoqPZj4vJwWsegmZkDVQv2puZIVKAl
         0yC2cXyC3+foUaDrE+RN4dZVny+3LTNJNcBQsNoLnc0QvTH35ZQFpZ+BotrFX0aCHOC/
         mq90AlGatiUS/qNyVyauJcE10QdigGYZ3yQEfhOwa6iPm/0C9vbOvL4Z7VDseOdvJKNB
         PEgOzVU6nLWi6ElW51ASs8yX2UkDBRoEj2fZ7GPSX2d8xC5hFYF8qprr9xLP2VmRtxJY
         0BHHj2NPER10byzlRGnObybOdTYFYasftOrHE2qGW3mk3oQErsSrcsGLmGw0BStUmzYV
         3tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW8V7YSoPHFRaA2WizvuYUV88IPZnR1zmfxA8z3woI23BJHX8qknjWgscHv3MVqYPGCFC7nfWn6TJhLt/MTdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8c8zn+cTnHlJM8DT79mB6JmBd4aK6fCbtnbVFYchB03FprDxL
	bViR1nWQ9KeABMillxOA8mNZJwQM7e/KXzksmoxTMu0QTrYCnrm0y3SCy6btYKOC
X-Gm-Gg: ASbGncuh4/ZvBCSsTT3weRT2DboV5Z2UQY3EXcDXq/pzPrPrG96i0c8a5gPHhw1Dv5m
	/+iiIwvW/NMJJrbjYmxZoc5FhTbmolS8uq2aNO9ywjamXhKW8+/+/7RDFubpj7dioSjKubeKt0e
	nYdwRH79Zyzcwi6dmYkyVIauGZjd4aqxJMDBLb6i6lcJRP77KsR6KSdl8gB84DRa103QNY749Gq
	sKjw+CzzVM1tx4T3TtSAehouYrynIec/i5AOfW67LzvVlmva94D8CJ1sv1gGN8WJqvpz5v6mkDM
	jxrU9kJicYebEGupOrToBZrmfaTy1r8mSIzLFTZ6/w6JtI7wcMFLDZbcQZ7sTd6BZATBH7+LFkD
	ninnVURCOS1lxTzjizhvbckZQC17/rQ==
X-Google-Smtp-Source: AGHT+IEzw+HMhtbClo177HVd/w1cVZeS4EdrLYZApgOY0nZ482UsPgyuJQa51LNrMY3+KaXBnksi2g==
X-Received: by 2002:a17:90b:180d:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-32d43fb8b5amr13570751a91.5.1757527591266;
        Wed, 10 Sep 2025 11:06:31 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:777f:f183:f24a:5cd4:ead3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb313dafsm3279188a91.6.2025.09.10.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:06:30 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: vnranganath.20@gmail.com
Cc: brauner@kernel.org,
	broonie@kernel.org,
	jlayton@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Wed, 10 Sep 2025 23:36:15 +0530
Message-ID: <20250910180616.4324-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730192748.39517-1-vnranganath.20@gmail.com>
References: <20250730192748.39517-1-vnranganath.20@gmail.com>
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

Hi,
Please let me know the feedback for this patch.

Thanks,
Ranganath

