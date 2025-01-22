Return-Path: <linux-kselftest+bounces-24945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168CA19446
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E9C188D363
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65967215186;
	Wed, 22 Jan 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="EBoBmJgA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F329215170;
	Wed, 22 Jan 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556913; cv=none; b=axUcmt2HZmnc3/V3ZBJUI6xtMML4K4WdV/3Vmnqg+vXK8a64OdQk1nSZkXvpXtog2wsy8c6yQjgTiYf0KnKesoim3uvDWmMj9dTHudzfuETAox33QHXW2qi978Qh7Ga+7LqYIMTTZl1zbn6k+CLSkwJfVVnQkGjnjLfDjo+9Im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556913; c=relaxed/simple;
	bh=on1/UJL7pVlH767fNUBKBDbo/X5LknLYmgFA3ie0ZEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOzZUmhKkPzQCfbi3JbKs7ZFQkICy6kTTKzlWjthuEVzV8UlHL+FJ+mlbFa4cpt9MtKUtddJpAUv0T/4fgHzULrgZEpPA7ZJxbnkEL30vMcGYj4phT3CpQmU+wPCf2JwMIAPksRywQAxJoA9agmSibD0V/g1W27UoONjdy54eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=EBoBmJgA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556894; x=1738161694; i=ps.report@gmx.net;
	bh=on1/UJL7pVlH767fNUBKBDbo/X5LknLYmgFA3ie0ZEo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EBoBmJgAqjibLNSKwszCS1gPkfJQFecTdv+isxDP4OsjQWad6xxMQ91KByPSgOOz
	 gsnGg6NnybjpVcT4kiW2lr68HU7Ee6FU+hrKzTqvtvRr/a5eWxpANHhIEgjnhwEK2
	 VXJEnFxVBWegZX0w9dKVvZKYAP3DO1fI1KSs6yVxx0naWc7n6Ikm4sIBsnKIcaZ9m
	 8iZNYUV9RqtjziS6J5irKQBbBMSeaAjrQ98yErqXIZZMYDb2h+2e9fIeM/tVwTLuY
	 sVTGkrTisJ6Xi/KP3m1F/ytioIQGO5MpzZxwfF8iyj3Lcdp5ppCBaxrvcC9TdL1dV
	 jHkUeypG62iMaSnoYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1tfKkn2XBL-000TL1; Wed, 22
 Jan 2025 15:41:34 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 6/8] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Wed, 22 Jan 2025 15:41:08 +0100
Message-ID: <20250122144110.619989-7-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122144110.619989-1-ps.report@gmx.net>
References: <20250122144110.619989-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:kKJDrPCpHnFyzcAyruWjkTQ24FHSL9dUBybh07+84NzTesAIpjD
 4TxdJkanXcULkWtUQts0c9lQuDIGQxU8swp0t/1dcei/7oFyk1CiGR4hOzUTp/KnRdX3Y+1
 TfRExHHXtnZ+E4XQ5jljv+u75rautNlO06GGUrzXSHtbZGKu0ODOUDlU9EQli0HIqDNICXQ
 Q6UD2oEOwM0t+UBuYg77A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+ZZ3qlWOV9M=;CQCLPNRqnemM10p9MLnBUmeSerh
 pEWa4wNmV0W5iT08N5g7XKAtsKpuPCOqcATGTUKvFKeuuJi0Ynx4/gkUSmTbF0lQPfqGgqR3J
 /HYQpsqM8EmBld/RmSz33SqOdaJDhfVrlhkyWh/rpfKR7mA8PP2rFiDRkakRb81fDBFlz00R3
 5Gmi4fTL2c0nmKqGtHuPzGFffC/XIYgLnEorig/FDF3ti3t07r59qgG9DjnR2DL4wrGI9hFOT
 cBxmRpxpVz5Yc7A+hGoYbT0/D/5cfUjwkbMSUu4+RNuXJKvnt6SzcBsvPbfX7t2DVBLvpWelC
 MbxtGWAh0wlWWSBHJWHazjslaboilVwfvOuS9dzAS9qa45fJSUxx97lre2JtRPwPHJFsvJnAq
 3vpEo4FmtTMwPzQgITZLtxKhECFyU/9xb4A2Oj/Yw5s6WozTbqdsGKo6iTaS3TwDaY5virBbV
 abuG/9/0j+N/ni9O51ug9lAcEo9yx7Yj33e9x6w9acWit9JNJNMwT/EAWCKhEzSs+dbcAR2iV
 OfJf75K7JjTYu2UaeuiViB41iwyhGZHWhddwYhvX8EtUJ8PnMiPTIWwosq0e9z7+6GBWW+B9d
 Gg5poO4ykRyNWx2HHqUeyFl1oiGwq1sLOXdSJnpmdAzIy2gthhfO8aQbvKma/v/Uv9pDMt84T
 rYw9vTdmSsbcBDMvbChvgWrgwTGy+8Szuus9YTVMN0UuZ0TRjEXqRoAobZodP5W9ZuTQ+pBH9
 okdxBCOujnRL+p7FReqGIswnTsUOJLra01bH/a/viAteemHdnqTHkzBEByjwGezf6oXEesqrv
 jW26ctvT6n1GrRK6oMZlx3nUfgkJhx6rqhaj2HwDnqXhP8T3rrsvMrUbhKuQ4e7HcaYo4suDZ
 ntr6DEvLYgw+kFi80hiS9fT6qP70LucDR7CSKIY4ZKswfcsD+cDPMqfWaH58ozcr1PMEr/YJw
 WIaOWCWd8rTg7ZffO7uWZn0QNINV6yXFQiJJ7TkyeY9wKrC4BXpgTU4ywemdYqg2HQ/gVOStf
 AOSKHufKWBFApVFTUugDs1sYDKCk2L7l1m7LShj1YEFKvjR1zmmlukxHtGixwVxQ9hSuK99TA
 vJWpcR3FXC9D2z8PtrGojomdGQj6zVZKyq1qkA3HUh/dDmBZ3kwEi6yeugrCeoCCR6OgaVddy
 8/quhKBERgJRKvqh/Ij3m+Pow/PD9iWLZd1yDkkWVYw==

