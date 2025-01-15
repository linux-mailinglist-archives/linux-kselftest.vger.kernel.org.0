Return-Path: <linux-kselftest+bounces-24563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D026AA12128
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6939B3AD155
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC4518952C;
	Wed, 15 Jan 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="aYxCAolt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442B1E98F0;
	Wed, 15 Jan 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938367; cv=none; b=iMxbc8SBUe81xWhi3odtn9DsKBuLjAku7WJrBHCmHYSxsCeCBxH4n711Eu07SOG5Z4v5gqU6ht3tGGTkLCDIm4k80R0svaIGOJfiI2Tc4uhYnQrgp0N44sBj6F5qJhbDvqm+JVTi/Or0VXGMr6So/CLhabmbJKrMW0TL0NWJ4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938367; c=relaxed/simple;
	bh=hqeO2HsdlOqkHdPV9q7u/tubN2tjN9Oc3PMkL6Wip2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sltFeYFysvJ6q/UkrGeckm0kg8emCW53fqKC3gdPyG2Rdo9ZWVxZsLKNqzVrtmoc3a8io/wwbTqJbywY6/3VJl5ADIFZoH5YiyrEHdL9zdchFK67JIPTsybo3EGT0cwe6E9HSrhzT1pKZGBVlIODt6p6xiS3sUsDbTY56Lo5ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=aYxCAolt; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736938363; x=1737543163; i=ps.report@gmx.net;
	bh=hqeO2HsdlOqkHdPV9q7u/tubN2tjN9Oc3PMkL6Wip2A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aYxCAolt5vD24lYUTju9G05wI8nb+eA3WasVq/RPp8FZVGd1+sDnUpe+ONeqynee
	 3P2jcflDKOgfExLB8HolgjJUe4sZOpt93RA0MRlyk/Iuw0SYrDvYvyZ3ylbBdot01
	 KzfGqIwnAfYsbC/2WQnRCAoFFyF6Cs1eMCPBnH+OAXXCP17uJ/Cv5SMmw+Z0GDUPl
	 J0U+Zc+ths7fOedH2Wop5kwwZOUQApNO5gFiCc64swubSHtdofDiPm5c8LIYSGhU+
	 D4ZKE9zuWE9Edbed0EhULphDxJUA2Z4q6HI3DBVMXNCmNb10f6yRMjaNaRwr/oxm/
	 KfctJ+aRW174tzEnVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1t5rn246B4-00acVp; Wed, 15
 Jan 2025 11:52:43 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1 2/3] selftests: pidfd: add missing sys/ioctl.h include in pidfd_setns_test.c
