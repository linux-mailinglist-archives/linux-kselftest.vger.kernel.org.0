Return-Path: <linux-kselftest+bounces-24729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F85A1516B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F6E16936A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1F139D1B;
	Fri, 17 Jan 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="A3cjlzI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736038DEC;
	Fri, 17 Jan 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123385; cv=none; b=ei99Pi2SiNsVZB3sp25ottHpz0ADvuCUV5HLk+PnCUt2UjBMrvWlxHWZ9agvnionCQSIoQkAa30sxwcM2MweyIM/INCBVnleAECSFBJ1kJg2RM6uf7xPcDiNfBJqLHdfR9+4IzG0g9rhNTJiNoufXnOyYTIWE8aj1Qfoa9tKOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123385; c=relaxed/simple;
	bh=X0PZDGXscjXwT1DNiHrdE78d1I74q9KXi1uOjvY3Qu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDqZ35uT/x8vyU+fXBbXoi8e8HTRXcPk7wdK9kgmXiTsg71WWwZay7RA5QQCBsDTO8IFkj/ruwTXU9QJQhCZKgbQzI0dtfbTaGayqYEMWAoC1x07Nt+aiqfaDh6ziJTBfRgzRRj9anKeFaibcXa6QOXQdi/b/o8D10QdjA5dbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=A3cjlzI3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737123380; x=1737728180; i=ps.report@gmx.net;
	bh=X0PZDGXscjXwT1DNiHrdE78d1I74q9KXi1uOjvY3Qu0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A3cjlzI3JwBUQnuQij6DMIGbahnM7xUf29qJ4XXtEq4s0ZzlyRrGVgNVWT0bg8YV
	 riLGmIgrGan9f15XnJ/+f81fh6xmK36Z7D92RdXNCkBEjruQroV04wED9vySze6nH
	 s/9zm33iwoq1pZUUinppe37L9I5gkBpG6VTbSjm6w4Bdb0aU3pwZok7bAJw3FGgPo
	 UXiuMdboio2p5dMX/52PgwkGhZmspzalVCL98965h9KaqwmSpAKLB5ldVUZ9Ip1ph
	 k6VmJV0tKJ0R8AVV1lrr0Y2NZWiiiGSoyIHLX/oMnCgOmpF944Z0sA+nwYFise4bv
	 KbkWlV8WVUlQlJ4u7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.138]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1tqb931Djl-00VFco; Fri, 17
 Jan 2025 15:16:20 +0100
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
Subject: [PATCH net-next v1 2/5] net: pktgen: enable 'param=value' parsing
Date: Fri, 17 Jan 2025 15:16:10 +0100
Message-ID: <20250117141613.691452-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117141613.691452-1-ps.report@gmx.net>
References: <20250117141613.691452-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:OE7esmNLKbCijPCW5KDVIpw5ecau+K9fCt9up619VngP6l8Rhj8
 01fOSaa5/jOSAZrzQsqUNUQp4nUm8f+IFyK9N41pEc1Xpo3Kikne9zESjRq6gLvUfTlHUQy
 sk4xMht4xb+SBf1vTg6/KIlir1iwHRvryjr7mRJ5RO+YjcpDGW9XZP/YyeKLZnPu66FWaji
 hY7+f9H5Mvda85JecZgpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V6FFWbIazfA=;POI4WEb5dBZ7PPkn78qFG9joOc4
 SrOK3OCh2kTRCzoiFRKArdGC69zp1dHbgezvI273GmcD8bdbtrUuRkX6GdrXdvYWByqtpAAvk
 nX9HAtMYt5U6a7rlt3Hsj52rSctRPXZzblGUQJ4y4njrDGJEAeLDbuz+IJycwh87eRbiGF+GN
 JP9M6dQ8lCrHDFe9PfrE+yblZ3lBXkPyY0Mg2J90JiMUEWaqlB0IUjbME6Td+nK6EjHZ3HYyr
 KMBr7BaiqhXP+Nr9Q0DF+TYmyWiji94gEVEvH+lAxakGuN8T+0tLcmMKF9KT9t5RnXA2M/soB
 3YpS7kCCp0GRVXv+UTHo6CuMlLzx6h2FV8XZuoB/Q6Ml+H55oUUS61dQKeXxHPmE6X2oUAMM5
 wGrWZ0ZTgwbh4EsT5je32sYP7DlZSNmJN4/YYjGGObPR7wu1sTaOcgNBxme9z3kJd326Sko/U
 mzsrtpDkprjmMs3lXJ+W1Q62wA6AZuW0Yt4p6EIFE9CSr3rR770xFIvtbl2/RMhjhBAZKyQe8
 2tLUxB5CXwNPjtHV+K28Jh+tFtpjmlceBbdfnEUTQZ/8Bx9esErv6iuBJLdiwfgqZRIonZuPt
 fDtQUTW/VGmZmFQRBYsWTWKr/+7jXIJbB3CUsklccHgqlItMI/ze4HjNbSR1DlzgvtvalPl9b
 QUgGSJHTSAN6KDWcOHOCC1iOThEcX2yJKS3JgIfxzJjd1P1jjxSrf1qU+k3JO3RpuWF5TFrlL
 xjOpXtCvUT647aLnHjgGIT5W7GfK4YZpTMUeT9ojoIQwUrGj2hyKEdcX5iGTOPyQXgkp52PV5
 xS0wj0Mz5jT/O7jQDW2hXJwD3OGX65loXLUhddMHDEZKT6pIBkihrVhfAExJCofWsFAOQvGQ3
 VbdVwpUJ1oUP0CH/XuRNfx2gWkCznkgF7cf/x0eTxc7bN9u8VsVcKw0RSoW8jHic+vsX8uRN/
 WPlZefH107ETgpGgXuVWteBLCq50ezUylReHYYoN/12yJx5edoi+kj0CHlLJ/FGpGfJExGius
 ntMqdtQRtT3d6lY1YN2HuLg6+Zli/o0rGdBCbUMrWtqnJ5sWcer5FYUCGkYotC6BEG4lwIzXc
 hF1gKuoKjFU+tBQLFp183zcUf9L1HQSufV1nPUe+SlgxNjiNlq++9PRJWxXuNOy3WdR4o8DjY
 uujsVRkjOEM+b/k88uHXiyEtK/hXCJRE+meKTzknirA==

