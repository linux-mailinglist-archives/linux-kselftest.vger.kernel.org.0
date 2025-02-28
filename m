Return-Path: <linux-kselftest+bounces-27900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7BA499F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57177A235C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA7270048;
	Fri, 28 Feb 2025 12:50:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18B26FA73;
	Fri, 28 Feb 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747055; cv=none; b=rZB/1YHvAN5BRDkAD/86rTCTFjASA3s2Sj8EqS/O8CXtvKZTtmtnrdfJXn054AIvhDy75pJzMVFSL9MMVAmYwMqdz+mXaaE14xtMrXSNbf0wy97yqKcrdEDRE+ui54Fja+O344GMwksu/aeIQ6mHwJeI7VmVCjmvxumWLR0g/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747055; c=relaxed/simple;
	bh=8C+nY21yevsU3UwMdamo0a9NlqQBPI9CGp6TGPaKLJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXV/uU5YYNvdkRD8J0Vk4Bm+elYipMK10VUp9ileVHFxC6++6X3YkYLQVGiRGSobZ+MXg/HigJ/KFdSwSu9ob/BLspvgSor4VoMeT1kq3XDxWqtZq0ypEgj+Bqy/YH1IBuWUgJgQEPp3XtnRBQLtn+FODCJspLi/Cdc7TgFDsXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3148447a12.2;
        Fri, 28 Feb 2025 04:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747052; x=1741351852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EDxdX1XBRovJcfFvztzdNk452+H0oR8ZEN7mPlg0dY=;
        b=iz/MHgibw6QQspFqpDzu07unrS8gTcJ63+6WqI9U9czBRcraROL99hVJyQzKJkVfZ3
         j+9iB55VAnZr9K+V4LcnflahJLw5A5jxMVnWG7rkie4vLprFQvDj5XzSSG9jI8GFE0x4
         vUcwO/k/EPhGYo3XEG7sHXYIjsT0WPHw6eKAXY92oIE53qDx4/jRy080JkZR9TA32SOC
         lbLtvuo5rLkS9qDoDPv90hZmGvj2lBAnckkqWXE3ck4FepA1y7/qKHMsXxv9/j8VuNF0
         cJgcue6oXDQbFWPY5oRRxZIXTlepAI4H71y+64JlgDpJ88TW+3i+zYNUVnIeY0UaRlB0
         6JsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUboxH4ZrCl2wQ2cB1SM2H9NL+pbFHHcZigE5nl/ro4q7iZ30CE15Hwd/yAq3H8maE7LGJFd8gjDiFBhcDGx37x@vger.kernel.org, AJvYcCUn03+4mY3PpHU90sWth1r9OH9WjwYS3zN6QBMdo83kVsS02Maeoe63yuSFxoaWdoyP5ciGdriHnKdOIpSs@vger.kernel.org, AJvYcCVVp5jfXgbOC3kVhAu/W6S2xF5rCbUbSue40P/R0XGYFNB0OY0iK8PlmejTSc+9pAkYlfMMAUpc/oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Br7XQOxTEMR+3djTd3R3zroQiD+QUCcqBnNVqSagUl0ga2Y0
	fxu9j5o1Xo+VTzo3FxQVMpkqqCpMTVj0Y0FwuAxGNT5LRYVu+GZTQT4I6g==
X-Gm-Gg: ASbGnctUBQCgNLS6gKf7VM0jES5Qa0TB45qAyng6Ie4N8afRK0PG7lCxunKLAlAOOCB
	FanhcN/dpAaeCzhYnf2ouMD5XpZAAbwksp8ntupiFtXlMxHBe8wcrQRAlKV2CJYYzelLwQI8mNS
	tIFG8uAZkS/UHSbWYxc2Acc2kec1CEGgyDp9fqW3Jk0+wnpKNqe5/i+ozDovG3PEV7aGF+iK2Zx
	cymL8UzbHjOh9UHQdKQnsypG/UvubfrWV71N+9Z8WruwywETC1WO4F5e6cSlIPsX9QNSI/FIC1k
	6uIzCgv1uwKp9g==