Date: Wed, 15 Jan 2025 11:52:10 +0100
Message-ID: <20250115105211.390370-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115105211.390370-1-ps.report@gmx.net>
References: <20250115105211.390370-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:1TeF4Tv+hWMhGGDQm/bHziAhd3l7m9FEIIgxfOYBtNEnc3NbKNt
 dK4qRVPZSJ/oVtbPbe0fv2zdLjWPBpOyE3zCIu1DYcxDpcfogU3jSo3NxE7//KuawlarzHI
 hMujpt+hSuvIvqEwGsBwbK+4YKaJr05mUqcDVoDqytt5xYA8Qf6hbF/Sqtrx6pHyvCgfR8w
 TeGWkyt4Br1XcYu1zZKOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w0Asd71oIG4=;gIQoTBlAsbpsmlD7NyMcMT6pBKl
 f134Z4Q/AFzPJP6Gtddx+vjIFX3RWI7Uh+e6fx3V1doTyHBSLEXcQWDQIJvCqdmRxdQkvSoCu
 gFw1QE29U9OHbMmKdkMmEEt507SpBKgO6qji3AjSZW0FuTnfE4kgLNk8Av0kkpIHeV24H0u6N
 jNDq8DLRThHg/YBb35XJNMujnIALttQ4B7pj774icVHRKPiLKt7fQQcCS0qQxlqzSCdSCD1c0
 T+RBMp34FcBvpqZTHb097pfOz2L4vb85LHAFH5VW2wXZBjjnzxY47q+yNqgSMXe/Orb2ZBipG
 +/Yun7qUPKSxIFm0smB2hthFUDzk4wr4hgBrxGcilGsfDWe/21Uabaf8dmSHpRmwUDJqEQuRM
 gMANY4ptq3yEoUwI/gV/f4LGZECWuOCVzXbLZQD27bpsx3cTh5XmVVS6/Rg4hLMqpl9Z+AxZ/
 0HEfS48rEkE5Gn+dpKqZDT6s/Mea/4Q183fNXL0Qm9vQ5NynqCGfN4BW8AhfbZDNF8KbhgiW2
 JNe3hmzXTqdN6NcrXL/J1WAOAqnq1WCugRfZB/Le6aIGJ49KlF6hf1jqttKJqXswFxx2JfsRR
 yYX0CoHQkP8olfisKiU5fVPEqjch1iB3Lra/XVQrwKdzXId+O1WLMfQwby3i6tv9dqBH3jq7U
 vTgQDLgJiG7U+Z4zj6CW0tUBHhweaq2h8+f5tSS41WwfGe53uDoYCgQt1Gpb1fnFU5X1Cik8a
 lRL1N39H/w+FyIwgRF2M2nX9fh5uBYpvFvCbrduXseE0kneq3drv8At0ZGV0GJqiSlkTqvzC7
 f4RRqc6FekSMj1UbfytU9bu2QZpQUzZO043xcmk6J8Fg+0ilLpGNYbmwdP50xtvpDzJtOJXYE
 h5r+AMaNJvwnUWfXuvMNsifMqE5BOSou3MqYnPaLGfovSaPpZZFwnaqhHhfo8YUDogHeatOuB
 kKUDc1ktAB1XnzQEP8OOai9fEfy66UzKCTBRa93JgYhdwJBW+AlxdtPgkYYsXTVnBjHOKNeJa
 eGgc876DddXKO7QPs5qrFGjKF990I2u0pf3hfUCUt0P6bH15MYOFvAZZxpXDd0ojhlwMuaNl2
 8qXtEGOnYPDXedxS8LWLsQOkAwYFSc

Rml4IGNvbXBpbGUgb24gb3BlblNVU0UgVHVtYmxld2VlZCAoZ2NjLTE0LjIuMSwgZ2xpYmMtMi40
MCk6CiAgLSBhZGQgbWlzc2luZyBzeXMvaW9jdGwuaCBpbmNsdWRlCgpGaXhlczoKCiAgcGlkZmRf
c2V0bnNfdGVzdC5jOiBJbiBmdW5jdGlvbiDigJhjdXJyZW50X25zc2V0X3NldHVw4oCZOgogIHBp
ZGZkX3NldG5zX3Rlc3QuYzoxNzI6NTQ6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiDigJhpb2N0bOKAmSBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAg
IDE3MiB8ICAgICAgICAgICAgICAgICBzZWxmLT5jaGlsZF9waWRmZF9kZXJpdmVkX25zZmRzW2ld
ID0gaW9jdGwoc2VsZi0+cGlkZmQsIGluZm8tPnBpZGZkX2lvY3RsLCAwKTsKICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn4K
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9zZXRuc190ZXN0LmMgfCAxICsKIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3BpZGZkL3BpZGZkX3NldG5zX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3BpZGZkL3BpZGZkX3NldG5zX3Rlc3QuYwppbmRleCAyMjJmODEzMTI4M2IuLjRjOGEwMjUz
YTY0ZiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfc2V0
bnNfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3NldG5z
X3Rlc3QuYwpAQCAtMTcsNiArMTcsNyBAQAogI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KICNpbmNs
dWRlIDxzeXMvc3RhdC5oPgogI2luY2x1ZGUgPGxpbnV4L2lvY3RsLmg+CisjaW5jbHVkZSA8c3lz
L2lvY3RsLmg+CiAKICNpbmNsdWRlICJwaWRmZC5oIgogI2luY2x1ZGUgIi4uL2tzZWxmdGVzdF9o
YXJuZXNzLmgiCi0tIAoyLjQ3LjEKCg==

