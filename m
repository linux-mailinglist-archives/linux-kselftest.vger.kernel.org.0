Return-Path: <linux-kselftest+bounces-8139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0B8A6D8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0D2285517
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFA131749;
	Tue, 16 Apr 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+hhsgUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC6131742;
	Tue, 16 Apr 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276625; cv=none; b=FzJHoyoZeemb2mGMuL1EYOYmkthOV4D3l0NtSAwt8uCiZVMNlwhqavlY2y/Z/uzYQcaYbl7q0X+mOO7+jSkaWffuLnOWGGjbMTSJ/9hO96a0ZuK9smh0zu5kcr0AQzeWPF5lm9ZJWfuQa8UuGSXo3YJlNS9NXwluuvNnmC08kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276625; c=relaxed/simple;
	bh=9oDLRiiM+JPmmWah55f4UeKYjqp4suxwjRoWuUuu+3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaQQ9bWVhmPEscgz80WtYOnvryruSgghFHafNqdIG2X31oRtn27MZN/icngyIBB/qrY2Utg5J7ZLKBiyWzL4HMRDw7OdV3QIuV7ZhWhnCeFP2+vB9bbN6epxmqOaO6/x/cBisq93BcaG3M515LWZqfcjyO2KaboRo0DoSAzkftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+hhsgUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1376C2BD10;
	Tue, 16 Apr 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276625;
	bh=9oDLRiiM+JPmmWah55f4UeKYjqp4suxwjRoWuUuu+3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l+hhsgUMj1ryVbNOkDI9Pv6zSEgiPwQASJ18l76IcVMDxByhOYQMRDfMUYGFU2p7T
	 jEPJd/aR1IL0sMvbkMXZeVIzJRtfGCLZnx67oHpk5QKe6wCJALyoXJ0Iaou1THlpi1
	 V1cqzBnB6oR/Ij795wMyuaxHgl/IB8wtT+QXWhIva29SCkorMhM2PtRIy4r18nvvxm
	 BqwPnToAQ6kz758fSg75VUDvpRtZRX/0o5MNRylH2FGoiSsYHDMQPA9FWr1+nSWVl9
	 ovepCyvsw/2ySzY8vP8l0NlCOheCcnFlr+K1V90Dp283/h0+AZJuRiEryoc7/HKW5U
	 rES21gFLM6AUg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:20 +0200
Subject: [PATCH bpf-next 07/18] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-7-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=665;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9oDLRiiM+JPmmWah55f4UeKYjqp4suxwjRoWuUuu+3E=;
 b=2+hnYzLBcNJUrnVQt3aPnXWg1McU5HMAixFaWKJpbu8wORHXzuChF3kZemEDt3+qUbkBiocNb
 8CSpi5DsBUCBb/ODxcMKaOcv4odmCHmd292kKhNED6D6KzNu/9JDbN4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cee0a7915c08..e4ae83550fb3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7306,6 +7306,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_wq {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
 struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));

-- 
2.44.0


