Return-Path: <linux-kselftest+bounces-27752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD97A48052
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C216B751
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602D22FE15;
	Thu, 27 Feb 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="lvjC/kcM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C342C0B;
	Thu, 27 Feb 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664580; cv=none; b=l+XRr9zDeqDfLE1im4ZBWTj3Prm+D+zuOxvleheiPODFXlbCJTW7EY+anJjb/UgxqQnoASBonoN+gX9Rbi8Iwuz4gUzCY2YJ/GB0BF1uOZJsmyfLEzENgvm9Skp0vHh8+/CR86OvEHEZyjbc3avo9B4oIOGaqNrTI/5WjXv+/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664580; c=relaxed/simple;
	bh=6YhuMD+fZp15NlYpzOupLk0ws9PYq1Voacu06J0Qh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ7XB+kbbUJgS/1hKR3nT31ppXc9gJe72U40Obio5zGWusCLbqU58c0CW+u8V1yoZm7prb1cYhPZ/gKpVQB3FBFbq//UxgqH5U1ya2o6MV3UKqM7RygCAUI9qUrQK7Kpf+e8l0Lg8O1s1CokX53Rzy7GuEKix1+06WdaKdxFZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=lvjC/kcM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740664574; x=1741269374; i=ps.report@gmx.net;
	bh=6YhuMD+fZp15NlYpzOupLk0ws9PYq1Voacu06J0Qh2E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lvjC/kcMwpbAjEwFKs6zxoDbniNDyzxr2fMTAjgACe4M2sLwLpeIZqz+Vh1i0Kd3
	 QZDkSN2v02WgKemDU+fzjokJsAq/gqaNk1TN9fVJ1gwuost+JH1miiLvdLyj0bzJg
	 4+FGYYHGWvl8Loxhj5zOkNHIEdHus3F2oxsPFvQHJJlKBcxdIfqzyx24rYeSdR31H
	 i1O6VRBjr4T0yEmkaPrT4CO1RcuCy3X06kMqVzoEyGE94405DzhscKOiACiDf5g0V
	 P+VA5YXdg45852VJH2R8iEl6ff8ftj316uYQmycqTpbMuby47KqNh6VQmNM8O9iGW
	 hv11P2bqUEMMRZ2kuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1tpIGO2kkw-00F2NT; Thu, 27
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
Subject: [PATCH net-next v8 3/8] net: pktgen: remove some superfluous variable initializing
Date: Thu, 27 Feb 2025 14:55:59 +0100
Message-ID: <20250227135604.40024-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:EUIXcxlKZnX2/p/4jMa01w1aUMFkC6XFDOrlNn91juwz9cofZ1D
 gdl+8BnZhZSL7RY7CLN+Nd0YMid9W2/nCUqQVplpJLb5OrGd+8dtXL5epnohYroihgkaKg1
 t3rTbfGAsFQ9lhcpoXdAg0kEmTN2UuF6jzigv8r4XElyHQPDVuUnB0a0cafoQ8WuY3c6uAA
 LrZG087Ui2F3evhbo51cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BkUoI9KaCRo=;zxEJzEjODqPk70w6cvO33JrWQcy
 +uwZeqZcivYV+bv/UsbgHHAA8uoiQ591PDaNJDMoNCwgTJcKaHsBPfte+5qjeosZVtmLVOqiG
 B1nc53mQiT+K3nOOnbhrv0pBpHBVnadmshZCUdzI/xVafImlc2KnqmDqHSGN6OvcZiO8Fsnvd
 5RnQRxJh8Nnx2KV1rKymbd53tzxvmjvZCiDGHf9FLtAeL1tf3GeG2OlJJy4bZQjL69jqPe6KX
 cvhxdm52OJvmVRStSLVaZ1rcXQvVfmtaXoOD3O2ETLw2pqFgF+tf21mwmcMOW9z0HJUqogY29
 Uw0Oi8cC7IpybW5c727OgeJOnqH/Euh7RZnr9Mqyefyj2QGJl8oisfohUpHm7A9n/ctmHT8D8
 DkV19xvdFP/BSASFBm9Ai9P551C7F3uZH/PLS1P2APjLNB5O11ITAOrRoJcGM8WwHD064rCeh
 F64l9PuNa/ZlrETMtoN6qhn3aDKokefL3PI1VbcCHtWBQ1X3S4YQmSmGxHYv9YOj3hFeERv4+
 5cbEaPi5VSF/CqOXZWT4/k6MxDNbssr7kTW/YiLq+g2Zlb5kFBj0h4m8ZM4lC2/Y94PC+cMiG
 dLC9YcsylsGj8yhtjsfOQQ26jsxV4qGBXyYqU9z/PBlkZRxh3tOrBUyB4+f3Epxq3FnHIbCAx
 YmtGIs4BlHKncKmf8OsQARFC0oyvQH9y6gmhM49jGbExWq9TGlvaRvVkACi6XqHqIFg8w260r
 MOEsGoA0dIBkKt7zYDdrWcETP6BdkkIUrtoivvlegBkku0/JVGIE7aR/Hs2D3oPIA60FBj2hV
 broGDqpORyIq5WI9LKQyxD3qxuhVma77nKEMm8bLo+LIGCKdtCat7r6JGwNRVlI/Dzh89Fc9o
 6/aWvBfmbP2M5YjxEkaFVZtHIUK9STMNHySjwDKSpS4BnpY88SkcHUFOIcLMVEmfbmgAeVUKC
 q3Iq8DGMmlMSI3sAaT0HrqL9jo2RIQ4Hnk28AWgg0RqvX6+Ypr6QPw+rL1prw7owqLFfW01kR
 zoPs+oJJm7SeQPeBdMbSlwrZ5MFAh/lCcJg2cbpaIC4NeXFx0im6wS8ySd8agZPLzlorNyC6Y
 pk6xsZ6yVhBBOrVamQYz64c8NqOukajFYUhpulbulpq1TTeSXDiA9J9BIJSk6QRor5Wc2eymA
 sGVuZJ5WqbS+2j/ys5u2ViKTcfbESrnHf7KT8i051UjsJEdBXSN8s8U3i61ocBTaUvJibjRjs
 R23p/UAmjdGtWVdsrzNkVHJNNVBxchgLS21Mg5/KLchdf8RCFOlw0zVFYyiz5SpvcTMIjs6A/
 Ikkkn0yfjhDUbaRVV5nV3faMwzx7fXFiR7jFWUPe2TShJFxRmoFUHMsdT5Ch8L83NR6dsvObg
 JhDP7Xc015Ag5F7OIRohnwtf4dYMXw/aVBDStBNkzNi3jjDdGFkj090ChZ

