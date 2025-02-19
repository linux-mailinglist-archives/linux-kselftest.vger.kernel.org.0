Return-Path: <linux-kselftest+bounces-26942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B7A3B5CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC893BC350
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3441E9B0F;
	Wed, 19 Feb 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="qGTX6pwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB051E7C25;
	Wed, 19 Feb 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954742; cv=none; b=e/rv25bJEABkkOVTzxzXkUdzjnZeQ4BLs8EopHsAbekdO4MEq4XjK5DcDDVHCOZYrutrMZaWZHnuRt/fdDsFbm2o1GdIErnlMIZZ9XCDLYE1kcsWhAntBfr3fO4sV7zp7ZpPskpPnQEqGfuGd+Qe9SOnvQ1r7knpkTdR68JB0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954742; c=relaxed/simple;
	bh=JXTeytykjZDxlJKs0JESY6a1L3ZB81ADACooI6J7FkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWoIQAsBYjpkjOQVNdwIPW0FQpi7vTMk8bNjuABMqMkxPtfISNXsHqS/5oOvZS34bmsuwSpWMx68HPQO9N+2/P7eJ5sy67YN8KLNux8VH6Sq4SZMKpfgkt/VQ7LD4f+SIR0mEvK4u631pHngS81hPHIm95oR+ixFkNM9qiNFjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=qGTX6pwd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954734; x=1740559534; i=ps.report@gmx.net;
	bh=JXTeytykjZDxlJKs0JESY6a1L3ZB81ADACooI6J7FkI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qGTX6pwdpyWB8TNz8m2xGCKVa/wkrX0htlB//YQam2m9o90G5/rJLXGtSpvD+0qg
	 DHm173haz7HA1gx+ya7ZVwEcUKpFmAWB8NwWaWLtZ9HwOJ4OAnhjEwR+5dhe07OIs
	 hseqix8gDumoB0VO3zYBoEoTlS6gcIwC494dOil6KSTzmT1IbuP+WJoqMO0IkyvoN
	 zwYLxMdmGjul43uVwLPofJtu07e3P6SvRCXoidbjEd0wo5QZdaUqNh3idhqW4zUTN
	 Wo5n9pRsjqitSzA78Mgv8dcvVtP5w0tcf9wiuSJfgwHk3rBljQsGbEHuB//ZSlC4P
	 ZUviAVQBo0RH03qqxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1tLsoa13j4-015MnY; Wed, 19
 Feb 2025 09:45:34 +0100
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
	Peter Seiderer <ps.report@gmx.net>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v6 2/7] net: pktgen: enable 'param=value' parsing
