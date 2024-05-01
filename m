Return-Path: <linux-kselftest+bounces-9191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BF8B8925
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1721F232DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D65EE80;
	Wed,  1 May 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW2nEUfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329D48CE0;
	Wed,  1 May 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562464; cv=none; b=rFn2NMbh+DBbbJQFRbU3AjONgKFfW/WFX4SD8hTF6NNaa/hn4DoOYLi031YAd1gri31kKbsON6jn8RlRw8ZRoccHk2Je32YFDAlfFWVckg+h77h4L+uwkvBKJstb1QU495MiXcFf81rFvSsHFsvZDO4CTmY3MGjeRPUITdv/BM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562464; c=relaxed/simple;
	bh=3M3Wnl/h2raSpsy6VCZxZzdAzQMNJsqJJU3/6NMSVjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cj+hdZsmMdFGZYuGzgOZxXe4ulFZn9JC/p52JHpWiHzyOe1VJ07TC3EbBEXZpfVgnfkVOk/z7I9qWBVYu2VQ0asSzZCLIbqUGYIxESrkWMuyFwkkoJ1LEEV6PopbofixDRNltkg3E4J8RjFoytcGg7fbt7/DNns2JxqcPhxcwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW2nEUfX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b2119da94so51980205e9.0;
        Wed, 01 May 2024 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714562461; x=1715167261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4XqB6hBIbawz6bEQ9yMFUln9F1VDqBqpK6RBvlwPM=;
        b=fW2nEUfXzIjViKuY77EqD0IqkrAV4DNJZMKaWzvbLU/2Ryw5p6GRCxbrOd/uEcalRE
         oP9XrSwrCCEZQtUFZko9UL4cZb1rucUCYKjHy0qkj4XU52l5JP3tSG+sLBVdPE0rAfAq
         Fefen3lHRGy7mhwzctqPcsiDDg8EsUSQx98dMDc5hdBkjZYHRDSb4NkbIuaVyoNTt5Ej
         k9YiB2/Z8STkO8/CIMqO46J00VanmEPDza0u0mNx3BV2a+2U2vCmZp5HrondkocFqP/0
         dw1cE1SrNueiuTIwyMWRJrt3+eRyQPVV/qyGW+UD676ZFiZCI8vh8ffTmWEv9Xcd+mC4
         Qxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562461; x=1715167261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq4XqB6hBIbawz6bEQ9yMFUln9F1VDqBqpK6RBvlwPM=;
        b=pT/da/WohQ2IGD4KYvWdssTyH4gw4S8JF/qVQ6iS5X0wqPYOY0oBEF1iet9eWPKBVB
         g/qo5tWlmeYP1OIIRxJLVUZHuoN54wuDn8tJ//khre/PI6pigyEcWIj/wPGl5DxmPBTO
         PACwA1SaEwjKluElGwOjGGE/fuj4hK8UT+Xbp78QwVY7IW39MQG7UrTjp0ZAgh6jxuTn
         xcCyDPAlnMfIJW3lUARsDSykWcPeVYLCIPgWF+trHW1V1UdvvN6SHueVyEWh5gv8URmt
         N/f0kKIW3RqVlKjHP7kWrZoA5pt8Ajkn0WaDbYHSI9TUXpaw7sjL0ApPOGAWwIPYIKwN
         jAAA==
X-Forwarded-Encrypted: i=1; AJvYcCXWeCX+hZtczUfY2ZDluHLjfdUt0bKSemT8db7jHVakmK5t3s7Qz6lIb5dGCBqErNhlNLSzBe36FyFXCx2OsEZBLzvgfok3NnsW4XCmSGB92TD2IVFtFdmrp7+HXPgKrgVqhKUigufgtmRVt/SeBF74oKu/coHLYl+5g4uEdfMX65n1
X-Gm-Message-State: AOJu0Yy7LnE87JOfoHE5SG0U25iYwrH69hZcriM2jovsInSz+N3seNtR
	bEjIrtVwrOtomty8xzbGFoBZTYhEfI4FSBPdTKRAN8g4pHk4Ip+h
X-Google-Smtp-Source: AGHT+IH6M5+jC4MHPn/cHXX4xJnlJS7nu6wiILZSJkRaZS8YtKJ8bZOzpCSMaw/rWyJBWAI4FuqZ6g==
X-Received: by 2002:a05:600c:1e09:b0:41a:7065:430a with SMTP id ay9-20020a05600c1e0900b0041a7065430amr1702106wmb.41.1714562460801;
        Wed, 01 May 2024 04:21:00 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b00419f419236fsm1864481wmb.41.2024.05.01.04.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 04:20:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: Fix spelling mistake "{GET|SET}SOCKOP" -> "{GET|SET}SOCKOPT"
Date: Wed,  1 May 2024 12:20:59 +0100
Message-Id: <20240501112059.1348423-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in .descr literal strings. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index eaac83a7f388..ecf5a7a047a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -933,7 +933,7 @@ static struct sockopt_test {
 	/* ==================== prog_type ====================  */
 
 	{
-		.descr = "can attach only BPF_CGROUP_SETSOCKOP",
+		.descr = "can attach only BPF_CGROUP_SETSOCKOPT",
 		.insns = {
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -947,7 +947,7 @@ static struct sockopt_test {
 	},
 
 	{
-		.descr = "can attach only BPF_CGROUP_GETSOCKOP",
+		.descr = "can attach only BPF_CGROUP_GETSOCKOPT",
 		.insns = {
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-- 
2.39.2