UmVtb3ZlIHNvbWUgc3VwZXJmbHVvdXMgdmFyaWFibGUgaW5pdGlhbGl6aW5nIGJlZm9yZSBoZXgz
Ml9hcmcgY2FsbCAoYXMgdGhlCnNhbWUgaW5pdCBpcyBkb25lIGhlcmUgYWxyZWFkeSkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5
OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY3IC0+IHY4CiAg
LSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9tYWluCiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2Vz
IHY2IC0+IHY3CiAgLSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9tYWluCiAgLSBubyBjaGFu
Z2VzCgpDaGFuZ2VzIHY1IC0+IHY2CiAgLSBhZGp1c3QgdG8gZHJvcHBlZCBwYXRjaCAnbmV0OiBw
a3RnZW46IHVzZSBkZWZpbmVzIGZvciB0aGUgdmFyaW91cwogICAgZGVjL2hleCBudW1iZXIgcGFy
c2luZyBkaWdpdHMgbGVuZ3RocycKCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNo
c2V0IGludG8gcGFydCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQogIC0gYWRkIHJl
di1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjMgLT4gdjQKICAtIG5ldyBwYXRjaCAoZmFjdG9y
ZWQgb3V0IG9mIHBhdGNoICduZXQ6IHBrdGdlbjogZml4IGFjY2VzcyBvdXRzaWRlIG9mIHVzZXIK
ICAgIGdpdmVuIGJ1ZmZlciBpbiBwa3RnZW5faWZfd3JpdGUoKScpCi0tLQogbmV0L2NvcmUvcGt0
Z2VuLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4u
YwppbmRleCA5YTVmYzEyOThiZDMuLmI2NzhiMjhkZWRhZSAxMDA2NDQKLS0tIGEvbmV0L2NvcmUv
cGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTE3ODUsNyArMTc4NSw3IEBAIHN0
YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAl9CiAKIAlp
ZiAoIXN0cmNtcChuYW1lLCAidG9zIikpIHsKLQkJX191MzIgdG1wX3ZhbHVlID0gMDsKKwkJX191
MzIgdG1wX3ZhbHVlOwogCQlsZW4gPSBoZXgzMl9hcmcoJnVzZXJfYnVmZmVyW2ldLCAyLCAmdG1w
X3ZhbHVlKTsKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwpAQCAtMTgwMSw3ICsxODAx
LDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAog
CX0KIAogCWlmICghc3RyY21wKG5hbWUsICJ0cmFmZmljX2NsYXNzIikpIHsKLQkJX191MzIgdG1w
X3ZhbHVlID0gMDsKKwkJX191MzIgdG1wX3ZhbHVlOwogCQlsZW4gPSBoZXgzMl9hcmcoJnVzZXJf
YnVmZmVyW2ldLCAyLCAmdG1wX3ZhbHVlKTsKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVu
OwotLSAKMi40OC4xCgo=

