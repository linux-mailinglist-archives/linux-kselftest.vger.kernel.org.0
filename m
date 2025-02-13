Return-Path: <linux-kselftest+bounces-26523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA8A33D54
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F3B188CCD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D8216389;
	Thu, 13 Feb 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Bb3JqgpQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17821576D;
	Thu, 13 Feb 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444456; cv=none; b=Pee0WPC0pDEwssWzZ+p7HHatYzFKEkzHtdPAkIGeL4R8H5qe5XSgdJeMtpzmDh6wa7h7HwPfaRSgwHwZKHP5X/6bJrREXesVtC5HWSl555sUksvUWzZH/HYOOJ+ifDi3cG0/Efuz497LEaj7EsBMRGnB6TY4NvDk3+1+Zi9qAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444456; c=relaxed/simple;
	bh=FXOukLshRwD3TGePfrJUyNPMP7nk+xOAjD4QyzMCnyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0wccSk9w7IGhqJxU8T5ebWTZ7P3n7ZGjhAhj1ARHMlpAJr8ECGTkulTT/VZvqiORFqNafKrY/cFPxGEKKe4NMREd6wOrddfdWhqIFbvicx6Kf8acspRmLISGgXa40VfJrtl0tnjEKg95ptRiJ6UDah4u+PknpMIzwNUfLDI048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Bb3JqgpQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444432; x=1740049232; i=ps.report@gmx.net;
	bh=FXOukLshRwD3TGePfrJUyNPMP7nk+xOAjD4QyzMCnyo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bb3JqgpQRPtQlMieJg58bvcyXnabCRow7DX1S4xHA8dQLeA4Twe5zoV9ONnipXDm
	 Eua6eAq+y1AVNr41/cg2nmQaKNxwfwIsNi49/islX95MfVTFTlYwffnGRzY/r8qUl
	 gr7bbmf2zGGezcBfSOz1wPJm8hAgRXqhILf6JIogQvs7HrYTvi8t6pS9W6CD7x3Ej
	 NFH93WGs2H1w2vtAC5ryFtLZAaktq4gLlfEI/CLG/lzOi+bqimt9wUPLRCMv9fJuI
	 3RlKt0eSQytJAdUJ8hTbKwmW8SUlshzDjArwhNNNwUp5CcslhLm4Sc96VDFUBOAoM
	 LwJ+4LNS7DBtqhQm1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1t7YVu0keY-00pCi8; Thu, 13
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
Subject: [PATCH net-next v5 6/8] net: pktgen: fix ctrl interface command parsing
Date: Thu, 13 Feb 2025 12:00:23 +0100
Message-ID: <20250213110025.1436160-7-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:bckGzX9xcjDIeR13lfMu9Dmgjb5TEE2Ttqyx1uXqLPgTmXoZhUw
 WQO3RSwWkoj6NjHtvfF8Vjbh6xoxt7BoJxpLB7ipApq0eX1Y5QkF0Jpry3cs8MIB+YW95iu
 2Ki36QovjxCrmUblh8kku7DORuTV3N8h/8xWQfdxg9M7KHTYwgQPkE1CU55LxCNltERS+Qb
 Pn6PhqqW8VzZPmhqhhxog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q5kE7y0woMM=;gBsHYENiDYlh+9ckv98klxhhk9c
 wad6IzBnq5ctx665AXwgPKU7p14hE+A70YwEzUkCKixo7zACSSSNzaI48RVSFvqn9yPxpke3j
 z5IKiOsc0nTgtlF0Fwung4scEFHrQQb+uDWzsY4ExbzImlsMzqg5ZjRZw3oWVQFNimdFjrk0K
 GOM8FG6mSdDNfHLHhvu9+XGkHGm4B8/AVz1TozmyvTlqtkeqCJ3lUg7Q/zMbrJ4/kRfN9Ll8Y
 o3Z8hL6z7Hb3r1LrEfshZjHJLtUUsUZBHBRrINCH+U7xq9Wbpy1D66PQNJ1XN0/MM7nAaJ2nH
 EyPhqH5fqM8GyPhAV/dH8FvdMyEFMgv2yQMcYa2H+NT5u/PVYSY5jXRyaHFSME/YQfmuGJzsy
 zyif4loQI25ECIWxAFFU5++stevec/blZN/ZWJjQxPhKEvyRQ8bbslamKU034+bh3/96VhNVW
 j46fte02WMXh8GIAgGR4SvbeXQomScKA9I+T4+ba3XEUTh+RoiY3IXFty9sRT0jb6fEHcj5oF
 66Lpf+X2hXC+IOqa7r+UwKo+dcORO1Y8gPbwsRxMJ7IwY/YsImfS3U47X39KhsumMedL5KbzS
 GVLmNeAFehTxr3GJKCQ13CzyEbg76ZtLeqoU6aoeBdDubOSXBK27NefwZFOaidG7W96J5Uvor
 F/q5Z7tyIvZYvv1+wlvjn6SlCs0Y1RrutcPCDffP+zTvKkMncIRHKA9mNGfiOLUIkeD2RksJX
 1h/y6LJuwGTkTZzAba4Mp207wwo0kky+P1EZ88hHcxDNeVP10LL4lIZWjdlWVSTTkqpmxWKK8
 qykOJ1k3U2JaZl0cc6fhigvMBu4BPdd0yT9ZE3YDh/fcIkDth9+qlLAuY3ZEbhS+s3/fXSc/p
 KBj3CrciqT+hhErAwGKXvZiwAa156HqQ4b9YDQOYWbfqBNQ2t8gpgZqk9j4GkgUrIk1xBBe0A
 QIeyt/dQQPcxwejHphO4p71Yu6zVZj+lR7cMRS60YHZ6LGgcwlmUXZ3gXx1JgX28i7cGVcZYV
 wa4vMGCKac8ulHnHlEEJLqkz3UUnZvLy9+SvAXUe3vDtA6cxx+XnBhYf/qqXdLEadKGv4d5ni
 d8KRJLmoHeDQW/fBI7rCyVqB5CdWV68whnnba/rMCd7v9PxHCaxqJA3GdKPLVKpJ6GcCA/8wd
 JsEeX55D2tuiJKpWRHk7FIpVxwl9rklN9rdVB66TPXtoI0w48G7PfbryaxEiL3wMnM/YO0ePc
 EgdKlwZF+sMXncvcecuMLlj3XffCY9BPLpwV0KCxgvQeS/lyk9p02ubq/WnnPPjZZeEm91HHA
 o0iqwFx4IGgvtqGpByXUsDM2xKqPN4VRS42JlnBT5Wl/8GGZ9LaXyd+QkBovFFXndAA+3FzKQ
 83ifSWD+D2ok0LkHtAsxN0U3pxqJO0watyw7EbhMp1CWH/KEcGXoEXQ1eL

