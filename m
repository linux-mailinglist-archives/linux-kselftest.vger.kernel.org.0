Return-Path: <linux-kselftest+bounces-48413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E55CFEC71
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39696307BE62
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193E3A35DA;
	Wed,  7 Jan 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HffQtd3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VbfctQdP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HffQtd3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VbfctQdP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E43A35BD
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800347; cv=none; b=rprhuXb3TcOmFrYUC36VyJOuFeBZsyO1qLrItNPe0ff0cMKc1Yx0QEbHqoLKHj+HB006iOryO5EYDt2tSZighHC0DMTkKtHvSNuUyi0Dhzl5q5fK+px5WAxqlfShaj1kByn6lRadeGnqIT1/EZP58trAyFBgkF44iP6twHdpyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800347; c=relaxed/simple;
	bh=50w+oXt2hScNdCwJcCVqTG2Afxm91zAvIhyTSnt4iuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bv7UaYyY+ejscvvxRelhdpQcGuGYjJ4pE+K2hszcRaSxssDjwfHCyC4ESmYza07gTc9HjwM9nqiFQNMzC/7yDUCCnC7tQZJnG77X9IDfY6jqer860xwVILfd5+94u28x+9zym6y9SlYeik+ju44XJnm6O1u2vNwbXV6B7k4U3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HffQtd3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VbfctQdP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HffQtd3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VbfctQdP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCC185C1FD;
	Wed,  7 Jan 2026 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767800336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1vbLNYrfc5erOsYy/2jQXQL9OCtF2aZv1jUjz7lYxqY=;
	b=HffQtd3TM1BjTsGQwefVftqZ3266RcD5AQK/4N04203quy+/o7pt5WZA0OKIcTsJlJy5Z8
	6r55ogwrldeu7wCKXZxogH2VLcmrQDif6W9cbMVXllJpxMfHnvrQcM/AS4gYxJYp7emvik
	F0qgge4sWcc/sUhCR/OCv10z2eHbeq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767800336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1vbLNYrfc5erOsYy/2jQXQL9OCtF2aZv1jUjz7lYxqY=;
	b=VbfctQdPdf+mJe9RMGv9VbUn82Ba4/3Av9AMqrvN2bCZZC5EHOdX7+qFuDO2IsY1/wVRlq
	4YyCXKKmztAIQFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767800336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1vbLNYrfc5erOsYy/2jQXQL9OCtF2aZv1jUjz7lYxqY=;
	b=HffQtd3TM1BjTsGQwefVftqZ3266RcD5AQK/4N04203quy+/o7pt5WZA0OKIcTsJlJy5Z8
	6r55ogwrldeu7wCKXZxogH2VLcmrQDif6W9cbMVXllJpxMfHnvrQcM/AS4gYxJYp7emvik
	F0qgge4sWcc/sUhCR/OCv10z2eHbeq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767800336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1vbLNYrfc5erOsYy/2jQXQL9OCtF2aZv1jUjz7lYxqY=;
	b=VbfctQdPdf+mJe9RMGv9VbUn82Ba4/3Av9AMqrvN2bCZZC5EHOdX7+qFuDO2IsY1/wVRlq
	4YyCXKKmztAIQFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5396B3EA63;
	Wed,  7 Jan 2026 15:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FcJ2ERB+Xmn7CgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 07 Jan 2026 15:38:56 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next v2] ipv6: use the right ifindex when replying to icmpv6 from localhost
Date: Wed,  7 Jan 2026 16:38:40 +0100
Message-ID: <20260107153841.5030-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]

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
v2: no changes
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
2.52.0


