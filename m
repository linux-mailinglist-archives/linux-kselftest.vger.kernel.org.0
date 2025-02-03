Return-Path: <linux-kselftest+bounces-25586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6174A260E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D91889109
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5320F098;
	Mon,  3 Feb 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="PsWZuBTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D420F06C;
	Mon,  3 Feb 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602166; cv=none; b=ococLst5eWZSR8k4nwryu1f1RhUdfTfsvS1oBOyWc0ZZMfjTO9IrvS+VnvUWyUHQzZli0EWbWVC1gHjPyDaVJprp0LcJ66svQZgxjGHAiJxJDk6He29wF10ikLV4ptE2MTI5QjWCkGNBeePqFS2UR71kSjms6MI2mPWY0J3PIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602166; c=relaxed/simple;
	bh=XQcXY8W5zssQPj2vDW6XqskIpgYXaRZL4eRGC+4TkVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjvRPamQHEwB5/uYkiWIkiUeZkQWBdpHh4CRAb9vwe8KJ2qlPRtUVp4hafIl3lXxJqApu02IPkboQxaxr/prqy3nR0qSpAkWlX44OQutMFHwffa49nGWMnuAlAN+u2UQvr3u31ZCzHRyHlfVyNbbIzAsqldFfE3Pw5OjqB4vdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=PsWZuBTq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602150; x=1739206950; i=ps.report@gmx.net;
	bh=XQcXY8W5zssQPj2vDW6XqskIpgYXaRZL4eRGC+4TkVU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PsWZuBTqSOm4c4wiwI9XfNfp7M1TqbjYw0uGdTiBvFIDo2+YdYeccVbYhbkKW0QS
	 fFlDVreNAxdRyDqgVtHDN4LkHdi2a1jfuG1dYx4yzrKShoN+7bFwV8fDO+A9DqtqE
	 xzNjGGSJLmwe1PyOzzyoqA6ZEsZtgih+QEk45r+JfitvzUcF78XbBs1Ksi2TarY48
	 Jo9b+wlozNRouKlAqy7KQ7L2aRSCZYgE+PgIv5svuknRRF8kYOGvcI2z/t2Ed7v4y
	 wXhtFnK5Vfbn2/MUdKIWQrbQsUFxc4SvM8maz+OnMc3ycs5L3E+uMUa+dEh/iRjV5
	 rEILd3XnQLRH/D6+Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1tLUoW0Rpq-00t89K; Mon, 03
 Feb 2025 18:02:30 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v3 06/10] net: pktgen: fix ctrl interface command parsing
Date: Mon,  3 Feb 2025 18:01:57 +0100
Message-ID: <20250203170201.1661703-7-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203170201.1661703-1-ps.report@gmx.net>
References: <20250203170201.1661703-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:wtL+52vE8hHckBdnXpaZb6Eriegov/kJm2yLUR6acMUq7GQ8Dil
 IBtMlrMWXi2nqMnM7thqErv8MEQMt2lhdHRbNmIMxROSaomLlz+azyHRfqkhh2Li3oz05WG
 znr+DdqZVav604WevHEPJS+W8hxJBnhcXUinaD9/q8NAjTzoUx8KyWClmwOwiOioNmvs3uD
 3IhWGG/qS9Wpntc0HjP2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IED8DqB2qqk=;bsP+S726eAr85DsxAcmpbhuYdMg
 CXG24Ah6QCs2/cqm89PSI2NuHKUV7Wf9DADkEZVe3QlJ8sSJsGsR8aT/R8SiT3Lbg7Hx6Y93J
 2WxcMTErVBuhh+5btjNcUS7rjDkmQHBiugJn2ePjyOnZML2NlhqTavpOJwVBeNDOlrxlS1EN7
 Iwtex4FaskhBXcOcm2tt/E5MWwFiCh9qNzLlowwa8IIs+sBItJEi40wvWP9Wji0Cm/C2OYfWs
 9pM2+SgyhTVSfrGXgImo/bLWugjyAZomD7UU1K9G8yRWOeZvFM2f8+KmjP0kz/Xo4PTfzcVC9
 tXTltYgoyeOnM2P5d8wrmwHUIC9t2CM2s2tvFeeDGEF4em0ylgxUIMFfcrdkc84Z1NSUEI355
 VFDmvwrHR0prLZHT6M8WDzkhwPCDaZ4krrldRBjyZDuy4ttdCpHH45nJU1TOjhcmK+gCDAmLO
 pF97dzvjbkdJKsx8FnbWWJQCVfutE2MXETlOSJNDThTXhUmTxrC4mB9XhBKMBYvbNBHl55fla
 Cv7cGeJGly9Mqfo7EavcNzAYHV9YjQTVxfaY3k8JxcrbErPcEuCpMdzrdLuDZFzAMSd1e+FWt
 s8F2UEBC9CMoGz/2AY9Zs7GOD+ha3yKuLdLMsbfW5/mXneePLm/J1BuPObNk08d9vfz0zPAGU
 /Cd77Zy13g2F97pkPANQxKVg2+SNjdTGpth3jYmMlmYTIFcABlFwmfeLCnnXZqD6fGcJrfZno
 Z1RuH+tHxxWIJRN6lWRCU2aGTyaW9+vnEXzQH48ISPSCSdNpy0+obuW75lNQRbDAmKGhl357H
 +9bpJ3IvPTBIPW3OVlX3gWp5tjpdyPMigQAy5fsSwnS0Rk4UTUXAX5q2wxeyYnPqyEBJ2nz4k
 0YIpF3ZiJJfY2ejussFA5PKAvuj0xeB+QckOrvhhj5C5spA3pIUmr/lJg1wvGrHKrcr/rMt5r
 WuyWZ+98u3MzFhipIkHaIEfOi6YFMiwQA+oa6i6OKTLKDCIg5iyithfWETj2AeoYznNqvhFv3
 lO0jaVsa+alCNdH6G99ECAmky2ifJIspVpYF+khPsXpiJOP2mZKq6zi0P+e8NC/ox1AZUvSot
 G3RDid49afaNcJjUKCLRiuCyqZlqD/pMtojffq1zB6P7Kfz03Ze6bbxZsHVJHzcJhQbpRHUcB
 fKZoN1wvp+/vUa2mImUkB29H61MUAMpIhIf9rnJt+qs+4AZ1YBvnKO1SYiR/DlVH5MlemEwWJ
 eE7oapPUEBYNSKq/dU2ln2TOT1yXZmWBqHczRBF7yTl3XIjvYcvhYCuLaykM/NBVKrSuJ7HB4
 GXenAwagGo9xhv8edp2o9qzybPGqlLmjAvImlNxW8TX0JA=

