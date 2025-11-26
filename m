Return-Path: <linux-kselftest+bounces-46566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49905C8BCE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316734E1903
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E63148BD;
	Wed, 26 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AL+MXQ/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0n0WmMPp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ryujBFC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y2yoHJDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784D340A57
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188404; cv=none; b=DznCCeh1BKyc49GPkVKImSqCPYQqVXcuxUAEQfoToe0vatRSHqr1u7f0YYneezqVyCmehig8POVOGmsc3nEd4VnojA3U1rkVW51VKwUijUPDl9KNyE4u3vUDmBIiZU30dBHGQ401QrUTEfglKyo//YKFVxTy1xi3dlDqlT2wIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188404; c=relaxed/simple;
	bh=z7sOYHy8J0lnmrliZ3kmLku30Y0juS3r3eF7C9Og0zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCV6+79o/0hCpK4rIxZybip594+ynGzEA4T1iL/ij/W5cyT+LqIcwa4Vog3p5waFdEmAEdUwK2naNSVH8iwEXtJIT+gjbCKSsnYB1acO9PHNI7JHzLdn5O5gPsaKa+4aQkFaGi9jStqFKBHpz2b3z9x1/Wmolq9K7Xw/gX7mK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AL+MXQ/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0n0WmMPp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ryujBFC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y2yoHJDp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC7FD336BE;
	Wed, 26 Nov 2025 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764188401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ZGGIf+chp9/73JzcwFoh722FFjDNNtO2bWbpDyFzbQ=;
	b=AL+MXQ/s2YMzTgBbb8xK4NLnq/frBTmW/oXXxXnE6REmqKg7FLSJnlek/wUU1ex4B49lqB
	9r0k+x6PqY1dpSMlFxH+FRHKZQRbAYEOHDsYSP2IiD3AVt7PEnfhTEtYfb2tR9KlbDA9YA
	nrZNXvJZrv6BV/uTwjvRzdhdPzSiGRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764188401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ZGGIf+chp9/73JzcwFoh722FFjDNNtO2bWbpDyFzbQ=;
	b=0n0WmMPpEMDKCaW12dhJGCzyxjUvHeZgSKSaSrOeUAVjYojs35vOVP0RP4rTlmag+cqAAF
	zV+Mb9pR1h9RpSDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ryujBFC0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y2yoHJDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764188400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ZGGIf+chp9/73JzcwFoh722FFjDNNtO2bWbpDyFzbQ=;
	b=ryujBFC0hJ6eFrPhXFfJA7OQ6j+x1X7THJy5/RHONSNDmwgYDGVMio9bYcccBQ2As5xQqD
	4KJj0NPa4z734T1ahzUOIokgl0xnHhJoLVIejQjZT+UXSpbLfNhiG5F11LgnDb6c+h6L+s
	hMU6x8lQVOxLwJXorewGCPxjz4PJhv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764188400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ZGGIf+chp9/73JzcwFoh722FFjDNNtO2bWbpDyFzbQ=;
	b=Y2yoHJDpuAsLfnMA8qXUedGewqlq4+QWlvg2I+zYylE2PybpxI6MnchmkVO/AfIrUqkNSc
	EZHbky2TOosad+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB1C3EA63;
	Wed, 26 Nov 2025 20:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tGNTD/BgJ2mDEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 26 Nov 2025 20:20:00 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next] ipv6: use the right ifindex when replying to icmpv6 from localhost
Date: Wed, 26 Nov 2025 21:19:42 +0100
Message-ID: <20251126201943.4480-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EC7FD336BE

When replying to a ICMPv6 echo request that comes from localhost address
the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
skb device ifindex instead. This fixes pinging to a local address from
localhost source address.

$ ping6 -I ::1 2001:1:1::2 -c 3
PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms

2001:1:1::2 ping statistics
3 packets transmitted, 3 received, 0% packet loss, time 2032ms
rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms

Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/icmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 5d2f90babaa5..5de254043133 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -965,7 +965,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	fl6.daddr = ipv6_hdr(skb)->saddr;
 	if (saddr)
 		fl6.saddr = *saddr;
-	fl6.flowi6_oif = icmp6_iif(skb);
+	fl6.flowi6_oif = ipv6_addr_type(&fl6.daddr) & IPV6_ADDR_LOOPBACK ?
+			 skb->dev->ifindex :
+			 icmp6_iif(skb);
 	fl6.fl6_icmp_type = type;
 	fl6.flowi6_mark = mark;
 	fl6.flowi6_uid = sock_net_uid(net, NULL);
-- 
2.51.1


