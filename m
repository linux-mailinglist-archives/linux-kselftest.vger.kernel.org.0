Return-Path: <linux-kselftest+bounces-455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740B7F4F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3DBB20D69
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39A5B201;
	Wed, 22 Nov 2023 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dF50PVdg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OF/BwjXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E201B3;
	Wed, 22 Nov 2023 10:21:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 4FDFA580452;
	Wed, 22 Nov 2023 13:21:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Nov 2023 13:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677266; x=
	1700684466; bh=JJhVdczU7V+MRWD9pKXDtWWzYuthdE42AK0YbBKT7ow=; b=d
	F50PVdgUTy+lowMWaJEiGE3zPZujRZVyTjo9FyOYpxRymzz4dCbUUyRQnC+9ixPu
	Ae5cUXNfOseMZ8hVjTJNbpYTPWlFFxD9u+4V4lYmGxwdJogtnVogAqxN+I6Yr3L0
	nbCusAT9W91OPwOkF2WNX37MmDWweQrljYEajhG220IW9l/pc3/D2hFuhbryFXi3
	F/e77zoKzP9ENJzVOYeaeqf+D1RvLLQ4ATfqvXCnen++OvLFZSAPlHsmLlDxBqlv
	nFCsZ8BYEVgCiNCUZqj3WccxcQ5oayYjE36dlYcvlluZtj3d9OAp0byVVDRDtdJX
	Rs7r8KHChg32URIzIFFSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677266; x=
	1700684466; bh=JJhVdczU7V+MRWD9pKXDtWWzYuthdE42AK0YbBKT7ow=; b=O
	F/BwjXRZNdD+dOpCFVX0WjjU5Ya1eFqTyNpSal68q2Ksaq3CaRLdnhqcUwLbkkk8
	KdiKQSO0YHLJt/IR1HsTjPQDUCac9D8wR+eP2WoMR2f7Pvmx5xHhYU8wDKzl40v6
	vGNnUb8Pg1kzowjwpikMTz2R4llSCYlHFL8D5dkxQTKNRoF7DNEDlI77Ce2Qw684
	upgjQI9uMGukASuzT5p4xHY1+TNN73IiAfPQ9qCbW9nEraK8WA2ukqcmeX2J3c3K
	J0Aq+qKVPBGr5Goo4gMn9H4Wou9TN3kEBxY5So4WQMuelPVMvFzFX3643h49LSfg
	c97guHywmX8hpDuznn/7A==
X-ME-Sender: <xms:kkZeZcD9wCPDgksE_Bxv1Am2T4pF3VdrSITyFKtYVmPe8vqkkmXmUQ>
    <xme:kkZeZeimHFKlw-UtIUINz9eBvvi_Jh4XbKfhy8jWNMI4E5tnpJZWvmOUyVr7VEwQN
    ofp101GGknKhnEvgA>
X-ME-Received: <xmr:kkZeZfnYZ7lnOt0Whyb4iaMFR5iItbOm_D7h0LNPk53YWxs5RLueNNGXnZAOkxjqnokgxT291fsM1J_6nkHx8xRZ1FKekswx5P7zCyHDSh1ehg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:kkZeZSyElnYRO-fk3O5IXcg6T3LJu2Oqv8unyLr12tlpPLlKK4aYaA>
    <xmx:kkZeZRSTqfUQEI2D1l27cURVcVXbFnHt1J3xC0cVMdU5wc1lEiWlPA>
    <xmx:kkZeZdYzrmKpZqjqP8HOkBIJpcUbjH6ceGRHMoMhhBhYTOe7ZlLPVg>
    <xmx:kkZeZTlm-tBzBWHzIEE86XuiYcwNH06f4OXtW9Ih9tTxCynUH_7Yug>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:04 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 4/7] bpf: selftests: test_tunnel: Mount bpffs if necessary
Date: Wed, 22 Nov 2023 11:20:25 -0700
Message-ID: <e0028438c01f733c6d1913db397c0df8f274f537.1700676682.git.dxu@dxuuu.xyz>
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

Previously, if bpffs was not already mounted, then the test suite would
fail during object file pinning steps. Fix by mounting bpffs if
necessary.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 85ba39992461..dd3c79129e87 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -46,7 +46,8 @@
 # 6) Forward the packet to the overlay tnl dev
 
 BPF_FILE="test_tunnel_kern.bpf.o"
-BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
+BPF_FS="/sys/fs/bpf"
+BPF_PIN_TUNNEL_DIR="${BPF_FS}/tc/tunnel"
 PING_ARG="-c 3 -w 10 -q"
 ret=0
 GREEN='\033[0;92m'
@@ -668,10 +669,20 @@ check_err()
 	fi
 }
 
+mount_bpffs()
+{
+	if ! mount | grep "bpf on /sys/fs/bpf" &>/dev/null; then
+		mount -t bpf bpf "$BPF_FS"
+	fi
+}
+
 bpf_tunnel_test()
 {
 	local errors=0
 
+	echo "Mounting bpffs..."
+	mount_bpffs
+
 	echo "Testing GRE tunnel..."
 	test_gre
 	errors=$(( $errors + $? ))
-- 
2.42.1


