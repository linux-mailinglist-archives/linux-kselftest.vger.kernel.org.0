Return-Path: <linux-kselftest+bounces-24564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434EA12131
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0473AC531
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC11DB151;
	Wed, 15 Jan 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Tv5fi4JJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2B20AF7F;
	Wed, 15 Jan 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938372; cv=none; b=YQfgPuCIgl0xgMwMOJ9Yi7tbw0r5zvUHBjTVRz2PRjzRtAJAf53u3IGrkSgG2Gbb6fiS7u6OIlhka+T5BDwGAQwtFH4WrTtsLkTS/l4k0rxTO3r9uNDnwT8VKaz12SCijvgjfTXDS9+vmpZyQ3UlH+EpnNYsXYx8Kyfvrp96CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938372; c=relaxed/simple;
	bh=b52HVgPYSUNIcSDkfRPpdklnQwe5jZHyTnnrnqgr64I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9Y73tv58PdLMlVMYwRMc2pYm76l7Pvx+cnku9G400F/RwkIDU4iizj6OI/Dii1ZHttleE2Tbww1XlzbrlI51fR4G9mqvW2TusGR08ZK9GI/zzQkBwV54HvLcewYP5Wvqk+oCsMciN+yW+lFT/YpZ1mitX7Es2Bcn3MIdBVNDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Tv5fi4JJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736938364; x=1737543164; i=ps.report@gmx.net;
	bh=b52HVgPYSUNIcSDkfRPpdklnQwe5jZHyTnnrnqgr64I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tv5fi4JJk08TNV1Gn9L3JOAVnWOd6t2H/k4SlIHF53icPH+cKJI3adZQeQRFX1fl
	 oMNmUBK7CiqLkzO8/CHJGynuBZFFv9Lfnm7gpWlX3PObVN3wVaDYRhqNVbuZgPy1q
	 3T7hNqVUM18QgXDxfIwF2fmvLvz7rJMNS6GOnwnRCboQPghcG7OmxuSlD1B80dWSp
	 1POWDustupM81izDJvv4ST34yvyz16x7NOALlCe/byS2mTQ8ndQC3/9a8YdxMy+QS
	 FLwGvWWSTndA3AiJnn9Dg7gAqspDszu+uUNpWUAvb89rl1M0N6DF43ZRF33B3vHeG
	 tMVV3unRn1BCOtjkMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1tsh3Z1DPR-00Wgc2; Wed, 15
 Jan 2025 11:52:44 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1 3/3] selftests: pid_namespace: add missing sys/mount.h include in pid_max.c
