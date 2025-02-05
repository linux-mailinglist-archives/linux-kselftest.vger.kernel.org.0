Return-Path: <linux-kselftest+bounces-25841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6EFA28B68
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88689160B2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992018A95E;
	Wed,  5 Feb 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="kqARW5Z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842F15DBC1;
	Wed,  5 Feb 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761133; cv=none; b=iV2M5k9eCKDobwOjRiXkSZqG/jD+N03URaZZ5JF2i/WpNlPwaPc9dtVmJrZSjGZUeNmE3Uh8t7amJyKFnsz2B3qeeh3+VWkwP10D9VOnzhgYuoQYiOJapsljGeT2nI3CBwtEmk22AJFg+vUE0FlL1jmhGcAbp6vjXC+bPw23zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761133; c=relaxed/simple;
	bh=HaTsn8aQF0VRG09Je95Z/RUtJgQ7j2KbJplgaRlrj1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPjLVI7skgNDsPLIMFgO+iIkpwOD3eVWhjPORKwHLXIi357N3Ev0njuYlh9ghtw5egVEwdxEOMCUEsXpOKaR2ya36+nKSvukef0pRX82FlFPsPfe/MHbAd4OGrSVcl4b0dQSC4aLeWlWfUeR+igleLVoNBP7hLJpWY84YfAdWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=kqARW5Z6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761124; x=1739365924; i=ps.report@gmx.net;
	bh=HaTsn8aQF0VRG09Je95Z/RUtJgQ7j2KbJplgaRlrj1g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kqARW5Z6EA+UEl6yDAMe2yCPGl3XabRnuS8cgQANLypxtcr5pauX9nbUXXXwM/lw
	 kB5PenUDVPrZ42GpytN6fD5fV9MCmuca6NsB0ya9T+ClNzmZPEAKzQo8t8ompODjy
	 UG8yluI9j7P5AqG+G6juvmOYwb4wodByG1mlxWh0C7c1w9/evC/TEoHAjuuN42VBX
	 ZddO033vPUk9YSb0behzhJV+1EF7lQoRav6BG06vEFpvmT8Pdoa3yPGpmMFH8saAe
	 eg3MHRuc/HlSLNQuZVcqzQvB3TvmqMCOf6V0LdqSR1QqkZDATafLwJ+5Efj8mYLGs
	 0GBckKPc5bboScwgzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1tz7tK3yA5-00PSot; Wed, 05
 Feb 2025 14:12:04 +0100
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
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v4 11/17] net: pktgen: remove some superfluous variable initializing
Date: Wed,  5 Feb 2025 14:11:47 +0100
Message-ID: <20250205131153.476278-12-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YFjuxS58pXpOsNlIYN9TyNzLAG+ngv4CaRkZv9g03t4OZgTmKCC
 Q4OBFD7QSw3Ch0DMnu7Z3K5KwSCU1zE5/fD+/r2bzl3FaaX6BsnrX/18FvVKuexIL017dbb
 yXINccm9zNALMVDdAINNCjxy5C2UilKX6d/loVMSbAZ5vAJba/yx+XgvXcsVHdcudeT2gk4
 lM076ezTL6uCInMsWr1Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XIkO8hZ+FDY=;tPFRhhLzNEkrLGqoN11rhKubz1F
 tR2IqBXWEApg5nuD5+uu9jyaj9z/hBnZ+lAXhqu8vzlE/ZBAi03Pdld9KT2DDQQfWGhl4UVjB
 YvlTExZvfDBoRKgnwtQ5iYA5fWXYMK8yj10Rq0ma7+QhtNUw1mXt78nLn6nOLDPQivJW0rF44
 bzvCGOBxv1Dw0UrjLQtmKhWBuXI74j/6da+Ls8RyhqPw9JX+QVuFSKX+e62DleNaRo4N6FSgV
 Ov0BinZ5JspXKifGFr/Ln6vyiEf/RRK/Gh7X8bK5XQBtdpP5fz0ihB+KtXAfNUx96hC0sja2f
 WNM4FdFnSSmSHECdR4FAFiPRu8J6J6NmhqRiRHqTRKo/bfAe2LBZv1nffQ9UpiMVvQo+Th/f2
 OrWupjcVsVH5gykQd6K7dpb17tbpa0Otfi6oanr7ruewW+rbxlJELGDeTRevA0do33RJ2ptXb
 ANZKD6qYZGfntLEyLVCpBzdgr53Qc1cbjZtAlj0H9XNj/qkbdAEcAR1tNcfQ3s9Qw9+2zITQx
 74OlW1acWzK/dqPCLmlAWOKn7Y5XNxHrOzT6BFXBn0GS1cYOh2E9PC/viMU1/VHaMZvkq6PqV
 ddi0dpu+6s7ZBb8GivaZp2xN/rVCRrz1UvCQVmOEmSpAytkhSbBB4k17rMBSsLzKlWjtJH7de
 Jqbj6OoApK4JeQQ1rDsdaMPMe5EjC8NikTJmoJ5OnJCo31ByOkH8SnR0lYap+IzQwmtd+lDgs
 dZLbd7HTfKWrHadgXeuHlcvFFykz3gWxoaW2rhDKRqMSQ5VywtkK35pND90c6+ngQNqxvnL4I
 whA9LW+t6mY15FWV+t7b5YvEBPRfzI1aruvvIYyGnL3sVtQ6qqaJA2Lm7CNl3qOPrSejx2nje
 kgrNLtb9Q0UsumbAFp6HNQOqGVfUi5WT+ekYdV7fJSEeLdqmGxapvm2tmd7dFV1SK656ujAB0
 yibAU5D8EtbwXCr9H58DkAHq/igeVSPjbnOXRlvTTwvvRIZk/Ny1tWccZpRkxdmMPJ3M2G+vL
 q/jX4F9wbn6jYWrAfs6382+OC4Tsk3rIMF2pxtLjujAZU3HQl4YXu5f6N4rXjBAU1nxMeA+U2
 co5ZJIlG/OWm0hV2LDcG9ecEwffnvP8JRzQaiHm+4DYKh6hbaBSQSaT+2IyzmSxZ8IzB/oHNS
 ijcyLtRTrlANjQu43TcStt18OpgkXcOMddTLg3RpNx3p04dYsjCeWDpRyKXcP9G1RMLPuxs8W
 qaD7s3PMjLIVtTDlnSchQShRI6u84xoZzNnbAn8u7HCW8VMTDLZUNIGx9eSoqOxnEqAfJUm+m
 aofVfj4wUuPEM9W5u5udyK65sE+Uge3boKMfGhvfLWm2EXzpiKH3tyw3YGYXNR14wxU0wchm/
 9rXlriR/jELtMlAVkNgzfwSiuyI3KQFyilgaXmsCVfR1K49xrzRpQTIXzf

