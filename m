Return-Path: <linux-kselftest+bounces-25157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE0A1C21E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071DE7A4709
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA38207DFB;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYt6Wnle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F019005D;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793456; cv=none; b=jZzsR/IVpU5TFP2ndtu9FFcXo/KoQfIXlmssno/Zl5octrpWMgiY+DIIdB+9L0TMLCF57pRqNPGyhNFWOTDns2Wrmn5+4Doty/wzaPSGkYxkTN1qGq3hxYVbimZEXRwx5Y/O9YBlwzE5HiMtu29TMDp0ahbflhXm07hePwo9eTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793456; c=relaxed/simple;
	bh=hTYJU8HfjlKdIevLGmzWkOa6/jkRNnZ81llqBTx0oas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NnNZOv22AKaSvK9B+wr3Zx6gVca/wxtS3mI+m7LMFIpzbi4+OAwyScseahTfBTirsr5ui32slDGmwp/q+2q3EAtlMbbeucFXp/BeT/iW1d0U6zKwFQPqVkynQ2vb2bWmL939+3U3onEhD0/uGLU/D+NZHXhWPt43AidbMuZsRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYt6Wnle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF5DC4CED6;
	Sat, 25 Jan 2025 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793456;
	bh=hTYJU8HfjlKdIevLGmzWkOa6/jkRNnZ81llqBTx0oas=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gYt6Wnlew1yXP8CkRurseo59VAIS7Wt3IWUJYwQikg2Rqviv60FrwVWmhAHrOL0UC
	 xJRuFxvgGogWsGxlKSVMQsJph3mnxGdzgx16RLDfDx+h5Dwodis1C4DAfOsNnk5i7G
	 X2I7vG2Ye49cUeUo5a/PftyjqZVhaH4BCTGrUzyvqHePsFT1D+YRUjMQXXdR6GeQwZ
	 EG6fstyENE1oV/x3KeIMzdJmBKAHw46o6Gma0E/VV3l3jIJ2bhDolNW/6nxiNcC/K1
	 HqCI6kpxcYW/g1zlGlgaWC/Lu6lMF2F5hrvH8LEeEo3OcdOM4fcm/N16827cdUL2iD
	 pdhZ8m47GYpoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D26C02182;
	Sat, 25 Jan 2025 08:24:15 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Subject: [PATCH 0/7] bpf: Add probe_read_{kernel,user}_dynptr and
 copy_from_user_dynptr
Date: Sat, 25 Jan 2025 16:23:35 +0800
Message-Id: <20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIeflGcC/x3MQQqAIBBA0avErBPUFKKrRITWWLNRGSOK6O5Jy
 7f4/4GCTFhgaB5gPKlQihWqbWDZXdxQ0FoNWmorlTbC5zCvd8wHz5mTR+G86bvFWhOUg5plxkD
 Xvxyn9/0AV9yrMmIAAAA=
X-Change-ID: 20250124-bpf_dynptr_probe-ab483c554f1a
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=hTYJU8HfjlKdIevLGmzWkOa6/jkRNnZ81llqBTx0oas=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlJ+h5PE5cEOfd260Q563RihUGWI2X8YoRdatI
 ccWSV2eoLSJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5SfoQAKCRBvO5jUL8bJ
 2GAAEACoZmnxJGr8tDW3HqH28VzCoRGdc6e7L7N4W8PmDwpBD+wCdZuaMpTeSq3GxMSVwqyqBdM
 WPSPRj8r9dq7Azm+HWqX5PT4Mu/30JVHteVGRcNOgwoHDl1ks/+QXjffhgwMzeeBrcjVD5AIiOW
 rmAZj0bN0I0lFvz0SL+Luj/3OwG/Ubl2fErsFXqhhXfP05b3+QPeenivg7TlPovmrcQgCX3JDaW
 b0lNHKSxiOIROA0GMEV+2MVgg56nyghMLqdNg2VrSJFlt233sHfAPFxCWuDH9aVJJHFzO7RZikq
 YQEikxvAE8Iv0TqKF4Auu+pCrMf6iTiA+SSsN/Mla2V2Zi+kB6aMiKSFZP1/5eCPGaG2S30jxoj
 wfXvoLvRb8nqrJt3u7YIR8rSh6+WvCbVqQQhnuwV1oifeP1Jp88zwgT7PoI5CAH8R51jCcBOWe0
 YEUYsXGQD0ozA/zEkMwCLfQV6b2ryEQIS1Y7ATn5V3MopC2PWz8RbUs4l1A0rORAr1tXt5Ai73J
 AakLq64RhXZeUOHHEosmVtUJFVuUE6cwJo0Ah/MU6lm4GGUFkRTkRk4dTRjFZmqUvjJagWT1fD0
 cSEdYa4PvELsV2+CJQ8gmrRSs4dgBhqbhAukurJ0psCMWTAOgMprL3QNywIaHzMQ7lZUtRjwlss
 94stLfcRYkT6+Vg==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

This series introduce the dynptr counterpart of the
bpf_probe_read_{kernel,user} helpers and bpf_copy_from_user helper.

These helpers are helpful for reading variable-length data from kernel
memory into dynptr without going through an intermediate buffer.

Link: https://lore.kernel.org/bpf/MEYP282MB2312CFCE5F7712FDE313215AC64D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
Levi Zim (7):
      bpf: Implement bpf_probe_read_kernel_dynptr helper
      bpf: Implement bpf_probe_read_user_dynptr helper
      bpf: Implement bpf_copy_from_user_dynptr helper
      tools headers UAPI: Update tools's copy of bpf.h header
      selftests/bpf: probe_read_kernel_dynptr test
      selftests/bpf: probe_read_user_dynptr test
      selftests/bpf: copy_from_user_dynptr test

 include/linux/bpf.h                                |   3 +
 include/uapi/linux/bpf.h                           |  49 ++++++++++
 kernel/bpf/helpers.c                               |  53 ++++++++++-
 kernel/trace/bpf_trace.c                           |  72 ++++++++++++++
 tools/include/uapi/linux/bpf.h                     |  49 ++++++++++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |  45 ++++++++-
 tools/testing/selftests/bpf/progs/dynptr_success.c | 106 +++++++++++++++++++++
 7 files changed, 374 insertions(+), 3 deletions(-)
---
base-commit: d0d106a2bd21499901299160744e5fe9f4c83ddb
change-id: 20250124-bpf_dynptr_probe-ab483c554f1a

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



