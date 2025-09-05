Return-Path: <linux-kselftest+bounces-40836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BAB45916
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F01BC1C06
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414C353364;
	Fri,  5 Sep 2025 13:31:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A72D6E62;
	Fri,  5 Sep 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079084; cv=none; b=AEf7aoyn1fLs64+yJTCSq2eukFpDGSjWX75IrTu7xfjbF8+E6De1oyrfyRi4qHEJO0d1VgHv8XOkZVzk56o8uetHHxFZYGY0clYB1X5HzVBWp3me7yb7AbnM3u6SXZtl/LHJxNiD9lkNqpSRbV4fxS35Q5mw070ieQdFNI0FF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079084; c=relaxed/simple;
	bh=rf9sVNJsnmH3LOWkU2HEe8xahf4pGl4aNLifTk2O568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm1AEreBSjWMGnCzEHBS6BB8kfIRbda+ocQBSHAivy/Giob0RnqcLEMo3qvKoXDJqT7B+N27NQ3IQijmmCCyQ00v8UzudZFfECAZjcNYZvIyHoxuj0g4U+lYGnT5c+bAvu3WNWBliuhwN4Hm3iA24RbOAnaMne1fGenGQ5x2skE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b02c719a117so407922166b.1;
        Fri, 05 Sep 2025 06:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079078; x=1757683878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKeG9hLjc/M5EqvMp73Iry6LN/4QdPtBlh+yTbCmNiM=;
        b=hqyG/gJFWZuC4+hoWYb2EcrsfQl8kGxPb1yOAHEZ6XPTLrNWnPJFPMTttxmBZunNDn
         yxiYaxXVS6hhgXjIqw/OblE2gu9VjRwibUMzVCL50YhImbimJp9Sn6JLPXCcR2aHCOcN
         rdQGFNvMLVtGyyhULY8K7Rx9a1uV2gSSC8nrTOPu23RI+FkqxAPiG/6BARteIUS4boHp
         CTiBYqYVK6FNfY+XqUB+JyesHvAx5/srDJJmh91R3XoqL2FVMPWUOZoNPzmKLVVFItX9
         zox8oMWpwv1bxN41k1iWIpCDdZLJy+TsCGUdSf4FQFAGQYe7a846HvTca65dMKtjQRdj
         lmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG377ceflOqb+Jepw82ZpU8mPXmBP9PiXG/OKi+/CrAN0oRcNCtPN61ReTklxCY4wMd/vcIeANC4EIkI/fU7ud@vger.kernel.org, AJvYcCWCFxD06eBfIePMUAf9IV7NG+TIa4iZIggRM9JTDgb1HBH2hy3gVHsSWxOG2QtZhglGkLxvNTuclf/dKoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqxkCnpSx9gPRX8MTaSPh0T/V3dcqlbHDmZ03VCV4quyKBMAf
	CHk+OoCtFPnHH13aIscbr0qtp3F7AxRPm/8wuLm0tzGWmnYtgBvXCRKaZppGuBHF
X-Gm-Gg: ASbGncsUIVpUrsRpSjr4zfal8Gr4RjY/ZmKCTcrU4RFvN8Mk1TdgpclNO0JUyQVIzzR
	qYexg2xn9bI04YL0ck4PIDHwiEXidvdQ8PPthWfZgRZMblc5Bf2Sy2midszU/I+q/b6qaTW08hQ
	8fmvN634gsDWBcz8QmJ5e6QHQ2R1Wbf05NG5UDLcBfqpPGCoCPF1NvYuPhLYJ30epTNYnlNwiHi
	VK1jIEN8cBq0AtaVZyvGPs3w/IfxvIqR0ReCEHzvdMqbiRkGS1PhgkerNLd+5Qa/0gyZSrTGS50
	db9cshftvdYy9neE3JFKk0DYsgPsVJWCCcJ9zDxqJCqBrHQX31i8/OfTwyH+3c8zumTRzAgXV6F
	sfuDNXi/5fZ8CNLwX5gkF1WeyX4F6oSe9aQvpbVB3TsNO0IyP/uQY6pVl4MER8MLDGb7/qWvJCV
	FAoTRE
X-Google-Smtp-Source: AGHT+IHlLmdR6TpWWnLz8ssez8gC8hhaH7N+HwIxNnPl/p7xdmHjtnhQggrFarSFnyf3bWEHYs9VmQ==
X-Received: by 2002:a17:907:720d:b0:b04:5a68:8686 with SMTP id a640c23a62f3a-b045a688d92mr1367852066b.4.1757079077794;
        Fri, 05 Sep 2025 06:31:17 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-56-72.nat.epc.tmcz.cz. [89.24.56.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm1547277666b.85.2025.09.05.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:31:17 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 1/2] net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
Date: Fri,  5 Sep 2025 15:30:55 +0200
Message-ID: <20250905133105.3940420-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905133105.3940420-1-i.maximets@ovn.org>
References: <20250905133105.3940420-1-i.maximets@ovn.org>
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
index 4160731dcb6e..b7c6736a7fe7 100644
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
+	if (iph->frag_off & htons(IP_DF))
+		__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
+			  tun_dst->u.tun_info.key.tun_flags);
+	return tun_dst;
 }
 
 static inline struct metadata_dst *__ipv6_tun_set_dst(const struct in6_addr *saddr,
-- 
2.50.1


