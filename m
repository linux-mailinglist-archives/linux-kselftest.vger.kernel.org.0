Return-Path: <linux-kselftest+bounces-26519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3FA33D42
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9404F169BF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F0215183;
	Thu, 13 Feb 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="o+45TAaZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CB215060;
	Thu, 13 Feb 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444449; cv=none; b=WeoFaSddniOTO06yqVkJxwKGBs4G8ObSuc1xfENk8WdNDjYm6jY9bkG3Qljh4Pr7ixc2RocX0/c1+mznRE5HzdczTmraU6STZUL7Z1d1DZWblANpJtviYqf+iXmf+II3yGILqvBPW6e/9JR7GeZbsFpVm/ZhtHN5acPfoHTvQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444449; c=relaxed/simple;
	bh=lFJTNeYYEBTkaC/3wh2Lv43QxbvTD6janjNU/XCDQVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhffwF5v3of/lVMOKh7TFN2z83pFLmJCZyFbS5cban93dJwRXfow2mmWtOQPlQEG0QLtqcW0th9qLCenuhZlbuF90Wl22M6cWpNScbYrUuk0eCu5imHAtbnyh5XObbEk1lpFwBYy8SgDi3X+Xu8EEK0sB8L+l8pjs3wQtq+a40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=o+45TAaZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444432; x=1740049232; i=ps.report@gmx.net;
	bh=lFJTNeYYEBTkaC/3wh2Lv43QxbvTD6janjNU/XCDQVs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o+45TAaZfs7E507/6DlmcD1bzYRYDjd7zxd6954SrV+WHxkwrZW17UJJhAvCPJlw
	 caF+5U6+/rOIUCFLpaGSxs4hGaPrx3ZUHGuuf911g2V4SruBUfa7bc5S10lQG4KE7
	 v6XzZawM6JfqQRlcodXpMPfkOcmKv5G8LRAcD3GPj4GEDuMfGpI16Ud2dM3ChNvqp
	 uMWlrBEiGbQAACoVAlw96fda7dLtGJIva7x/g0hif3sOAG7xHLohSAOtsbghJAVko
	 vVdAOx91ThrashZOTrIZf1818Lowwh5dKSJkkqxqTUVgsSmecQA6NriRWSfz0xMki
	 ZYmHquVupHMQsbCflA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1tpel02Nfm-00OyhE; Thu, 13
 Feb 2025 12:00:32 +0100
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
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 7/8] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Thu, 13 Feb 2025 12:00:24 +0100
Message-ID: <20250213110025.1436160-8-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213110025.1436160-1-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:xwBeQ76e5NWdP6OGK1SQo1exT1I0ZuxTszWvW+QPJKFufEhp9n4
 Qq4U2fTYTJAoqUlDmqXmGmM6ynqU0JVW6J0QNeYsxXfXcP3Z7e/avKKJkmVl/TDllhbAlIG
 5LlZzkq8miwcf+60tKZWZVR2tTZ0E3elQlbavhpvsNRmOAqIgWc5VnXHTpetkNJZgbdgNdR
 7ZWP2BCr2fgmsNUUBRyhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vCIvKXRtjmk=;Quf+BsN0TXFXZWhk/LMpum2tphc
 +2XaUXH9FBN+e9P0fdauvt8nOmzxu+exPdmXUNYmDniyxoKiBz+BDHP48LP5aizR/B+Sm2VtU
 pgHCG9u8QaFR8tHfamsLACaaguxamO+53xJQPJwG8NCCum+loifILxDZ/HtPVVTMHb5NWQ0o1
 ylOX4/YEIOMJKY6Nq0avo3XT6bKnvyaiIZzdAyiVUlvlm5hPzibsW8rbVKe0VnggSML2vqwdj
 NxTMCiK6K/RX1G7FbNOQewAgdgHndr+9qrSUN+l8skxCtTznsyFDanHrreGzOo1zbPqw4tWek
 vjt/c2A57OLWJ40tmTuSZ0F+sYn82DHx5Wwbs/bIThsnCaBChODvktue2G/BbTPaRjy66TkUS
 HicRcCxpJOOb48uNmuFR9H1fkaCKbYqbU937CHI98Hk9lVx300C5UzxKfAKo224hzCGbOWZCH
 dy59wUa5kDMOFekv6gZ6fxThrCsERVr9PlvxuHHBI1tpOkAYEB1kDBDDZPN+vIBJbsEugGpfI
 NXs59VGjIBiB4W5Jmy3r/qcc0es57+Qw26OHUfaMMstFvbZIdH+3uqIHA7KRJkQ0VYu8pw8mB
 P8/Q8wyUGT8srbE1u5nYoGlcLWsmC41zcXH6QjEGI/SY31my+esxaV7dUl1cNprU60pAb4fji
 ZDG86f5SvecY6UqaSJ8a4Qv49tJmA/R98mT3xz2wfO7ELM37gyyAXiYpbx/1GzUW3AOzSyPqv
 WquBXIN+wXRfZn/coJy6QpisZx0/ykoSbFsiXU4IYcO1uZUxKwIekKE2jYbcey+qv6pwHI9q6
 m4XM5zpsto1ccgcXyoa+2N+fxo6fQb0Y/636UYJqKxM5Is/Fn1pVFI2uf/xskd+O/d8pIHpEm
 cf6iE05+Go8SeMicXBw5MBNsZQnP63cVot2mIkuEI+ixDsuEp4IMSb+L5cRLpBx8zoloBx1p5
 JEdgG1qULCVd8YMIv1tviuvyM3T5d9/wOTZot8lpc/z0egiNDjBCNW53wJbe6dVQrqgSJ0f3J
 z1vzHUeij/NtnvDDHTrJg3JIHIaq0UQ8IHJryGkNPTUcyUAQlBlw9xtEmfJebpf4qB9xExs93
 Kd0vjbiiDL4zBBTw4Oo7aZR4eWtFzNHaNz9ILnxBk2YarnMZzzlWxUcJaAvhRehpi9pdrt3LZ
 N3KHe0OaNgM1yT5u9hO2BBy+fpRqYYEoSc5ERCl5Iksbwdn7qNKA7fpjTj+CECVRLw+j7dUPh
 HLG++JvBxfYcv6/+iSebKkLpHyiwIviPC5dyt20SHWz4N6FJhL3T8tELdleU1xSFn2jixtHe7
 +rd5LVwnmV3j2d8Eu2NbeVg5mkfnRsAX1PYkLNpP3AY0DGCZc1KFs7O6ptU4onaoM3pbeBbz6
 BPGspW1yhPDo8QDu6x7WpjvqvOjzvASSCM+kV51hMUx1AU/bKBqwgjOm4h

