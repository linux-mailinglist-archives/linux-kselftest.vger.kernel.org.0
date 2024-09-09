Return-Path: <linux-kselftest+bounces-17489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86E970F48
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85951C21F42
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253BE1B2533;
	Mon,  9 Sep 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCE3FMbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC31B1D59;
	Mon,  9 Sep 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865726; cv=none; b=rezLk99g6/mEqTe2XZ9BXLhIxByuipYG7AsBEeB87i2lBrVQcMxOIY2PBnLroQ9eeTEYoPB5JGIg10mU7oHHSWPz2m+0MYAYMBgqO2W9r63ctDSsYQHd5r18/aFDFe+UUtV5fEqolOxf4ZVAqwYXhtNYHuiCVfonamsYRcOO/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865726; c=relaxed/simple;
	bh=8tm+lcdAFkZHPiu0E0ltAWkkidqC3z2DF7qr9c3wbtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbdkN4flR8OvDvSvSxyhMbvZu/p/qF1O8ozeBlSUneXDms586bv/QhINBg8/tjrKt30evb3ZK8YDnSZt7xPkA6d4hr7M4KzMltkH3QTPtdQUdrKohKd6AnyL4gfzwoz95Mn6KrOMmQ7d9BdE7KhO01ciDBaEhyi/GfZoXk2eaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCE3FMbZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c180d123so2172307f8f.3;
        Mon, 09 Sep 2024 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865723; x=1726470523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/MFlMnrTNocZP8/Uv97NsCue+ROk0MIWVg6GOd8r8g=;
        b=DCE3FMbZwfKM6cUzwNwDblndFx5QuYiCFmR9iWzJORugfvmmccaWGAS6sKGaGiHO/E
         ZwgK2kfcyAag8kwSG8dBND2Z363ielfkDQr57thoV5/5Y08+DcdBJ2/OH2EKVooHH0VP
         ekirJKYHXSJA+5KslKfRVUk8hs6/ILl+ZDSuxFriKRsvGskH2n010ofCAGJu8xOgwnSX
         yXlPirt8jt5NAm6tlzDLX45QT6l1HD7eKryPSQuGzWflsTGuI06MDLPEmsl4Bqizajlg
         KlZ8TJK0/NpPiqrsDPYtNw1mXKwKWFtefV8O+nWlQP2KsbD2o82bO4KVGrkUw6Jd7Yo+
         1IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865723; x=1726470523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/MFlMnrTNocZP8/Uv97NsCue+ROk0MIWVg6GOd8r8g=;
        b=RQd/S6V5yyihk8sdX+cKfhRK0Y2YTKmQO51eDoa+vS6anzYvwiE7xAyfz1qu6ZjtUp
         xVjfLOQAX2lJn2totGJj/5ZkUI0+Zn0SIunK70q2jluUKnuensLh5d7w0JMLfFSxn7wl
         41U0FvAv8zOPGTFJ7lCbYzYeqCBn+avKGJr6PHdxyWfs0vnYXUgsIEDGPabW2MBjztL4
         T21LGL1JImLjLNgpUINSNGmqGm+lik3EmPv3ilL1EnKnd2F23skwI/1J7L4RwcXmpt4w
         5/4WBX5Aal/SuZsY8cN5gDETymIQwOG8CoNv2gVHGuEoZrmgq9IrTi9OXZgwRx8VAmG1
         jzzw==
X-Forwarded-Encrypted: i=1; AJvYcCUKFNLxlibnsVbyuwgJX1sNgX8WMt+sV2pvZHBHPmwl9ziqXK4mLOpgpGIGFdD1KEiOWrsQJZzSG3HaBU04Hw==@vger.kernel.org, AJvYcCUnDSEWbeHKmyCp8HWlfAPijCa9rc/TTJCaQxF1hDo1m+iiEV8fJjOZogkOBZNaZCJDxbs=@vger.kernel.org, AJvYcCUtN9/TLuyXksKlfFvyTepzkAWXb7aEOYpnW7mWDnsmcswAnaqV1t3zZwnvfCAALCjjfbJnrksbGAlqsg==@vger.kernel.org, AJvYcCVr2J0tlKmEEQWb18EMxNtQglfH8gedRYBfceS7FAyq6/348ghgBOuMtgDQ/R1+Ac2bXLgfohN7PaNrH1ady4Io@vger.kernel.org, AJvYcCWnYMw7THqPt2lhrVqwy/Vu7sCm/459UzmuDw4RwUyraAMyNS9WiNGwzu3VR5X8GMeHfRo+aZ7QejpXBV2c@vger.kernel.org, AJvYcCX3cp7ZQwC4hJxY0k/3GQjmPPP9tHkVo+wxrukTHOvc2T/rVPJM6vmyEg0dNIT8XGpV0PDRDkJsnm3uJ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGsHeyOmsjPNXNkddXH+/+mWSFPbyGcAtX4VXtt03IuFCqgSA
	JFH51jX15lsKxr6PJsHcJ7hsuqWzL7YvzgOd1E8nhAOsLZqL/n8oViXD8d4C7c0=
X-Google-Smtp-Source: AGHT+IF/jsmfALn+XbJWo7DbJRUOtQ19Xtb/ZppZO8Lnb9QwaZtsxMP8/xIAWo66GB7XqojzBH2ExQ==
X-Received: by 2002:adf:fd12:0:b0:374:baeb:2fb with SMTP id ffacd0b85a97d-37894a0d0b6mr3746464f8f.35.1725865722690;
        Mon, 09 Sep 2024 00:08:42 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:42 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 17/19] netem: Include <linux/prandom.h> in sch_netem.c
Date: Mon,  9 Sep 2024 09:05:31 +0200
Message-ID: <20240909070742.75425-18-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <linux/prandom.h> header to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0f8d581438c3..2d919f590772 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
+#include <linux/prandom.h>
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
-- 
2.46.0


