Return-Path: <linux-kselftest+bounces-39003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E82B26E88
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 20:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5026A21848
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67784308F30;
	Thu, 14 Aug 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqNXdfBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7479308F12;
	Thu, 14 Aug 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194429; cv=none; b=VsR00klQjHU98/ltcix3PKcFhVInSmdtTkGgOrAAZBS8vqia5B2U8OhMK9E7H9onl05p75q/f+3i2nu5GaQBamHC8Iq3mIqLSAVRJGWJHPkoi7LQV3xMWthuu/9kkOv1vvmzHRSJaqv8VxMCTojbEiULQ1wh13e1z/AUGEvpjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194429; c=relaxed/simple;
	bh=8xziYD/6Re3uOfO3J5H//8CNXiAG+S16/QJbdP5WkHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3faHpEjn2soCdo0qNNNZmPtlETT9LbZ0ns7caFEi0gLYAMGODvbU7u1r29h+/sFn+d798uLhvyY+Cmub/dnWtYV6/YG8YVjZ6EKNKI4qwg152KsfXqKUwEB7IKcuJruMS1K3tqWweUZ7N0XbJ599EdGmiaJkpbXpg9Yjgzk/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqNXdfBf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso1817765b3a.0;
        Thu, 14 Aug 2025 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755194427; x=1755799227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaZHVwhwECYaxOvWDR1JC9N7A4JpiSLI6sXG2h9sB0Q=;
        b=lqNXdfBfey759CkpxQ1jzjs35Qpt6EonCsO6oEQGz+BN/FNSoYZazgkfsZ7w0OFKfc
         71gQDaoEEAH85mh6gWQGYrz84ql0NRgLo3vcWeX0PfwlVb9KzrdIZZRv+lVG5A2awZFv
         mr46+GyNH0p2h33o36q+QuDVbh+kFs3nh/y7LKsU/5fPOvOJ2BZxOXUluxaH2eBkWsHC
         AiC5SyGRKiAy6NYfO+ULH2/mN7ggci6bkbYE93Zd/O9zGuParr0aMvidDM5LpyR9ELxt
         E4P4I9+OkIQUnPmg8KoaSmCoJvtsnDza8ZvdX+YtbE1w2eUITudH7dlSjXfJBKss77Bd
         NykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194427; x=1755799227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaZHVwhwECYaxOvWDR1JC9N7A4JpiSLI6sXG2h9sB0Q=;
        b=HYf0YjtnBjeObVROHG/e1VIqyY9aGASgEBxYH9h9ejDF/cD5pUjh+twXfmaEk7Ag+t
         bwg0aD3NKM54I6VhRGQfYSG9dEdWjv+63bgcSqyrjd5q7Hh3hK8cgconyVuicXyfc4vh
         Fi+Zlj0KpENiBmYuJsGRlPytUvPOiIYI2qdW4KmMqDSyI/FYnWhPIKNp3PrrTjQUWMBQ
         ++1dZJEy6VKaNvV6WpNH7gLnV7k48bn5UtZlXjB5pCqFzXCzvLCBeD0OHRqeHH/S7wXh
         GCfqqlcUYIWKjlj5ixvewzTOjzYvcAobTOLB03EsiXqX+ckp9Ww7+NlhQ1OSf2r1+HxK
         mC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUFopPWVtymnYU8LKhVXV0x4SQ2/fDVBW6Zh80kQs9p6MwNLtiXgCVuyFPyyEJR52IgcapOKBiIIXdvlOg=@vger.kernel.org, AJvYcCXfkz2J2aSciBTi0DFwKrAJPdh1stZPSPHLkA19KBuB+993rn9AfxvGUXVYJHOO5oITkHfDhUZD@vger.kernel.org, AJvYcCXkKrwwZhdT+9H2gaGVo/9nGv1VN1XljWvzVKPpwiva1HPi1d/+ozTvyEkHRvgheYJppZBs+tLW+SIIVJnSaXoK@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0vCP/JKfLYbrjB+0Q++DTb5FpeUYCnM0QyjyozRJdtWVUx9h
	KcD1iWkMpUBPMy/0iuGWj4KmM3/981bEzUf9RbROosbMbKTQOMrS2/YJ
X-Gm-Gg: ASbGnctKDbZGoiyL+mLrmFpgfXMjkoiSV9LCqx+JCIwU/pFCeTLli4gWqdsRSX1Akej
	h0nMnQfvggOnj3k5P3NaE3RiegaBclY/E8EgMUW6YeChDBsAULbspcChK2czooyLE2fJ+jQRlGs
	6s5L6KmNhnnpyUKsbfQP+suy3ZkqL38ah8kJpN1LNkb0YbM3u6JNHC7q9DcQ2Pyg+TeSe63LZ43
	CBsWnVVCjqhC30K6bUQbBe0RxtLhXJsmtXDGjUGaGaI2yomMJ9xhnfF5YkQhFwE97vS8KrjzYHZ
	rL/iknZ0hqkhurSbUNDoB60MZDfTE8bY8DjCJz+v/W15A+B2704EuXQ6q6gU4CWbC5IU2P06Xzg
	DgUPEih7nVa4gEWnyYxXkK80=
X-Google-Smtp-Source: AGHT+IEtyF89hTr62fWacEmH0JGmSbFqOLigcH+An4mi7ad2LA3sdsN4XmcI5yoFqNu2a11dsNryQA==
X-Received: by 2002:a05:6a21:998c:b0:240:211e:8e0 with SMTP id adf61e73a8af0-240bd286e8bmr6477838637.35.1755194426840;
        Thu, 14 Aug 2025 11:00:26 -0700 (PDT)
Received: from archlinux ([36.255.84.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe74bfsm35147143b3a.121.2025.08.14.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:00:26 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] selftests/net: openvswitch: Fix spelling error in print message
Date: Thu, 14 Aug 2025 23:30:01 +0530
Message-ID: <20250814180007.406941-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a typo in a print statement in ovs-dpctl.py:
"Unkonwn" → "Unknown".
 
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8a0396bfaf99..b521e0dea506 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
                     elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
                         up.execute(msg)
                     else:
-                        print("Unkonwn cmd: %d" % msg["cmd"])
+                        print("Unknown cmd: %d" % msg["cmd"])
             except NetlinkError as ne:
                 raise ne
 
-- 
2.50.1


