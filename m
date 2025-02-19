Return-Path: <linux-kselftest+bounces-26963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEEA3BEE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCA1788C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080781F30C3;
	Wed, 19 Feb 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3Xn67lJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBC1E5B89;
	Wed, 19 Feb 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969501; cv=none; b=SiEkQKmojiuTDec4hYFRnX8nthpUzKNXcQ24ygQiFTt8VB/+o0o14pWbGopOP7k3Qj/P7I6bQzcIGYi7xHLjyVILtwaJP5lhpiTeRDRLbSQraJ5hr76hKv7v68OaN1GOrR3noqkGBcpF31uEj9UMCpmPyuLJqXNtqAR71RTgX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969501; c=relaxed/simple;
	bh=jZGAovV5B1ykmJN882YjcynX9CWKmzmbJdKE/yIxe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBHQU7JPN2JKyBY2Ob7H2oD3HIs5SfQY8fsVj0jHMmYpVTsvP5wxTLh1mhPV2qBzy+ONjnoDgGPMo/jgch74kfciznnc2ofsYQdV42J94utB1duCVnBNvjCW71MAonCd0DzP83yLdMgPSw7Op7nshtAg98r6r2J0aW6UxnKi26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3Xn67lJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211cd4463cso68153535ad.2;
        Wed, 19 Feb 2025 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969499; x=1740574299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=K3Xn67lJqBF/v6y6nw+wxUqYN11rEXrC1frgwzEHvTuAcbyTmVGrGd8echiwO+RVN9
         yZhiQQwOcU0Sgj+QSLuV5zsyZ1Q9VYEyEEpTClUObrYK5eYZgqxjQy77TwnhRc1Q0YBG
         PSyuL/T7EIzZsj6+uz8/xqwkBMA+g9pmv7tVYJeD4Ctfhh7eKV5j4kVSfaXDL1CAgzz2
         of3aebvDvjvrmQAaaKoa2A0dNofRlX4BsZc7JdwhEkINbbHivpU5s9+jduF+VD49IQeQ
         592eXsJTa5MH3qhZIF3mz3+TxyO+R9wdEBVCeJQyvS/3BgSZBSkFVuGxuGmD0VLolzZU
         3b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969499; x=1740574299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiGtI+5ToMID9TUSdNCghgiM3EXs9/d4cQAhclrcdwo=;
        b=Q+QqXqNuvT5dDVSiPdNpL1bB9mY437qr56Yq9FasdkXTv2Aygkar/3P/gsffROtzaY
         ePbnZOLLq406GA1tm7H+UI/ZD9XrXfk6BvPmhPYqGgddedfURl9kNoV/k6wb820RhE8x
         zp56Nomv7sxi/esZ/60Ken6Lk34ezBx0bOxYXuYRePvlQDp8LAMyE21eris/c1Q6mD8u
         44x/Pygdk1InJQJJDzR0rd0xNm887TsaSMhf7xBhz7HWx13R1CQ3uDWcQweFhKMlTAfK
         EKuYBSC5Xkny0+ziwaLEhQ+CbGQyT3WcgnVMZDeo6K5aGd0evZH7Ccdbm29RwE1oZM8l
         dNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3f6LkuQ+cV3KYmoKVlKbGmz17hQmp+1MSJBuXzC/UGDpYiLGkSUQjn0ZpSGO4J2JY+8oggYxtGkHSb4Gj2u25@vger.kernel.org, AJvYcCVJBnQ8PAcOcMMVXp8i+lUrk+eWcC8x/rI7GaWjpUdRSi2KFoJa9TfyyiK7B5NGRO90DBfZNJfg67fkQiSj@vger.kernel.org, AJvYcCVSwA6KVDNYTRmArPKQNyU4D+8dJ13svxYdxO6Y63OiJGh4XUBiV3HFFwptmQUHhf8c+whszT4XEK9o@vger.kernel.org, AJvYcCVfZFbfjtfuNHV6WSh6+o/svvHYmcJjXPJWvQdZyLzFwOLR2jVsbRNY03TJllT+D4xaOzjZdUOIClazUQ==@vger.kernel.org, AJvYcCWM78bwSDY8Ppgr/XtUA2zVHXe9kOjwaRirFpkGtiZ93rvyfH/0GvG6WKGOl3Y3reo3orotvLPq2MsZmQ==@vger.kernel.org, AJvYcCX4MEFhFy4vOgYJGyBhybk2pvgFI7I+R0ZbX9I/C/kbVAsqA2iDEZTqErgohwytd94y5ZfQhXC6KLAUSAgtZms=@vger.kernel.org, AJvYcCX6xb5bMM8RqEcYx9vxHqQmBu/ZP58RDX4Emc/kq4t31d76MAfWY78zw45AOMxdxHgSa3Y=@vger.kernel.org, AJvYcCXpkVYzf6TwZNHiFtvyrJ2vFE9/oqApxDlWGBRngd2Jn4u0Uz5/o2CGcc2CRondKAGrvsi2D0h49kOS@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4exJ2QHnVcRZH/u7mWSTdTMCd//TvvfRGPPCK3cHSxcVKevT
	eERGL2WsEXGcYFne9hWt+VqI0DrEVPB/stN3JfOveFImcANEjzBDaFHFl49m7I0=
X-Gm-Gg: ASbGncsh2S2eAZvejACFfhqsocjGQtUj89kEx1esvSphnTYyypa8RWO5GLDuLe+rz4p
	JunK/btFa536s+i/7dIPRBAvhyPxgjphbXIoUUm9UQvzYm/BI/n2XuVT5fRU2F+npEC4GvPAbu6
	PNWqJOkMckpm89WWa78/Ja+V1GeVADqaaTumALSnnAhl58PXFTjyhUlkurzcTyljnqsKtNLGwL5
	VU9lyTDWXUihKK3eK0dLPeaHUoGBGShCy8A1JK08Y9+ZjINnc0LOSLXusGXQK4AvoVhrmFwH2LP
	BHIIoA==
X-Google-Smtp-Source: AGHT+IFttmTeAFp7rRNlCvGNA6c3f8HloQtXmzYtg/s+sWnJsGTKFqc7jLE1fU4ek1ihZeJfgcA+rA==
X-Received: by 2002:a17:902:ec83:b0:21f:5933:b3eb with SMTP id d9443c01a7336-22104087bc1mr237554135ad.31.1739969499276;
        Wed, 19 Feb 2025 04:51:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:38 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 05/13] net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
Date: Wed, 19 Feb 2025 20:50:31 +0800
Message-ID: <20250219125039.18024-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_init() is called from register_netdevice(). In all code paths
reaching here, tunnel->net should already have been set (either in
ip_tunnel_newlink() or __ip_tunnel_create()). So don't set it again.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..dd4b4e5be998 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1326,7 +1326,6 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
-- 
2.48.1


