Return-Path: <linux-kselftest+bounces-43140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C92BDB531
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A7B18A759A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7030748A;
	Tue, 14 Oct 2025 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gID5//DQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B23002BD
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475172; cv=none; b=ENp0Z/2LK4aACWDuFOBY5gujKTc6KvouPSvN1ADDJenKdQMWQ+gzxJPq6iyV5dDEYLqa8Wzyp/E7vfRyRp6AvGd8Rq1b8qccF603ojq06kd44fHOrUTYwiig2p9R0iNzj9Ty1FqvmSjwFbVa9CCNwpimJUDYArDEsrFfiAMlIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475172; c=relaxed/simple;
	bh=V7v+pOaS/Y/gC5OrH8EAkdZLjfAruClStwZDceVuw88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=co4R3aPyVTBHyHxvPpa/0AMcIry+wmsv8YQVpYWOCyXglyI4GU8GcD/6xJsm3OMLGDUSnqMthS+AnssvLhcx4CJHXBIDVRCimIPNw8NCp4o7+hocY/qmMnTjLZtF2SZM+qEw/2HN5lJQVbXdKFT3GFU9OwaZ6Rziyp5UFUP+Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gID5//DQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78125ed4052so6756357b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760475169; x=1761079969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyC4LLQcwbbHxZ7oSfAdTEYfnna/tBhmcvxxjsywYQg=;
        b=gID5//DQ6r3+rJac3MhLNP9ZJPD1sF6KLKyNyof9IfKq9gXxvpbldgv9+GkK5RQNHj
         CMc+SzEesgacBQdcbTs6WFyqktquffGYVMeXXSXVrdKLIU9xzVz8ad+8Er0DCXyVR40Q
         ExYGHJWKuEYwYcsiFlxnS5FKhehvkBbaPB2r60lzQFYmRUz9CxtsHkd4X5Hm0RN3xOeT
         mJi+O7cYgM1kGLs2NxmYWGGeB+DYuxSrppipfhaJ18Vxcl7ibQWEAnMljp/YpiXUinQG
         F/e4yYHzdcXd0SKZnRBebP5lJuibg+OQ+QnF4iKsWlPb/lyu+LaRmeEWbe+qpgANJOfF
         +owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475169; x=1761079969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyC4LLQcwbbHxZ7oSfAdTEYfnna/tBhmcvxxjsywYQg=;
        b=pm0GTo37jHTYHNAa4ikPSB8F4GEBgSOVLiFeHMUAp94kbePxBQS5Yp/eOgCCBF37IR
         QupPJu+lXW3vnzz6qaSb8jDvQzoJXrHhjvIyEj2L8rd8kUsgitmiHqpflHJRBBWBex1p
         B4TUwrdccwsteaQPpy7hF+JF66uKi2XWZCR0Kqdm6PVJL0c3KpP9oydBMSvqgoax3WoO
         PoOAWk/7gwWMvWnwP3qKqfN9PvQpj1N8LTxO6xCbyY1Ml6THro5NbHIs308F7qN8qY5Q
         3OFvo/gemWc8jRar3wQFDKI/uORhSuJFInt/RMgaII5J6/KSZ1LcXHn/pInbqqvm0kTV
         kaaA==
X-Gm-Message-State: AOJu0Yz2Uz3niYwZNiRpzbFZ5idtfAWiqFBHVHr9SgGZNCtjjF2Gvd3E
	WnzKFE5CvWPZMxssMtKaFB+PHka9dJ/yFRxXdwihBiZH+MB35yJqO+em
X-Gm-Gg: ASbGnct+Dzghcf0xBlwcalThUFkJGZXAt9Zd8pqajjVXzfOwR8hx41vUgVjwCvL3JSX
	I2jz4nmK38myO1pq3jLmDfL8erf8UXUjyPolQPBr6RhT/aDj4JUT1CNg4uIQ+UEZ6bLofDhGAR8
	dzWxM4fp1M24yesr0fe0tM21ulH+/NxXM9pMtY8PzsBbY0ktnibxVXKTMJKy4iAIUlgxY2XQgMV
	5xEuSr8QLWeAphtu0KgXeb9KPGZiIOmPSnv3cZhMk7GpXQCRaF3I5tF4LWTDQ2ADXSuszzpmB/9
	i38OzKQMPrWcnPyGdyrnJTjRqSu1rwDBHYXDsHqPrjTt3Y1pkMMpx+K7YoP2II/UWL4PSJeDG5T
	/IazI/fL5W5LvzxYzs7T8LJKbFBXNxL5q+T9HB6BZsLdWxdKUMF/JK7PEiDiJt+DolypaGg==
X-Google-Smtp-Source: AGHT+IFCRRm40DDjhn2TEr20aRuaPJEvmy9taUntP1uHoQXO517vsour9GZ0smRONPkfXTDYh92yCQ==
X-Received: by 2002:a05:6a00:a0a:b0:781:1920:d12d with SMTP id d2e1a72fcca58-793858fb6dfmr32179732b3a.12.1760475169402;
        Tue, 14 Oct 2025 13:52:49 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb18e28sm16176088b3a.29.2025.10.14.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:52:48 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] selftests/dma: add dma_map_benchmark to .gitignore
Date: Tue, 14 Oct 2025 20:50:41 +0000
Message-Id: <20251014205042.1637315-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dma_map_benchmark binary to .gitignore to prevent it from being
shown as an untracked file after building the selftests.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 tools/testing/selftests/dma/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/dma/.gitignore

diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
new file mode 100644
index 000000000000..b4b99b6ffea3
--- /dev/null
+++ b/tools/testing/selftests/dma/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dma_map_benchmark
-- 
2.34.1