RW5hYmxlIGNvbW1hbmQgd3JpdGluZyB3aXRob3V0IHRyYWlsaW5nICdcbic6CgotIHRoZSBnb29k
IGNhc2UKCgkkIGVjaG8gInJlc2V0IiA+IC9wcm9jL25ldC9wa3RnZW4vcGdjdHJsCgotIHRoZSBi
YWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVjaG8gLW4gInJlc2V0IiA+IC9wcm9jL25l
dC9wa3RnZW4vcGdjdHJsCgktYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1l
bnQKCi0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvIC1uICJyZXNldCIgPiAvcHJvYy9uZXQv
cGt0Z2VuL3BnY3RybAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBn
bXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0K
Q2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1
Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5
IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAgICAgLSBuZXcgcGF0Y2gKLS0tCiBu
ZXQvY29yZS9wa3RnZW4uYyB8IDE0ICsrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdl
bi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYzhhNWI0ZDE3NDA3Li5mNmUzNWJhMDM1Yzcg
MTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBA
IC01MTcsMjEgKzUxNywyMyBAQCBzdGF0aWMgc3NpemVfdCBwZ2N0cmxfd3JpdGUoc3RydWN0IGZp
bGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsCiAJCQkgICAgc2l6ZV90IGNvdW50LCBs
b2ZmX3QgKnBwb3MpCiB7CiAJY2hhciBkYXRhWzEyOF07CisJc2l6ZV90IG1heDsKIAlzdHJ1Y3Qg
cGt0Z2VuX25ldCAqcG4gPSBuZXRfZ2VuZXJpYyhjdXJyZW50LT5uc3Byb3h5LT5uZXRfbnMsIHBn
X25ldF9pZCk7CiAKIAlpZiAoIWNhcGFibGUoQ0FQX05FVF9BRE1JTikpCiAJCXJldHVybiAtRVBF
Uk07CiAKLQlpZiAoY291bnQgPT0gMCkKKwlpZiAoY291bnQgPCAxKQogCQlyZXR1cm4gLUVJTlZB
TDsKIAotCWlmIChjb3VudCA+IHNpemVvZihkYXRhKSkKLQkJY291bnQgPSBzaXplb2YoZGF0YSk7
Ci0KLQlpZiAoY29weV9mcm9tX3VzZXIoZGF0YSwgYnVmLCBjb3VudCkpCisJbWF4ID0gbWluKGNv
dW50LCBzaXplb2YoZGF0YSkgLSAxKTsKKwlpZiAoY29weV9mcm9tX3VzZXIoZGF0YSwgYnVmLCBt
YXgpKQogCQlyZXR1cm4gLUVGQVVMVDsKIAotCWRhdGFbY291bnQgLSAxXSA9IDA7CS8qIFN0cmlw
IHRyYWlsaW5nICdcbicgYW5kIHRlcm1pbmF0ZSBzdHJpbmcgKi8KKwlpZiAoZGF0YVttYXggLSAx
XSA9PSAnXG4nKQorCQlkYXRhW21heCAtIDFdID0gMDsgLyogc3RyaXAgdHJhaWxpbmcgJ1xuJywg
dGVybWluYXRlIHN0cmluZyAqLworCWVsc2UKKwkJZGF0YVttYXhdID0gMDsgLyogdGVybWluYXRl
IHN0cmluZyAqLwogCiAJaWYgKCFzdHJjbXAoZGF0YSwgInN0b3AiKSkKIAkJcGt0Z2VuX3N0b3Bf
YWxsX3RocmVhZHMocG4pOwotLSAKMi40OC4xCgo=

