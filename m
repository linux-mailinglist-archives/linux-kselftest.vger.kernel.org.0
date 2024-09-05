Return-Path: <linux-kselftest+bounces-17206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A796D03C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0C1F26E50
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701AE1925BE;
	Thu,  5 Sep 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4nZNeru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498119309E;
	Thu,  5 Sep 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520681; cv=none; b=a1vn5acZvMvZ5YCJcO+edLifHMHb9WXHB7TfHcGbQy8eUU/5OajV4bIyVJqRjbSASGNSRoWBHB78nFlkF6z0sGewysqfTMa2ObN0aVfNy7dn24cuZDbVg/ij+2ajRGdi8HbynlO3fkonSR9OfXWanEPGTGU4fGRDcejHNGoDL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520681; c=relaxed/simple;
	bh=qjn4bYpnc3sdB2QTbr7U3+e4e+QlFCoBLwCKFutGSVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb9wwchRtKavg+h84q14b4sYIvP6xKwOA8lCImXo0JatmymVesvXtVCEAOKoDxvc0itnwS4ziX1DhMR+bc5H7Urm4CZSTymhaQYAuPaSDkkk8HEaGsTyDBAgejW63DTAwf2SYU96jeO1zVm1ZCGhwuw8GjXx7rW0a0aqOHZQmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4nZNeru; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-205722ba00cso4512025ad.0;
        Thu, 05 Sep 2024 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520679; x=1726125479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP3RiSVA2PzoQSWjpyM3hUS+f8SmsdBGbkZ90Q8ikY0=;
        b=U4nZNeru592GjvnP2oAh5Xzxvf/bpfdf5DAkRxT8soksrVHj7CRPgZtoryiC29bnmi
         dCpCf2iV/2Kgn2D5Ju+ByxUaoasl+FvWwdwCH23U3eT7mWnFCC84EfO7X8uQRg0j8RHA
         1VDVe0oyfYh7E6H0Ng/N6FXS9HwUQi+P/10R7E4xrlOxYALXX0EwULwpitIdSC8RH0Jr
         xZGzrTJ/9wrj3ZeuRTWhFhjnCiy07YkzJizWN4hN1kaJGKoVyC7D8dyohkbCRCkM9kzR
         Y+erZJ7YYN9sIqcgjs+vsUDg0PesN6yOI6HXo4hYSFlHz7iAStrGFbzGVGl9hcvdnL3J
         7nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520679; x=1726125479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP3RiSVA2PzoQSWjpyM3hUS+f8SmsdBGbkZ90Q8ikY0=;
        b=qxw49t/ncdU7hVFZ9lAQgTdSo/dCyliJ41QAuEg+AgMTjLwGH0tf0IEU8tRSdD/kYI
         C+YiZ/ZPOfCsA5xpp6HxkxFDwHUfJFuDIPu/S2FhDB0kwyjedGKNRwCJVI5obGjy5HlX
         P7R+d3JUjAg5DqGo0uovZF5C3M/kKuUfQttewnOsaUj2/NCYoOsvM2Yre0q6f/f02lRj
         NkqsRbieK29f8uaO+zftmJpURIfI7c/AvEyFhgZl56djE8D4Ucb3M3IbmwW04SrjqfKU
         ELJIkJfGEuIZo4v8K1R50ZLJgKtrEitjYqsTJHuTF4WNH09o6QyxSTbUsK5vrFS0CIDR
         804g==
X-Forwarded-Encrypted: i=1; AJvYcCV/q3uZv8nTDZw+1l0AAc1jrr9bYLgDDILJeeJxEzij0nqweE76ElosWSi9s7r91Rk8zrFkdo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yype0n+99i0ZV/AV/aIvCXMTIuzliLlm5Qsz9tU9DJ0/pltVW1q
	5Culew3n3F6oCyolDzHMAp9bgBMXksNtahcQxrrftBw18HGAf5TcpzGApX33gnw=
X-Google-Smtp-Source: AGHT+IGpTNYT3PgXESdKWr8uWYHWixR/xmlPHfz5UsODqIeJ+yKPOCbBCML/deqDNf8frtm7lFiacg==
X-Received: by 2002:a17:902:ce85:b0:205:9112:efee with SMTP id d9443c01a7336-2059112f162mr111327415ad.21.1725520679034;
        Thu, 05 Sep 2024 00:17:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b19sm22929425ad.61.2024.09.05.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:17:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 2/4] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
Date: Thu,  5 Sep 2024 15:17:35 +0800
Message-Id: <20240905071738.3725-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240905071738.3725-1-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.

So let us revise the doc here.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch/
---
 Documentation/networking/timestamping.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 37ead02be3b1..ac57d9de2f11 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -158,7 +158,8 @@ SOF_TIMESTAMPING_SYS_HARDWARE:
 
 SOF_TIMESTAMPING_RAW_HARDWARE:
   Report hardware timestamps as generated by
-  SOF_TIMESTAMPING_TX_HARDWARE when available.
+  SOF_TIMESTAMPING_TX_HARDWARE or SOF_TIMESTAMPING_RX_HARDWARE
+  when available.
 
 
 1.3.3 Timestamp Options
-- 
2.37.3


