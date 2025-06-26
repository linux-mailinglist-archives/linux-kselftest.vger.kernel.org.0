Return-Path: <linux-kselftest+bounces-35809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E7AE93E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 04:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA251C41DA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 02:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0133155C88;
	Thu, 26 Jun 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddwrAKAv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449E126C17;
	Thu, 26 Jun 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903682; cv=none; b=mnyIijm9MfAkeECLcZ7QUrLUhrifLO9F5FZFOZaZdSSv8mpq+pw/K7yxYtpEkoDL8t7XZRczFF66aVmuRfE9aI5BkPQ4NOOGo9qU8j6M2a9bPTy59QSIhd7tNVUsYa6E9fwmlWILyU5Ha+aiA9DlANjEybmjqsy7BxVA/SH08vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903682; c=relaxed/simple;
	bh=fGBdLx43ZNKtIbzyx9QYwr/HXAxnuOX+RmyAX3dJ02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaQZg0FQk5eE8XNqtyXS0IFwDYLwFkogo2w7EctrvKOdJA72mTd+byX9OdoIxCAcohmG0TSGMqSSfl9skhKWWbsEIHzX+9AOVTTlIdchw/5fQO/4kqvyiy7IVOQuQ8JZTEw83uLIkhcMhb6zxzhWXlKbs7JRidsmOzTKNCv7d5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddwrAKAv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34c068faf8so506333a12.2;
        Wed, 25 Jun 2025 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750903680; x=1751508480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QqGYjD8NV1Lz9h53E/xb2YOnYvPPC++UyYL3ZPC24Q=;
        b=ddwrAKAvdzYtRaE6wP6cG1rdAJbNTymqS4v80hSHcX5wY7Tt+3PsVLGjTNb6Pspsnq
         LJS2zbSVvhxav3Aoof1J+AUs+VWBUH2Z12UbyYc7txbZz3501u7g7REjYDMVIBp1p7TJ
         PJuqyeYOaQpmkQSPYNivVgT5hENHEjJofhpvua7EfcmDwewejWCK/zTunxDKnGZXmt9H
         AEWpcGZx0RoZZLMcAvd7z+qPuAzONOdJ4OeUI84U13FZR4W60p+XTgPynjwQCWBEg9/V
         LjH0oYGN1o8kiCXy21uyN1lO9mjYdl5rpycxpFSFTm5CmLc0I09Ztgt3hRXUOaOK+C/h
         HUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750903680; x=1751508480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QqGYjD8NV1Lz9h53E/xb2YOnYvPPC++UyYL3ZPC24Q=;
        b=bMYlFMwq5btE1PrixT1S2BrCkv68ABUKJeG51800e66O11NsFdyzOMMl1+e1PwqJPH
         GDZJhWEOuOg2gxI2b4Cx8DMQ+iqrOwW6pXKOGdNJNj+rAGd5aU0QbHvrb2UJa8FsJBwG
         yGLc2+ku8TfgnbGKkiUKK2RdcuNlDd4ZLgrsJDYADQMO5VS75yH6tXI6riIptIYICTtu
         usQqp5oKWN5yj0mpFqXBtMRvR3fm8OXlRG3NMD8eG6/350OJtE/sHb1sG873Q3uMaeke
         EOdzFFWFCEJqy2LZ2DvN4AahPi3X06daNLh8AiKiZJt4hpVEZ6BS0UL9BLOG9ldIEnCp
         Hjdg==
X-Forwarded-Encrypted: i=1; AJvYcCW06jcdlw5MG2O9C2w/6HEqgkVzritDErMqLZ1JKWcyveWBU/OSKzeYn7ZtSW8CMCqSKNbrHvw66gQTc/A=@vger.kernel.org, AJvYcCXjNM3snd3+9/qIDxoatnbg92NDzt7oALp3vV6NOc+7as5DEj8i/rviAVjAYbCNvfP2o3qr+u57J6ZKjqbSFgZa@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXT6i5Z8GnKFG+iyy/H2wMEGxCjZxBhS3SXq/DkhaOYP20c8F
	CaLYhjCD89hCc/7k3luWn1ooFDlwozNQJUB+7asMjlr1ZTddTOqnV37K
X-Gm-Gg: ASbGncu6Cv3nRh7wcXqFs+stf/R53U9DyQ5BaXSLnrQkgPpH+M3LpojVqv0RgSE493/
	t73pN/k7uz7fHvUO1TGgS75zh9e2rGIZDH8fXtZza+jjwOczExnTdv8xzVKtbdPHeCc3Jzgh2EL
	dr9ewKAbpVaajiqA8kNoj3GBX3yqX7WLTFsyoG31XRjcEW6bgKsxBOYxIhBjZRGUuOWDC4Tiz/G
	BJiNUgWZYu22yz74DnrSLQTUNsWNv/aFWZ4ksRho+L7J8aGXmonlOlOj24U8iPs2opM5CTUihdw
	nULd52tBefAR/fY5pGiXNznbFz9U/H04DxX/rCRu493SGtkpyDk2cI34C0fLr1d1jzJIld5uBLY
	=
X-Google-Smtp-Source: AGHT+IFw3FQlZnA+EvUsNN1IOB3BlWRZTtCRZlRlVSj2VO/QZ0xMVRH5KO8rzFZ0phgpRnx8AufnAQ==
X-Received: by 2002:a17:903:2bcc:b0:235:5a9:976f with SMTP id d9443c01a7336-23824030ccdmr110775315ad.24.1750903680502;
        Wed, 25 Jun 2025 19:08:00 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:cc0b:584a:7d31:4a04])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c4318a27sm388110a12.28.2025.06.25.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 19:08:00 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] selftests/mm: remove duplicate .gitignore entries
Date: Wed, 25 Jun 2025 19:07:58 -0700
Message-ID: <20250626020758.163243-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant entries in .gitignore confirmed by:

$ sort tools/testing/selftests/mm/.gitignore | uniq -d
hugetlb_dio
pkey_sighandler_tests_32
pkey_sighandler_tests_64

These entries were originally added by [1], and later duplicated by [2].

[1] https://lore.kernel.org/all/20240924185911.117937-1-lorenzo.stoakes@oracle.com/
[2] https://lore.kernel.org/all/20241125064036.413536-1-lizhijian@fujitsu.com/

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 tools/testing/selftests/mm/.gitignore | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 824266982aa3..f2dafa0b700b 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -38,9 +38,6 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 memfd_secret
-hugetlb_dio
-pkey_sighandler_tests_32
-pkey_sighandler_tests_64
 soft-dirty
 split_huge_page_test
 ksm_tests
-- 
2.43.0


