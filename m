Return-Path: <linux-kselftest+bounces-42764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D660CBB8F37
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 17:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EF1189F807
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D9265CA6;
	Sat,  4 Oct 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rue4QxY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60C25A63D;
	Sat,  4 Oct 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759590015; cv=none; b=Q/0lzgj1Z6FFlfVa6KG2BlXriGVch5OCCXgwDfdfwxLmk6t5J+zJQFyNvwboT5dCH/KQfJVJ6f5hXxP/HINR63bHJWUE/ffzV3LP3xYqcyJxHnDhJTxXTiZCJiKNoOTpGiDYez2wdWxCUf823qcOTmPomrqFDN6JG+dBCSiZi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759590015; c=relaxed/simple;
	bh=QVLvGlKGENt5Oa1RDESsTcNXnOD/LO4z2+tZnMEGLzU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qLJi39yUlWti9FzLWk0BB9GAj7RfIDGTrNKMLsZLx+x/55SXY3csh4oKrUI0vrUgu/fFr7oIxpfXNkiLpcwpKJdJJSi/QZ+bv6IF1lLjbf+iOhvlmyqDfc8PgBfmEozVBuZytzG7aSRz9tfTQBbNgIy50BXkW/ougyJHySoxJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rue4QxY1; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759590001;
	bh=tn+YvF5nNWzUdFcTIZa4tTMNaGP57a1gNGPj26KqOM0=;
	h=From:To:Cc:Subject:Date;
	b=rue4QxY13aotxXJhp+BAIXKP/RXc5Eqf37r9w3f46bAHFPZnPhhziKTMw9f9FuYEL
	 MuJNnR0gqnu+o2PhO4Zcgx9i7I5vUAA05ov9VHQ6tQjZmGD6l8fu/t9NxcpDIFJpyJ
	 dbDHMRwMbx+1plLeoL4Y75MVm7BP6yZjWgg3SfxA=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id B9C95EF0; Sat, 04 Oct 2025 22:46:28 +0800
X-QQ-mid: xmsmtpt1759589188tarf5jxve
Message-ID: <tencent_6CF18825069C425759D597502A56AF85A308@qq.com>
X-QQ-XMAILINFO: Nwl7PuG5jlSkIQI2xkKGPz2sNzpTy/KxLxsIosdPU5PqjEzfCAToQ4duB/fmls
	 diPosV23DYr7mefP9mOuWiVqAZ7yDMhASS47YPPR7PNa85FX7yBwlvugoOsQJySZE9xTageyn9YT
	 ZuoTNL1oOajuUyIpa1sCVNmSdAHCUZmaHdqFShs9KgyIoWhOyABFh5e+jW41Djd7GBg/8+gApWPA
	 kZUV+iBDdFgQVQDnYAUtoozUeeMearRwA47Dt+8hALyjHutuWlDyj6nm6K3/1+X4uZ0k8duRIoFm
	 NoCtaRvxw5CC/h7wZsnn5mb7xunOCANifxknqfIV76wKrXZtYnhA/RsF+4Gw/Xfgs/bfo+z8cyIg
	 SO9+nzGbEGnAkuFd3pA7OrYVVNC4gQ/vApLwIczRm2GMymms76vd9/K2RTt8CJSTB+rcREMvHW86
	 fg5naIW8SESx4IezEEl2Y2AEnlekOyPqAvg8X4nii9J34EdW7xOYmhL9Kd3LrbpBpy+7/H/gdsuw
	 Lyv5GVqmYGi6XI3vtRz0SG4LN+zTGRNjsr2WIqC6sEng88Ca/b/3b/WJgNPAbh+1WQ1Fa1tBWE5F
	 2m3eeeyGbifCP8NsLH4n8aNKyE2BbRLC3dzbY8mQGaZ3cT8hUkqhk0Thf+p4174aUhMn1vW3Hp4T
	 UuR7fPWH2Gk+Ja8URLTb2EAFjEhGC1at7AVKXqGcOMOPH4PiumkZJuZ1EOar7LPpBkw1vTnN/Bt7
	 WjAp1mrnwJmEpPO3YBp08IqQs6ltdciQxwJ/NLJXlQ83pqsC6nJbJe+pAVlMJvjkpss9JKmHJHUi
	 i16dnqHTRmEP0dUQ+bad+fnx4eofkXyCrSB47X09egoKZBRc/yRLXFzt6bMYn8Nru1moBCfDI5Xm
	 G3x0dIYwkbzf00U1RmCWgztFxHz88Kt8GMaoQtQ01QQsMZDGkFrMkdPGDG2S+J7ebQ0hffgBb3uA
	 A0XAfr1JIMyQNXEWV391OuBPl8P/OXHppTl6NXjiBfJkHHU0KHluz7xGgJaHNksLAEUaVbWF9EH8
	 ZwREUD+fxfHPqj/XeCxxXt/T7DtPjkpUiso8OfUQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v2 0/2] Add kfuncs bpf_strcasestr and bpf_strncasestr
Date: Sat,  4 Oct 2025 22:45:59 +0800
X-OQ-MSGID: <cover.1759588929.git.rongtao@cestc.cn>
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

 kernel/bpf/helpers.c                          | 96 +++++++++++++++----
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 12 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         | 13 +++
 5 files changed, 104 insertions(+), 21 deletions(-)

-- 
v2: remove extra __bpf_kfunc and fix comment of bpf_strncasestr().
v1: https://lore.kernel.org/all/tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com/
-- 
2.51.0


