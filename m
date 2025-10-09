Return-Path: <linux-kselftest+bounces-42911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B5BC71AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 03:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD323C4D9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8272625;
	Thu,  9 Oct 2025 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="r/2K6Deg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1634BA53;
	Thu,  9 Oct 2025 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973204; cv=none; b=c6nCQEvVgMWFnPTD0rr7+TkJNJg+ymlD0VOgiZfByrOsEyHY6iXlOG2NyUGJ48u9JLntFdcVIfDU6XEVuU47gDCdq1qSov8YwQzAkmAwuUTIKSSJcjAsshCJnciksvOVLANipYU323imP6d4sKK+cwR4diUrKEOE1az86JZV3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973204; c=relaxed/simple;
	bh=od+p2h+WPuyYD4bu+R5S21ymZaC9WIzwwMLvE87Ix7w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aJv4AJPMwRWLfDH+Lmn44Lo6ESlYs/mN2AtRQN3ckeEHku0PwBuk5+cTW29owIC/dU0ESpGjkHywCJ5l5Jqzj5+UvP3ei6ZLw6uXINqsWwBTV14iDINCkdn7v82kXP3ny/O0CAMldvqeM2j/W7JnrIJMozLu1Uki+r+HfCJg1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=r/2K6Deg; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759972890;
	bh=E7k7rJ7e1uWJuLqvdpY6Hs4Luw7i8jwf/F7YvaxBUSM=;
	h=From:To:Cc:Subject:Date;
	b=r/2K6DegDVax8a30AudYpfcDM/JfKLAzrDYLCVIFVxjW40GRP+lr3pVCYK/p8R262
	 bfyeR53lY2TX/E1h4XSHomeNCUxwndAe8wtX8i47jShQTYXPQLsCzPV3f2InYZsaQ4
	 dWLxhumxfhAQdVtnt7AcrqdXsaU5HqS7Izez2pYQ=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 55A04824; Thu, 09 Oct 2025 09:21:26 +0800
X-QQ-mid: xmsmtpt1759972886t48db2vn0
Message-ID: <tencent_98ABC9680EA2A20198904316DAE5A84AD906@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6WXVltu3zxirWsnqkeZ5sZf9hnMWyZLUBSHh84hT0kw5rVGUASR
	 o606A1tGv+x7RH8yBbc09PnKNX4bko6iZscCREMi8tvrk/ni6TdFP2f5WzSaZr2VrWQDSh8gHtZf
	 gcCypgsd+Si7sRFIuZ8A+j8M66Biza0jyVxbznRR9EtvR5VrbqNOcJ3r9aaQOrS/DM1PtFgQLCO5
	 1qV8oo7tbCLAZ+xZR5nT+uMtwfeegDCox4zl29ODc1t1FwBfAwTfT6AEGa+2y1+CH5tVaCs1d0fJ
	 AOE6KddnYmbh65hUtbO3KdTyE97v3tR9mH//LwqfFtRXtVFajVCOfxkBRyO+FlOu3nSFYJdbsJqv
	 Fc0btGqxhD7tz+3/34ZYLh4j+aEpj9aKpsx1MNRPBM3H24gG1t1yCVoB2TXKvcR01IgZipdhgZNw
	 pIglgSkMHWfow4Sl0DdiTv6yGpQC52VHtnPkPvfX/SyaeL7owqHuGvCoD/GwIAi4NQYbpVy1qAo/
	 cux3Ryde7DdN9pcznyeDxwKnZvyOwAWCzS3qrmmbkFlkcTxDgAudr/moW2JGg5nAJYNuxEGt7JlO
	 5zrUFfvpuyph1Q4Zm7ELJLKFFzVXsS2TZik6TEX+mdJzURcIGd2S+tBc4/H8wioyu2P6pk94H+TS
	 HDxmt7TKG3Hr9TdKo0JtFuyl/FaKDToRPT2lLfAxWjZhuhoAexQxJDV68AHdWe0W9JLpt5ZzOPTO
	 25WWqxV5uFYmBVP6uRG48er/XOT/yzjfkVkRGFHQJ/6FXmThmnYGp2cFwYE7BkqUfHa+3DRMfLRV
	 NFhhBOUsbS/Yt/QqqsXAD3PxspbKuXAxGDeHVEddeiFjA2t629NE6T1b8ThsSpxtdqhYIFIT8as8
	 CirbMffI+uKaKjjItL1d6vlCU/r4zwXJz7+r0ctl+Z/GpRim97yZFouDs+ss0GXcX4gVu0q+p8+B
	 rW7q4c7Y5eLFJmJ8i9YprfXwvGu3rrQPUk/UiIULKQbWKjHjrUrtPYEEvCC+Q3sX+oJ+2B/iBWrn
	 R+OJ2+h/Iq4xmkyZFl08MYM02TYRbzNshC+qL7Y3Y8Iw0RpGFn
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v4 0/2] Add kfuncs bpf_strcasestr and bpf_strncasestr
Date: Thu,  9 Oct 2025 09:20:14 +0800
X-OQ-MSGID: <cover.1759972627.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add kfuncs bpf_strcasestr and bpf_strncasestr, which are extensions of
bpf_strstr and bpf_strnstr, suitable for more scenarios.

Rong Tao (2):
  bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
  selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs

 kernel/bpf/helpers.c                          | 98 +++++++++++++++----
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 12 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         | 10 ++
 5 files changed, 103 insertions(+), 21 deletions(-)

---
v4: Fix wrong comment.
v3: keep __bpf_strnstr() static and compress some tests.
    https://lore.kernel.org/lkml/tencent_6E59062E4249590597452A06AFCDA3098808@qq.com/
v2: remove extra __bpf_kfunc and fix comment of bpf_strncasestr().
    https://lore.kernel.org/all/tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com/
v1: https://lore.kernel.org/all/tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com/
-- 
2.51.0


