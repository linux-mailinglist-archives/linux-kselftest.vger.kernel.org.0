Return-Path: <linux-kselftest+bounces-3676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A486383FBB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3205C1F21C8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7667DD2F0;
	Mon, 29 Jan 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Sp/P9ZFJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toSTS5fI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A0D515;
	Mon, 29 Jan 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491464; cv=none; b=k7nF5f0u5nzgQc4LyZsEGJ0r62sZaaPT6e04HS1OQEP0xoCS1OCgJhCCM43IkXVmWHNt+qDt5z0g4URljhVjn8dwM0kxgBEqzU1Yg8O4Lg1fqHBO7Nrk9FWwB865n09YrOaBZiYVvZyGZtowuwj/U/n/Bj1TnorL4M8UEAiVLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491464; c=relaxed/simple;
	bh=kQEe3sxHRS25R01Huae1wLO1VdyUa7hma2vI+TmJQuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=exqo8w9XMcTruA7bYtaIu9paCGKyTt8AILpdfuy4KCx/c1TKaqn/3151u44By+F2Jc5rM+IQbQ7gU+HZHVDhAVhfaMep8Rq6YmN9KM0qi4BQ+fUHTKxBEOckf7uD7NoqtuA1KiEN6+STIyWhCBKebAsmhLArA8IUCA61Qv/uYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Sp/P9ZFJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toSTS5fI; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9954E3200ABB;
	Sun, 28 Jan 2024 20:24:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 28 Jan 2024 20:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1706491459; x=1706577859; bh=UASoXhX4PTY3QDklhg97M
	HiJ1GxNYruI0l1hSTsM1IQ=; b=Sp/P9ZFJkQIEHfcvNH4pxlWQcJTVOu3NARJrb
	QU0vlJmpM4nohk3iDeQEo/Uuk1NtXdRe9TzUPuLVLZwihZ2nMpR1SaHdOFYdPeJr
	zyyOLJHWmQv7wFfiklp11U0lm+k97FGE2W734EFNtr2HA1l0VDW6mjxCvSRt+cv2
	Jz2l6Sncb1dytEyLi2GEvXGQ8aodcH4vddVYUfcqlyPdggq74hiSUGoZkM9NARAL
	grjLqJgJe/RfIVPH+Fxq0yr0PsDuKjMfahjqvFerrDmJPT3klD1YJQ4f8hx5H2my
	hiIvvxRm3KeWyQfKVuh8g6GeiEUxoxvfTxyklE1gB/WGbzKRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706491459; x=1706577859; bh=UASoXhX4PTY3QDklhg97MHiJ1GxN
	YruI0l1hSTsM1IQ=; b=toSTS5fIeqME+j6fCgQl7sXWi2TbaNbgcEYAv/FUpQCi
	ojINcUtIFRCemYQFFUCw9KMt6lbUje5JxS9ppMq3UONrtbV910ynaSb71OoD+HR9
	MskHaANtEDpX/5ZHaX0tU+6v3twRjwEl6fh9aWg3iJaQzjt41KBNs7OnsV5nkZUf
	9Gf8uMy5g2kYfJaAOtwMMELWFbjTIAF79KrHS0lZ5rR+jWV+YW/iswh8WhA3oYi3
	iEncy2kWOFdpaGrtvFoMJ0nG9xynxVzhhwcsP7Sl9yD5qe/JLLH1f5gG1Q8jBSZK
	VLY7S7aDF71kp6q6/qfmcapQgHbU65dYB5oHy/DKQw==
X-ME-Sender: <xms:Qv62ZdjsQSYWbTlKTLSEqMzzeUVWsCelA_UpwRQPxO1pbHXMb9VtDw>
    <xme:Qv62ZSAE8nNVyjnQSVjZrXsWge5dcgOFoP5891x2RYn4LJanvbYpqiM9jdLBQJ1P_
    62DAc7xuFK7DVJxvA>
