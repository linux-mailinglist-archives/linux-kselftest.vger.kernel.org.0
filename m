Return-Path: <linux-kselftest+bounces-457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8A7F4F46
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F651C20A7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523E5C09C;
	Wed, 22 Nov 2023 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="B+X9C77J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxsmaB38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD4A2;
	Wed, 22 Nov 2023 10:21:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id 9102758071C;
	Wed, 22 Nov 2023 13:21:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Nov 2023 13:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677269; x=
	1700684469; bh=FuK4bS9tTFjezD3GdPwdW0QDdO9NNWltDhOsenLHkyk=; b=B
	+X9C77JGH3b1jTsp6qm22PCvhJHboU5I/AIyQsdtB9+1Qy66Kd6gmgDVGi7QCjg8
	axDkALIr3THvEO4neF5rzKw6uMDZ+HCdRTIk12UDDj3CYdpy8LSBdCoIHGmKS4I+
	e+A2CLmQvixxmunJaeu9vvvDaI+A9jTFxXv3bPqKexp+SGalgRnoFDyS2YOIETkM
	czdl1wVDn0fKAcd6wA5gj/9qr47QVFBYZrdHNQSmv+cfQU2ez7Pni2BB2JRsY6/u
	ZcItv7XBi2p7w1HAlzXDgHWnlZgS98dh3zYYu0sKY4xgzZXzQqk0dtLDXjVUmP/A
	LdqTfaSIc3Zp5/amSXLKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677269; x=
	1700684469; bh=FuK4bS9tTFjezD3GdPwdW0QDdO9NNWltDhOsenLHkyk=; b=X
	xsmaB38ivKpsZWBP+/F0rQNi4Hd/4NUJJFChk5ZSYlKyu92A6/13jn09nEJX652p
	o2uw33xx1iMo81dEUOLGFX+jUzA4dPEmaTRkz/M/YQSCR4+gOmSzHmnoZgQWZ8bH
	9i55uwqFLhi1MPrTAyCpVwiGxha8ysPuonbBcv3OY4GoxCMftxcYP6HBNa9fxuEP
	4SJN2B3dx7471qBk4NH/O9SNYHJY0x6klCWQLW/VKM40OPvD5sQc3jKvBaTY8zr8
	CzKeiHOUwcyduJpvpPAm7I6vLaGRsQD0EkWD9nN4klnnUTi78Avd2HqvxEFkJMkW
	EkGFIbKEWhxuN3SPuB5sg==
X-ME-Sender: <xms:lUZeZbxRLBQ2rStXg-zzyE3ATBwRHZ_ACMXjWrCYVd4iRDssV31miA>
    <xme:lUZeZTTRkxG9H6PKSGOaaT2Tol8ZTtwWGn7iOTbMk_tUospvJPkLabowq30JEuspN
    v0cOosnFe6TkB3yOg>
X-ME-Received: <xmr:lUZeZVUjNTWth-ERQVBEfQFSSwLdbnkLGVXnhkRsWxMne_mLX4NxoAUO3yIXxNB2tLOAeIyPEc4liiIWnQptJDJCqOFXCAMmbSZ_iuV97dFuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lUZeZVjVnfIgIby6ZPRyxzUFoN10_RZYyHzQpjBl6sUlRI4GmMFJfw>
    <xmx:lUZeZdCqRFQSKGptDzS3fXIplyqNKN0yLK1LSHxBGOFiez5Rql63Cg>
    <xmx:lUZeZeI2Wusn5oPnUfV_89dAA5tTEd9rpxLN-TvVI_n-e2iNfzrXSg>
    <xmx:lUZeZcV5HpZepT61911RSEfDbgKQhne8tLOl0VebSKwsx6fMKmuaEw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:08 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date: Wed, 22 Nov 2023 11:20:27 -0700
Message-ID: <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to vmlinux.h definitions seems to make the verifier very
unhappy with bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

It looks like disabling CO-RE relocations seem to make the error go
away.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..ec7e04e012ae 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_PRESERVE_ACCESS_INDEX
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
2.42.1


