Return-Path: <linux-kselftest+bounces-26525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25424A33DAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D827A2F0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F421D3EA;
	Thu, 13 Feb 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="D7rFTfN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088721D3C0;
	Thu, 13 Feb 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445569; cv=none; b=d+kcjshSYSZ9b/gBLEHpgOlcrjrnrhhQYYfm4kqX56BgodGtVZFouxPbbKs9BLrbj/1zP1p272BRJyOnC5BPHoiG1+cUkTzkLRQ7P4gHMiinoGYKRXkn16hSCBffdgrAuAg6Iqr/1xvh54+XFq8yTpwz2wConbXvEx9NLPz+/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445569; c=relaxed/simple;
	bh=JdIo+E+SDO2PpXqGE31iS5BduX/7fzUOoJLxV9EOoIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCBhRROZDEnTirPpgKCT8Eft/Mz+I/2SeLSn7pS3IOgjJqM85+SyEUIHJ9V2JUadBG0FayEo9LaNIXVVJ42Vgbtl6sGZJgvb/LwyfCf2JM+utKo0rmcKpPmxfwWh07vO84JIOMeYzJ0044Kg67CiWlZhUU8gNOg7+du+gXn4TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=D7rFTfN/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445565; x=1740050365; i=ps.report@gmx.net;
	bh=JdIo+E+SDO2PpXqGE31iS5BduX/7fzUOoJLxV9EOoIs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D7rFTfN/YKkRmt9Fj/2eYQEEJUzBb0H7a2/8prAvepjJo6sX/77qQj4Yza5E6Uu6
	 zglQvGQPi8+UNbKT7TDA96Zt5OixAtVR3ZCUTI0OQY91Ab8ZMEgt2HoQzfH74i2SK
	 WJqLUZvLVreTf6hG5BWe4C6xtxUsQdApKVjJgq+DnQy+aq22nA5oSS1TX7k4bO607
	 6u2R9BZ4Yj12YQzy0LOocT4gGmmnmziw7JCpi+2UNALUF1YVqXNouvHRWSfFTs6y8
	 Vb7vsw0tfcs4MWQOpQurl83VqcPggB+bqgz4fWolWE28zPHGptESsQ5gGENrbY/Qu
	 cHcx9u/er/XVyz92ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1u3cV82hRn-00IDQ4; Thu, 13
 Feb 2025 12:19:25 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 2/8] net: pktgen: remove extra tmp variable (re-use len instead)
