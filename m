Return-Path: <linux-kselftest+bounces-27235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5341A40249
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A707A8A25
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF825335A;
	Fri, 21 Feb 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="B2VqTNCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CC20127C;
	Fri, 21 Feb 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174778; cv=none; b=YX62EmeFaj7CnHLe/AM50lpexdp9GdHAXZtcy0j9iTL67tEid3ofkSqTmd0Qrj4X/N9/1ud/wgRYcmRbp2S0mMGG2HtdDoRexrXIiqajcduMPermRnGNnQOY5SRndOIwyNdrFlY810b9zwovRF9hRrcM5UCE/QWQVZavemskFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174778; c=relaxed/simple;
	bh=VODrfIAOe07267joIm9z549kGH46LS57jdE0el030yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFluI0tdYgR7PekyIULPJawmfhoby0j+9kNqMiDgt5YdXqsmbBS91053hS7M5UUknCHHacj5w+x13Gt8ptB2rfYTyIfzNTcVw5MfQp3Tdh29VMQrHbyOr1rNlz7FdEKKyTuRSSbmfS+RuYmYUQuMQjnOzAOWfNjXL23/gPWp1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=B2VqTNCG; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740174771; x=1740779571; i=ps.report@gmx.net;
	bh=VODrfIAOe07267joIm9z549kGH46LS57jdE0el030yM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B2VqTNCGTQD4bGHV90qrAB7ChrPkCg938rp8I39+vNH8jhUK2AxKVWhBx1v3m216
	 Z5EU9Eh9QP5c6w7pD5VqPfQoFiXK/2eAlWa/LfTubDvGbUEhjM6FNLfklGxKtMRfF
	 csxcDaqwHK870luciDqBhnRxrSnk1ydF70N5O7WNDfDjie/BUNULJB3fIXm79nTiZ
	 SbUt4yNM3CfwWRfRBi/XlGQ+mTKP07wiJmGgljUIoGoqPkbWVH8BNvIPJvjapfttd
	 j5jpVQuOAJvvSmz41pHg4Gi0bVRaRBG4CmVhL6IB6Xtwvde37Sq4bxvyRCcK8hmei
	 ygvLSm67ZtFLiLlDqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1tguNw1Gj1-002sHT; Fri, 21
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
Subject: [PATCH net-next v6 3/8] net: pktgen: remove some superfluous variable initializing
Date: Fri, 21 Feb 2025 22:52:41 +0100
Message-ID: <20250221215246.383373-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:cKdqq80VN0HruqbYuSuJuljjOjhZaO5bS1SIDecYB+H4dcr9zfY
 7s7bVt4IyRFItM0kUGFyuAHx1BUbXmal5+/q/peJWi/Y7fworxfqT2f6/5ZMHyFoxme3xRw
 kq6pOp8+FInDChwnZcM/58kCiBN4/BQ7t6zdX03X/tSIzW53qMituBK9YBm44eWQQ3Hqu5S
 tdwpIZpUasjkl+8sF+gAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IKXuZLgkGEc=;oO6WgifjZQ1WDL55Gn6iVu+vTB0
 3/IS3juyO1soXKD5v9oWJwkZb8kiCagLEoQNzepp2lvKAY32fTfiVhA5Ggo7BSYGPwOg2YUWC
 piAarp7eriUi8iq5pt9I3R2xrc4HfW5LEilGUXuI0LyldYfDaiqZxmMSXauvad6YOonJyO3dV
 GvuoAdOEZWDO4hpVeWK134ae7DpZfIfiSaU5WLuNwwW68YreozZTW7qplyPQUlvmRe+EwC4JV
 uynIv7PFPeTjDMSNY3N61DTKpN1h8RM/IBDDe6lv3LtH4kq++RqI3DtZqLe2RNv+CMqHKJDrt
 Sa+hh+dXrWFjsi7Pn2Uj/xtTckfXau7UBrVqAKLt21VoK0849rwfcHW1aiCBc5GQbMl4WzRer
 s8ex25avl4TbG+jgnWoF88+fGnawMd5mESMY9ysNj6gzd38U8oV+ZNaUATCiVY6GMxuupilVd
 4YXlMd2O/SdYMhq9PQz+9LOpqleaqbzKfYeEhunnPrfPNNScpCzsiFGgvVwFgnnYsdE7IhkwT
 3gtBP7L/rlKOPnL5+PlhbVKkGvmq3TQbfwBqC7rrNxtcWsV4ZSSxG24N0ZTnPzTvbF1wzVZGP
 hRySJxvYQxmi1ryOFxis264X7xR9dhkD+hIz2zxcYrov7e8ZJb9ribH3uPPGMvhuLDyQ7Vo3l
 aThpH4SOG/MrisRU8bshWWPQGxgCbCzJmGgJi4vEzjshs+NxUgT9BgRubW/41dpTQT+WnXCzH
 +FatsR4qX24XUbUtOdLqsh9SKSIyAWaAFh2MkqIrjoRGsA4ehs5kIXeuyKiW13fKocHtJ6EFu
 BXLNc6gQTU7k3/S+dIKZid4k9KgvPoZrPIAsB/ifiABU4/R3DmtSTXtSWPxAZ33/pi7Dj7J18
 6kO5FIHQeJrIms95QX2p9FdHllN29GYNIlMAhcyqihYCp+myZXV35EaTwSoa/ivLeZVBS4Y9J
 cLrYaGW8qLuDzm958hIFtS1SekdjG0Ji7IpgNWrulfn5Vd1Gcgc64waFX9nG9X6l8d/iKvjR6
 GE3E2baMRqv1wTE6AirLayLQZAJsc4u2tbIDaGkvuQGxQ16BE9UXdYr6TYEv17Ld9b2k2spcY
 h9JkTmjHLGfBaMBU+ezpuEP+sq4Cov5nlYpvK1dHJhoG8LwtWVD5T1H9qnR16A+i4HqAKCzdA
 6BgsCIrY7nNy6KgA55AGSjjRmDa3p5UAcg81lvyM6GJ+GG/CAX8XaZz0nx5DDRfMmBmun9xj4
 Lv6B3w8wySaB21zQ50z34jHWpyLPXOfsvn6tjvKbFhNX/zw6ai+4g1dPNwAkXRTlQMRiY2J7K
 8rZO9aA0wQSz7EJjzcMXMrT0H/jMJJNeKJVcAFw8n5OvJn6vq98YLX0dqLlIC7pOjtTpZ9EUy
 S9PeFT12hUcTtMDig4En7Nk61xxuOSeAg5VbXwlk1n6J7FRCgvGGt7oDeH