X-ME-Received: <xmr:Qv62ZdHZoFIBgCnLzmLD3S7ZxEXX2DyqstxMiOMW2vy6EYK23Jj0mlqAdYVy07CZeSgvbkqi47Kp8joEaorqp0d-f4OR9TxCKAtWAHu_Fqg1hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffegjeduheelgfdtudekie
    ejgfegheehjefgieejveevteeiveeukefgheekjeenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Qv62ZSTwvQHw03v-B2f1Bae6pN4fJB-3Qs8pCTG6pZi9wB0IlqrCtg>
    <xmx:Qv62ZaxbEzm0olNmw8XT6u5Hgp2K4DFcOrRD_Mo1YqOS2_wuDmHRhA>
    <xmx:Qv62ZY4sEd0MomoUDEp5-KW2l923PFpKcPYCM2P57eJmietEO2dsGA>
    <xmx:Q_62Zfhc89QQ1-UiKEW_sidKxkm0BIiyi8TNBF-Dz_bCocdzYVhFcg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 20:24:17 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-trace-kernel@vger.kernel.org,
	coreteam@netfilter.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netfilter-devel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Date: Sun, 28 Jan 2024 18:24:05 -0700
Message-ID: <cover.1706491398.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=== Description ===

This is a bpf-treewide change that annotates all kfuncs as such inside
.BTF_ids. This annotation eventually allows us to automatically generate
kfunc prototypes from bpftool.

We store this metadata inside a yet-unused flags field inside struct
btf_id_set8 (thanks Kumar!). pahole will be taught where to look.

More details about the full chain of events are available in commit 3's
description.

The accompanying pahole and bpftool changes can be viewed
here on these "frozen" branches [0][1].

[0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
[1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed

=== Changelog ===

Changes from v3:
* Rebase to bpf-next and add missing annotation on new kfunc

Changes from v2:
* Only WARN() for vmlinux kfuncs

Changes from v1:
* Move WARN_ON() up a call level
* Also return error when kfunc set is not properly tagged
* Use BTF_KFUNCS_START/END instead of flags
* Rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS

Daniel Xu (3):
  bpf: btf: Support flags for BTF_SET8 sets
  bpf: btf: Add BTF_KFUNCS_START/END macro pair
  bpf: treewide: Annotate BPF kfuncs in BTF

 Documentation/bpf/kfuncs.rst                  |  8 +++----
 drivers/hid/bpf/hid_bpf_dispatch.c            |  8 +++----
 fs/verity/measure.c                           |  4 ++--
 include/linux/btf_ids.h                       | 21 +++++++++++++++----
 kernel/bpf/btf.c                              |  8 +++++++
 kernel/bpf/cpumask.c                          |  4 ++--
 kernel/bpf/helpers.c                          |  8 +++----
 kernel/bpf/map_iter.c                         |  4 ++--
 kernel/cgroup/rstat.c                         |  4 ++--
 kernel/trace/bpf_trace.c                      |  8 +++----
 net/bpf/test_run.c                            |  8 +++----
 net/core/filter.c                             | 20 +++++++++---------
 net/core/xdp.c                                |  4 ++--
 net/ipv4/bpf_tcp_ca.c                         |  4 ++--
 net/ipv4/fou_bpf.c                            |  4 ++--
 net/ipv4/tcp_bbr.c                            |  4 ++--
 net/ipv4/tcp_cubic.c                          |  4 ++--
 net/ipv4/tcp_dctcp.c                          |  4 ++--
 net/netfilter/nf_conntrack_bpf.c              |  4 ++--
 net/netfilter/nf_nat_bpf.c                    |  4 ++--
 net/xfrm/xfrm_interface_bpf.c                 |  4 ++--
 net/xfrm/xfrm_state_bpf.c                     |  4 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 +++----
 23 files changed, 87 insertions(+), 66 deletions(-)

-- 
2.42.1


