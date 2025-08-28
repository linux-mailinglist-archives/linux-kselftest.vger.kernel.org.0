Return-Path: <linux-kselftest+bounces-40168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C41B39B22
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D288E360892
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60130C60A;
	Thu, 28 Aug 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZzptfstS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357721D3EE;
	Thu, 28 Aug 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379519; cv=none; b=ocVqWE6E/7rrNOIOFQCxCuAiRImtNYarJZO9DTiSc1Jnzlleo5sP4bzSQZiD2YJUw3tQU/gajOBAdNAYAmat9YOExhDpwhTRWN3z5Gu+5IHvI21hyYQZhn4nKvCPoXHCZLTJXTIgTsMDLhzk8onib8kEWY8zyYzmnUrodHdR/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379519; c=relaxed/simple;
	bh=NPxx/ey2tXKTRsHU1SUjCV4ADg0ZhVLhJz4gBqVmG84=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NsmECoFov+aKCDnfxRqnMht6m35ygctPP0+ls9edOxSks5zw7dZ/C/tDSw/jhLFmkLctqHn1dFUlqgJSYYYbvizm0f2jsx6kzzbV/4l+Iml8Sj571C39fewNfhYWE+Obc0xhD9s6sXZQHMDQFUYhFD0rni0YNOCjd0di6seSwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZzptfstS; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756379205;
	bh=BcVs6RdP2pVoj2tAX1f2LpjoEbkeuktpGmJZui03meQ=;
	h=From:To:Cc:Subject:Date;
	b=ZzptfstStfO6aAXbq/AEKgn2QZUMn7vegJfZY4yz3ZnNphXtntqy9vxSbQzHtu0cm
	 akJFo2ITBYBmWF2mtaPur9QTN0sOzDq6uNpg1q7j0ZuUl57Ogr3o+l6oMqHtJV9h9E
	 BqkyrpzRcPWfF6Nh51HDScp5Y0oFHYlNsCDBNiJg=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 1A914CDB; Thu, 28 Aug 2025 19:06:41 +0800
X-QQ-mid: xmsmtpt1756379201tzxa3pir2
Message-ID: <tencent_8B8FEE211A1A0009ED67855EA2AAECBDE20A@qq.com>
X-QQ-XMAILINFO: NAtipnnbTPeaZftIKjm/rzpYqAps5Bu6jLMD80w4t5M+CXEhckWTv5o7AbnL5p
	 f5CsG5CvIxXXyvoyRAsTNAzbjXQOoWeDfqffw4Q3JtCd79pHyEm3+D5XoKRS6KT+qCsmRLY89iL0
	 ArrfBA6oCIdFkGbrtfqMu08UGDGSPC7TS5RLtGl4vQLXdSAdWytqFL3WjjQZU9ntQfWlXlYNiiR9
	 j67iuVdY07/ASW5afemUwE3hhVP+jhUOogECLpggCetT0Q9slMFHRfHECLVZVSmH+dfRdyzu58Ml
	 meB3+u9Z7nXKJ7syeEhK887iWP90QUwOa6ffsDJXLGimxZku8iZ01cQbOpoAMt0eCVI1cJIbc5gi
	 NW8FrPbT296tHhOpbZ2hGaG1gk3J3HuPXa2YfhdJ6yq4nVwJIXSD5ULEGcypmvkTRhTKsFKTHqDH
	 z+wpRb6S2YIjHj90ZSQFS+J1QsOQV3pNuQVkX0bphRazjurtvow1IjXOSpli3jTkpmYG0GtV5kDW
	 ofOSPo3bm/Z4dUyXtfMK4Wmn+5IAGSM3KG3NV7W6uzkYmZwedUWwk+2PlW/5BFw47GTzwskSuQ3M
	 TGl8yE+v1actqPHz34+anKqJK0Xawu3Eoo7bYAhjhR+JuTEAu0W79Hj7FdaZ1OcxvgsbescUqMP7
	 p3e2ZJPVCea942MWOGHlC6pc8BEfOoIud+VRlkdsJiPomGgKqlXrts93pH2V3nugxw1ib9p4w44o
	 +KdII4yjcnPKBHfCu2HnBlPfStYeIe1An+opThrqTgNTRKAKU+qhZDjEers24myxBDVynXrzSltk
	 hFB6nTQDVxd69SVy35fhY1amJdhqvQLBFqH/W4s5fEq0g+Xj/8IV9kerlU3afBmDgDC+an7VT4Nq
	 wYuq6yCoiC53QU5tL0e5s5XlYiQvidXE+ETysv+qo99yEXXFL58iyh7yb1hFgk7kD5+1Ltvc6MSG
	 UosnqVUWbuzcU3x594CDIjTOasoXEXnRq653xwTdURTV8q9RKV1SHheSlSJM8q52fAkhy0xXV9Ru
	 Kwkdj+fh/DdxQ/GKqs0gx/+1bZZGtWH+w+K8eyJUMv34SJDMFyDnJl9qsSXO8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	vmalik@redhat.com
Cc: Rong Tao <rtoax@foxmail.com>,
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
	Rong Tao <rongtao@cestc.cn>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 0/2] Fix bpf_strnstr len error
Date: Thu, 28 Aug 2025 19:06:26 +0800
X-OQ-MSGID: <cover.1756378974.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bpf_strnstr() wrong 'len' parameter, bpf_strnstr("open", "open", 4)
should return 0 instead of -ENOENT.

Rong Tao (2):
  bpf/helpers: bpf_strnstr: Exact match length
  selftests/bpf: Add tests for bpf_strnstr

 kernel/bpf/helpers.c                                      | 4 +++-
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

---
v3: Fix selftests/bpf error in v2, sorry about that;
v2: Follow Andrii Nakryiko's advise, fix the 'wrong fix';
    https://lore.kernel.org/lkml/tencent_DF4DA83EEBFB9246E5E3357BB40911CCA005@qq.com/
v1: https://lore.kernel.org/lkml/tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com/
-- 
2.51.0