UmVtb3ZlIHNvbWUgc3VwZXJmbHVvdXMgdmFyaWFibGUgaW5pdGlhbGl6aW5nIGJlZm9yZSBoZXgz
Ml9hcmcgY2FsbCAoYXMgdGhlCnNhbWUgaW5pdCBpcyBkb25lIGhlcmUgYWxyZWFkeSkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQpDaGFuZ2Vz
IHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3Rn
ZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2Vu
X2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9j
b3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggOTFiMDY0NzNjOTI1Li44NGZk
ODhlNDgyNzUgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3Br
dGdlbi5jCkBAIC0xNzkyLDcgKzE3OTIsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJfQogCiAJaWYgKCFzdHJjbXAobmFtZSwgInRvcyIpKSB7
Ci0JCV9fdTMyIHRtcF92YWx1ZSA9IDA7CisJCV9fdTMyIHRtcF92YWx1ZTsKIAkJbGVuID0gaGV4
MzJfYXJnKCZ1c2VyX2J1ZmZlcltpXSwgSEVYXzJfRElHSVRTLCAmdG1wX3ZhbHVlKTsKIAkJaWYg
KGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwpAQCAtMTgwOCw3ICsxODA4LDcgQEAgc3RhdGljIHNz
aXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCX0KIAogCWlmICghc3Ry
Y21wKG5hbWUsICJ0cmFmZmljX2NsYXNzIikpIHsKLQkJX191MzIgdG1wX3ZhbHVlID0gMDsKKwkJ
X191MzIgdG1wX3ZhbHVlOwogCQlsZW4gPSBoZXgzMl9hcmcoJnVzZXJfYnVmZmVyW2ldLCBIRVhf
Ml9ESUdJVFMsICZ0bXBfdmFsdWUpOwogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47Ci0t
IAoyLjQ4LjEKCg==

