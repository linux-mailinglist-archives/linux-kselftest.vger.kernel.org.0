Return-Path: <linux-kselftest+bounces-24727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD766A15163
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5B21693EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7554964F;
	Fri, 17 Jan 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="ao96/Hmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CC35968;
	Fri, 17 Jan 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123320; cv=none; b=Mdgfa94bM95Sc6vUBB+hWTR4cQHv1a2xC6e5M+KNrudQKZ/NokdB4mUSpJaeOz69/q1GAlIAvvXhYxwuAfH8gK2jGnYZaJayENL4SDCzhgU1Jry7M1BRbqFOoLedbf8WqyT9FiHX35ptzK9W8duR/gNDPplNGbtS9RjU0iMhf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123320; c=relaxed/simple;
	bh=SchB+c2hMhcWnD510+6n34YKTHOVJ4nmQf/tY/QHnng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Te0PmKFkmXwvi7FlKPlz9gU5BRA2BEvJ3HezhSgP/ytoWEGa8YarajPn1CSH8P90MvfD7BuAWWCDwGGCOOrKVynJcZgs0Snp2W257ZWb7TkxxTid19G91YDzRxqLuHCR2iSSWF8tE2EYJRBIcVMp8sn1Naz427See9ym4sdDHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=ao96/Hmj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737123297; x=1737728097; i=ps.report@gmx.net;
	bh=SchB+c2hMhcWnD510+6n34YKTHOVJ4nmQf/tY/QHnng=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ao96/HmjcZ5WDlIHOT9TMMOxmqvaw2TUrfOIJwDf9Q9CYmQE1eqQaXDa1nFvcRy9
	 HCggfM3CVN2B7/cA0r5vqb32LuQGXQ4QjNqaLjdPdxILxi6AGQuMhXRYuKuMZI0mu
	 9RCGHae2/AX3kIvqziJmHajsAnoF4TYJh6Tg1g20F+ohjt9uEA0ItSnugvFIlLxZS
	 3uBTSDt7BExKrAeOeiPkn5scWH29cKoeUx27RQAH6TjahlFIRNbOeRIzCddRXFOBE
	 1MY+uloY1k0Eg4C+DjzARefxTJZ+OEEp53Ty48//DV/y/VlKuqt8csntoeFWYSIMG
	 Z5Eip+ZLY8eFHCbATA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.138]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1tTtWE3TVK-0166yt; Fri, 17
 Jan 2025 15:14:56 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1 1/3] selftests: pidfd: add missing sys/mount.h include in pidfd_fdinfo_test.c
