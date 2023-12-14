Return-Path: <linux-kselftest+bounces-1974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640AF813DF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 00:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCCB283AFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D86E581;
	Thu, 14 Dec 2023 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZaqCIeQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HL2/33ak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BF671E0;
	Thu, 14 Dec 2023 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5C4013200B63;
	Thu, 14 Dec 2023 17:56:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 17:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594605; x=
	1702681005; bh=XQshBmyjBQf6RY2CAow1bMPPx+5T2NN0wUXPXm8LOKg=; b=Z
	aqCIeQGurRCTM7hZ4iasVKc9O2LQIFe3ei2Nwew2C94utMf/LqvJBaqQXRpSIEgk
	foprlzpuWhEp05gaiT8q4QVRqDiM6QbVuznut8EaFBCbDcwa8LiQGzSWcVoJbbuQ
	sy8mNs4TkSXXZ5zyzzDJaW55lyeB3GpHckAZFYJAYDrm89soUw9wbdmPGTVy85Lm
	XbeF5Y711R6W/m5BFmkkWusaW+xxEmFr7wZz6eOs4UaAlJ9BU/LPSlG/eKojVhwi
	alqplz4xrwzNmSkgWGMBu1kslSoOxh6QR1m9w4biCkIRAHxSPVmnTOzC+jaiELjh
	DJ01GHj9SQwi7cwyFDc4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594605; x=
	1702681005; bh=XQshBmyjBQf6RY2CAow1bMPPx+5T2NN0wUXPXm8LOKg=; b=H
	L2/33akpJKh8LYF5lXkV20iIT64GK82zts3RPdoHgfTXn5QEyoRgN3kypilVZl3e
	4JweKZNSf8eixcUGwZG+eRfpGCa4XREDl8EBUhitaDT9AVHJINRpy3lompY2rFjx
	fW6fuMPKTbh2Xy8yEl6YZmsm4UbmAfkcPGVonCcRSZsPXu4iyIGaEjz00pbmalWD
	bO3RtbRkM5a2S8zRlcksHCR6ObFTon5rNTPwDEuyYjh0qPsN5JYqXe0+eGkN4bCh
	d4ZOTq+yUXhPbKnveTHHHL253UHad5815ixrPY+Ilq17j2DLSQqqIPRjR+oNqIzY
	Vx4tGA+buvC+HzYrpUvTg==
X-ME-Sender: <xms:LYh7ZcQ8b4ZcMEH_ADmm4j06O23hK7-bbJWcmXTV2qEBQ2S3_nbWAg>
    <xme:LYh7ZZwTm3JKClqnlmQ9QROs2bcTv0HkZYVCR5BUua_Hfl2aNRPFhijvwCQZNheDV
    UeQ8RjERl2_Ditj7A>
X-ME-Received: <xmr:LYh7ZZ3Z1XIHDACbXx1D_6GzYpK7IwVURSBJxmBhWlSWSjU-GYJeAtPjfJk4N9TOC8Q286ImzHPDIXZq2WjgSf0kB8cz3Joe_07iV-kcIrs_MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:LYh7ZQAiMA5g8Z3Ssox1UQ_HXFkbX-6BnjyJxrPyhh7BlraicJCYzg>
    <xmx:LYh7ZVg-Tt2-AcMQoqh3PG1hw9NaPq-bmOhqlshVL33htq-ubnCJcw>
    <xmx:LYh7Zco3WtCCht2bPIxcNj9y6Dy4l6hIlHE2s7RILuU2E4f7ES525Q>
    <xmx:LYh7ZdyLGIktnC7tRM1--jZX23KFULGj3K7hVn7uTcq16aPYG9qGcQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:56:44 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf: selftests: Add bpf_assert_if() and bpf_assert_with_if() macros
Date: Thu, 14 Dec 2023 15:56:26 -0700
Message-ID: <97ada80f3aaaeb16bf97e31a8fc204513b4fb6a9.1702594357.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702594357.git.dxu@dxuuu.xyz>
References: <cover.1702594357.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros are a temporary stop-gap until bpf exceptions support
unwinding acquired entities. Basically these macros act as if they take
a callback which only get executed if the assertion fails.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1386baf9ae4a..d63f415bef26 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -263,6 +263,17 @@ extern void bpf_throw(u64 cookie) __ksym;
  */
 #define bpf_assert(cond) if (!(cond)) bpf_throw(0);
 
+/* Description
+ *	Assert that a conditional expression is true. If false, runs code in the
+ *	body before throwing.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_if(cond) \
+	for (int ___i = 0, ___j = !!(cond); !(___j) && !___i; bpf_throw(0), ___i++)
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
@@ -272,6 +283,17 @@ extern void bpf_throw(u64 cookie) __ksym;
  */
 #define bpf_assert_with(cond, value) if (!(cond)) bpf_throw(value);
 
+/* Description
+ *	Assert that a conditional expression is true. If false, runs code in the
+ *	body before throwing.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the given value when the assertion fails.
+ */
+#define bpf_assert_with_if(cond, value) \
+	for (int ___i = 0, ___j = !!(cond); !(___j) && !___i; bpf_throw(value), ___i++)
+
 /* Description
  *	Assert that LHS is equal to RHS. This statement updates the known value
  *	of LHS during verification. Note that RHS must be a constant value, and
-- 
2.42.1


