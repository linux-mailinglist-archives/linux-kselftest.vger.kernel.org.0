Return-Path: <linux-kselftest+bounces-27237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35AA4024D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052C2700243
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06315254B09;
	Fri, 21 Feb 2025 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="hlCOo1bA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C8202F89;
	Fri, 21 Feb 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174778; cv=none; b=WeKGOIRVKq6Zr5TkVBFqefIsrfg+TH/59o3LUyfYsfKTxajhozQI3Q0azNg83tmtSRguu8MLrGIA0Wa+D+FD2VzQsfZQCNBDlXEbAAfUe/rzlRupcm5XqsLNLQtp0QdiUzhyEQKFMT8fADBGrBwWIZ5/a9GBc2fxAQuYZoYTyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174778; c=relaxed/simple;
	bh=tmTSEEzGyIhUtwofgL95uH8cGlP+iF/hT62XefsPlic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rR4A5o+h4b1k7eZ2mjvJV4EJO3dNZoWt5ysPJoLtBbpr/VvXBX9FBK+S8DFnOb1lK3ZKY6AruCK2yCki+LDffncdzUMO4Abix9NB6v1Noj0giabuGSEN8gxmGfgg3gXK1YtnRdthJwNXpF4g80/l3xqkN4ywusc6X13NTCIn1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=hlCOo1bA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740174771; x=1740779571; i=ps.report@gmx.net;
	bh=tmTSEEzGyIhUtwofgL95uH8cGlP+iF/hT62XefsPlic=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hlCOo1bApO66I0wOFLIo035lsJc0sy7+9vnNqqq/HQO5s7mNTUUoQEEAJqYhTKmp
	 Q18Iwl18HFcEtepEaQm+N6RH8i44R51oIQJ1WorH3nI4EohCLVrOOfH+p+rdSxzUW
	 qL0dYst8FjAt3/YT3P9AIqR2+LH0ARLs5QQQbyN5xnDbXwXWgfMSiUjq7shZGzQlM
	 M+/fGsP3FJ9Y+r2BZbYgnhirASFCUIzUXEDE7vtNp+HVbkbTLhTvEowij7znB7vx7
	 xjxrup4WYywPEiIAxhkMOIU3PRQMUtAEjzOi54D21THiBJUZyQL+CQ9hxn6aEWUlJ
	 Neds8xjV0R+5zNfIrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1thB6A47s0-001VN6; Fri, 21
 Feb 2025 22:52:51 +0100
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
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v6 2/8] net: pktgen: remove extra tmp variable (re-use len instead)
Date: Fri, 21 Feb 2025 22:52:40 +0100
Message-ID: <20250221215246.383373-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221215246.383373-1-ps.report@gmx.net>
References: <20250221215246.383373-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:bI3p3HO/+Lc/GQn5qL6cfUiAkOd9iq/VzYXpW/39805rR3YYite
 fTPlTCU1T41hxNdao7syYaNX3DS+U2FxIs2ii0IYuG7HptnkGjCrAZrSNfLgsydX2rqmQO7
 7oTX2x3XtZyfdD2D2F076K4a4ipU3gwmWf1wYRCG5o3KxWfvFqvkqzdebHP2K0W38no1QNH
 b/ZRTviJ+14t4J7HR3RyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G4maLxHccsU=;j44cNmIPra/xJeNmNUtrT7mY0m+
 KpVV6uGRkiqErodz8uStjHW/zkfZTtxl3AVkiLFDr9bfflJ7yD1bUAG9K1ZWIAUR/a3wLVe5R
 NZD85Sy1lYv3oyOxvBrXYMdeBN3Ruy8rdV1DX600TkVgseiOchmhPrw9RCXoKs7WmsCH0mDJR
 QdSoQOQK2FKsi73OoJ3Rj9vTCSQti97Pg7ej5ABLZ6L0hDqWdSqlF5FDapgZ59tTO5GCoT+sJ
 Gem1WnhRqySNO4AFBGOSPXGJYMewJtNv4PZoiDzE8UhLzDTN/BZS+UIAwMgB+DZEuKJKYnxX5
 sGswLKe5IFLPEpZoLyvp3rmLErz1KDxi//Orlwk3k3PKkgik+jWdWmoeZyFF/bUVB4XWAmJZl
 OWB7wg1mI37jJOS7QOTzcyjUkJIBdSuyLb+89qF84DkoRmUhY9N2RE2uGJjcLRyp+q1HYlFbq
 goAq86vJyBOfnMaAlV2VPgZIl7eRYmOQ+9VEJaDfV9LqW72TKY/rC5WDFhDqWxHl4NFAoJ3HK
 nSIFE2SMIJPljvdh2JH8HRv0m4artVMflzthToG7M36kU4y5co6ZiyKxyhnb3mRKAHCNEm/RV
 QFqB5Tn8+0lpJQUEZWMvnNmNsK1cdOqrsulMBAUiughL0g7rQvZQMhwrb5kGwAqvigsXSR1TH
 MLqFTADaaRz5g7/So8JL7WeZZRnFeLP0OUv6Ba9QwJ11ulxCxLYbUOkjBDlYohf7qprdJMrJb
 fsocpemBHxfq2hoK3uYTbG5XaKXh3Sx7RWQaJpQCdiTDiFGLRDqdb0nnqbsWRf6NWg1EMz0an
 Zn/eiSqIiz0YsfaCPn9gqnNQUnFcSr/YkStCkg0r3PFlkr6rUKHJDpVP2G1xo5wTedo3rmNK/
 f5eb8lfXdccjjd1AYHpEd7aemIjDbIon13TUtLIRtW/peJGG4RKA1RT+fy53+V9JL2IAJ6Uog
 rRgjfv5di2ohtwEOQ+98nFUUUtOEucEvwZTD5M1raXzFqLk1tbKe7ldZRXpYjVqMHsoPV+z1H
 8+XPauTdGfPmG1MCWOPxUov1AkRFk75YJdzCtcl85JPbOYZ+9O5UiV2d0nYBW5R1k3pXxKJg6
 okQcdrqA1ooCWkclnDOxnLe6fQeC9xq3JLTCn7lX+sTDQGv6+SQy+9/OXtZcsAnxOgh5yD+YG
 alzXYgsWQQJMguX4EWMn4YVeGIuVCbPQqHPqnDyI0eRyV6HlbJa13OCOW5iNKFCaxGG1csxrg
 q80qbUbhqpJe8drDKhbGdGjyDV2COH+vNeWq7DwGUq3Yg+Qhzx7goVLJdkSDdBd3u5lq1fChk
 0tUbIsGMuVp7YJ9QjJdlY6ewe7JI0zHF/r6MIcahO/R9y9qDEPkunfhwLsISeQIXoZRPcq01j
 qvpxhqnuC33X7906ZIy/5QXnaRaCAqsc4FCEP4sA5lJaxzlDi7ztYtECT8

