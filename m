Return-Path: <linux-kselftest+bounces-5199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB085E359
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842531C2477C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25558615A;
	Wed, 21 Feb 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW2owCt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1898613F;
	Wed, 21 Feb 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532795; cv=none; b=e0RoCZMjFXdoxQZNMS6Ebop4eR7quDJ+/YzB1bpD40O6CGjVZojkzLPoy+v5tXzYljuTzXRE8Z8wyNegSAfZDQSdpAPsw4zWYPmiv3+SDEV9vBt7diGD0CKp6+YFDpHKm3G1KhNzo4lZQmqZvbz8EiqJRxiEdATuEEn5b3+jGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532795; c=relaxed/simple;
	bh=FSFPqOox8jy+6us2erHCBIcxyNaaYOx+aOuItwb5naM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwVSu1vfjQ3e0WV/cnjFGUqo/RQ2VHP7qvnNb3kdjKuUqrSyBjp3UeR4qrp2juYjKSsLcEMp7BWOJ36k0oH/k9Vw9N7UTdFzr+lUMV/iqYkAql5ES8vaooHo/wt3NAAVqZ2eYPKHSdGQvBmVRcshLRagwW08TJHLymbmoWu0keI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW2owCt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EB5C43601;
	Wed, 21 Feb 2024 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532795;
	bh=FSFPqOox8jy+6us2erHCBIcxyNaaYOx+aOuItwb5naM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tW2owCt+eidfjnZErOd6UZdf80iVKOoRCZ/dpzQwWJy1xOJOcoqzQ5M2+U03abqLS
	 2eYJR3BZOBKr9VzTln1c6qZwaWnNwrBvqXeSY1XkIkcnc0q5unKP2EUNZZN+zBOvPB
	 0LcbyYIfW7tD1JAFx3zAuyVej64OwUfsa71rjTLyDilvbFCF2ZHexpayVZuzw7lc2R
	 1eZcFuTqJDTYH060SXuE0kkhtyvnMivAglis0vt+AHEAFzY3QKQ+QjJjwyoffReJ1j
	 41aAHQu7U7zrmJ0mdBDUpcUm5LCUPw19sNQD1y2VApexlpnG0okzvqDGBVx4BpzLiY
	 mz++cAnGIipCA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:32 +0100
Subject: [PATCH RFC bpf-next v3 16/16] selftests/hid: add KASAN to the VM
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-16-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=600;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=FSFPqOox8jy+6us2erHCBIcxyNaaYOx+aOuItwb5naM=;
 b=os7H6Nw/gEfbbLdcePDV54UogZsbsOUmDrFyLvScf7QTRZCgWAui2Sw4Yz5yjwtlweqqb1KN/
 hafTD3+SoIdA8qt+8z4AB9K40VwVO0llfpGdqp5IY19Ibm1gvzmaQMQ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It's always a good idea to have KASAN in tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v3
---
 tools/testing/selftests/hid/config.common | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/config.common b/tools/testing/selftests/hid/config.common
index 0f456dbab62f..45b5570441ce 100644
--- a/tools/testing/selftests/hid/config.common
+++ b/tools/testing/selftests/hid/config.common
@@ -238,3 +238,4 @@ CONFIG_VLAN_8021Q=y
 CONFIG_XFRM_SUB_POLICY=y
 CONFIG_XFRM_USER=y
 CONFIG_ZEROPLUS_FF=y
+CONFIG_KASAN=y

-- 
2.43.0