RW5hYmxlIGNvbW1hbmQgd3JpdGluZyB3aXRob3V0IHRyYWlsaW5nICdcbic6CgotIHRoZSBnb29k
IGNhc2UKCgkkIGVjaG8gInJlc2V0IiA+IC9wcm9jL25ldC9wa3RnZW4vcGdjdHJsCgotIHRoZSBi
YWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVjaG8gLW4gInJlc2V0IiA+IC9wcm9jL25l
dC9wa3RnZW4vcGdjdHJsCgktYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1l
bnQKCi0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvIC1uICJyZXNldCIgPiAvcHJvYy9uZXQv
cGt0Z2VuL3BnY3RybAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBn
bXgubmV0PgotLS0KQ2hhbmdlcyB2MiAtPiB2MzoKICAgICAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQv
Y29yZS9wa3RnZW4uYyB8IDE0ICsrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5j
IGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYzhhNWI0ZDE3NDA3Li5mNmUzNWJhMDM1YzcgMTAw
NjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC01
MTcsMjEgKzUxNywyMyBAQCBzdGF0aWMgc3NpemVfdCBwZ2N0cmxfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsCiAJCQkgICAgc2l6ZV90IGNvdW50LCBsb2Zm
X3QgKnBwb3MpCiB7CiAJY2hhciBkYXRhWzEyOF07CisJc2l6ZV90IG1heDsKIAlzdHJ1Y3QgcGt0
Z2VuX25ldCAqcG4gPSBuZXRfZ2VuZXJpYyhjdXJyZW50LT5uc3Byb3h5LT5uZXRfbnMsIHBnX25l
dF9pZCk7CiAKIAlpZiAoIWNhcGFibGUoQ0FQX05FVF9BRE1JTikpCiAJCXJldHVybiAtRVBFUk07
CiAKLQlpZiAoY291bnQgPT0gMCkKKwlpZiAoY291bnQgPCAxKQogCQlyZXR1cm4gLUVJTlZBTDsK
IAotCWlmIChjb3VudCA+IHNpemVvZihkYXRhKSkKLQkJY291bnQgPSBzaXplb2YoZGF0YSk7Ci0K
LQlpZiAoY29weV9mcm9tX3VzZXIoZGF0YSwgYnVmLCBjb3VudCkpCisJbWF4ID0gbWluKGNvdW50
LCBzaXplb2YoZGF0YSkgLSAxKTsKKwlpZiAoY29weV9mcm9tX3VzZXIoZGF0YSwgYnVmLCBtYXgp
KQogCQlyZXR1cm4gLUVGQVVMVDsKIAotCWRhdGFbY291bnQgLSAxXSA9IDA7CS8qIFN0cmlwIHRy
YWlsaW5nICdcbicgYW5kIHRlcm1pbmF0ZSBzdHJpbmcgKi8KKwlpZiAoZGF0YVttYXggLSAxXSA9
PSAnXG4nKQorCQlkYXRhW21heCAtIDFdID0gMDsgLyogc3RyaXAgdHJhaWxpbmcgJ1xuJywgdGVy
bWluYXRlIHN0cmluZyAqLworCWVsc2UKKwkJZGF0YVttYXhdID0gMDsgLyogdGVybWluYXRlIHN0
cmluZyAqLwogCiAJaWYgKCFzdHJjbXAoZGF0YSwgInN0b3AiKSkKIAkJcGt0Z2VuX3N0b3BfYWxs
X3RocmVhZHMocG4pOwotLSAKMi40OC4xCgo=

