Return-Path: <linux-kselftest+bounces-25839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A03A28B61
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F79A160A46
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418E17B505;
	Wed,  5 Feb 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="N/mGV0bk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FE158D96;
	Wed,  5 Feb 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761132; cv=none; b=gISF1WgoUJKyqdkVs7oKHvlwW1WLLeAma5eJQgpSjZCxgmMrhlGqKJTlsThjrxpZ/jXXhke0C2y239fCbAY35ktRzXQ5MT0Kvq/ZoL+mg1TCUIdHAVsM/T46ZqW/pgvmIKNDEUWHrhmRZQQ/tiaufZmhQlrcveb0bgwly2wxiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761132; c=relaxed/simple;
	bh=+pA63p/sOzpKmlI9XQBY7/IRJuC2ORlkSrBGwknyc9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REcCaItycBsZgBx7+4eWLoBHDYk+rkcHZCKaAE7jDOB/Ik/KleF5jZXKyQfwIdQRw46KoKHbHRlVdGij1Z6u6go76dtFIRY6bv3u/hD19cW4whdz+fq8biZCRK7+MgPSqy2BnJnBBI33ys+w6yupTr7SiKNTepYofFt4oTZFIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=N/mGV0bk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761125; x=1739365925; i=ps.report@gmx.net;
	bh=+pA63p/sOzpKmlI9XQBY7/IRJuC2ORlkSrBGwknyc9A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N/mGV0bkyyiwpiLoPZaRXHY7jQrXC7H5ux+gaCTuf1KBh5l80tgA2PMTQ7XspmkX
	 bEPMPXVA30c44FBqiPm4HJaLXJNZsw/tAXme+uFoSC9cczehfwcE8zl+BIAGXLqm1
	 UZ4AYLzC0ZJ0oYvNLWFc9ALwwyM0syx1MSH7BIQLMZjWJMV+j0yX3kLcQPcAq36NC
	 7ynV2XJz8kuKM7mPM/1jUcWk6rfrkUAtl/DyhQFQGTsN2rJ9Eps1LZs8ObHQR7+Tl
	 2hdnw/QyWUcN/VQLK1dUw1OvIxwoH4zwcFkePk6doabPxaReDnXrOTPUu4jj6rIFk
	 /iXg0e7AazXxsG2dvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1tYD4Y0cln-00HJaT; Wed, 05
 Feb 2025 14:12:05 +0100
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
Subject: [PATCH net-next v4 15/17] net: pktgen: num_arg error out in case no valid character is parsed
Date: Wed,  5 Feb 2025 14:11:51 +0100
Message-ID: <20250205131153.476278-16-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:OwdfeW7srCsmSPs6Q7Sf9Eqij7ID+a/xyjX55WPlQPmG4ZWcKX4
 r+RWxMZIKDWW9iUYvo5Nvi3HTrfoYABrRBgZTJiu97tD3E0tj6c8wM+xoAnNnLvjEkAnqV1
 l6P1fsvUSJk4DDG5vaXkdkkmD/BJ7Z+TNHNmeQXrWX8st+Aqme1nwQPZ6WNl8Wvo9KYX8GG
 oJvWCMcJlSoPFQwNwvp+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YXVIf384CeI=;bVcAQLvIa+kfO5OIj7KsaDUBwc8
 /U/udXur3/2ZfWaNybTh9CZUdtlUHQPEuSlXSTR/qksSXHT+Hc5rKCK8sU34u3bkjn380fkp9
 lAfTrfg8IZYSaR3MDfA8Wuj2rHYv3F6T+YwyYgobG1XKqrBLkiaWhuuRLwGc9QTZgfOtrGz0g
 9d5RbaJSDwdAi0pCeFuP3bvxNbDnBE/89eygvQmw0K5COqx+Xq5Z5SE4s6eVW/gRO2RetLwSr
 bB/z2qB0rZAHtMjjC7uUB3/gpzxwl/I1AgGRwocvWtAN7Ivsm0AasDa8XGeQE9LXj4M0Amr4t
 +PHUeHvK6v/1uAdInh5tuoz6vOUqu6hK/o5CzDqGWBLkrKkIXGLO4AXgzJgHqS6vTAg0OkC8z
 dr7YbkMaTD1t8qqDOd92FSOjxXB/xhhT56XHb277QAtzgZ3PZU5I3Jj73fvZ8pdEKEsGtZfC1
 DwNdSdtdO7IEKK0DwE2qk/tR3cmxi8vunoKB+3FPFsutOatpztMegm8pLVDemjHtX3uzaXBNo
 SKHQF6WMzxMtPsQWLio/oNMSjn3gWrQkNaKVplGG8ojDsv8UMsXsXO2lMkokHdH5eb5iJnuhw
 CZUvrY6RhyYi6pqvi1zaJ/27U0BZMwLcACHtykRq7a5aV0s+O6coWbVEvp+9NDhLUXnAsbit0
 kUenixPWfMmqyuNYCwptca4TX+aCup7rIqfICQy42Id8wm/6/UwzRzLg6adD/R+FNhiUS+QE5
 CC5k0qpn12ecwJGlcZ+K/p42wMGlPQ8z195WduN8OG7mizztQ+fGFwQCxMeQxrlf9AaGZfayu
 iR0LTJadgenLGau+jGsgy9G1DaLtd/u4kIlRZevLAsnQBekPwTn8dLdBOT3UGW6yCuwqwOgul
 1xeD5O5rWXBlicZJ4PtPjIfQP72VpyafS+X66qfMOE5y1vr46Y9UcbDjRum/gzSjm1DpjFl5u
 quXxhiCwdMHkOHGFE8Xpe+terD7xoecFK3E6kBux21LHHY9j0fZN+53TLMCUw2WuS6a1XHV5g
 MWk4qRDKIIlnkT8U1rM34v0VxySJN/Rdo8dwdb5sxcWKLhHPC1aG4bSIxTdBelrF01oCiIdG9
 F5sZ3rc2C8putXOrfOsD1fa8rwIUP7k5Df/PVy1e7DRMPaGBY0Zq+NEZB0ySQ/UA2GWplxyBY
 p0cMp20tnrcoZLdzvABuN24XVGHkNXr9LET6B60EqootlJ3uNqlnMbDuM4gvLXq8wrthgeK7u
 SZCiEvQtJd4qknmN7FNhN/EEZ3MjwCMiQEiz8OpjLKD9e1cr71GipQM6E/XTZAgj1B+BJ1KUk
 lA6y+RR0VMI09xGGBhG7F6mrPaITcoWWz/PplJv8vS7gmc=

SW4gbnVtX2FyZygpIGVycm9yIG91dCBpbiBjYXNlIG5vIHZhbGlkIGNoYXJhY3RlciBpcyBwYXJz
ZWQuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0t
LQpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAn
bmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIg
aW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3Rn
ZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IGNiM2I3MzJmZDBhMy4uYTQ2ZWIyMGVkZjZj
IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpA
QCAtODIxLDYgKzgyMSw5IEBAIHN0YXRpYyBsb25nIG51bV9hcmcoY29uc3QgY2hhciBfX3VzZXIg
KnVzZXJfYnVmZmVyLCB1bnNpZ25lZCBsb25nIG1heGxlbiwKIAkJaWYgKChjID49ICcwJykgJiYg
KGMgPD0gJzknKSkgewogCQkJKm51bSAqPSAxMDsKIAkJCSpudW0gKz0gYyAtICcwJzsKKwkJfSBl
bHNlIGlmIChpID09IDApIHsKKwkJCS8qIG5vIHZhbGlkIGNoYXJhY3RlciBwYXJzZWQsIGVycm9y
IG91dCAqLworCQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0gZWxzZQogCQkJYnJlYWs7CiAJfQotLSAK
Mi40OC4xCgo=

