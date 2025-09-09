Return-Path: <linux-kselftest+bounces-41057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC0B5034E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD3C3ACF71
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56EB35E4F4;
	Tue,  9 Sep 2025 16:54:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C135CEDA;
	Tue,  9 Sep 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436890; cv=none; b=uBDCuVpHrAddgmLAYlxKICRzh0h3o7yRjnMhFGFlYB5P0Ya1CTwF4TFkzIGOPzFUXEwrhOpJwltqjpbHjT8N9ygBGnU4zIYSKjjHnaN5HfFguBcOsE14y+NosJA9nrfaMXPACNrz7YEmM8R4mjZ15K15Q3N1D6Yw+OeC6O6KKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436890; c=relaxed/simple;
	bh=jdbVfhyNDy3ScJwdpuXRbfGXLtpnNYn4aqpJz5iRAj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObSSK7Sla91O1p8J2+Pm4HXJHQDTCeGKBwhFB7Rtoe/0+rL6DjZOqAy5HnMLsjsbjzGI7vG/6l3uKZ/1xHZFiLC6bRbxcuiB3QjRERlowdlKwZDwQvG4KTE7MqeiZIIibqPlseGxAy5rWHcNryW1Ab/3BoyogPDE7BiMhHk59Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso5716013a12.3;
        Tue, 09 Sep 2025 09:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436887; x=1758041687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US5eECN201nn2lBjMJZb8xxddZfYzRWCBlds6C0VTV4=;
        b=matfhCoXWhr5qe1v4TEwrw4fTpXLGyPY+eyyC4UbWIm5bx+Sw/OCkVrjXbtdR9qPv2
         fS4PJSL3g+Wf4R5H1Fw8eezxF6TJ6yRsjEeGpiFGMIjQTKYKcdLlnSSXuwpO1+MLHMZE
         IVVJfDeGbsCv/bXSquOrMqvCJ/47o5FnbwBTE/TKab6sii8V9o6CJcI50IKGLCRdwEXg
         Ex1xkNVipPQlgGpjc/cplIBDv7cK4vW8CKO2FIqG73S4E95sFgiaArNJSLLDwdbN4NT+
         HiNXtN1y2NNvShDMbtqgrxn+NrHiu/bPSxv0pQpHEWk3lGkCAatiyI+oF6CVtE+y0BFH
         AvRw==
X-Forwarded-Encrypted: i=1; AJvYcCWGmfNbpKcAx0H4HKfqfoXXqrPfFRvGZJQPAGDkM/hEQp8zIkboO92gDqwRiDtJr1jOfvyB5jFAxSgIptWy1s/3@vger.kernel.org, AJvYcCWf8pPTXmx3NcRa3tpLZhQPCLW2gZ4u4qHPDGCGMEUohInKnAv17FyH6P4W70b63vPYwjPQWWvssULVWjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pViYAt/Aev5CUr2bYZqgSGc7JHafhgCQGF6muYdi+TGitbII
	dmJ7/2GliF1/QK9mQ6XTt4l21nZGz1crj11jtKAtvDHay9fc1N6oJDnUNchu3pf3
X-Gm-Gg: ASbGncsMLPIgd+BDodSsYW53aUKYanc5dlMjpoQ+Iyueg0nNgkp/m0LNzwoh2fkZjTH
	MtFx39dWCBeRQQkvbC3tBCG25yKtAb4YX4fgbk6tkjSyS563zH7pium922CWUmvyI+uH9neJ//5
	TJCmJrm3IXIWmSsLXj7EdMDYywZmLl2j2dbiDf2LZkL6yXEK5xk6wtTGzLND5liMlMj706j6IS5
	aVkrTPN6Zlts3ZIIEJWBJYtbdEg3JEsTb0hdzuadkNF6LUv0VVBt8+6ruSW4hamdSNs/UUUyZZy
	CO9x0262E1DbkDJWKh0mpyaYWHblpB8KpfKZU1cyrJJ7N/2zhNbhaWZfPJcNc/VbHynvGXAKMAC
	I+EsphR6kBwuuonroYfY7z1L26Gm0fnUl7Hqz84r1yV9wzznXwEo4c45xrzlRrA==