X-Google-Smtp-Source: AGHT+IHFTyi2Am6kv+da94xkq47KOQe4s4UOqJfTE+pf4N1crcnYVkWFX0RbgEYNbOpaLWRqJqhI7A==
X-Received: by 2002:a05:6402:13ca:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5e4d6af43famr6945957a12.17.1740747051629;
        Fri, 28 Feb 2025 04:50:51 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9b0esm285376866b.1.2025.02.28.04.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:22 -0800
Subject: [PATCH net-next v2 6/8] netconsole: add task name to extra data
 fields
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-6-f53ff79a0db2@debian.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=leitao@debian.org;
 h=from:subject:message-id; bh=8C+nY21yevsU3UwMdamo0a9NlqQBPI9CGp6TGPaKLJE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEeR0dUuM8iy6feHnneIR8HKpF3jdXbSrH5j
 hoBCqF1+RyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bXl7D/41F7oovHfDcfl8vMTILBOt4iEFQ7/NLgJk6Wnzsj2NPGLRpGBM341RmrEyUK2lTR0d2MX
 v7kebcOPnOjXtfJozzSbob/iZGvOLEJsMvf0CBqMOTDyuFtC8t1sO3ChBRGhDBjaLYIO6lE2Qr5
 w5qJrzn/+g3vpLsBLcPRDIZl97tiqEeRnCpF6TLnzdIsmynmNGRVmlFMbYe7OAsEpu16ikqt1Tq
 amj4wUFUP0VCr+SykKpTfDKOC5yrbIsblI/US6m+04ZXlQT5ErDDJV8RDv77WhVUmRXvV48Kdj2
 dNcYzARx2XmEZnga+DV8+YBdJkJqinKgl8JaGqRzJM58ejKva1pmWbH0XbunNR53Wlf8+YeoVZj
 peVIoPzjxFCvjGLOWqxNLs87YR+JKnJ52snhk0VCn/REIkYsx8pMBKfSmtclKXq6Td+5uu64bPU
 XGYPohTT+2kRaPkzSaFgAzvVdY8DT7K0I4UoHNob+Du2RIuxAXYD+0uyyqi892p7mGGr5J97/6g
 kK/3BpPtcGbhRjslo+LFl+6fGuQxuw1Gm71RfTpZTERKU9yB/8q0QzW9puXJhHo2aF//UjmoHrs
 HtIPxWLQjrGgU9zmsqm0m0UDFNR8CMuUcycdsHK8StT38YPeHtCWaLnadhciqSQZujBXj6nvOnO
 nHB3WdbwFBh/oSw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This is the core patch for this whole patchset. Add support for
including the current task's name in netconsole's extra data output.
This adds a new append_taskname() function that writes the task name
(from current->comm) into the target's extradata buffer, similar to how
CPU numbers are handled.

The task name is included when the SYSDATA_TASKNAME field is set,
appearing in the format "taskname=<name>" in the output. This additional
context can help with debugging by showing which task generated each
console message.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9798b2b409e26..098ea9eb02373 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1179,12 +1179,19 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
 			 raw_smp_processor_id());
 }
 
+static int append_taskname(struct netconsole_target *nt, int offset)
+{
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
+			 current->comm);
+}
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
  */
 static int prepare_extradata(struct netconsole_target *nt)
 {
+	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
 	int extradata_len;
 
 	/* userdata was appended when configfs write helper was called
@@ -1192,11 +1199,13 @@ static int prepare_extradata(struct netconsole_target *nt)
 	 */
 	extradata_len = nt->userdata_length;
 
-	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
+	if (!(nt->sysdata_fields & fields))
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
 		extradata_len += append_cpu_nr(nt, extradata_len);
+	if (nt->sysdata_fields & SYSDATA_TASKNAME)
+		extradata_len += append_taskname(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.43.5


