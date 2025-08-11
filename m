Return-Path: <linux-kselftest+bounces-38665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD04B201C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF993A888C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD9C2DBF73;
	Mon, 11 Aug 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbFrEYmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70592DBF49;
	Mon, 11 Aug 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900726; cv=none; b=iCaViPhkUj/8c5CNKomBzT4Nl3xKLxCdlpQIvzO9uIDx+wL5u6/Sq6IbSyownsMQYoeW3vdHAa7sOuxqDUB8Loo4b+SJEOCjt7vSU2EnLExKDDBtHBnK248r26aSqJjSgD6Z/tp1S+Ewbfzna6qYHZK0KMRpdb8bWVCyvnH0GP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900726; c=relaxed/simple;
	bh=des5gSYvIeWFIzyviF7RIfsIRBzUROyPbzK9Qkkyq3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DkSn05xaNxSm7R61PPRDnPcnj4kESbqlzXSWVrGXcaXtxXTz1yLDJ3o2jIEI7OxUISq19PgLIbPvY0pmpXm/A/DFy6u65uRjDn8gDA/YAgRsSb6oHBrM/lStxDof46NlSo7fQcbRqf7i9n3iO98hyF4hsYMh75y414xg7zcan/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbFrEYmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E70C4CEED;
	Mon, 11 Aug 2025 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900725;
	bh=des5gSYvIeWFIzyviF7RIfsIRBzUROyPbzK9Qkkyq3c=;
	h=From:To:Cc:Subject:Date:From;
	b=SbFrEYmCbusOxHhswX9rm/y2f8AdNC8lOL9kP3zDmjaNi+5agTA2xAyM72DL53WKH
	 cj4bYvz87PtfgeyVmW0KDnbPJN+lCH8BCui77GbcJ21FdH7rP1DaHqmZuNEFuQDQRS
	 osrufcQ/DevLWz6blbySBuhwv67VpWIrBuH/mzILKrEqrDNRt047jJabg8rrN4a21k
	 AafiEr/hQXK/yFo+9A1o35POkuJTGuECzVCt6KrLvvrOL/ieEsE+YKTTmXJRdfrNF7
	 iTWETUxTLEoUKB2ilRlp0DGd3CZMEce8LgS4pKTYBS5YdGOot8b99ER0Mo763FBzZY
	 Qi8SodNQLMZ9A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] kho: fixes and cleanups
Date: Mon, 11 Aug 2025 11:25:07 +0300
Message-ID: <20250811082510.4154080-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These are small KHO and KHO test fixes and cleanups

Mike Rapoport (Microsoft) (3):
  kho: allow scratch areas with zero size
  lib/test_kho: fixes for error handling
  selftest/kho: update generation of initrd

 kernel/kexec_handover.c               |  7 +++-
 lib/test_kho.c                        | 52 +++++++++++++++++----------
 tools/testing/selftests/kho/init.c    | 13 +++----
 tools/testing/selftests/kho/vmtest.sh | 28 ++++++++-------
 4 files changed, 58 insertions(+), 42 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.47.2


