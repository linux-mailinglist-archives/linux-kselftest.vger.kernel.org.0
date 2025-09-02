Return-Path: <linux-kselftest+bounces-40503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E212B3F55C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3269F7B0740
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0582E2F04;
	Tue,  2 Sep 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="E6NELseP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F792D5955;
	Tue,  2 Sep 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794179; cv=none; b=Dgn0AQcHqcKpEmfvAO8na41yILzbbaIKvD72ITHEZoKvHwgYFZ1Cz1hwnrZ/MUC6TYHj5EPJrRGBqZHVrbIWzZ+nMFIfwaqeocyR/9XfWcoyH8U6/+4FHHTrZ6jZQclE6gbAV/GS49jMTk+43IiNxKW3j+XFfstE/9TSXpQ/Qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794179; c=relaxed/simple;
	bh=Ei9sWn49oM4R3NLDxpoOfJDeJR7HTa7HGiLk5MxpBf0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WzJb1LT3EYb+9smYo9ai21MP8/Ev5SuPnJH31Q18fWpmPDwavOBWlwC1SQT5aFOF3bThOC/svLXNa5ENmRMVIW2cSRMJQLwTmhfFjB8Z8vuiSXMQSRCqTdNFcFefqIKP7SS3FzMvAwPLdkZakqgx7slbbrDMdFDBekJttnXPq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=E6NELseP; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756793868;
	bh=UTyRQAVc+TtMaXhHeqrGih7kWbQXu1ktqJ5nXLrN7vs=;
	h=From:To:Cc:Subject:Date;
	b=E6NELsePDvQBaAilr/qb45nRHcZU/q5ez9G7L+NYC3iJOVswVeA7iS6YBHu1ll69g
	 89xQoWERafeYHVVaLVaO46sHHeI5H5S6ux1Yjur2OBT0NE+zqR/LF6/g1BRorz1acu
	 KWotTIhqcG9XwY6fczp5NRfmdQWAE7EDQ9HgbUwU=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 46BA7243; Tue, 02 Sep 2025 14:17:43 +0800
X-QQ-mid: xmsmtpt1756793863tea4lpras
Message-ID: <tencent_855CC6A884BDE28D8A21BA1B5408D567410A@qq.com>
X-QQ-XMAILINFO: N91PKLMQLILLuKwd4LvrC0ppjkxA7fIzXcrIswxlPS+AG/PbuxqI5u4FvntQMW
	 o/6hl9FCFQagEZ6+plFza7JerTIMpKz9DlVzR7oOG8G+ydEkRdlSqnJvGn3Xye24294WmOdLw+DX
	 0Jh01FX3sFDZQTdVmgK5a4zQ87kJyPbKtEW4HfK1CUZyphK9Vj0GWV3uOIY7DXCd1qja1BhYuLEm
	 wojeyyOXgTVbKZpfUAeid3nJ6h78SgHZKE5EnsFb+snOw+GedEV/z+AHf5vKHl2LFYGxjp5InnQm
	 UHlaL8z/qDFl+CY9Xe99P25HTNYwwFaG9HmYo2AjHRgnR4g4iFZmvsqL6FTmnDiwFRq50TffY9Ze
	 eFIYbXh5eMkAG+2FQ6MwszfHOShlCl/OB0Z8TwDN/GmOKdpgV89vOJISdbbv7fDNCAJ1NfnMSauu
	 eJ8lBrwwB/83YwVkGuUM4bqhhVTP5BG7UhAyqEmpuaF5vYXtH+LQwsud1JLEW8K7kzOExgV1M1vK
	 ge5NHWemaKkUfg+dtlmUNBkhU/FPfO/vdbdOAg8dSyYlrgtPonOiYuQm78IUBemwc6aIEBBpwKu9
	 zc0MzYtvTLOCicTxSN3BHTpz2CiJTv71UMZJ6Uab2f68nZvIQGr/kUI0T70UxxfrkYYlBOBr4/eO
	 xXJyivR4+5uwgcNFIE7KDMzu55BSiriKcPVvObANupGHD7mFZQLzHkwmrCN7s0N62NmZ8e1wMylN
	 sMqE5bXpi+H1pd/fEcu85QPPTUQ7e6YaXVr04TSDqvz5csS+4kTOmbZeeipAYB8jGWmYbFiQ3/Rf
	 Ll/YtsmXo5h6VyTO6Edx/mUBsirncF/0av8ir5woOBj6NqXeQoObb6eW+dWS6A2453LaFb4GjAHy
	 yQVjAYlya5c0fjut4aTEw0C3ySu5QIHuTYbanHHf/K0akozS/7S97IcS1VPu9OyJfzrC7ZprHBhM
	 50KvNqxZyjpjxCzyrn0AFeRBQE8JocUpMMwt6anQfmaG/iEqNlNjxn5LR6yi7bjZJ4b41fr+15sP
	 pUhR1q5y/arCe+m3qKzIBszfvjXUc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH bpf-next 0/2] bpf: Add kfunc bpf_strcasecmp()
Date: Tue,  2 Sep 2025 14:17:15 +0800
X-OQ-MSGID: <cover.1756793624.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Kfunc already support bpf_strcmp, this patchset introduce bpf_strcasecmp
and add some selftests.

Rong Tao (2):
  bpf: add bpf_strcasecmp kfunc
  selftests/bpf: Test kfunc bpf_strcasecmp

 kernel/bpf/helpers.c                          | 56 ++++++++++++++-----
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++
 .../bpf/progs/string_kfuncs_success.c         |  5 ++
 3 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.51.0