Date: Wed, 19 Feb 2025 09:45:22 +0100
Message-ID: <20250219084527.20488-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219084527.20488-1-ps.report@gmx.net>
References: <20250219084527.20488-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qtFBHre5bAlwBkb9c89w7fySFqvS3OOLaPLPg3HyIWWq/hqtVi1
 5Rle4P13Il24Gl3vy7+UDPCrK3CSPRQQS+wtzyQN6FFDHGaI2DtinuGjGIA9CZgM7N1yq2y
 htFOw/vnxvVyW88KHOR5Lui9nMgc5BIwJ5BY8r3hakIlQQTpFigTjsg2JCftF+eqfSOOewE
 kHuJt9PXDSdq4M3154brA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fWKiy5NIOGg=;KUGRcY8BWENVHi/+DRhv5YjxSbS
 8107Lt45t1NXZ5NEhZ7BEqZakf+uOPok5wpM962WlNi8lt7dNfO9Kx692MQuGW4shYPeTVuUB
 FKI6LFPTJY7yH9QIxTOAORv+eLeJuFmaoAKZZh9i7Q10T5Bg7yjhugMZoEGYw7aV6CYGSAUNc
 1HDQNORxh/xc/PUM4DkbnpeVGICthdplU/W7hEVVN3cS6xt6kwqOEvS+DSXC4JVQR13N+yKkq
 LcE7bJLHf41tzttKf0psYsb9K8VstxmXtQxMxgFGdKCqYuZctx6BBZdPz9FPk0Kq5nz1oV5it
 VCxQJzIRxjk9o6NcweMwgrtAfDdIEk0gTOerCbo6dppoL1nWDhl9fHZdTB8Eq87zhN/KGZGiY
 tLtnahGYedfhYC9WyHZbkJfNQSb8VgoFIvnOuM9CwJYzSBk8nD6662a8nrDCf2Hdka12aaYo5
 nAdGze3VTiMpnV/tUca/XLLk+q31jkSab/jl5RFa8AJ5eO8Fn28maIn0575MpUXBq3OmrLuuV
 8MG6WsdhizffQu9hbGur27Sc0554VswnhCaEOvYX4w1IvdrT5V61+AmtI5uCFJ66MGsmnon5Y
 Co8NY7dr3WFqloj1kWLk3wH+Gb7Onq7DAEG9nasBFCoi7OYWjPMH1emZKWsE9bWd6ojP8lngO
 cuQMVvIYw1dt7QmgKr6z5B0WWX2DO8rbQISvfVldY6clEFN0bfRidINVX0OcgEhajAmgKPUJJ
 6VGitGbg3W3eyCUvKM35cpHsS+ivaBot2D0Z0LviEcj8L8Zt2Suud6VDz08RypvgLeAuB/K4G
 z9dLrMgK1cwaRG2G9ikW9j8E48GB/BZM6mbEiPmpty+hafJNh0wLeLNz65DgBhJZNmQ6drO8e
 ou12b94ELn9oT4bPhdpuD6hBqM+uCVslf6tJcRRv+Lk417dOCArYjxbhx7G5rXewzSQWvYOff
 kRftIBDtumZ8b4NHtRDJfg5RNKh5uR5sawCGXCbb76s02ftOUK5qxw/CDOJgt6LWAz0AdHR3l
 1yz0v6P7rKuNuNOtSFKRZbZZZPoSvtNRPMhja/IBvaoR0US8TOy6UzR2zd4nKjwAtmbKznhHc
 46ot2ALWFCl/CrC6phAisie6FR5exB7joI1uIDa9Dpx/9dOIhuO2AuhBDhNiBnVREF/nbb3xA
 aLXg57JE1V2ck1VakI6YerdkeZCQIj5l5wme/w1bZnXOzJoMD1iEk0WikENrBdVUrcb2rZNyK
 oOa9cJp8Pdt5aatj/+jdzWDxXFHDHr3aUEfD+Hfk5m8ibvkqcUvhZGI47RKivSeIh9PuetJ8R
 +ZC7Ab/a+I+cX/PPAB/YZHJbAt//y9suWewEJ7AvD1BL6IEBcU04XdCiT/4pOWvnJEdbFxpUv
 5bbclxbtzz2DJpUZqv6CxOhL14Ja4GOFvkROifyGuCPhnFKVCXpoX67WBn

RW5hYmxlIG1vcmUgZmxleGlibGUgcGFyYW1ldGVycyBzeW50YXgsIGFsbG93aW5nICdwYXJhbT12
YWx1ZScgaW4KYWRkaXRpb24gdG8gdGhlIGFscmVhZHkgc3VwcG9ydGVkICdwYXJhbSB2YWx1ZScg
cGF0dGVybiAoYWRkaXRpb25hbAp0aGlzIGdpdmVzIHRoZSBza2lwcGluZyAnPScgaW4gY291bnRf
dHJhaWxfY2hhcnMoKSBhIHB1cnBvc2UpLgoKVGVzdGVkIHdpdGg6CgoJJCBlY2hvICJtaW5fcGt0
X3NpemUgOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXpl
PTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZSA9OTk5
IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXplPSA5OTkiID4g
L3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPSA5OTkiID4gL3By
b2MvbmV0L3BrdGdlbi9sb1xAMAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJl
cG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3Jn
PgotLS0KQ2hhbmdlcyB2NSAtPiB2NgogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5n
ZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNoc2V0IGludG8gcGFydCBpL2lpIChzdWdnZXN0
ZWQgYnkgU2ltb24gSG9ybWFuKQoKQ2hhbmdlcyB2MyAtPiB2NDoKICAtIHJlcGhyYXNlIGNvbW1p
dCBtZXNzYWdlIChzdWdnZXN0ZWQgYnkgUGFvbG8gQWJlbmkpCgpDaGFuZ2VzIHYyIC0+IHYzOgog
IC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MjoKICAtIG5vIGNoYW5nZXMKLS0tCiBuZXQv
Y29yZS9wa3RnZW4uYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA0OTZh
YTE2NzczZTcuLjRmOGVjNmM5YmVkNCAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysr
IGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTgyMyw2ICs4MjMsNyBAQCBzdGF0aWMgaW50IHN0cm5f
bGVuKGNvbnN0IGNoYXIgX191c2VyICogdXNlcl9idWZmZXIsIHVuc2lnbmVkIGludCBtYXhsZW4p
CiAJCWNhc2UgJ1xyJzoKIAkJY2FzZSAnXHQnOgogCQljYXNlICcgJzoKKwkJY2FzZSAnPSc6CiAJ
CQlnb3RvIGRvbmVfc3RyOwogCQlkZWZhdWx0OgogCQkJYnJlYWs7Ci0tIAoyLjQ4LjEKCg==

