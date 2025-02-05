Return-Path: <linux-kselftest+bounces-25830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F86A28B43
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B633A7464
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F27083F;
	Wed,  5 Feb 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Q2v/3yWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64079195;
	Wed,  5 Feb 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761125; cv=none; b=o4SQ/BYoPR7aCBOewDvkzxusBYN47rN7qwu8XjCh6pGR9MSUvbzGoB/uTlWGEDoEh75cSKlv8Hv66zGMmCP/l3gm5C48Op7xloFvWy2r42iv/xNH39Nqv49HHAtQy40H+sDBV5kDZ25U/jt65liaJ3a7Ot3JDPyoKjXmYIcftOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761125; c=relaxed/simple;
	bh=TQmLPWR3TtQPrHPZJzINpdSovUG7XNvIayKaJVzgEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRry7S0ZjTl3oVOm4SXBAdNuYp/8WX9XkqSpE8MO2LQARws4jamfsxVVeXIUoEanwIO1cpWezL/uHcISkd1sRyEUrOvAJP6NdH8/7BCzAkLSsrokce73THBOnOBaOM5wme7vzlcy3PCjxiu47qOuat7M5XCJPCzzq8ePMTAYzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Q2v/3yWZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761121; x=1739365921; i=ps.report@gmx.net;
	bh=TQmLPWR3TtQPrHPZJzINpdSovUG7XNvIayKaJVzgEtE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q2v/3yWZl8FK1TO1XADf8nNhKcEEq8hPeyv2hKhcZH99yLb2nH+cbWtEaLUPDH2S
	 99KJmfKBf85D9aLTrV1HPy9IL0nep2zmsVYDiT/J/Am6r6UjtZTunibTZCio8IoWY
	 I26ZMB1ZQZd6j7bkkikl4Hbb9jnRs2h3V/ZKqnKUIdsbT+8xMd0T+P8S1+78SIYxM
	 pXMP1sv20oooihl7uDs+JRDWcNDipI0V41TmRRB1XnLEzq7djoMXb1JF7cNSepYJZ
	 Wt6WCFdfY5IoYiLTCH8tUoD8qKaVWqg0dVs1wulOCkU//U3UU8yXieZRemJwDnMOn
	 2mOeEpxyXm6JUotjAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1t9uof1Rbo-00gApC; Wed, 05
 Feb 2025 14:12:01 +0100
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
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v4 02/17] net: pktgen: enable 'param=value' parsing
Date: Wed,  5 Feb 2025 14:11:38 +0100
Message-ID: <20250205131153.476278-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:SdIEwppqEOqXW3lmk/nWVqop6vQkgpQ/Uje5XF7UyIq0ttSrqHc
 5uiigrG8yxfpHIFIdhA9bSbOXAsqJ7glJIJVl024qCtwM6e3zQPmDinxbjxfH08/WJ3BpBU
 6zF73NVLsYRFQvftsFELLkZwFr5wq68oq/9hL8Ay0vDwS7+ZlX89qmp4QhrodOxpiYBM+gp
 CeDezKS0QVCBjCjQ3063g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EUydzPO02o0=;CyGqAnDMlSW5RuFFPUWUNvXKFNE
 Rp/ArppiAHxrRZdiwhaEu/be4iRMFwRBL9EnqM5qK/4890lL6xHhFruOJpqhi0uXZx8PKDUj9
 3x3osenOd6KJknMyIOVZLj5akA9YHaFbt3fpFlch1GAtLvEPN3+ENdDrFwzd3WGp2x0es6012
 IyAjFOcYi/TSmPG7sNpcp6K1r9egTudhZqgW7xjQcmy9Bc8+AmHhzKGrxg/kM4dPHTLx6ANUy
 uBQ/FozljZPfL70Ffp47zk8XzkdQNbEdmVrOqrSUKn1Kt7zVpC49HssqsuVFh2HgvSanpbSoe
 sul6MsyxSoBIYnzO2y9jv7b1k62QkO6tMMW0CijkhO1Hn1/kMAwodmikXmSeAqMvX18ijtZSO
 x5Oj8lrtHvxLiILA112gaX0RiVdsFnpuFBLO+PK9doq2PqjRlO/ET4pCEL+TInGsmXeVipx5z
 aAx8I4JUHX4vfVqk6ZhV7iFPM3bo+L0rvHMf0F7OrAZTl2w89vcc/NUyX5l4lLH5MEekjuib8
 yKWYqcTOhGEaiHqdixD6XL7MqlqsAlhIXo/zyGrZ8V/G5S4ez1qordpkqjmnTVNww8Wj8P8JK
 vRv1o23mGJePTOXybhKOUmlf+7he0OwHHUy6EFwte6qJ0mzrEqQBQf3u5OYHbpHEvBiDWdMqt
 z9QDj9IXMwX1pCXsWB3CbAH4T4fNSoGBDsGNDiVRBym7c7x8CdEgv+QZcwAAEkNLHr4gdkA0k
 xhVWGN3j1jww+C9b2c08st8792C0PWhuWvaEVHbn4zxTthQxRZ1WhMXhGoaF8BesApOxHCgLw
 +x3ub0GT8/+Lm+mhaNuiUbwVKn/LJkxjatCPmXCWeYjp0500WnpS0nuPVq//vuA8W2C7CeelW
 jW2ztD5ZqqEGeprzoudQlGHWt7rfmduxKNWXrDYyL0RUsYDhBkDP0YSyDbW1F3RTP4zoS7OFM
 YzvqpTBVTK9i35qp9rTwi6YY4gIIaLNy01cbpf82TzSMTh4gYeiWLrZBbkPCMgJRCFDu2OYp5
 tZ9UKTxsG60gK1DhCPBJqHLs/poF62oewc0kNqMllQYf6lnDypszBxPV1QkAcOOhmq1ll7yeG
 mu3fUwflxM2T2l/F2X3ba0Hmk8tP6oUyV37Fde3YlWWK4fGyd4HTB+R+pSxXAmYigbh7n2S3I
 lE2ZBIXa6mxFcBHD7Sf1bzp/K4U+9AFUC2gWSAUoi8mGr3y2D9AXjzMTUjWqW3w+UK9EIebDY
 4KQ7gfa3/I3EfX3sm2tSbjgfp361IdPxhWVWM1MLlkWqmdyB8EDLSU0ZhrdBUH29hvuTgrAGD
 anjafGNzMcfPqCpMDrLI5aLmrIouqRdQKnnVKZaBFS4btU=

