Return-Path: <linux-kselftest+bounces-27325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086CA41900
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6921773D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F62505DE;
	Mon, 24 Feb 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="OSjKnjRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E224E4CA;
	Mon, 24 Feb 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388986; cv=none; b=uOX99yZ+XDsK0IeOxmcK+n7xfouwBQQbJb/1UE3d7ka/Tl25cxY837s0Q37PNo1h5xTW77EA3PogN8/QtzW3sgmxQB3bIuiLrRpAOWZee+gcLU3l+Ijxtmc4JVTrFwdkLx1X1BbkLk1C5thlXPlENzBIoUd5CN6d4flHye+1B80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388986; c=relaxed/simple;
	bh=nFpR1GNOqJgIdZaAhB+vgdglHLY0zBSfUjt2gQkoN94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M51l1zd3cGUPFEQFmrXwc7g+mfpxZfRMFHb00KHT/eEM2tJ6Czbe/lWgGRWafTyCcII8C8lz1BxsJCM2QfAN9HzLt5bxaTdmu9Tm50OQFBsUr9uZGiM1D6qBKkuJOLhWq7kU+I+uejgGUBEHFinfPC0yLpbeaXlVrsnw70lFN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=OSjKnjRw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740388972; x=1740993772; i=ps.report@gmx.net;
	bh=nFpR1GNOqJgIdZaAhB+vgdglHLY0zBSfUjt2gQkoN94=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OSjKnjRwZNdnb5Yb4n492YiOGFHGyzyjuMgOA15t7CcJwJAlLxOzI+f5QNehSQ/0
	 RgJxlQWvZdXNhKWpm5zDn6XlcigtTF3a0yR/89PfGAFXM7qxKr34zrOaYGUe+SsUi
	 86dO1AtPlt6cowmyqb510D58XvqZZ84Gg5FHpc9r9zGiNhUe65V07ZboMhnIrmq1g
	 nkNekONxanrzVcpj/FV5BAbwZ76clhLQy+mhp9wnQjx7fHhgoRYx6CY/rohZA0reu
	 E+WgUku5erWH6GMtsvYrZNMTLFeyMcMqqCrhKs9dkDp+udjBz1jSUVtKsa4U4dJJo
	 5PtIUyPOLh8/AFxBHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1u0IAg0W3O-00Js7k; Mon, 24
 Feb 2025 10:22:52 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v7 4/8] net: pktgen: fix mpls maximum labels list parsing
Date: Mon, 24 Feb 2025 10:22:38 +0100
Message-ID: <20250224092242.13192-5-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224092242.13192-1-ps.report@gmx.net>
References: <20250224092242.13192-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:D04AgCst6nQRznuby5CymvqTa4+iPaxfoklv9B8lQevROeVX++a
 GX8CyvhnddmjXKUhWiI10xXgF8mr9lNz7U98LNiDmv7Zt1UayX0Jzkqe3TPpOWUvusiTPWU
 SZ2CD5aV5kmaA6x86Os8ZcSo9EKDt2yJOAdg3Bjx5Wr6QutwvvtywxYgT3rQMHF6tOSmWZG
 69ZzoRfsQ6IVhq6Is53TQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SluIFem2MTI=;+U8lB0/YuePV04yr/mC6G6SKBPr
 ikMIwtte9XQHSiyStT/VZjHBFFrrr7VFLFY6k2X8UPzjsDH98kopb8bndCN4UKQ9kQJjvOzYY
 Mz1ghFHWIDh9fhhP12w2XsjNHG8bb2MVMghksswDyTZAdX6J6y4GqzBWrWNZTxPtcojnmJI+L
 tB5329nqO30yDG3UQ+DD+88E1/Sndcr0BbojFZQfcgcf9/d+yrxl9dOIwW5IFoXsjxS9nFQ62
 gSsJnHS0BxO9a9O64nJe2RhaHGM1LM3TlDWxSA2EewWcG4Cism2NXsK94fwykz3EUiC+4AZlu
 H3Yw/4ZB+EETdbT6WXSj/JT/QpB+gwPTZ249+8UERsAciGm12pZTmWtDBgunVXqgunrzktXBX
 RCFmMRDMohBwou4/jMV/KgQuYooVBVjeinDVIoAtP9FW4Aooqk2GAfpWajsc9RO+2xoOm7+3Z
 UbIMcMEeL2vUnShlU/um3hUjo2CwsSAYVNV4Pm7YzmUGk0UZlo+Av+tYJcaFZXRzpyvlh1ZYK
 IAVev3Dk4+QjXbbgpjleeEN/v28/RIQ1SYEd8oLXs/hisDZNB7QuGbF2VgeXUQSrx0vOCyd7X
 rlx8UCpnWLOxgQMt9X8dusA/PPQTFEM1x71AlMWpj8ZONlQvNU3X4Nfmr3L4tmnIESZLTD9rR
 NKCE7W89ZIiXVK2n7KT3uhJeVpsJkhnLX6KmGkmlCMHZUs30/botmrUMIh/xYPhCyXh2ayIL2
 7VO9dsT6LSqn9RcgRL/0eq8VJRiCpoNbePehyr5/r5ohvw+y46DWhgD5uFQ0LJZmLit06Ww5J
 W8Dpsw8HaYA8rGpYGw79NmOHDMwn8500/vaiFmGQ6ewv2KQA5LMZeh9lhgetX6jzoWvtMg0Qd
 o/GT6W9A2iWY/4mtamDbPH4gQKgE+WB3+8IsPl3OlwRXFE8Ng7wQTzf6PVvrkPBhErxpgOcvM
 V7/vOvSjOILljyyq1PI0/uiHtyzeQVEs8jtG3mv0b5HIZI20J8foeHJBsnGxyPqy7lduNqkQO
 TN2Y9eyCNCo6R2+am8x8x/hMy2nPvAmqtij4q/U/NwMhWlYfgfChXUiYESFFGhKaYgtdTAQhG
 7/vuJ2TULBjfZU2elCokFLaMW9jsFINIjLNiFC7s4aUL04xy8fqd+KFQ2XiyY7JSEAf1iS+4W
 aVqL/3dG1/4f1sHoSIi53f69BNqDIiS/L0QfdyJwURiRryMgLyzSrHHXrMy0haThCM9Z9wdEI
 7VMgwOsle8H4bFWKcvlu6UOJAvlJXb+TIiBvCPowc1sYm2Yvq/Ghc0p2TLC4uImJVXPVdXXXJ
 VgDolpW/DkUob7gkyF8+EgbOZT8YLa7R+8O2Mc156l81G3OwTCVhg3cyyWRJ0baVOOCrj8o/C
 XM838jdBTw2WcBjWCzTJubmTsDa2GWHzuneT5XSBZKIAFGwFjWhcV6Gmcn

