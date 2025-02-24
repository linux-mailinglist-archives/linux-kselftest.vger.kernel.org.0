Return-Path: <linux-kselftest+bounces-27323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE9A418FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322D3188BDC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0E24BC19;
	Mon, 24 Feb 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Mibq8nS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EE24BC08;
	Mon, 24 Feb 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388980; cv=none; b=OEGr4HOHIJmZ9lvoYtwEHHi0dfBRocqX4pouPhyuQtmC0iUlN+LfYLSwSf0YNKIaAIHnwVTGMkMy39pPGdeyJOeR2qxQtHnP+D3A96m3J/JZBl3Y61iSNAGIT/4E6y1q6ogXKHXcqhywePKuq4gYZZBwkdOeDg3n6+YrGH9jmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388980; c=relaxed/simple;
	bh=j+ZMvUdvZ7CSrVjG/S0MjvEWJ5CEcbjC4jhnBGbsaxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJBXe3AEEpgVCru9JTvk8pytsOxH7AvIC//94gAn9ZYvy3sg7FQoiaNSVxohBUF+satxInTy9IfnxrCVx9PXCEfCLwjhbp2o4KOT4pWM8LR52eRWpcrxV4VbwnalPYZHazOz6ChWHGHe6EyuRfEBXToOJN1MiEHoM9cnjKqGLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Mibq8nS0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740388972; x=1740993772; i=ps.report@gmx.net;
	bh=j+ZMvUdvZ7CSrVjG/S0MjvEWJ5CEcbjC4jhnBGbsaxs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mibq8nS0dkfxO5upgth1mXJBmiBkquiDvxJezOPmKv7Ao2H9nT6RnylAxFHCP5Dk
	 CEvSw6IEswfq0mUthaPk8K8WKG/U5YWLjz/w7dev36MU16z5JU3I35121h4ua717I
	 nquH1/5mOVTejeGTtJSDzD/w6frYf5UjPe2RzdRii8WBPbST4fCtKW++zZ1Bi1X7/
	 /uO9NolkzViIHiZUQFSr1su3NeB25MoBayUx2lFHx/JV5ubGhRohnF7O+UDwNU4pK
	 oc3RDlSOdRaPDj5c/RF1m7yakpFlhCXiWShdWjWBS03QSf5zHZPTDEPNFvrb4ccfD
	 F0heFun1WJzslfKOng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1t2OLD3Dy4-00n9Tu; Mon, 24
 Feb 2025 10:22:51 +0100
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
Subject: [PATCH net-next v7 3/8] net: pktgen: remove some superfluous variable initializing
Date: Mon, 24 Feb 2025 10:22:37 +0100
Message-ID: <20250224092242.13192-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:3o6Ia6EmkO6p/MdUU5yA8mxbjTpHv0TYmStRBQccVuD/XjaM6d5
 wB8/gsQVENCs8xCe1CBmBtgPLw6694rXG61Js4sJ43tOA5TAdG7OyQ9hKlJbmNHr3q5ZGIi
 KOe1zWJxeGEWK036/KE7RhMOf2PA4AVTUSmKy0g/Hp2AZesYuZQXF/D/NXOk4Wz4+h1JXx4
 1npj2GQGMd7LiNhnfVNog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IU7UvSRrSqw=;uLmh5DULuauslwE8XtK8gCzjuLr
 segtQwEVYNF5u/G2n83iNBOAQLsiRNHGFKyD8i8hOTXG9KlGUVuaMeMeftiIQcBI4KKIOX05C
 6TqvRSXDVhSfKOymZs9r8SRiFFSznmoiygTFm+/G92B91gzv8BOikwHFLqhhyNdLmeg6WsaO7
 iyMb5xXfoEJf1Wt2pgKmvjsoz9nFoGHltUrP4ccmNyu11bJOyQdcxz/IXIH96PS1mS3K7A2dG
 w8beBp6LVrE+Kvu4Gv54rcbUAixlI31KK2hcSdAGGg+gNZ13k0wa5WjmOK58DY7LyGT4ymu0s
 oAsGaBGemHw9u0BWC6pfqNXWlDiwvR5Na96lRUC3jGjwML6TlT8xXVU/pKgKN8Zr9nwqbk0ob
 R4CSS91MtBEkpKI/289ifvxEJjUTC3sHNHln+iyt1vEnSE/TtP0nhkrq4OxxK934x0LHy+T6T
 S9eG58YVSpK7AaWssvTjdQaTVmtrCbeAYYivOTCs8AuVn/LMov34jWrRJKTVAJA3P6O2A9kxn
 kQNJFbm96Rfa444Px7RFBNkfgkHQFGQwafKKEKlFD+AWXgs7sZ56zVaYFFXFKijElJkDZi2Q+
 ie9aaZu57ZOPJAAD3jnNTUrp9E4jQMPm/CgrgCiu5soJiGReX+JNPQHcczTkqWbudfVWuWWR7
 9R9v3UFXffjqiXvlEF2kNVYLnA/Pi11VK8Wdy+98HbRO6RKgIVBs1n/qNCMVMoJakcKRruumk
 i6lHMUKteAEnxgrSGbw8uMGaFQrc0lJNSRkcAb1GQG2ImsAaPUObZ6LwQyJy0eWJpMNtuqTIv
 BDVzHTekEjYtjqPbRJv7aDa+V2vKwPfayJRct6B+RIIDrr5K2KMHS1M9ZhwGDXUZnOdtZI/XD
 NnQihkAJGpk4SbOzGtVsvAmqWmzE1zYyLxip7f9j3dMXnyu3Bkst6RNmogB0ARyRhqd50dXlO
 NmVPn3WOBkJYMfqM9cMR85rXfzF+GY1DtfQyDzKrDq3uKP7pqHM7/U60mVy9gpHO3HGMLdiHV
 rc5GcWihuc5JkX5t3MYvdcR9Wu5/3R23IS90RJFK1xK3kD/LGm+QgcLOVDllsPxGMlthzGY5C
 SUZ+8LLNrS/MaV/dSIGVdbdC81kWFcHU5u5UxxTY68s50LoaM9hU9/bNEaDJcv4XXuI+JjtGB
 MQSfE5GMcbwzcsAGvYio+Mn9+CFAtyUSpq67k/EpgbAJG/XoB0s+jVGmkVr1bamYQzrr1uimZ
 kvtbjgN9apyxXKOlgYn2byH6QyOO98w2VLBpDKkircis/B5Z5YanRt72nG+HNb4ICUMIIRwaU
 I+Sfm21868REHnBf45VwziPbY0CIUbD0IhcPPBL0KN4If0lpqkikFjP1RNv0fxiF0gO27MuXR
 PIvaf6ybs+9rEfk9Ogm168ou/JDOFJtjtwE39VkWeJRdiTt5gv5MnYHCnV