Date: Wed, 15 Jan 2025 11:52:11 +0100
Message-ID: <20250115105211.390370-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115105211.390370-1-ps.report@gmx.net>
References: <20250115105211.390370-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:/STygH3V3deu60mGkNqvSvDEgdxySbNyLdJidGZPjmxlUWXbMgK
 1X5pFhR/BwLYItDD3sgR52ANp1PBWGLkCnI7r0nPEsWLlrv/+x5lAsc2zsr8JGmeLzhEBP6
 1tagUg1lyjZQUVNEKLLOndkEgBGdAbzepI7M57aSnHLckUTqb6Du+3kxoEBRShsr/MjD1Ii
 qK44mdzuLgvnILc5BmDJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QsywIUToccs=;x4PMqwlcdqj0Heb/NOM7mBZF0Sx
 UU1mIP+A7VkUhb7f+M4n0vXOpgodzOt9XeOBbsbHod1ae6bsX9g3ecahJ2ekXjLa5348E0Tgo
 CmptGzpjYjjaPfyH39Ot3oJBkRrUNbRCmEd8lm6pq2FCW4DMxU0XnBBTLP2kkNv1EeYotxZ0z
 afXztCp9jj0fiXoqtn2t6D/SZ8rCQhJyky+AkhNpVKzL2gpILHcWqYLSZ94TML/lkmsPlCN/f
 /bgdrMWOZ0rgbGDuuXzwgbWcaSz7VStr1yxJcx1ods9mw2yayxOEbF7eug/CsY1fwUJ5LpKE+
 hsfYt0ROInNuYXnAVsjcO+SYi5SVszGC3yCJD8kJnaTe69UKrCvsF97pnkAWeDO/mv/3+Zez0
 vYErYDl0KVED+QQ8mE8f+RhYb+6I9lgWWTxPzNAu1xXA2KBl3dnLBNjsNiRlBKrGki9B4ilUo
 riBAYlc2Ve2XMaYdxjgMGIJ0iPMByoQhJjdG+SpXm900hXMLJu5xogqldZoU3QapnFkGlNIx0
 pwrkppQvVTfesPMXCld9TqXWyPYDFSQSuPdRm/y/BHPa0rKjK4E+rmkaaigEFfXuL71t8l2zS
 4D7SDxEeXG9VTNv9ihUpu3nPGB2m6jnwsHbudjdVit2A81Q5j3v2DiqR49POqfm+paUCBBb+5
 yP8tGBtHV6H4TUexU8pU8URcJ0oxqZcPey63GbnyfIquzg5wMP0UjTJVzSqYAg1W/kevyNVZ6
 Fr5eiwm5Sr+7zeV9gE9hqyuKDWMcdR2GSvIMHHxFNyb1LFLqgy9aYUo1UHKfi+6jU9rKrr4D1
 Ah0qQG7CskR9qZCTkH5P9PtmPSoPBkEK22RgrzZPklcAHTkQvQzTSIJ8W/0mUNlZhneTh5wwo
 0hlExVy2guAUz16lmzjnow0i+y3PuxyuQjrswdnt+uxzBgID2VACg+x7crhOjIaLFLuhOmfzX
 nLwy7an0+6bU/p4TMZnGZhRoJB8s+v2+2MaTQ53kmxZQ6H4XYJ2Mt+kAjtRPRSet6iveqCUsP
 M+EFg+Cs3yLv3cKvs/ECRwhOq0z6AOd6jvs0RaM2y+jzGP+ww6osREKHssZuUkbWsGaJxp6Y1
 YORDD41POzWz8TeNRcHYBr3BVcXo4X

Rml4IGNvbXBpbGUgb24gb3BlblNVU0UgVHVtYmxld2VlZCAoZ2NjLTE0LjIuMSwgZ2xpYmMtMi40
MCk6CiAgLSBhZGQgbWlzc2luZyBzeXMvbW91bnQuaCBpbmNsdWRlCgpGaXhlczoKCiAgcGlkX21h
eC5jOiBJbiBmdW5jdGlvbiDigJhwaWRfbWF4X2Ni4oCZOgogIHBpZF9tYXguYzo0MjoxNTogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmG1vdW504oCZIFstV2ltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgIDQyIHwgICAgICAgICByZXQgPSBtb3VudCgi
IiwgIi8iLCBOVUxMLCBNU19QUklWQVRFIHwgTVNfUkVDLCAwKTsKICAgICAgICB8ICAgICAgICAg
ICAgICAgXn5+fn4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214
Lm5ldD4KLS0tCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRfbmFtZXNwYWNlL3BpZF9tYXgu
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkX25hbWVzcGFjZS9waWRfbWF4LmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9waWRfbmFtZXNwYWNlL3BpZF9tYXguYwppbmRleCA1MWM0MTRmYWFiYjAu
Ljk2ZjI3NGYwNTgyYiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkX25h
bWVzcGFjZS9waWRfbWF4LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkX25hbWVz
cGFjZS9waWRfbWF4LmMKQEAgLTEwLDYgKzEwLDcgQEAKICNpbmNsdWRlIDxzdGRsaWIuaD4KICNp
bmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxzeXNjYWxsLmg+CisjaW5jbHVkZSA8c3lzL21v
dW50Lmg+CiAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KIAogI2luY2x1ZGUgIi4uL2tzZWxmdGVzdF9o
YXJuZXNzLmgiCi0tIAoyLjQ3LjEKCg==

