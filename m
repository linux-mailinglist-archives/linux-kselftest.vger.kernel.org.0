Return-Path: <linux-kselftest+bounces-40318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66756B3C0DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212D17B0E71
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C78327798;
	Fri, 29 Aug 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QgY5OlkN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E9101DE;
	Fri, 29 Aug 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485341; cv=none; b=WyXSOY5ZTDsRo42hT2i6riBChyoMqj2+ppVbsCqJrerhst4xjU8mTWu2DXbowFcwYeTHcMeUr4CnXcHzY4WwfJ+rcIU/wv78V8nNtMjG1vCp7BrxMptYs9EBQLsKRDv9Z+FXjVE5Dthb/P+PWEbWb8uYsbKTEKegn8Hn/pfBiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485341; c=relaxed/simple;
	bh=avsdQAMCmTpxO9RaTShWc6B8/8TxZU+wQEr0gTzhhCY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TgKLfyvod/LuAgjsbqq/EVTVtSDjnfg5ytfQS5I0bOgf776jr4Do5RL18+eaHnZCsbo1AWzG03OAXnCdgYnSiDud/Nd+dwbgLMSROeTQKN8u/OAuQ60CW0NWR82t2C1A9a1yK5peyjllkTUY0u78RaigFvfIqZbBIt7yV4wCi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QgY5OlkN; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756485027;
	bh=Mq3b9/nym6/6DESK+e6R9ME6Y/BHiTYd9Ad87/o6mr4=;
	h=From:To:Cc:Subject:Date;
	b=QgY5OlkNHcl0xkwhvxjQT5iRMV6rHamPcbBpKO0pnPA8Vkds0GWzfxC9qY5T1NiMI
	 kF/MCu8s3kstNeQDMDkVZWzO3HR0W2ijvOTFafh3xkMD/IrGerRTuD87Uz61on+BYt
	 5bjZr9jWnQYvq2SM1mP8r6QHdctcMUVe4Cawui6U=
Received: from f41.lan ([240e:305:1bb6:7c10:7285:c2ff:fe86:1af4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 79781438; Sat, 30 Aug 2025 00:30:23 +0800
X-QQ-mid: xmsmtpt1756485023t8ndhyyre
Message-ID: <tencent_E72A37AF03A3B18853066E421B5969976208@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSGokr56ObDQiMcHSG6y/gjR1giVFmEfQAyv6IS4Qg4XXGf0cHOA
	 vkrkQM2YmxgrFnMe/x6NL0iBJq6XTGJIuO0giTdGCJBnfiSVQhJ6Tn3KptNmFW3AlUGzvO7qm3Az
	 08NnGGZHBUPnDYzZ2q5wvv2dpg1aP8Mo9MgVv+1y40iibPozBxs78YhpkdxM4HwT0dwBZFC9GQwX
	 iVmGgrFah3/h0nkXmBXDs355cNGFC6TNywSldJxVnKR26sdytItJkPxBxuYTRu4IF98+2o0bfSRh
	 BECyn4JyybBZoB+uO6aEUCXzRUwVDTGuls6pgdbgbakmlqSnIkWroG9GfoL4J5ESpFeak89+IsVa
	 waTQIhGiGuVSMZu5AwQDYFn1MN4Y+8BpdPTmzAD7Y7FHAs1pwS3nS+vaMzCK6xyCjVW0KrX4MU3x
	 u7l4fU2Z884QR1DNrUhXEZA92+JGN0OT4Y3rJZ6CvduQUELdv3tEjx9LfpyyJxAViy8GbIJzyM9J
	 cNQQ5W7hLdF+8FoAw8Lwg86abRSlJrheS7/CyrL7vVpV1W1RZnw3/HJoDKa230VTm/z/Pw0h8Q4W
	 PZgwtMjsqZxW4o7iFxjei/epmfoUplxQvOyZO8oP4y4QplbWaLwCTltSEGvWKDa5YSCU5ML/jKB2
	 e2bGjPSMb5PdQDn/8NuetZAfKTn2PYE4NtDCvcrP1g6XZTc2MszTfDJOsyLqyNHH9x28Yw5YF1Pf
	 wDziQZOuK4edUl48mfRdWDraTAZhtmEOB6RlHAcgCHjeAL3BAU0JVcm4REOLlGZtu1pBfswu9GDP
	 OMEOtLNv3jsvIwLQro39G5iUJt9PDlQwaNZ8YYjNg/ybP+3Uv8H7VlDBEiFBhqj7rCGd++0UeCjY
	 yVOvts+TTyyihVPUiZ0OG9wpFlWGZvtoJCadT/TIyCJS66bExFI2ON/pFCUFCgdgBpdJ5quye5d5
	 RV6BrlvRWsz2GqB2L1N8T/jpy3kPnizc2Za9o7EznfS4N6y3RQ9R9qroW6j6SvFeHrv8L/ytEbr2
	 w4LHkS9b6rJZFmebpD+QaN54yUsPO63/HYZN8uv85CluA0oFb1
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v5 0/2] Fix bpf_strnstr len error
Date: Sat, 30 Aug 2025 00:30:16 +0800
X-OQ-MSGID: <cover.1756484762.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Fix bpf_strnstr() wrong 'len' parameter, bpf_strnstr("open", "open", 4)
should return 0 instead of -ENOENT. And fix a more general case when s2
is a suffix of the first len characters of s1.

Rong Tao (2):
  bpf/helpers: bpf_strnstr: Exact match length
  selftests/bpf: Add tests for bpf_strnstr

 kernel/bpf/helpers.c                                     | 9 ++++++++-
 .../testing/selftests/bpf/progs/string_kfuncs_success.c  | 8 ++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

---
v5: Add more commit message and change the patch 0001's comment;
v4: Add comment and more selftests;
    https://lore.kernel.org/all/tencent_CBD40091C14056E8298BE3725B65EE156405@qq.com/
v3: Fix selftests/bpf error in v2, sorry about that;
    https://lore.kernel.org/lkml/tencent_69BD268FBA201219240B51661D5E96A8D80A@qq.com/
v2: Follow Andrii Nakryiko's advise, fix the 'wrong fix';
    https://lore.kernel.org/lkml/tencent_DF4DA83EEBFB9246E5E3357BB40911CCA005@qq.com/
v1: https://lore.kernel.org/lkml/tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com/
-- 
2.51.0


