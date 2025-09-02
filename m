Return-Path: <linux-kselftest+bounces-40665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C1B410FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4016E1B25416
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55D2EA737;
	Tue,  2 Sep 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t/JPApAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92975274B51;
	Tue,  2 Sep 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857139; cv=none; b=pakNyNti7z78TTwSIQAgC1KRM1U+vmSGlspZMEzDjpoYmSRCT9V1EuiFACRlTdSS/IJOUSJIGGDJbgjiBT/YVuS7nHb5qJpmevWwGENddcKbfDZqixBVOe1r0HGsG5BE7I4fTuDjJj5NEXTIoeQM8T5Wbc1X6/nbTsq+CP8M0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857139; c=relaxed/simple;
	bh=ZjfMK8QZbixBUlyogLCkmEo4BQhthsjlCcfthR+K4KI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=sn8hoSkb0qUeo0LZU7uNxpsei7j2sX0oahqqdsy++PQ7+GmA11yFUXyXadV1ZFjw0++3uGRu5x4HxrOqvmiFiwWc1/iWLuCq9X8QFIbswL+qlSumiaRLZ3Mq+UOwsg/6VY9cFhRwXXx86p0uwlbKFUHRuAhDCd+RxKsFsV6YSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t/JPApAg; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756856827;
	bh=DMkppThHn8ys5maql7WSO6foFFp8w5MlTRBuShBDSkM=;
	h=From:To:Cc:Subject:Date;
	b=t/JPApAgeoeLraDTlLrwW9u3TE/d5zaApneQysmtoSCLry2YNfMq3SC8vyeiASHup
	 W5IrPC/5zwdNsy02wtRc6Ds6tOm1ehig30AsDayhzqjznD4IF0wDsrQkVhZfEhC0U7
	 IPTsYuWrAcotK1zwT7AOsC1tItmO03Ntqm5xNkUk=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id BC3A08C9; Wed, 03 Sep 2025 07:47:03 +0800
X-QQ-mid: xmsmtpt1756856823tyxiz5cbp
Message-ID: <tencent_DA8DB222AE19F40A9166AD5E5AA8A8BD4E0A@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqXGUtB1HZuLYzrmZuNEnK636uwvXP1k6iiZIm9JodsVl/5j6/va
	 5wrxtwxzjRfqt6CRBJVDkgwHP1gCRxHP3x6HyFQKpa8Une6EZGqEUXLVCBUEO1KJYrSQBcEy9E8A
	 tLk/htWv9xyfi58C0MKDuXqIlzmAtIw77ki7GZWHDbO4lUrfwqfqncqv96fUqTG10RLmV1XxsB12
	 Ft8V/tp/wKHXkiszYFWvO+nKKDeUBB7NTcCJgAbnxX7UHjqp6I4yUZRp7No3U1NDSv+dOmxuSpM4
	 jF34pG0aeZ9DdbEhvtZn8ier7Luzz/jt9+0FhYS35UitFVNzChDUlFDUHXpHTg/vKS1WCG2IXhNB
	 ei0ZJimUIhzDfViQzkts800ZOjx6vUxhnC6QiSTFiAaHhO4/EyQE8RMl8HneBr72iB/+XjyfQ2F4
	 irlnHBPmHYqdhu4WlcKEUh5NPHdLpFX78Bc9CSy8ns17j4afK7DGZiSWyXlXMZsDldG4N1Ji1+ds
	 KOKK+GXvS12AxX5AYhuaiF7e7ljFrcR5rgU5HQ/f7UX36mGiJ61G73r1QAc0iHx2TkvliGGQU++3
	 b2hJfVIS/X1WH2VM+0fFMzVwtNwKCgSZgA0L7zfb2i66Ugvb2rQN+iRprHBUpmSwNj68Lr25MB/U
	 gJsoZEaNpILpHqy3GW2A5ICXBfKRjLfpqwLWMqhoaZAxbmFgrka9qCW9dkaDuF/ixV6b+KctOmR4
	 e0KuHnprMUt++PoXG2aHLoorSw+mQ+DUHhgGXvPxuHwv9FXYrYyMxMx9xQ+HlNKy3BA6urta3v3u
	 IqoqZB4ii+eeb2lrSsHjF4+tRFdaUXFNtwlN3s5/+mp16QtUUYjegFmgYUtV0OsWJfwdRRdT+4Kz
	 k2MRFZNR51TiNmuuxl4z6oy2+Amz9wEwFD4KXtQsslQbS3//4OTde8qbQ4FfVh+H7sUdzqqXr8aS
	 nYk1ai6JwcAFQqnqLPJdKTlihK2m3NMyWOdzvcD2aexA9So3H+o9v+7v3oW0ZWcvM9cYWsL2dBFU
	 VHSQkCsQBwjD280JsVaIdTDnFo1CZa4mkliuT0Fg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Rong Tao <rtoax@foxmail.com>
To: yonghong.song@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
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
Subject: [PATCH bpf-next v4 0/2] bpf: Add kfunc bpf_strcasecmp()
Date: Wed,  3 Sep 2025 07:46:33 +0800
X-OQ-MSGID: <cover.1756856613.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfunc already support bpf_strcmp, this patchset introduce bpf_strcasecmp
and add some selftests.

Rong Tao (2):
  bpf: add bpf_strcasecmp kfunc
  selftests/bpf: Test kfunc bpf_strcasecmp

 kernel/bpf/helpers.c                          | 68 +++++++++++++------
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  5 ++
 5 files changed, 61 insertions(+), 20 deletions(-)

---
v4: __bpf_strcasecmp should be static function;
v3: Update prog_tests/string_kfuncs.c for "strcasecmp";
    https://lore.kernel.org/lkml/tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com/
v2: Remove __ign prefix from __bpf_strcasecmp and add E2BIG failure test;
    https://lore.kernel.org/lkml/tencent_8646158457D4511C447C833B21B3ACF6CB07@qq.com/
v1: https://lore.kernel.org/lkml/tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com/
-- 
2.51.0