SG9ub3VyIHRoZSB1c2VyIGdpdmVuIGJ1ZmZlciBzaXplIGZvciB0aGUgc3Rybl9sZW4oKSBjYWxs
cyAob3RoZXJ3aXNlCnN0cm5fbGVuKCkgd2lsbCBhY2Nlc3MgbWVtb3J5IG91dHNpZGUgb2YgdGhl
IHVzZXIgZ2l2ZW4gYnVmZmVyKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz4KLS0tCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNoc2V0IGludG8gcGFydCBp
L2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQoKQ2hhbmdlcyB2MyAtPiB2NAogIC0gYWRk
IHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpD
aGFuZ2VzIHYxIC0+IHYyOgogIC0gbm8gY2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwg
NyArKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5k
ZXggZjZlMzViYTAzNWM3Li41NTA2NDcxMzIyM2UgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdl
bi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xOTAwLDggKzE5MDAsOCBAQCBzdGF0aWMg
c3NpemVfdCBwa3RnZW5fdGhyZWFkX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCWkgPSBsZW47
CiAKIAkvKiBSZWFkIHZhcmlhYmxlIG5hbWUgKi8KLQotCWxlbiA9IHN0cm5fbGVuKCZ1c2VyX2J1
ZmZlcltpXSwgc2l6ZW9mKG5hbWUpIC0gMSk7CisJbWF4ID0gbWluKHNpemVvZihuYW1lKSAtIDEs
IGNvdW50IC0gaSk7CisJbGVuID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBtYXgpOwogCWlm
IChsZW4gPCAwKQogCQlyZXR1cm4gbGVuOwogCkBAIC0xOTMxLDcgKzE5MzEsOCBAQCBzdGF0aWMg
c3NpemVfdCBwa3RnZW5fdGhyZWFkX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCWlmICghc3Ry
Y21wKG5hbWUsICJhZGRfZGV2aWNlIikpIHsKIAkJY2hhciBmWzMyXTsKIAkJbWVtc2V0KGYsIDAs
IDMyKTsKLQkJbGVuID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBzaXplb2YoZikgLSAxKTsK
KwkJbWF4ID0gbWluKHNpemVvZihmKSAtIDEsIGNvdW50IC0gaSk7CisJCWxlbiA9IHN0cm5fbGVu
KCZ1c2VyX2J1ZmZlcltpXSwgbWF4KTsKIAkJaWYgKGxlbiA8IDApIHsKIAkJCXJldCA9IGxlbjsK
IAkJCWdvdG8gb3V0OwotLSAKMi40OC4xCgo=

