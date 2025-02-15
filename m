Return-Path: <linux-kselftest+bounces-26701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6681A36A04
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 01:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66658189255A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF926F4ED;
	Sat, 15 Feb 2025 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYVYL70T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006DF4E2
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739579889; cv=none; b=cpSrI3DdH/AlwMh9TF7XKPLTremDM4XtHPehvWVTCtqv5BHdrDp9X3+yd/cvY+77QZ4hqe/5VQDPvKZ9KPLtolpGxV9kIgoKHWDfPTVJRSROd0lkNlxefGMmie3pr1Hf0vgAqKNxnpenGwO15eYafU5faRSkMr1wq7eKHb8xXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739579889; c=relaxed/simple;
	bh=NZP88OOVd8sOVeFyMWWdZu1T4Q5qG9mjnpmoDAwu/qQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CjaulHPmuhJyYug2XK5vtSUhDFOQ0D/FNneEQ1YOLoOCON+bbHdSLinC913YccIpRvOYg31u+ZrZQ+izD7zE3ZHXxFz7cgKhPwmHxjhWw7lp9MZ8S8+zOMoheQHGtyg1NVJmzFqBwCAlbOdaiq1Z+kgsQIlCLYcD/A3BL5XdoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYVYL70T; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5209dad13b5so91192e0c.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 16:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739579887; x=1740184687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uba/34vcev8nB2+9mx/dFBIX6O6ekMm5th//00Qxgbg=;
        b=BYVYL70Tpq9/bUJz66LGhzal45n3crG5GHFszE/8/vJLAEKgt0aREb5KO+AJD3OKPN
         RyAyhky1dQgGiD6b0ciPl+Rm/qwQLrezotFXEQvKKDyYj4pIIfJEaXincaUYH5Xs82BT
         BHUkCSdd1hoDDU4bXH3A1OJtKbplQV4dw1YnsR8ZAD9+6gb6rvmgY+b3J/LqZRM7denl
         jIPCp40uIubRxy9e2A3+ofihqB+daQDwLNWPAJT312zoerKRgOoNql+AJH+Kar2nLZ8y
         YEx4DMWMWoCdZkXWqpT55lZPkk9P9yY7b3EbuwOknr4UiVZSYEclE/yX+t9YgGUEHiNA
         F2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739579887; x=1740184687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uba/34vcev8nB2+9mx/dFBIX6O6ekMm5th//00Qxgbg=;
        b=cgi6WXNgtTzlWl9hnCGuQw/WwzivYvc1uYzni2cgSU70fx+bfZCQOhJFG9LKRGUuiP
         MksZGZdfn+FWHcCJzH+zdibaoioOT3PwvrPxSLjsK+wRIkCsBgVTpdQ+z/YWBvTEb+OS
         3nPO6ox/Fh9AVcPV3EdAK26/ob5u3hbEy4HWnn7azTYQvQEIMLqioQV3qxf1ZVCcuzEF
         pPFklwbdXYN6U5dE6pAvyiy1e5GMx6G9MPYC5l0C28r4urusWC65Wsh06fR3pz4+Raqy
         7Wrouxu0LpOH8aCUiBiw/oWVCEmTsGQzvRbAe4jmvULQfkLLEOIVEuDHt0vmqwcmcc7K
         Sx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBTWuvfTa3OIajd54xGrn5EGxIiyPf9Nxf8Hs5iJVTCSoWgxZFPBDkiWpA6Ag5m65f9LMWzi30Wkt8Ai10Ddw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgs84xJJWeOt43wtStztuph6OHZitQ3uQGLqQUq7FDwnPrbR6
	h2PeNYROdBlOuHf+7GrT/7ohc1es2/9QHOObT37TPidqzslYuGx8
X-Gm-Gg: ASbGncuZVd8ylfSaaJqEW/JpjunnXgOvewcnYRVDN+f8YpvQcSiniznBmdPmDZp/IUp
	t/uqFiICjakjb6c1Buov23rbkX/6dEoeoFsbQh5rBhU31tZ5eEuVFMP4Ruz4muW0BnoLrBYrS6c
	rOd2aqA1hGGpQI6vE0Zfz+TnPsbYRy/sUyD15BMyMNy9hfTLFjMT2fbWK8DPECA8LCs/tEIjD+4
	/hJc6uWI6sP5qFBAZ1sTnjsbwiqBgx2pbvukBDUo9eWIhG7ppl5hHaDgUoirLxxruWDmgwxdtQm
	nrHd
X-Google-Smtp-Source: AGHT+IG0Qsp3zBqrDJ9vcgiM1ZZJXWCtpPeDbJHrSNYpl5rhQFtE8hevU24TpxXeIZsYwVDuaNZozQ==
X-Received: by 2002:a05:6122:20a3:b0:516:230b:eec with SMTP id 71dfb90a1353d-5209db668f7mr827598e0c.5.1739579886818;
        Fri, 14 Feb 2025 16:38:06 -0800 (PST)
Received: from fedora.. ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207ab6f6edsm939621e0c.48.2025.02.14.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:38:06 -0800 (PST)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht,
	pablo@netfilter.org
Subject: [PATCH] selftests: netfilter: Fix typo in conntrack_icmp_related.sh comment
Date: Fri, 14 Feb 2025 21:37:25 -0300
Message-ID: <20250215003802.1466786-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the typo "adress" to "address" in a comment in conntrack_icmp_related.sh
to improve clarity.

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
index c63d840ead61..f63b7f12b36a 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
@@ -171,7 +171,7 @@ table inet filter {
 }
 EOF
 
-# make sure NAT core rewrites adress of icmp error if nat is used according to
+# make sure NAT core rewrites address of icmp error if nat is used according to
 # conntrack nat information (icmp error will be directed at nsrouter1 address,
 # but it needs to be routed to nsclient1 address).
 ip netns exec "$nsrouter1" nft -f - <<EOF
-- 
2.48.1