RW5hYmxlIG1vcmUgZmxleGlibGUgcGFyYW1ldGVycyBzeW50YXgsIGFsbG93aW5nICdwYXJhbT12
YWx1ZScgaW4KYWRkaXRpb24gdG8gdGhlIGFscmVhZHkgc3VwcG9ydGVkICdwYXJhbSB2YWx1ZScg
cGF0dGVybiAoYWRkaXRpb25hbAp0aGlzIGdpdmVzIHRoZSBza2lwcGluZyAnPScgaW4gY291bnRf
dHJhaWxfY2hhcnMoKSBhIHB1cnBvc2UpLgoKVGVzdGVkIHdpdGg6CgoJJCBlY2hvICJtaW5fcGt0
X3NpemUgOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXpl
PTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZSA9OTk5
IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZWNobyAibWluX3BrdF9zaXplPSA5OTkiID4g
L3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPSA5OTkiID4gL3By
b2MvbmV0L3BrdGdlbi9sb1xAMAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJl
cG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MyAtPiB2NDoKICAtIHJlcGhyYXNlIGNvbW1pdCBt
ZXNzYWdlIChzdWdnZXN0ZWQgYnkgUGFvbG8gQWJlbmkpCgpDaGFuZ2VzIHYyIC0+IHYzOgogIC0g
bm8gY2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MjoKICAtIG5vIGNoYW5nZXMKLS0tCiBuZXQvY29y
ZS9wa3RnZW4uYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA0OTZhYTE2
NzczZTcuLjRmOGVjNmM5YmVkNCAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIv
bmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTgyMyw2ICs4MjMsNyBAQCBzdGF0aWMgaW50IHN0cm5fbGVu
KGNvbnN0IGNoYXIgX191c2VyICogdXNlcl9idWZmZXIsIHVuc2lnbmVkIGludCBtYXhsZW4pCiAJ
CWNhc2UgJ1xyJzoKIAkJY2FzZSAnXHQnOgogCQljYXNlICcgJzoKKwkJY2FzZSAnPSc6CiAJCQln
b3RvIGRvbmVfc3RyOwogCQlkZWZhdWx0OgogCQkJYnJlYWs7Ci0tIAoyLjQ4LjEKCg==

