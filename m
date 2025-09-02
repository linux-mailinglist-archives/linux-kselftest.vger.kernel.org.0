Return-Path: <linux-kselftest+bounces-40593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339BB40159
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623851B60EEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC42D9ED1;
	Tue,  2 Sep 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qLheoQzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283982D3A83;
	Tue,  2 Sep 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817634; cv=none; b=JXbjET7Xnw9/eqLPP8XhzWgcN7YajLIGZyfFe/dG61sSWiRlkCZpZsZ9lrvbUPp0q68pgo+xTxkrnsEGl2G8W3Da6hE9fGI/RLj8BhLCOeOSiYETUuUgjvq4GZihKAQDbBTA+F+zXV9miwW1e9sJm9/2n/MYUdrzSkgmkuxhxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817634; c=relaxed/simple;
	bh=g8Aim77NAHTK0ZTbHSgoP5l5J224zz2a5ou+JdoIl+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=divrvS7V5Vp/lncoqBEoQdPAc/Hdj3mIvIDmvh/GEBUtGM4RYjJVxl7Ovh3sHcBlSDgYTOyA/L7Yqw6LxYlARzpHKsYKXn5FCm8976/FtZmfkpseFFSVyfTAGYp0rllXYwZXVhH/YW9ecJNBqCStymJdUYaKGxxJJ8ESHwgY4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qLheoQzv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8E3431A09B9;
	Tue,  2 Sep 2025 12:53:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65B2A60695;
	Tue,  2 Sep 2025 12:53:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DA1D1C22D920;
	Tue,  2 Sep 2025 14:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2U+jg8j9SZx/xaZowxntjhB9EE9FIpB6jN4vJSqiwdg=;
	b=qLheoQzv0/CiECjHE6kDyEfc/V3zlPPRlLMBeDZm+tKVyX9JP7rBbby4U9ZhCuMt52RKAv
	+/vtFMV8UCD/HMdD6Irtew9F9MR4LcPmbjqqmIzRTpHlhEl8mMk/JU4uFMeVxagIgyXcJx
	zmZ+BCG8QeO9exnAwDUC6Mpcz4IOZUA4cJL9yJtExPdwWP74YBibBpQy/KLtJZNtm29KFP
	PUcGN82H8P48wlAj/rd19EY2ovLPSSTLMbfR92bx6Drt3i9t4usg8YGP2Lwk7RbZ/5Hahm
	phxa11fFxfA4/OKTkMdjm9mUl9/DuXxWjGNjm3Lt70O1k6nf/KYVFHProzzcdQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:52 +0200
Subject: [PATCH bpf-next v2 02/14] selftests/bpf: test_xsk: Initialize
 bitmap before use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-2-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

bitmap is used before being initialized.

Initialize it to zero before using it.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 2b12159a7e9c465e08a452d920f3961981168fb0..ef65beec3b870ae4fdc7aae9e3c4537c8ebbfce3 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1079,6 +1079,8 @@ static int receive_pkts(struct test_spec *test)
 	u32 sock_num = 0;
 	int res, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
 		exit_with_error(errno);
@@ -1269,6 +1271,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	while (!(all_packets_sent(test, bitmap))) {
 		for (i = 0; i < test->nb_sockets; i++) {
 			struct pkt_stream *pkt_stream;

-- 
2.50.1


