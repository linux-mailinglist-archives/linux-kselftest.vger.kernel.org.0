Return-Path: <linux-kselftest+bounces-17385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CE096F0AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 11:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC39281A2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AAD1C9DE9;
	Fri,  6 Sep 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aluuAlb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C031C8FC9;
	Fri,  6 Sep 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616635; cv=none; b=pKntdieF53OcvnwnrFn1X+EY2yWJcZc+hEiuziUp/ryHYPs0IJs9q7sppiHRwuHo1GpaoE9xpWmA4PZshLQJ2Uzn6/R0sYHtm5rg6hvpilY+1skf22zUAemng+tYb/Z9uuAmOV4/OteQFTvIq2AT07AnQ07xxRdWTistY6j9k4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616635; c=relaxed/simple;
	bh=hpu0Cw4bJ7EMRakd6iBmqqiST/NK5gAiDKhaThQgCn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upULni5zqZvE/vhWuJZgZ+OteeKNECWMuFbAxATguFj2zfOCE8deJuhKh9ymP/PD+zs/DG3HeiYpM7X5F9f3hrx6XyJVFerixiMHXlwf5N/XQ0Xr8LqGIg6leJqFelpqkTxtS+GkK8uogZa06rP+8FUmqBkE81vZ/hR6cdlr9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aluuAlb2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc47abc040so17233775ad.0;
        Fri, 06 Sep 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616633; x=1726221433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=br5kRp5uqStR0YnOOImPgj+z5ppXk2dXXMWQAr3gVX0=;
        b=aluuAlb24LrMRUCYUb03VURbJeYugzh68fBWC1TBWIdZCaQrRynhFLWPtF+7JGkjYJ
         e0R+jTQRcPUlFyv+qYY20PUJhMGLkutM3j7UvnoMNEcgwZ0ELn8WVn17waNf9kxX/hzd
         PG3JGQOXlhrfaDBYy/VQLuRXBTZQvlkFS7x4w8xhYcn6MY6Haa17AuGE1zRcXom7ioxJ
         qKQ3Hydh5XJk+S+0ENY54IILwJecl0O0PfwFpHA4rm5t8JPmM/wOEZd+/On6B3ZhK1FT
         yh4Yvq2rcWk4P8rIwvIE2Pbg9PWIyiyO5vN9229oHibTgPOW9Swkd2TnmWlUv5CMwYV1
         ixZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616633; x=1726221433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=br5kRp5uqStR0YnOOImPgj+z5ppXk2dXXMWQAr3gVX0=;
        b=Q75coT7UplPyUegukZkSQaKJRRXr0tn04J+dDqL/ZFTmSYQjYSZqcNVg0zqa4aN1hg
         ZZcy5fviIusXlmpc2rGaCaak5F2QVjmuSTsCOHxmwNBZcXs+7h9M+WCM/XLGoQRF+LEu
         XFVfPerM/ked5jjsOnjDYFJErPV8Y4rJ/CDoxu45yQegYT6qn1hsZ3GPZiZU5c+SVBaT
         Yea9gWDF/11YN2pg2pMBmt27RXkTvbvC80P9ZvxUPxF1fHJNiBm0NZj4Z+A47J7CI3Mb
         9Pnyc952beF/PBBSbGRXkV3lVyf8GZI/NELWsjMdCJ7BCsTrWuaqjw6T0/5S5cIK4Smf
         t/NA==
X-Forwarded-Encrypted: i=1; AJvYcCW9eNOprjKiU8Pa8FehMJbTtF8wMZLU2Nfc8HYY4LJ0ZZo2cS6BS+zWMZ9VkaWyySCVNrxNcuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7fMa1YMUv2fC5MhQ0phLUTG4t5OFWNVzYQ8dA/rNuYFBo7zr
	KoFUrmjPds4/ZD6MnY0MSswuq4Pa4ql2uzzhHfTVqeJf6nTQ0MWfCERekW2rCAw=
X-Google-Smtp-Source: AGHT+IEboKjDKlboPpy9643hYQ+7Xx8XaalSmJol1lKeehclIBckg0wlGT6AN1dnH9qQ4TWZ67zFFw==
X-Received: by 2002:a17:903:1d0:b0:206:aa07:b61 with SMTP id d9443c01a7336-206aa07105cmr96447955ad.43.1725616633298;
        Fri, 06 Sep 2024 02:57:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea39300sm40459315ad.172.2024.09.06.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:57:13 -0700 (PDT)
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
Subject: [PATCH net-next] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
Date: Fri,  6 Sep 2024 17:57:06 +0800
Message-Id: <20240906095706.77636-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Link: Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch/
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
previous version
Link: https://lore.kernel.org/all/66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch/
Link: https://lore.kernel.org/all/66d9c3f875b90_18de412948b@willemb.c.googlers.com.notmuch/
1. cook this as a stand-alone patch (Willem)
2. add Willem's reviewed-by tag since this patch doesn't change
3. move the reference link at the top of S-b tag
---
 Documentation/networking/timestamping.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..9c7773271393 100644
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


