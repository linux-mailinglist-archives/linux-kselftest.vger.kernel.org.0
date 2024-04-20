Return-Path: <linux-kselftest+bounces-8539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B18ABA7F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675B1281FD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDA175A9;
	Sat, 20 Apr 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oolvUAm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B23AC2B;
	Sat, 20 Apr 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604187; cv=none; b=n6pCgMuU7z9Vh84wZWvSfyw3zU46lFkeIM2O9QMF0H348NZsFZUXebONc34nfdnncKND8UQ47/xUNRcEUDoyzj+OAlGw6KH0s7ztxsNChFDh/PXPKv96HTS8flsW6WummTHniQhrJU/b747RexCF3mEO2HMNwLSUDp9J9knmfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604187; c=relaxed/simple;
	bh=tpZ02heBRK94o/uaI7Fuv/sWmye1ZJaeReg5EfCYGr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyE03IV05CEwRdD0aW9OB7SWRxTQVJIDH08M+lE9kUCLKSrJdziIIaqouA094Thp00MGmhOxfCc2NcxKHxDndZIXV33HZm+r4C2sGbdiUFS/6BPvD1OZrXZy68TtC6xx8IVw+HwGTZVYvLJJKQV6S020G1FO09uumw/hUIiwEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oolvUAm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B590BC113CE;
	Sat, 20 Apr 2024 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604186;
	bh=tpZ02heBRK94o/uaI7Fuv/sWmye1ZJaeReg5EfCYGr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oolvUAm4cWLhSA+BjrpkCCDHp0oMKijPcuM7TL0PtGbanG6Up49lJr2rZDL3Z+/ZO
	 XJ3TD7UqY5l7C9NKmeQYrR1vnl4n7SoboEX3WmqfGjSmTtBINJLyPgu7Sy6zZ92jT6
	 3q2gAYedIglLw8rZYSBQ4eXortotu/SWWDF5bMKwMBkOjaOF+SK57Jv6/ueIh9ZcRl
	 pnLmBg4yjf+C+ufUiHLaPQAt0JfGVNT4PUcXlKN4pm/AOXu4brPkey0YvTrlgo+6tg
	 rT45RH2S6BkcQMI8vWHs30f/5N7G64uEe4RzCjEFKLjfZm9uRYP0L2iXH8vAiiiMAQ
	 49L1RX0X4CQbg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:06 +0200
Subject: [PATCH bpf-next v2 06/16] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-6-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=692;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tpZ02heBRK94o/uaI7Fuv/sWmye1ZJaeReg5EfCYGr0=;
 b=wSrU3dH9G/jlFLgwLTuyo2aiyD43CQnc+PaTwhEK5DZys44koWN1sczOZJAYskRvU67EBZZlu
 EzQvrJpvgMpCf2wLqlxiXVJx3CnAY+/Crqte5Ear5ylwij82iIrC8M2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


