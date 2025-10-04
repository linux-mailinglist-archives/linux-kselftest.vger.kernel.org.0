Return-Path: <linux-kselftest+bounces-42757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD40BB8E1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B259189F855
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C141247293;
	Sat,  4 Oct 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="b8QNMx2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AC227B94;
	Sat,  4 Oct 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585053; cv=none; b=tQt9rzTD3kC8p1hwRCrsfEALGTVPskEKrFv5k6TZ1EwsDNu5H08k5eOt6lSL6cvhDv0NIz0jhLhg7tlXbfV/YYzrB8KapexxuoJxdSIhsNpVPc0s6tjZGr4gkd58OGAuR2vz53IK6GyE7u2wSti6UNkB4Skx0egcNUTEavFv9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585053; c=relaxed/simple;
	bh=EF/DaFNdmRdgTA/B9lDT+LF4lNVR8eezwp47iZbRseg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=l765lS4TgT/UZ3tvN6QKDtFbR+lrjwaDBbHVKX/frtfqbQNtbQpYL7zi1PfPTs2Ik+O7jrK/Io9rTH7KXHiKMnsRnLoQms69LLYbKWgbFTkC7wzG7nR9KyF6pcqFSeluWmd4pOKXmW2qLcE0a0lSJUEvr/PEJMWjtjRl+ChCFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=b8QNMx2u; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759585049;
	bh=LLVTB245xm+9TYKWIPsVXRurkjaMOVzY6AI7hV7uyPU=;
	h=From:To:Cc:Subject:Date;
	b=b8QNMx2uLqzXZ6g+uFYNDDsnwxqeu5f+ch9HpCcV26U3Tze/YPYp1CucUUS9zzVnI
	 gQu9Zfb04U19wPWgFV0SLqSqDvplhZt7CmBViVTv2Ctl4RbsQO/y7o/foymn9Flvlv
	 sVNw3nR4PVRf3NQtmBSX+YYZl5YAKZkOMZyR9Ku0=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 6EF33CFD; Sat, 04 Oct 2025 21:27:47 +0800
X-QQ-mid: xmsmtpt1759584467thk0j7w1v
Message-ID: <tencent_351115D4D7B2D105C452833621C9ACBECB07@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z6ZRnxGfX/JQyMeV5NdhDr1A4P5m3I67oqMbxkYJVpvm4wUImyr
	 9G8rfDfU7yWscpEGZb++QK6WSCuZ/toVEsqOAqF636bKnttN3cIRXcm8hrTuGTCpO3k1P2XHVkI6
	 1E4GXZJ//DGEcWZplardX3xNw8SJVH6tG4d3IFxPCmETTz+pzpTrif1fyFzfdcdC1tF4gl50+52r
	 7GUugQmTPDWIHdZphtxmV3nqRaMvU3kM0WRsaaucotBSt1bfIUu/wnvv1+8Cn25uVaUfKEDITn1c
	 iu8Ci8rUiYQLm5fR3bTfm4FTOeXx4n8iazLIAXGu5eca5kozyizFCDR0IXnun6XYPmF5roi2eAB+
	 zHO45ALQgEyMMWAWYfxjbCFxjxo6bPAasnt/3szj4Jpi6GRCUisK/bHLluuvohCtAk/oQjlpMOdT
	 mpUoQ0AEHOup5WQuOzi46B2BHjBorbZa54jvG4r5faMk5CpVzbtSGN69Uq0BbydRBKjODfSYLIAf
	 m2LSABQQrUL/f5IgGHViLjtk6B6BHyfwd5e0j1qu20AbycB7R7ltwkp0Xck0Q9mJP8aBVN5BNB6u
	 N5aMM2oLcFWSp+Y2r3XJrVApmNyFUb4SykvCAB55Fdu9uYw4jh35eDND3Mf7/AAizBczz7aIZAEb
	 gGCW8oEc+GhaDO5yL5Yw1CSS9ku3/Zef9940DmQb4us181lwVlmimmVYy5DNh3k8KHiT80DHjIWP
	 3xHQK10wW7RmvJfdPSmuqJj8BDvlw2k9+cK30FfHn9RKbZgjcRp+zYr6Nzl2C11Kw2yqmXE4ONGw
	 vb0ApCBBhWZJ6WMV5K9lucBq+cJZwnEeS96H7oM5lpS2byKbrvBOuFvPSUKWVqcsJhfQuu+XmORK
	 yUecyRb1Yz2L6hl+RYXy1PCfWSM9BbUBi6lFokxJiRvngs9O9kUxGN+UfbPQCmpQswcQ3kYKAAft
	 fNmjCxLDeR6/KeFsPkDo2mPM324cdEcwpXyiz6d2jCxRTyhLZiUVeZe3GVf8Pj
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH bpf-next 0/2] Add kfuncs bpf_strcasestr and bpf_strncasestr
Date: Sat,  4 Oct 2025 21:27:18 +0800
X-OQ-MSGID: <cover.1759584052.git.rongtao@cestc.cn>
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
2.51.0