UmVtb3ZlIGV4dHJhIHRtcCB2YXJpYWJsZSBpbiBwa3RnZW5faWZfd3JpdGUgKHJlLXVzZSBsZW4g
aW5zdGVhZCkuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5u
ZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFu
Z2VzIHY1IC0+IHY2CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1
cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKICAt
IGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2gg
KGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBv
ZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9j
b3JlL3BrdGdlbi5jIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQv
Y29yZS9wa3RnZW4uYwppbmRleCBjZDZiNmMwZGMwZGMuLmI5N2E5NGNiODVhYyAxMDA2NDQKLS0t
IGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTk2MSw3ICs5
NjEsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUs
CiAJY2hhciBuYW1lWzE2XSwgdmFsc3RyWzMyXTsKIAl1bnNpZ25lZCBsb25nIHZhbHVlID0gMDsK
IAljaGFyICpwZ19yZXN1bHQgPSBOVUxMOwotCWludCB0bXAgPSAwOwogCWNoYXIgYnVmWzEyOF07
CiAKIAlwZ19yZXN1bHQgPSAmKHBrdF9kZXYtPnJlc3VsdFswXSk7CkBAIC05NzIsMTIgKzk3MSwx
MiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJ
fQogCiAJbWF4ID0gY291bnQ7Ci0JdG1wID0gY291bnRfdHJhaWxfY2hhcnModXNlcl9idWZmZXIs
IG1heCk7Ci0JaWYgKHRtcCA8IDApIHsKKwlsZW4gPSBjb3VudF90cmFpbF9jaGFycyh1c2VyX2J1
ZmZlciwgbWF4KTsKKwlpZiAobGVuIDwgMCkgewogCQlwcl93YXJuKCJpbGxlZ2FsIGZvcm1hdFxu
Iik7Ci0JCXJldHVybiB0bXA7CisJCXJldHVybiBsZW47CiAJfQotCWkgPSB0bXA7CisJaSA9IGxl
bjsKIAogCS8qIFJlYWQgdmFyaWFibGUgbmFtZSAqLwogCi0tIAoyLjQ4LjEKCg==

