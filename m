Return-Path: <linux-kselftest+bounces-42798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F23BC00D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC933C0219
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5620010C;
	Tue,  7 Oct 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nXRZ5aT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1416F288;
	Tue,  7 Oct 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806005; cv=none; b=cjglv1hdmavwbEALVlHmV3ywx8Sg/bYQ2TiufrYfrqx+/82OxpeZEM9JfrmkQJJAtYtAmbN8K8k2PP3OckZz+W6v05PGr5uvpL688koOb+g6Ybe6MLxSUQr0WkvL1n41/hRiIvga3VyMPDJFSJ6C3ChLHVwhcwVF21U5eKHWORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806005; c=relaxed/simple;
	bh=/vlPcppKnGJ+lW+fcnPdTnUXgjsbxcARfgThppHSPsI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QH73Jj7hyFRdnA7X+yZVpOAuWf31trf8kwgrCmi3EPPxpKVUnV74TFwSHl6uzVSFHgb7Pv+xknf7zEbsdVZ5UQxcDPfaU0wT6dc4bli49wtmfJ86BIdWu0Kn4imhpflS8mbMnPUxVdL80mhviNsyEb+QCS2gRNhJSiAC0dfj/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nXRZ5aT/; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759805998;
	bh=HFlDB8BZr5BFQQSrOj+U3Shf7L1iVHMAKdZeBl2bj9k=;
	h=From:To:Cc:Subject:Date;
	b=nXRZ5aT/WPIk/fvBexoV74g2YZdB8nuF6HbBX5opc16cpzJITClxcF5PbxQhLd3s/
	 lr+HCEhQnAFrI1Pn9G4TdLRF23qzTPnFHSV09VEnCI4bm1LK2B724NRK3JqOUWOIM/
	 rbhHur79jU7FwCcrWVHYIlSccFPgn49OMUaddlVg=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id EF6A0012; Tue, 07 Oct 2025 10:59:54 +0800
X-QQ-mid: xmsmtpt1759805994t3ps3mief
Message-ID: <tencent_15BBCAE66BDD681D629FC197104C56D46506@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jzQXL55XH0cEBIDzApW4UBEbjjnudb84o3fzG5QGOgBuUG9NFcb
	 zF63ViWooPEgulZDkorwyR4Wb1ANIqqnABapVtOFBojHyOz6xn/A2lRjit9JR64pKWWXzeteMe4o
	 NN+lMXYUutxnXI+hh2ff48sQGM8bhXfYA3zcvnKPrr3AHtq+ZCwTuRY77bGbLTSnsQtPaHb/axOQ
	 zSR3vMvEaMwUbm2rVx6i47csjT31SpYN/pjD4y1fpfBbU+3R4Du+Po0ki0LlWAUK0Kp8/aRFup0g
	 m3PsaPw6oM6lO3Nro6gUd1yNZalDnm9CBjMi78cOTJODnuQfYITSUK0xKGcLCSB4KBrewVETJCS3
	 IN2bCmtUDZAcXDbPaeU1m41iRg4DfqLIzvk8IAPS4R6YxKK2OTm9GgOLmlmGHlNs7kuIKJF69exN
	 sfQm8Xxp7PJ2cgVjQzJQw72CD1gRFK5hXMHo8PMdILsCOGVhAricE7XVAz506JrIXIJ1Sct+F8YW
	 /X+wvi2vZhqxQ+H3gxhhYgQkfgeh7J3/XY9Z3RzCaMZ9YCPMmBqqLooql3ZOAwj7HCmL6eIRYMz/
	 POg2ghJzSmRyCmHu/gV6BSrYD4x6+af/kl1lFmkBK/WGDSW+EngjD8wmup2VvZLVYsw1aMb01Qba
	 CBh1y8PstBEA0ImjLV8g74qvkN62xmotpsB4dGdohJFYoINj9+AX6gktUIOuI8SJmRrs3L25RXYa
	 SUdmzXko9iz+MCOzsm2pG+7/hXBpis9pPPSAryNdz6rhdXK7yBz1Hnw1ebBWtaycwn7t2TjjviP7
	 +zM1W3I6epzQAEvxA+m8OzJy06RZZzcNqpnUkN42xyeWCEPuwvjj1imeXZeaopRk3kW4lF00faDx
	 rIFw/OPfov5k5TaqrVhOczzO9Q8WLqffs84VrKtVjEi64Y/rXCngkURXx7R6plaL+SKcW6MNENs5
	 BT1Nw3RygeL+Q7I87YMuzC9f/3m5IpTtF+88L6jZEGyIXKzlP8KStEcNG71tsmi+Idr/T6MCU7Wb
	 Tt/OKs0HNwIe9IeAFcc71lEShMzT0hl3P9f0LyFQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH bpf-next v3 0/2] Add kfuncs bpf_strcasestr and bpf_strncasestr
Date: Tue,  7 Oct 2025 10:59:27 +0800
X-OQ-MSGID: <cover.1759804822.git.rongtao@cestc.cn>
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

 kernel/bpf/helpers.c                          | 97 +++++++++++++++----
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 12 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         | 10 ++
 5 files changed, 102 insertions(+), 21 deletions(-)

--- 
v3: keep __bpf_strnstr() static and compress some tests.
v2: remove extra __bpf_kfunc and fix comment of bpf_strncasestr().
    https://lore.kernel.org/all/tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com/
v1: https://lore.kernel.org/all/tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com/
-- 
2.51.0