Date: Thu, 13 Feb 2025 12:19:14 +0100
Message-ID: <20250213111920.1439021-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213111920.1439021-1-ps.report@gmx.net>
References: <20250213111920.1439021-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:H/PhhsIqx8cvF9Ak2WsVYrmclqrSpkz9+min1pgZUT1xDT4qsQH
 7xMtbPuTOVWzdAQ3TWmIIJb6XkD7zBQ6+0DSYwTB5OBZ5FlmFyEquGy5fGwn5zbnMa9YASr
 oNC/Y2RLuxBhKDdlVxZnYr5Zd0yALIBnJGoEhm5llBBdUacpZhdtHVevY28af2ESxip12ay
 KF/dflynkBTKpH2iQ/7Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HjEOTSD51mo=;X8dO7O9PvvITsu6aujW8bHs2GWS
 65Q+Zux3IQizWR0aRLcld2+IXXhzFgLmdOasekr9AhfBXd56FWPIjXoyV+9OnDc/rZ610qJ50
 ljK8iF2xfVwwJ02saDABPkOnnYMlnLzlfUWt5QUZg/CzGhXBt0JX0ESO3t6uMyXij8W2R+Wt8
 Naj36fEdGivrzF7wyKsQ/QU0atgTHcFuZEeVNvvyUwxosVi6pCQNzVjQwji1vcnCcOLpTe60c
 MC6fVibx70xtY/3fnVCXnB452Sq1m2FS5kpkwH9lTFIH5qw3T4CeTXObPCR52ZUhQiTa3bWEJ
 X5Ui/i4lghrEfIhGJUHUCsZQSd5/u7diwMl60E69yx156CvhcsXxCwEJMINNdU1wyquoGjtRp
 f/wZkkofAsYVwQy9IDMeADyHPEbtqq0zFGeBmdFORqWFAMOP8VClO1VEBlT9HgMxavZJpFeD4
 6X9A2Hh1E9bYAzXku/JBtBPgjPcLtx3fuWH/fJg7bCW3RpB4Go4h0p3BavfkWUMsRNVq/GbYb
 d+VoN44TlIAGwvEhpLLtlhm44KCee/ORkFV1kRBCRwUGbQgfcdHeqjm8DKVjVqTFuFtjltGPc
 RDTKleOIAXD/uWFkZ+VTcWpWAOmo5kUQfds2dLcU2fBceRyeas8UPOJqexNrnOCGBNAU3DBsW
 r4fGpZqnxgUDlgkR+T+a2fjZWsoQL+jMRRaeKr/XJfywk5F6pjmClZPaO7z66UhN86FmuwNMg
 2UuE+B8e5RCZaemH+R/eed18ihG38tYkPU0UbqTe7HjglmP/zzY81jG09W3voHQkgPMfGC3M6
 nEfAcDAIogiJvm2+oeOlrU/np4GUEhB34jhdWNrtrKURzfa/1lXpf9XmUkLL68mhFRN1dl9o4
 q9IfKWpv/Am1yhcKjKDMoQ/v5Y7E9PuCNKqY0vnGxsYrrjHWPFZ4mBLvyalJrhI4lXmsrlomG
 ++cmIerPapHQPQGHaNf0CvrRKSo7oVYrmvjghsAnQsEsSinq2YJy9h775TaNhhuK0ne7dYRQh
 9RwN7CaeF9wCYlN8640XNrFZTfc8FwjrqRYW7FchJZBCXKq5gdvBsclIX4o6Iza/IVjfKiHAh
 gYvqT3pwxtU8KSZ1uPz7fq4TdtZa0k0foF1fmZx2G23w5WdZeF3BPh38sbxcQy0CndCIUZI3Z
 GwkVQpoOKbXp3XCfq3e0IYogS4HdSxGT/BOPZxpqACNCTbMLtOF0rbK0vzwT9YcvMhhXld5u2
 G0gN3mGrDVFpgPJJ+MaQR/rjOstS/hCIb+X3IvEGj0bsjqbg/qyn5UDHbmyUpYr6iq7RITY08
 7sxzdG5LUb9VTLk8ooULdX1mKhWFyXQbKjin5YgftbHqInSsIAm6mPDXNBGFHcfvdcF+98tap
 G0FXZqc+dv8uLbJCQACQ/PrELA54GO3m/dvT19gzDsvMdI3dYUtxlLI/mz

UmVtb3ZlIGV4dHJhIHRtcCB2YXJpYWJsZSBpbiBwa3RnZW5faWZfd3JpdGUgKHJlLXVzZSBsZW4g
aW5zdGVhZCkuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5u
ZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFu
Z2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2Vz
dGVkIGJ5IFNpbW9uIEhvcm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFuZ2Vz
IHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3Rn
ZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2Vu
X2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgOSArKysrLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCAzNmVlMDQyMmM2Y2Mu
LmI5ZDhlMzNhYmUxZSAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2Nv
cmUvcGt0Z2VuLmMKQEAgLTk3MCw3ICs5NzAsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJY2hhciBuYW1lWzE2XSwgdmFsc3RyWzMyXTsKIAl1
bnNpZ25lZCBsb25nIHZhbHVlID0gMDsKIAljaGFyICpwZ19yZXN1bHQgPSBOVUxMOwotCWludCB0
bXAgPSAwOwogCWNoYXIgYnVmWzEyOF07CiAKIAlwZ19yZXN1bHQgPSAmKHBrdF9kZXYtPnJlc3Vs
dFswXSk7CkBAIC05ODEsMTIgKzk4MCwxMiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJbWF4ID0gY291bnQ7Ci0JdG1wID0gY291bnRf
dHJhaWxfY2hhcnModXNlcl9idWZmZXIsIG1heCk7Ci0JaWYgKHRtcCA8IDApIHsKKwlsZW4gPSBj
b3VudF90cmFpbF9jaGFycyh1c2VyX2J1ZmZlciwgbWF4KTsKKwlpZiAobGVuIDwgMCkgewogCQlw
cl93YXJuKCJpbGxlZ2FsIGZvcm1hdFxuIik7Ci0JCXJldHVybiB0bXA7CisJCXJldHVybiBsZW47
CiAJfQotCWkgPSB0bXA7CisJaSA9IGxlbjsKIAogCS8qIFJlYWQgdmFyaWFibGUgbmFtZSAqLwog
Ci0tIAoyLjQ4LjEKCg==

