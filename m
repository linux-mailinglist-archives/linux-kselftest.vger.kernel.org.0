Return-Path: <linux-kselftest+bounces-14310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DE93DFB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE3282043
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606617E47B;
	Sat, 27 Jul 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sILSI/xs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDC17E472;
	Sat, 27 Jul 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722091107; cv=none; b=UgE7GW8Jz0oPIWrWP27TYWH+suxn/k1koDUyifylxXjwcK2O8WuBzHwyZ/5BajQIlcXYP2nQfkmolcrHGAp55Iir9iUMLUFq6p61r5Bj6t69vLHQeMp34eFL03oLmJU/QE/23kgNv7aw2iiKKmgmfC/dH2ur2Tj8oVnbyoVQX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722091107; c=relaxed/simple;
	bh=BuQnJEKimLr7PDWyAhIdp0NXAS0BxBy3n41aIcbgrsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZoiXL33/j8r3NvSuA0S07RKAFhwhE6+855V2nOjIrhMasc23MDvZS6H/wbbBmsyHNeDpPYVOTRMy6Lvv21RSkEUACyKiSY5jeOJAWshzx0I1RA4LPuHopchs8wzG3ZcT7+ZuTvKA5TNfZaL74cMUK5gBrkAWI1KteNCNDKl8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sILSI/xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F980C4AF0B;
	Sat, 27 Jul 2024 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722091107;
	bh=BuQnJEKimLr7PDWyAhIdp0NXAS0BxBy3n41aIcbgrsc=;
	h=From:To:Cc:Subject:Date:From;
	b=sILSI/xsszUp04OfnBZODO+KZYeFxbcUPyD0C6rUz/Rhu/49+YjPITUWIKmaXuyoP
	 mWlU6BSQY3jQiSQ6mPnTMVDsy2KOWGUGfeaHHFXNLwjQJSvcDwIlltuzDfJCEBrLzv
	 3ADRrsJqUdu3MtHrAJitI8oFn7tNQfVFVttZ9Nx6WJpNVHEzUqZ8fckn6YchUATAul
	 NTeVW4fF/WU4BYcy6Xk7U3oXTxqe5nZV4W42GoQD5yqd7881P+wtAGekply1SrBBqk
	 Krbno9RM3zPcDmG2G50k6eEuOvP7SmRo9lGVlZLd/D/OqqpM7S0HtCczLFcOMH21hT
	 ebiC/JC3AWH2A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 0/2] selftests: harness: refactor __constructor_order
Date: Sat, 27 Jul 2024 23:37:35 +0900
Message-ID: <20240727143816.1808657-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series refactors __constructor_order because
__constructor_order_last() is unneeded.

No code change since v1.
I reworded "reverse-order" to "backward-order" in commit description.


Masahiro Yamada (2):
  selftests: harness: remove unneeded __constructor_order_last()
  selftests: harness: rename __constructor_order for clarification

 .../drivers/s390x/uvdevice/test_uvdevice.c     |  6 ------
 tools/testing/selftests/hid/hid_bpf.c          |  6 ------
 tools/testing/selftests/kselftest_harness.h    | 18 ++++--------------
 tools/testing/selftests/rtc/rtctest.c          |  7 -------
 4 files changed, 4 insertions(+), 33 deletions(-)

-- 
2.43.0