RW5hYmxlIGFkZGl0aW9uYWwgdG8gJ3Bhcm0gdmFsdWUnIHRoZSAncGFyYW09dmFsdWUnIHBhcnNp
bmcgKG90aGVyd2lzZQpza2lwcGluZyAnPScgaW4gY291bnRfdHJhaWxfY2hhcnMoKSBpcyB1c2Vs
ZXNzKS4KClRlc3RlZCB3aXRoOgoKCSQgZWNobyAibWluX3BrdF9zaXplIDk5OSIgPiAvcHJvYy9u
ZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT05OTkiID4gL3Byb2MvbmV0L3Br
dGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2Vu
L2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9c
QDAKCSQgZWNobyAibWluX3BrdF9zaXplID0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAK
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCiBu
ZXQvY29yZS9wa3RnZW4uYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA0
OTZhYTE2NzczZTcuLjRmOGVjNmM5YmVkNCAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMK
KysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTgyMyw2ICs4MjMsNyBAQCBzdGF0aWMgaW50IHN0
cm5fbGVuKGNvbnN0IGNoYXIgX191c2VyICogdXNlcl9idWZmZXIsIHVuc2lnbmVkIGludCBtYXhs
ZW4pCiAJCWNhc2UgJ1xyJzoKIAkJY2FzZSAnXHQnOgogCQljYXNlICcgJzoKKwkJY2FzZSAnPSc6
CiAJCQlnb3RvIGRvbmVfc3RyOwogCQlkZWZhdWx0OgogCQkJYnJlYWs7Ci0tIAoyLjQ4LjAKCg==