X-Google-Smtp-Source: AGHT+IF5WpQ9BlQlNSx4PkE0JwB3/n09qaYMSzzFOW9lj1zNEOvA7s98g8pDch1JVdTqJKMKLPTf/A==
X-Received: by 2002:a05:6402:5215:b0:62c:9185:2200 with SMTP id 4fb4d7f45d1cf-62c91852b90mr1593061a12.22.1757436887245;
        Tue, 09 Sep 2025 09:54:47 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-97-40.customers.tmcz.cz. [78.80.97.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f90cesm1497326a12.44.2025.09.09.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:54:46 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 1/2] net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
Date: Tue,  9 Sep 2025 18:54:15 +0200
Message-ID: <20250909165440.229890-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909165440.229890-1-i.maximets@ovn.org>
References: <20250909165440.229890-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both OVS and TC flower allow extracting and matching on the DF bit of
the outer IP header via OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT in the
OVS_KEY_ATTR_TUNNEL and TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT in
the TCA_FLOWER_KEY_ENC_FLAGS respectively.  Flow dissector extracts
this information as FLOW_DIS_F_TUNNEL_DONT_FRAGMENT from the tunnel
info key.

However, the IP_TUNNEL_DONT_FRAGMENT_BIT in the tunnel key is never
actually set, because the tunneling code doesn't actually extract it
from the IP header.  OAM and CRIT_OPT are extracted by the tunnel
implementation code, same code also sets the KEY flag, if present.
UDP tunnel core takes care of setting the CSUM flag if the checksum
is present in the UDP header, but the DONT_FRAGMENT is not handled at
any layer.

Fix that by checking the bit and setting the corresponding flag while
populating the tunnel info in the IP layer where it belongs.

Not using __assign_bit as we don't really need to clear the bit in a
just initialized field.  It also doesn't seem like using __assign_bit
will make the code look better.

Clearly, users didn't rely on this functionality for anything very
important until now.  The reason why this doesn't break OVS logic is
that it only matches on what kernel previously parsed out and if kernel
consistently reports this bit as zero, OVS will only match on it to be
zero, which sort of works.  But it is still a bug that the uAPI reports
and allows matching on the field that is not actually checked in the
packet.  And this is causing misleading -df reporting in OVS datapath
flows, while the tunnel traffic actually has the bit set in most cases.

This may also cause issues if a hardware properly implements support
for tunnel flag matching as it will disagree with the implementation
in a software path of TC flower.

Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
Fixes: 1d17568e74de ("net/sched: cls_flower: add support for matching tunnel control flags")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/dst_metadata.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 4160731dcb6e..1fc2fb03ce3f 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -3,6 +3,7 @@
 #define __NET_DST_METADATA_H 1
 
 #include <linux/skbuff.h>
+#include <net/ip.h>
 #include <net/ip_tunnels.h>
 #include <net/macsec.h>
 #include <net/dst.h>
@@ -220,9 +221,15 @@ static inline struct metadata_dst *ip_tun_rx_dst(struct sk_buff *skb,
 						 int md_size)
 {
 	const struct iphdr *iph = ip_hdr(skb);
+	struct metadata_dst *tun_dst;
+
+	tun_dst = __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
+				   0, flags, tunnel_id, md_size);
 
-	return __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
-				0, flags, tunnel_id, md_size);
+	if (tun_dst && (iph->frag_off & htons(IP_DF)))
+		__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
+			  tun_dst->u.tun_info.key.tun_flags);
+	return tun_dst;
 }
 
 static inline struct metadata_dst *__ipv6_tun_set_dst(const struct in6_addr *saddr,
-- 
2.50.1


