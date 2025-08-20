Return-Path: <linux-kselftest+bounces-39347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A6B2D1D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8891885343
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC5220F20;
	Wed, 20 Aug 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAVdh0jw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E320C47C;
	Wed, 20 Aug 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656400; cv=none; b=n+88vZ6KbU+Om2XXPfbqlIB0+6NXbeM1Ztsuly4aVUnFviIIwfbyRUSO6nzDAia/UAMTwtN6xKbyZIdfrLDkyjMCTM7fmKIdRHRcqeueCmGiUHlIa1MHjH5Hb+1dfWHgZOYTLUTXBfdyK0SKcHwCHTvcmZdWXn+us75gTmC//Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656400; c=relaxed/simple;
	bh=rnOOVfhATF2sXlf6TA43TUWmhbaHQJOoNukOPhP2/VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saSrVqWgtMolbEjN559dkADmLoBzFWeaqeeJr025EFTn60VumTKIrAb/6R9T6pjqhcpy1XJIvueC4qt1FAVc+qZJKlP2uw1a1s8A+KJrAlwqyFRcE5l6n5/2kej7DrwuyaA1k08O44D2O55En2WmaHyok4jLSjMYy6Z3aOGoRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAVdh0jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A2CC4CEF1;
	Wed, 20 Aug 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755656399;
	bh=rnOOVfhATF2sXlf6TA43TUWmhbaHQJOoNukOPhP2/VM=;
	h=From:To:Cc:Subject:Date:From;
	b=LAVdh0jwJUrH2mjNL6Kkknr+NZGgyy/LP7J7jkI3B7KIScfZREBWQP+ZlZso4wKI8
	 DxcmUGJA//BU7QeT3Lp5Cw+CbPUqxuwIKddftn29ckJO/Xt3x9pbD0W/Qnbczykp4X
	 7MC/X9gBiFI/f6RMarkG8qCpFPCf9LBzWBVaKzIk5U5/1DDsTu02Vxk2jfVx0hVNCu
	 Rc2gdNfO6enwngBsxSCjzTjhrokg4ZeIuGKWHmLfTfLNv2hyp5+kKCggfY2hQtvf9q
	 sVDj1LKcZdbcPOQSKErgUoy3qYllU85yWwpKttmO+7+DbFIFHarvtTNlrBn+im6fwA
	 EaXa/vhknZfhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Billy Jheng Bing-Jhong <billy@starlabs.sg>
Subject: [PATCH net 1/2] tls: fix handling of zero-length records on the rx_list
Date: Tue, 19 Aug 2025 19:19:51 -0700
Message-ID: <20250820021952.143068-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each recvmsg() call must process either
 - only contiguous DATA records (any number of them)
 - one non-DATA record

If the next record has different type than what has already been
processed we break out of the main processing loop. If the record
has already been decrypted (which may be the case for TLS 1.3 where
we don't know type until decryption) we queue the pending record
to the rx_list. Next recvmsg() will pick it up from there.

Queuing the skb to rx_list after zero-copy decrypt is not possible,
since in that case we decrypted directly to the user space buffer,
and we don't have an skb to queue (darg.skb points to the ciphertext
skb for access to metadata like length).

Only data records are allowed zero-copy, and we break the processing
loop after each non-data record. So we should never zero-copy and
then find out that the record type has changed. The corner case
we missed is when the initial record comes from rx_list, and it's
zero length.

Reported-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reported-by: Billy Jheng Bing-Jhong <billy@starlabs.sg>
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_sw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 51c98a007dda..bac65d0d4e3e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1808,6 +1808,9 @@ int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 	return tls_decrypt_sg(sk, NULL, sgout, &darg);
 }
 
+/* All records returned from a recvmsg() call must have the same type.
+ * 0 is not a valid content type. Use it as "no type reported, yet".
+ */
 static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 				   u8 *control)
 {
@@ -2051,8 +2054,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0)
 		goto end;
 
+	/* process_rx_list() will set @control if it processed any records */
 	copied = err;
-	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA) || rx_more)
+	if (len <= copied || rx_more ||
+	    (control && control != TLS_RECORD_TYPE_DATA))
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
-- 
2.50.1


