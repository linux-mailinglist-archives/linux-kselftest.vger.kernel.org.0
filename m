Return-Path: <linux-kselftest+bounces-27754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB9A4801A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C7E188D924
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE27233129;
	Thu, 27 Feb 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="GhtadAWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F03231A2D;
	Thu, 27 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664586; cv=none; b=gjugJrddMT4of6CkhX+71H1SRcemexo0mq60Olp7D7OODhMRkqR2YOSia5kvebQKF4t3Vwb8o85uPOui5vYHAb2w+aRU8bMHy5plwU5bWui4UXM9AuFB9PodnAchgeOmnX2kamxP4Cj49RCE1mZtalj3Ua1DMbqHAIVpkveT09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664586; c=relaxed/simple;
	bh=JgGQVVAhjrzOOCs+tFIJPn5/RIQ8L4OMx++skv9az9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhLFuS/MIdIsJ8eOQz8pHCOvxkwcaqnGC8I+4QrX+lQI7VsC1qMV4B8Ikml82vXY2uhxtpEqL0bF+Yyj4Jl6q63BmJpQPqm6FAO3PRM8FpPdem3Ff3Go/g8LQRxHKKsFLqT5d3CfuTx9Be/76cnGkzLPzg+4dCyHxQbtuS7MQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=GhtadAWS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740664574; x=1741269374; i=ps.report@gmx.net;
	bh=JgGQVVAhjrzOOCs+tFIJPn5/RIQ8L4OMx++skv9az9E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GhtadAWSYXO9ggz/SCi8mD8APvIGdJhbi2m7MJQJl/m2VLwEFdbW85c0VmoZhAcO
	 pAr6JB6j4PdBG44xscw7y91jz6rbzz2m7+dZPBt8gzPdGAxgt8/iInzE+a82TOFAh
	 kFriNiUQnbaqyUDYqvGbmTVzPkl75nfMZFDaQs0pOrPZN+PCXKfHsBZ8QKP2gizRB
	 LxGAGt0uJXTdS7UPtVcHEVDe5D/My/1d47vv+uhCIuuG2wG9lTWGSiZFa0e9eITK2
	 7Oxl2jMF3eqThwpsZl73815O3p2wzbYxg9yZvNrL3e6JgcU/H8yk3mTxTfoIvYvBw
	 GUg/dEEHC485rZB/Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1twB4z0zXj-00D6Yw; Thu, 27
 Feb 2025 14:56:14 +0100
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
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v8 2/8] net: pktgen: remove extra tmp variable (re-use len instead)
Date: Thu, 27 Feb 2025 14:55:58 +0100
Message-ID: <20250227135604.40024-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227135604.40024-1-ps.report@gmx.net>
References: <20250227135604.40024-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:X36GMHKlFQYWbPGzh0isIFHJJaFo6jhBUDudzhYm3OOXtpqURVk
 svPTMi+Z2UB6WZ4LkITVRp+P8PtJSxMknZXurPvcHD6FJCEiNBH2v/Z1v+bT+L0S3js+F82
 CHTOyi/ZuRA97fIF9MXRUeLnb3MUau+msB8x3vOBT+iQW0xpt2zlGqTfZ5avqx3Pu9qRGWT
 33b2PG2eBSACgX9erVOJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QB+H4xaP0Kc=;orwU92IZ52FMWIGSfgV2i8UK5aQ
 ScyhfYVlPsBc52p7OUeNvlPLJkJiFpOCnnLDm8wlWSnzKyFoCbgjfpq9xXCA3LRigvXZMNGzD
 POrOL8jKNTiuJnvtamvZs5Hsqqlt/kmnnRyof9hYQK1wR/1qn07QbYwDkWZcRWjZd434jhQQU
 JcQqQC7irNxHNCq+teM3SKkxjv63YmpFHXj7TaKaOyXECFYxhhR4ILovtGRuSYKpupiBOCtN1
 3/zyQ3J0JzniH7Lh/+fs9JeJMjV6VLTUyCX+CgxcovMXEuukN02k8Do7xHETbIV3Ghuc+T/E9
 cBnWcuVElKp9L6AqYRIEO+uc52OOmLExQjqPfBgNq6VVvs6QtUMAl+2qW/I1yQ8V601sF0mRI
 +ImtbEffwkgJ9sTxvAMbUpXVNplQdXnLOempOkIHw0/haRTEIwObn0rK5PHXJX9gXSbfB8Uz2
 r9g78myxn7dmZbHTDae57GTZbmLVN4jxSFxcJYpEn9sSTLcHQcDZyhChmbeNMMlJebRzswR89
 U5ES67Z3G7bcWegtzrBtZw/RtF/AgCZOXv8LA/UYy2cFxnCEcLQkuFVPXcWTSzPXehGuUTFMq
 6aK1V399KrxzwGgpRaMpuMk1YVAfZ6+b4tHZcLSeL4U6HdBJ0PVdyfel66lVDk9V6DO54a4wl
 WHJDfbGwnioGGxEJnt9TX2D/LkZe/gwTJ2gdEs6V6GSd4SZB/+qcQCLyU9twcPYn3VcgtD+pQ
 BgRVQsvaQUH6M16OqqkYN/z3VBUQxfKDjtYZeesFMSCSJs/oyueMkRE693uG2UziKATUfg7fT
 m3rOZSSgUN5MUw6HG7D5AKH+jWlUiOLsUiK/WLDSb48PYfwHfIo8d/cK9ksn7Dwgs4+pS+CwP
 pXClMTHA/+hxXaG+bdZplrjJnDORVsDAhFMDx0MnFVykEkM3NbgcpzHhZGihfsPg3ETvU0HwO
 pRm58TiiDiqQFLJT0PT97LRn+JaumAYUAEWjN5nv+G+5b7V0qJ/QNrbn0UFi6E27021D7sHwW
 WpYQW0gTOUgpQIyq1qHRGc8POTKo5RjBWt9Nui5hTXjYVg/eZ2tFWJDHGyCEHKvFbi1f5EkhH
 OcJLVztzIoSN/gCW+GfmRcTVqsZ/sIgrxLgwEM25VyRrfPNFkC0nN1kYMafy/ODA3fbpbn2NH
 YwgiDvA+Sy9CYqVNsGC/y3jSSag9e7c7iR+uhaSG2EmWNccgWHeXpTk8Tmgkuk4ziTVA1sqEw
 zUTzPwFyta3Lt1clTwJQOZ/kLc3a2kqbEzWsj1v7LzUvrXBHxe1so3EU+GnS+1Xz1yknxh358
 VsJjkoPxe/4PeikkTeJd+NoaQ9IZJgRNZYL/DGHlh2t1eBsO4kGJCwbzk4a7YJhhI9sKKeEts
 zZ05x5me4hj+1MZcEwP2K+jpvxf2h3m5guED8c99PT4dpUZBWFT+qTB6UYE4We2bj9ExQ467m
 doq8cog==

