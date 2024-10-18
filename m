Return-Path: <linux-kselftest+bounces-20131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4269A3C7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 13:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80564282119
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22455204085;
	Fri, 18 Oct 2024 10:56:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE1204087
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248973; cv=none; b=XVvtHx9aVB/fmjD3hKi14/fH9NGubeWBIRjj+eJYIPPqmEbellhtX4dHna8wMNLccejAngjsQ/Dh2205yl9fq+E9mPoKKZ+ahXAnmv9JEGbyobs9tr3vUxpf54mu78dr0bXIDrM3hETL0S9O9Rl7FbxBxKwy5ntu/1sNVmfHIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248973; c=relaxed/simple;
	bh=aJG+Ja2ZNr4mHW6ZV8ImBlNkGhYf60iO1OTwLhQu1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1Q/ZqSJ9mwyNSUO5oitOR72sjmWAPquIbM0WOUO9Dgn/tgfZFGFU0Xbs9JYLdmSGWSVBs1AHKi6fpcrqbWWbP229kJCObqtvW/hD4PXm9XT+iLV2LHkFHvvTPhFIUqi5AjUX4CSdUdmUm1RIS8PViNZJaXBG7WOTb2WjFY3Og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-x-zVYiU6ONGlk7XkK1l39w-1; Fri,
 18 Oct 2024 06:56:06 -0400
X-MC-Unique: x-zVYiU6ONGlk7XkK1l39w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B1641955EA8;
	Fri, 18 Oct 2024 10:56:04 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9C4F300019D;
	Fri, 18 Oct 2024 10:56:01 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: tls: add a selftest for wrapping rec_seq
Date: Fri, 18 Oct 2024 12:55:58 +0200
Message-ID: <20775fcfd0371422921ee60a42de170c0398ac10.1729244987.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

Set the initial rec_seq to 0xffffffffffffffff so that it wraps
immediately. The send() call should fail with EBADMSG.

A bug in this code was fixed in commit cfaa80c91f6f ("net/tls: do not
free tls_rec on async operation in bpf_exec_tx_verdict()").

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/ne=
t/tls.c
index f27a12d2a2c9..1a706d03bb6b 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -266,6 +266,25 @@ TEST_F(tls_basic, bad_cipher)
 =09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct t=
ls12_crypto_info_aes_gcm_128)), -1);
 }
=20
+TEST_F(tls_basic, recseq_wrap)
+{
+=09struct tls_crypto_info_keys tls12;
+=09char const *test_str =3D "test_read";
+=09int send_len =3D 10;
+
+=09if (self->notls)
+=09=09SKIP(return, "no TLS support");
+
+=09tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12);
+=09memset(&tls12.aes128.rec_seq, 0xff, sizeof(tls12.aes128.rec_seq));
+
+=09ASSERT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+=09ASSERT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+
+=09EXPECT_EQ(send(self->fd, test_str, send_len, 0), -1);
+=09EXPECT_EQ(errno, EBADMSG);
+}
+
 FIXTURE(tls)
 {
 =09int fd, cfd;
--=20
2.47.0


