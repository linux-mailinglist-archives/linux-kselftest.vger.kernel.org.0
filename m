Return-Path: <linux-kselftest+bounces-48984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6FD21859
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 883743015BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3D3B8BC3;
	Wed, 14 Jan 2026 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkFSUbeM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B293B52EC
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428846; cv=none; b=ec2WbaGM0QMYgozdDvWmcVpmOrgrGZMuPgZZCnlGZMSvJ7SPwqbPpI0JrtX2EFhDTAsNM6W89OW1ykog+UwAg3801la274CPMo7691Xd3WWoloifPINqSIB+wOMzHpq2lUoCEu9uKhOg3ayENteFNzREPCMQHwy7Las4cexlg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428846; c=relaxed/simple;
	bh=A8Qn2ZXNyjvn8gNDuWwA+Rtb50kD3BeNv2696tgjRjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO31dWxKKukGEYCpq0yzcOBhrKwLCRQf6IBdyDIdviTIqk/Vmuvo1oWHb0PuJ2PewYDxFC4V0KQX06RwcIRTQOEmAAWWNZv+9MgSTg+MGZwOtdVlAj9mtOLdJZwj1A1I0M2WhhIPCMalxtbwqVAG8CDRjfkWRySjehvAAOXNe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkFSUbeM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c5349ba802so25484385a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428828; x=1769033628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVTV9saCiqOGcBv4/N1kZOQdjcejYiLRdluYVStkd9M=;
        b=KkFSUbeMrfhGDKaMkcBs1gAfFq6i4S05xZsadrVDqLIjDc58XprImxwIwuuNeNYowF
         gP+Dc3oOBEHLBWJ81YZvIZaYPHFQZJS/eayyUVt8WEBjMGAPf+g67kQ9sLe9rZ8XRJpC
         BkQLHHCsA/+9pCdqroGPtuAeuaeLK781dhZcGJeKNh89MKrdzUyQJjwT1Vd9IsV4esIl
         upz8N1YbOjI3Ll11oaCts5RgRnZCVhFv4w5JTiwfmDoabFCGYX5snatjYlW+qIlSAJnW
         TL2us52c6ZFX5vPc1RescPzu1E/6IYJvM+9JxAPgKIJm+Gcuqu+ryoyML14NrM84S/ii
         YIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428828; x=1769033628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVTV9saCiqOGcBv4/N1kZOQdjcejYiLRdluYVStkd9M=;
        b=cnU8jYBlZmLLq3L+NvHDsUydCeHuF6RrdDoS9dYv7ov4Vi3FK7EnKXMSIrAeQQsBZE
         60S3negnhLh1OZQqlCOJXbrmql+5mYY3iyBS7npzmS1fXFZzc94MWPAgezK+85h0qbiY
         63lWn1eBNXvwNeJCbwgg/o4E9her6yNnb066cvEe8tu6FHBfxfS/wSptAu8kOeYbgq/s
         jcW3fVRSUugkvOTK6ohC7QqYRF9VAQ+1BwTL0C4GYJzVyE8rLkNi5iRKAlT7CMOAQsro
         0xfR/utnq8+z7kYxDts6wiF9PRnBYXz7KYBPzsZxd+Xi5y6YhIlQOe3AAjizo7C8c7b4
         W5kg==
X-Forwarded-Encrypted: i=1; AJvYcCWUC9m9PL5LtPqjAZyiauVZ191AoxuQDtLX6ENZEclp6sCfgcGoasslkHvn+BRaTSYRPhQEcklePkeXDmUa6xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8uycVF+G57m84jZEPZBqaKoCF9Rq3M5y/wU326ifnbuPHLbR
	JbSp2vf75xO0SOEDR8bonaQ0C+Lk6cIVtr3FP8CHiny2gRNOgxYUSQFS
X-Gm-Gg: AY/fxX6JIJRRtg4BFSJB/uL7oeHqtWvdg3iHMAG9hdhfxHO4/6FyN/tswueNYUdl6pi
	523wfjnm0+rBqt3HF7xWTUBioRz7yXzspZSlW4jyYUGQGV52JPqEeIRXMWZzccoWBcrPF4sDxSJ
	FaKS37Dckvv+4ktLG+t2BRBoQ5VoxAg1lq6oIPWBrS937Tt42Wwbdxm889WzRtGZYn8m7RpfUyq
	JERaZeomOrwTwAcXU3qSyRh/MEDJSgX3r8lixSHR406nnXecL4zaDDf4/JfZciOOqy07CzUds8i
	seiIU3tGNkerOBKEeoRjwle7jsqsv94Iv9VNf9+z/VFl4LCpeYdgaSI3ywGxdV4H58YyPOTQnta
	oJXxOgiRnW8oDlteybyLXyL8aOKgZUy2KQ+DjE459z+12gOz/G6A2Lh8eN+tw8G5FPw7Hvu0NXM
	t8Axw2Q55KuwAOciPdQ4sIxzNfzx3cAmynJYm9S0JvnygjMlOyY47YMvrcfHyzGyRJ5XgCG+uTv
	gXwExr6Dg==
X-Received: by 2002:a05:620a:2946:b0:8c6:670c:953f with SMTP id af79cd13be357-8c6670c9641mr44853285a.58.1768428828498;
        Wed, 14 Jan 2026 14:13:48 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:48 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Wed, 14 Jan 2026 17:13:40 -0500
Message-ID: <20260114221341.128038-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
 <20260114221341.128038-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
index 45e57c6f487d..79392e268929 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event list syntax and :entry/:exit suffixes
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-list>[:entry|:exit] [<args>]":README
 
 # Setup symbols to test. These are common kernel functions.
 PLACE=vfs_read
-- 
2.43.0