UmVtb3ZlIGV4dHJhIHRtcCB2YXJpYWJsZSBpbiBwa3RnZW5faWZfd3JpdGUgKHJlLXVzZSBsZW4g
aW5zdGVhZCkuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5u
ZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFu
Z2VzIHY3IC0+IHY4CiAgLSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9tYWluCiAgLSBubyBj
aGFuZ2VzCgpDaGFuZ2VzIHY2IC0+IHY3CiAgLSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9t
YWluCiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHY1IC0+IHY2CiAgLSBubyBjaGFuZ2VzCgpDaGFu
Z2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2Vz
dGVkIGJ5IFNpbW9uIEhvcm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFuZ2Vz
IHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3Rn
ZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2Vu
X2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgOSArKysrLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA0Nzc1Y2RkMmFlMWMu
LjlhNWZjMTI5OGJkMyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2Nv
cmUvcGt0Z2VuLmMKQEAgLTk1OSw3ICs5NTksNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJY2hhciBuYW1lWzE2XSwgdmFsc3RyWzMyXTsKIAl1
bnNpZ25lZCBsb25nIHZhbHVlID0gMDsKIAljaGFyICpwZ19yZXN1bHQgPSBOVUxMOwotCWludCB0
bXAgPSAwOwogCWNoYXIgYnVmWzEyOF07CiAKIAlwZ19yZXN1bHQgPSAmKHBrdF9kZXYtPnJlc3Vs
dFswXSk7CkBAIC05NzAsMTIgKzk2OSwxMiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJbWF4ID0gY291bnQ7Ci0JdG1wID0gY291bnRf
dHJhaWxfY2hhcnModXNlcl9idWZmZXIsIG1heCk7Ci0JaWYgKHRtcCA8IDApIHsKKwlsZW4gPSBj
b3VudF90cmFpbF9jaGFycyh1c2VyX2J1ZmZlciwgbWF4KTsKKwlpZiAobGVuIDwgMCkgewogCQlw
cl93YXJuKCJpbGxlZ2FsIGZvcm1hdFxuIik7Ci0JCXJldHVybiB0bXA7CisJCXJldHVybiBsZW47
CiAJfQotCWkgPSB0bXA7CisJaSA9IGxlbjsKIAogCS8qIFJlYWQgdmFyaWFibGUgbmFtZSAqLwog
Ci0tIAoyLjQ4LjEKCg==