Date: Fri, 17 Jan 2025 15:14:48 +0100
Message-ID: <20250117141450.691272-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:phF5BX9v+Z8ppWP91OUsXOlJygukYyDBouwMRwFRwrGq+pdDpIo
 KfdCScbM75PwnTNg3EHrdlqHr74PTdOE6F2tXdjkFYzKaLnHmQXpkBoheI2qK5iOeC+45nV
 iMME+qrCQfdSIutbALDxB2yhp48G+MCbqJm6gX66g4Vc0Cl8WB3wH5uFrGVqSTz1lLRezFS
 S1iRLItWG/mc5QRQ4eErA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S1TeltAZSO0=;zdLWvSoIIeGgvNeXdLANe5OXzsT
 XIPZUqu8h8AmXcBcZeovciYQT/ovRErLfSDizs/FKQl51TDe3nL7M/as/dBGcOvMVqbcRicf7
 HLajJDP+qIL/pfVAu83LDYiBzNhNLc7P+WEWAOhA0N8aQFcpzkPTEHchq16LDIEGuND+PEJl2
 U9oJ46TovPY8ZKjlRwtjCp4h5gDBVAPKshgJ1ufE/HZHVqDG+DNlFVKWO1Jvy0e12ZA89pYT1
 fz4XiMzDl3jn0LaaELDBS8Se7SiRyI0v1OuZWpIbtXo93OOZcaxy+LZxwmfYIl1346wRcGzu5
 qC8R7fgu1Xp3oiggJLcnkUPULnxYsZTQkl5bJHUFsZkj1DW1Qbg9fTKvQ9f2jApJNbMeiEknD
 qBNPrHeFAgh1ONFcCrVYqyb0rOaN4furZUGDdAplofgKtXi6KCL1UcAIemuW0VkAw3vZugDT/
 qhcKMV4+mHMpq01cWayi9P9moZpm+jMJfBk752vfsMLP+Sqkq4HmEOBW1bhjycmhrbuJMOo9q
 8hewFlRpMAKJWDSWJRYN6NWqOg34JsUxo5pMZ9Yvgh2PRZsiD2obATWoAFeGeYNxjSP7nWS4J
 dYJxf6+3yxVNX1rWtvqFWpph+BUc73mFJQSivqYNvL3yJ3yWwgknM4TUEJ6/UA2OQg2bfqDYp
 TmLhN0JSN2FkwTMx4885J79QMc8JDj5vvF1ajkZ2t3y1RE4Rqv207ibRIo/CSI7qSCDVIByQZ
 zxR2VBomALi+aivz4SvxUu0SntP+eSwHX2WRlOmajeyxoyMFK2hgJO7URzkDuBXDCwXS5tI/h
 7Ccj4BpfvRxughXaBAtfR+uYKGGQ+bcfG13NP3bHTQr03LymmvrY/vH0o/pL2/zYNbpo8yrQe
 QbLuNQh1ckVJEkYSh5DcGYxy/OE3UHk0o4Oap7BsGkwpR7Cka+5fHEKVDY0iLlZ2qL+Jmx8U0
 IF+CiS6MgDXHjJ0tGGEa2SMNwC70KregmgsgcXZNy8s3oCpcvC7EnP9itKX4rfwH/tTqrxs/l
 /sFkHLr4aluypsr+fjV6H+7dgAQqqPU6ICyq9Uk9kEzs1hXSRptEMKr18HfqL6MRQPJheyWR2
 WMML385aS3CGiAELfv81u1SQ6FJ572II3JfVum23NCVutwX7HkxZ08JjjcSgQsefn4NTD/Vs+
 pOEAZXNicGABiIMpbbQV1JJwvo8Y9eQmEATsNawL9fw==

Rml4IGNvbXBpbGUgb24gb3BlblNVU0UgVHVtYmxld2VlZCAoZ2NjLTE0LjIuMSwgZ2xpYmMtMi40
MCk6CiAgLSBhZGQgbWlzc2luZyBzeXMvbW91bnQuaCBpbmNsdWRlCgpGaXhlczoKCiAgcGlkZmRf
ZmRpbmZvX3Rlc3QuYzogSW4gZnVuY3Rpb24g4oCYY2hpbGRfZmRpbmZvX25zcGlkX3Rlc3TigJk6
CiAgcGlkZmRfZmRpbmZvX3Rlc3QuYzoyMzA6MTM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiDigJhtb3VudOKAmSBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KICAgIDIzMCB8ICAgICAgICAgciA9IG1vdW50KE5VTEwsICIvIiwgTlVMTCwgTVNfUkVDIHwg
TVNfUFJJVkFURSwgMCk7CiAgICAgICAgfCAgICAgICAgICAgICBefn5+fgoKU2lnbmVkLW9mZi1i
eTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bp
ZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9w
aWRmZF9mZGluZm9fdGVzdC5jCmluZGV4IGYwNjJhOTg2ZTM4Mi4uZjcxOGFhYzc1MDY4IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGluZm9fdGVzdC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMK
QEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxzeXNjYWxsLmg+CiAjaW5jbHVkZSA8c3lzL3dh
aXQuaD4KICNpbmNsdWRlIDxzeXMvbW1hbi5oPgorI2luY2x1ZGUgPHN5cy9tb3VudC5oPgogCiAj
aW5jbHVkZSAicGlkZmQuaCIKICNpbmNsdWRlICIuLi9rc2VsZnRlc3QuaCIKLS0gCjIuNDcuMQoK