UmVtb3ZlIHNvbWUgc3VwZXJmbHVvdXMgdmFyaWFibGUgaW5pdGlhbGl6aW5nIGJlZm9yZSBoZXgz
Ml9hcmcgY2FsbCAoYXMgdGhlCnNhbWUgaW5pdCBpcyBkb25lIGhlcmUgYWxyZWFkeSkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5
OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY1IC0+IHY2CiAg
LSBhZGp1c3QgdG8gZHJvcHBlZCBwYXRjaCAnJ25ldDogcGt0Z2VuOiB1c2UgZGVmaW5lcyBmb3Ig
dGhlIHZhcmlvdXMKICAgIGRlYy9oZXggbnVtYmVyIHBhcnNpbmcgZGlnaXRzIGxlbmd0aHMnCgpD
aGFuZ2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3Vn
Z2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFu
Z2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBw
a3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0
Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNCArKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25l
dC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYjk3YTk0Y2I4NWFjLi4y
MDRmOTNkZTAzYWEgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3Jl
L3BrdGdlbi5jCkBAIC0xNzg3LDcgKzE3ODcsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJaWYgKCFzdHJjbXAobmFtZSwgInRvcyIp
KSB7Ci0JCV9fdTMyIHRtcF92YWx1ZSA9IDA7CisJCV9fdTMyIHRtcF92YWx1ZTsKIAkJbGVuID0g
aGV4MzJfYXJnKCZ1c2VyX2J1ZmZlcltpXSwgMiwgJnRtcF92YWx1ZSk7CiAJCWlmIChsZW4gPCAw
KQogCQkJcmV0dXJuIGxlbjsKQEAgLTE4MDMsNyArMTgwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IHBr
dGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAl9CiAKIAlpZiAoIXN0cmNtcChuYW1l
LCAidHJhZmZpY19jbGFzcyIpKSB7Ci0JCV9fdTMyIHRtcF92YWx1ZSA9IDA7CisJCV9fdTMyIHRt
cF92YWx1ZTsKIAkJbGVuID0gaGV4MzJfYXJnKCZ1c2VyX2J1ZmZlcltpXSwgMiwgJnRtcF92YWx1
ZSk7CiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKLS0gCjIuNDguMQoK