SG9ub3VyIHRoZSB1c2VyIGdpdmVuIGJ1ZmZlciBzaXplIGZvciB0aGUgc3Rybl9sZW4oKSBjYWxs
cyAob3RoZXJ3aXNlCnN0cm5fbGVuKCkgd2lsbCBhY2Nlc3MgbWVtb3J5IG91dHNpZGUgb2YgdGhl
IHVzZXIgZ2l2ZW4gYnVmZmVyKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KLS0tCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBubyBjaGFuZ2VzCi0tLQog
bmV0L2NvcmUvcGt0Z2VuLmMgfCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9u
ZXQvY29yZS9wa3RnZW4uYwppbmRleCBjOGE1YjRkMTc0MDcuLjlmZTJhMmRiMGQzNCAxMDA2NDQK
LS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTE4OTgs
OCArMTg5OCw4IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl90aHJlYWRfd3JpdGUoc3RydWN0IGZp
bGUgKmZpbGUsCiAJaSA9IGxlbjsKIAogCS8qIFJlYWQgdmFyaWFibGUgbmFtZSAqLwotCi0JbGVu
ID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBzaXplb2YobmFtZSkgLSAxKTsKKwltYXggPSBt
aW4oc2l6ZW9mKG5hbWUpIC0gMSwgY291bnQgLSBpKTsKKwlsZW4gPSBzdHJuX2xlbigmdXNlcl9i
dWZmZXJbaV0sIG1heCk7CiAJaWYgKGxlbiA8IDApCiAJCXJldHVybiBsZW47CiAKQEAgLTE5Mjks
NyArMTkyOSw4IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl90aHJlYWRfd3JpdGUoc3RydWN0IGZp
bGUgKmZpbGUsCiAJaWYgKCFzdHJjbXAobmFtZSwgImFkZF9kZXZpY2UiKSkgewogCQljaGFyIGZb
MzJdOwogCQltZW1zZXQoZiwgMCwgMzIpOwotCQlsZW4gPSBzdHJuX2xlbigmdXNlcl9idWZmZXJb
aV0sIHNpemVvZihmKSAtIDEpOworCQltYXggPSBtaW4oc2l6ZW9mKGYpIC0gMSwgY291bnQgLSBp
KTsKKwkJbGVuID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBtYXgpOwogCQlpZiAobGVuIDwg
MCkgewogCQkJcmV0ID0gbGVuOwogCQkJZ290byBvdXQ7Ci0tIAoyLjQ4LjEKCg==

