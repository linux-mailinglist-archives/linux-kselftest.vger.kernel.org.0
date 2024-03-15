Return-Path: <linux-kselftest+bounces-6357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445887CF3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C061C2280F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075173E468;
	Fri, 15 Mar 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsfcneb+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8C3D98E;
	Fri, 15 Mar 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513895; cv=none; b=V58nruOjKnbU6zOgz0YPrucBlEstF0h2T5dC67f0Z7nJK9afXmrRihKYpNf0/PhE12dFhScawRVee1LdIFxTdPgZ7TXSqDRHF/W8S1mMyIOABVR4F1xY8IQTEP35XIQQqIlMnsFAunF5z/grUCrClhUjNYMYoInTZNdn59vn4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513895; c=relaxed/simple;
	bh=pz9UPHIhjuioBSALFwsu3RbtJ4LI8q55dYQ9cq39NYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onIiQpfNKPmMXRGHnLF6WFLsJ/6FKruBRMClkKQTBOxuyS3ToB7tkwcGrDHSGOmH+wB5s0DtvbsuqZvv2osv7eaAYgKfSeQlLHnXbSHBxsw/VtI1gdJNIdIdOXLZbDpM8STrmee0cpZTihx2HFfM/UwncyLDLk6XfQIQV6saWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsfcneb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA6DC43609;
	Fri, 15 Mar 2024 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513895;
	bh=pz9UPHIhjuioBSALFwsu3RbtJ4LI8q55dYQ9cq39NYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vsfcneb+GRbkDzs4fcHCgbYkwF3IEXRVaFuqq827DTW9SAeb9QBZW+gJIChC6dxz6
	 bPYloV/LAYe+1M0A2XCSU2rOakA8lL69iWvS3WsUNBVhHjYT341D1ZvpkJ9IPbN63S
	 mPty90JAEGDPnMMLEM689zBuxQMkoM8k5zKWcDs7yQsfk2rn8ZTmsBwF9ve//AHU6k
	 qfpSX5crE9s1K59wobt2XD8uELm+1ZVm1P6bP3xB1ijCUChwKldBs16SL2so2TfmCl
	 dplJ/HdvkkMtE2q38RrOEDSOPX0tdGXvitFBbdq3GQ73Oz1kIcxibDXmdI/cyo4/EN
	 SQx80W/Oz6OLA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:44:40 +0100
Subject: [PATCH v4 3/7] selftests/hid: add KASAN to the VM tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-3-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=620;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pz9UPHIhjuioBSALFwsu3RbtJ4LI8q55dYQ9cq39NYA=;
 b=47C81U4y5iw3hxTvaF68SSNG4+RtTfaUBYWWl2t1emxM6sB4YZsDd1cH4US4864vx0SJ0te5J
 ZXnkEblM+1mCcdutJkWq+wsdJ2q/DPugifB1Y2H6ssG8Ir/350Q8wYx
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It's always a good idea to have KASAN in tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v4

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
2.44.0


