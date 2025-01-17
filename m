Return-Path: <linux-kselftest+bounces-24728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E8A15168
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095BE3A34FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28122611;
	Fri, 17 Jan 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="S9V1jYSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDD25A62E;
	Fri, 17 Jan 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123383; cv=none; b=FrYbwpdlKd0F5S5Wnu9v227d4OfhZLnv8BvCgZgv5DT3ax7J1Gtt1G7SCstABMTIqPT/5omDSNH8C+5N/rBbixO7WnV3JH4fNCQL8RaE/Nb4uEpbRxIsN3wNzbT1DgMcPZFX5/H1AytGtF+Mk3RgmqZU5ebb1UNmYTdKQv5qU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123383; c=relaxed/simple;
	bh=dpHTiq37g4gxen68QdVNBAH4djW7txUk7SnJ5N1RKSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCdGvBiURk/3f35pPb3tSAbJgBunHhHTlWRKCVWwZDfd3c844AthnGFTLbQoLK5rS0kf/SGWkioDJshqwClbVp4TGa8ea1sYRrnTkULwymEF/QlbA9vzKljG9uYAVtaPkPAiYDdT/bkrO7nFP7u++Fz5RC17EgFhMlcxw2vMcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=S9V1jYSm; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737123379; x=1737728179; i=ps.report@gmx.net;
	bh=dpHTiq37g4gxen68QdVNBAH4djW7txUk7SnJ5N1RKSI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S9V1jYSmX7ocrCNiopxU43gh0mraPUVaBdrO1tXkMRZWfxgTcWyUnJwvYSWVaISN
	 IDxXxpbbZn7A9D16X3QoCbttGK4/Dix8yE8MTleYZC9F3v2m7/5ajKhCGo455LAMg
	 ZYYpeaPWSxiWOWuU/Fl9F/DluM3zEotksTAGLFzD8Ynr4wm3yaNkYoEVpINUMvr2p
	 urhCR1Dq2VRswRNbUnOOpaUqlS5UPBWo3HRd0fH5qlu+pACcjbjChEQ0uq0kO+Zs8
	 iLwUJR3sOzyGKqF2dTcNB6AVohuTVFkb6jBzKuVa0C6sJ3vRYOd+qleCP+yUWSVkn
	 AcsvR/yjv2Bq8Kd7lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.138]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1t4gz63UXu-00jlfx; Fri, 17
 Jan 2025 15:16:18 +0100
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
Subject: [PATCH net-next v1 1/5] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Fri, 17 Jan 2025 15:16:09 +0100
Message-ID: <20250117141613.691452-2-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:b1ul4GHA6s9CYulb/E6UFjhWwbhzbaJ8f4b3CNwOKIk/rMvk1jB
 IHc3zGCEJQGcH7wzL6rUgXdUjVPbbTtvVelvFxJCaDxhgfK3JztSQOipB4NcqFUX5t5C40X
 teqYku6ZrEHAL258T9V1jR+MMY5aPyDgs+ce8ppzvbYi5JeTgJSpx1D4nUZft69yFsQblzJ
 yQJUDpoz1EGsudxzvH1HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sIB85bAxRiw=;X3b+TZ/VEpgOTQ5pEbmI2gcI6Rj
 IGL/poDCCz2Ov2ElirkgpaR6iZyvUL58HcCsWaVqD1yzvRCjPYCPlKIZOQStIhM9V758K57SK
 JXwr4WqoyJqsXqkMan1KpXsE/OVRH3eo79ot5AGbpPksH/yXSJaHW2cppOLk/727/GTWpXopw
 9gTanf9deZKBkYKOT5Y4DKe2MoXwJVw0/LBygZ6FXGW1GdGEAFWZ3fMOBppZPKX7O2MnWf6J3
 u3EbMpgBySH0Yedrz9asCHdv8mP+c5KGl9NyVlbtLDIoGy4Q9bo+yMuaUSrVYZVJVbznD4VZu
 XeAQtMB1r/epRIqdeFbjUndkLlxk4gpjs7hg+7RuZVT05BQR4v1w2RdpDKAK+DAJiLdxiMTAg
 OkU/jgtumfC5v1bJGL7TBZK8spL3vFEMRF9ZfDmwb3EmblvVkkviN8Ud9R7tVw+wW6yjnDDuh
 lP4sTBq2spaIB0BvmeANn996FK4YHXAXTpSzN/5udBfNoXgl5Q0kQ0DV+pZeSOOoHjxaGP4Dr
 nxUqNapmP2BSGBHx3EoUtAwv+BqOwEU3iF+Nkhlm04thSgur8osVvERRzNei/5dZMzCUSNPiR
 uMQKiqAhNsnqwRU+1f4Dsjr9AzLul0aXCZxZ/N6xNDaztlfevC+6okys8apOvJRBhzvKiyLtq
 6AQYLFPfwz7jCfY0zqQFQsrJvfG6ehBSWZbZ8VXSY6YdULM3OncDFFg1Cif12y9vU/62rtFlm
 NUDVHZ9c25Q5O2j+7GUWaBVbjVGE9SpYBTzrt+5yZlmUX7JJfyptS0sm9lvCGV0ZuMHYnQiBT
 E4Y1QI4u25+xqVRFFtXhyVhswrBCaxB/vmlvzTgp21pQKKS8wI01ohWH8Rd36I2Os1+qXicQh
 MowQjoYFRycxjplpJot/METHkeI4S2XaYF7GBfKhRLNvCSmIflzc7TeDyyrMZBw4fNUEH1jYR
 X3QPybAnLAz2TvzN9wpmcQVkdbWBcrT+wq12/gOziqEePCzHP42mANhevTtcCit93XEB25qQk
 4kYqr8h8CmOFohrBdjjSKvGF3Pinq8aWJkqp10G1U3G2PauCEXpavOmVao2QWG2TqM6vO7x5n
 LgqAofno6iSXu8VB4iyLMtUvgMFEECctKVEL6laLpGoYvYfpWErNWdenT4Av6vkdPka+wf7jk
 fHZDr6YW3nsyoolqXEmLrcmhKucUiAi4HlAn21L4F/A==

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIG5l
dC9jb3JlL3BrdGdlbi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQv
Y29yZS9wa3RnZW4uYwppbmRleCA4MmI2YTJjM2MxNDEuLjQ5NmFhMTY3NzNlNyAxMDA2NDQKLS0t
IGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTExOTgsNyAr
MTE5OCw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwKIAkJaWYgKCh2YWx1ZSA+IDApICYmCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBN
X05FVElGX1JFQ0VJVkUpIHx8CiAJCSAgICAgIShwa3RfZGV2LT5vZGV2LT5wcml2X2ZsYWdzICYg
SUZGX1RYX1NLQl9TSEFSSU5HKSkpCi0JCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJcmV0dXJuIC1F
T1BOT1RTVVBQOwogCQlpZiAodmFsdWUgPiAwICYmIChwa3RfZGV2LT5uX2ltaXhfZW50cmllcyA+
IDAgfHwKIAkJCQkgICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpKQogCQkJcmV0dXJuIC1F
SU5WQUw7CkBAIC0xMjU4LDcgKzEyNTgsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBNX1FV
RVVFX1hNSVQpIHx8CiAJCSAgICAgKChwa3RfZGV2LT54bWl0X21vZGUgPT0gTV9TVEFSVF9YTUlU
KSAmJgogCQkgICAgICghKHBrdF9kZXYtPm9kZXYtPnByaXZfZmxhZ3MgJiBJRkZfVFhfU0tCX1NI
QVJJTkcpKSkpKQotCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJCXJldHVybiAtRU9QTk9UU1VQUDsK
IAogCQlpZiAodmFsdWUgPiAxICYmICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpCiAJCQly
ZXR1cm4gLUVJTlZBTDsKQEAgLTEzMDMsNyArMTMwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdl
bl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfSBlbHNlIGlmIChzdHJjbXAoZiwgIm5l
dGlmX3JlY2VpdmUiKSA9PSAwKSB7CiAJCQkvKiBjbG9uZV9za2Igc2V0IGVhcmxpZXIsIG5vdCBz
dXBwb3J0ZWQgaW4gdGhpcyBtb2RlICovCiAJCQlpZiAocGt0X2Rldi0+Y2xvbmVfc2tiID4gMCkK
LQkJCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCQkJcGt0
X2Rldi0+eG1pdF9tb2RlID0gTV9ORVRJRl9SRUNFSVZFOwogCi0tIAoyLjQ4LjAKCg==