Rml4IG1wbHMgbWF4aW11bSBsYWJlbHMgbGlzdCBwYXJzaW5nIHVwIHRvIE1BWF9NUExTX0xBQkVM
Uy8xNiBlbnRyaWVzCihpbnN0ZWFkIG9mIHVwIHRvIE1BWF9NUExTX0xBQkVMUyAtIDEpLgoKQWRk
cmVzc2VzIHRoZSBmb2xsb3dpbmc6CgoJJCBlY2hvICJtcGxzIDAwMDAwZjAwLDAwMDAwZjAxLDAw
MDAwZjAyLDAwMDAwZjAzLDAwMDAwZjA0LDAwMDAwZjA1LDAwMDAwZjA2LDAwMDAwZjA3LDAwMDAw
ZjA4LDAwMDAwZjA5LDAwMDAwZjBhLDAwMDAwZjBiLDAwMDAwZjBjLDAwMDAwZjBkLDAwMDAwZjBl
LDAwMDAwZjBmIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCS1iYXNoOiBlY2hvOiB3cml0ZSBl
cnJvcjogQXJndW1lbnQgbGlzdCB0b28gbG9uZwoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVy
ZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NiAtPiB2NwogIC0gcmViYXNlZCBvbiBhY3R1YWwgbmV0
LW5leHQvbWFpbgogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2NSAtPiB2NgogIC0gYWRqdXN0IHRv
IGRyb3BwZWQgcGF0Y2ggJyduZXQ6IHBrdGdlbjogdXNlIGRlZmluZXMgZm9yIHRoZSB2YXJpb3Vz
CiAgICBkZWMvaGV4IG51bWJlciBwYXJzaW5nIGRpZ2l0cyBsZW5ndGhzJwogIC0gYWRkIHJldi1i
eSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNoc2V0IGlu
dG8gcGFydCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQogIC0gY2hhbmdlIHBhdGNo
IGRlc2NyaXB0aW9uICgnRml4ZXM6JyAtPiAnQWRkcmVzc2VzIHRoZSBmb2xsb3dpbmc6JywKICAg
IHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0
Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lk
ZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5l
dC9jb3JlL3BrdGdlbi5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQv
Y29yZS9wa3RnZW4uYwppbmRleCAyMDRmOTNkZTAzYWEuLjAzZWE2YjVkYjE1NiAxMDA2NDQKLS0t
IGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTkwMiw2ICs5
MDIsMTAgQEAgc3RhdGljIHNzaXplX3QgZ2V0X2xhYmVscyhjb25zdCBjaGFyIF9fdXNlciAqYnVm
ZmVyLCBzdHJ1Y3QgcGt0Z2VuX2RldiAqcGt0X2RldikKIAlwa3RfZGV2LT5ucl9sYWJlbHMgPSAw
OwogCWRvIHsKIAkJX191MzIgdG1wOworCisJCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKKwkJ
CXJldHVybiAtRTJCSUc7CisKIAkJbGVuID0gaGV4MzJfYXJnKCZidWZmZXJbaV0sIDgsICZ0bXAp
OwogCQlpZiAobGVuIDw9IDApCiAJCQlyZXR1cm4gbGVuOwpAQCAtOTEzLDggKzkxNyw2IEBAIHN0
YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwgc3RydWN0
IHBrdGdlbl9kZXYgKnBrdF9kZXYpCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJaSsrOwogCQluKys7
Ci0JCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKLQkJCXJldHVybiAtRTJCSUc7CiAJfSB3aGls
ZSAoYyA9PSAnLCcpOwogCiAJcGt0X2Rldi0+bnJfbGFiZWxzID0gbjsKLS0gCjIuNDguMQoK