UmVtb3ZlIHNvbWUgc3VwZXJmbHVvdXMgdmFyaWFibGUgaW5pdGlhbGl6aW5nIGJlZm9yZSBoZXgz
Ml9hcmcgY2FsbCAoYXMgdGhlCnNhbWUgaW5pdCBpcyBkb25lIGhlcmUgYWxyZWFkeSkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5
OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY2IC0+IHY3CiAg
LSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9tYWluCiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2Vz
IHY1IC0+IHY2CiAgLSBhZGp1c3QgdG8gZHJvcHBlZCBwYXRjaCAnJ25ldDogcGt0Z2VuOiB1c2Ug
ZGVmaW5lcyBmb3IgdGhlIHZhcmlvdXMKICAgIGRlYy9oZXggbnVtYmVyIHBhcnNpbmcgZGlnaXRz
IGxlbmd0aHMnCgpDaGFuZ2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBh
cnQgaS9paSAoc3VnZ2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24g
SG9ybWFuCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBw
YXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBi
dWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYjk3
YTk0Y2I4NWFjLi4yMDRmOTNkZTAzYWEgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisr
KyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xNzg3LDcgKzE3ODcsNyBAQCBzdGF0aWMgc3NpemVf
dCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJaWYgKCFzdHJjbXAo
bmFtZSwgInRvcyIpKSB7Ci0JCV9fdTMyIHRtcF92YWx1ZSA9IDA7CisJCV9fdTMyIHRtcF92YWx1
ZTsKIAkJbGVuID0gaGV4MzJfYXJnKCZ1c2VyX2J1ZmZlcltpXSwgMiwgJnRtcF92YWx1ZSk7CiAJ
CWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKQEAgLTE4MDMsNyArMTgwMyw3IEBAIHN0YXRp
YyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAl9CiAKIAlpZiAo
IXN0cmNtcChuYW1lLCAidHJhZmZpY19jbGFzcyIpKSB7Ci0JCV9fdTMyIHRtcF92YWx1ZSA9IDA7
CisJCV9fdTMyIHRtcF92YWx1ZTsKIAkJbGVuID0gaGV4MzJfYXJnKCZ1c2VyX2J1ZmZlcltpXSwg
MiwgJnRtcF92YWx1ZSk7CiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKLS0gCjIuNDgu
MQoK

