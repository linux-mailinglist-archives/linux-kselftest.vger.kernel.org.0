Return-Path: <linux-kselftest+bounces-34844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DBAD7BE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FF23AD708
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861F2E6D2C;
	Thu, 12 Jun 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4sHbK8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B92E6D0D;
	Thu, 12 Jun 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758612; cv=none; b=oykDLHeFqGybBA7eosJ06LVHYtp0L98BVxAp6ehVyUyWLkePCKLa1JhbnPt7N5sWgMe8IjyS36mmGqw8b9cu8e0agy4szLegwMJAo3l8EdFynHoedKfD2SvF3C58I8PlzCVrkV2xBi8uJKZAXhkAS9K1pUG89RDkdJg0+pJU2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758612; c=relaxed/simple;
	bh=1fykyusYVro73+SkCEdouTI5VeesZrBsX99TGTggxRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAAyAvv9lIXR3cz9HD2ThZaq1wzxKon+gChUVXXxi1VS9gRNQTL5qia+sq33ISLlSHYpXpzqsL5ysojx4mu5xqIY/L6wkigRRZz6sLFSeySMdcZGyZJ+Sikqb7I3P7YpG/PICLspat9ZGSThXfsH6IMbWm/xtRdHwgRXi0HSLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4sHbK8R; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d393a42698so13740885a.2;
        Thu, 12 Jun 2025 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758610; x=1750363410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnKjnGPQVsYruwW26IKQXjP4KtQDe+H/2EepWEDvdH4=;
        b=W4sHbK8Rs5KCcGme9De5sqRir3UOA9vOZUcGmoOpf2cdZ8eVtjOlxadBwoa6UdY4qA
         vhv59KXx9PALywRfJr53obg2XymxjiHUWtZtVr5731rN5HyxE2R1NpUM85oNbzaafcrN
         VrvTpUCkIrV7HSSsCtVA8D2pyJ/IMq5Gwn6Cd1Rtex/VX4UtFGsn0WQdwxybAF5AesVk
         LT7hYM/v4q+OwU1ZZqFzpQbQs7Z6cvfqwmfpanM950fUjwV3G69dlKjS+VUFniiIuAnj
         cNFRaZasw117y0uEdrX59SoR6U3rvV92aAMU7lxT/gLn2YABxYYdzqpu/62udPRs10PC
         sL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758610; x=1750363410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnKjnGPQVsYruwW26IKQXjP4KtQDe+H/2EepWEDvdH4=;
        b=FYSb8ZBs+T1hBE7+4cYhBLcBcbUsfBomS5S2hjArW3N8znEvxz2bYAgCrW6iV6cfgg
         NNZJCP+1wYUnCsuvxuLDQ2kdL4AbWfPrekuhFenU8xGk8R82rh4cPA8jV9qk7gpsDn7s
         uaywj8UzIhW6/Q9xg0s4tqsa5fp0hffB9fTdf+TwfH35F58BtgwArrHFMxky1YZffq5M
         WYJC20eWBLQW/CsGtCtVBh1dE0vszMTY8FtcXzcvMX9xoL16PPT+6gjTkvv0KPwpaXop
         Dqt9aDaCYwZQJ0ggzrcZuYR3RfUJAI+Y+zgi8MM5bFcOHl4E8pIDfgWoRb9yy/kc8vmy
         i9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUzCku/qJEjoT4lmmSJWlLQMDfvzF1PDby7z6diCIzUGlMT28rEjGicpfzSbLCTYSCEHxsFrhoAnVw=@vger.kernel.org, AJvYcCXl1hzb/7TtZYcgq1mRBp2EBAVnlSixPgi9lWp8MBDNQgigANkhltwwRwPdypncKccWOM55JgnLBxC7tbgB5yH1@vger.kernel.org, AJvYcCXpsFENXwt6XDuMBp8YzIRglxg0uGbDIZCrnOc9LSgbmYoA8xLExibsrgmpq3mJkUbF45KAZRpX02YRfoe7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzemp48UW2eRTE77l+NhFmWCXbXdMkhb5b+0I6XRfqrHonCSFLK
	h4VT5dRChQmGcbAOIhgXCj997Wl2MisvoE7U8Dnx1Zop4kL9/HWuOI1D/kEyEkYECYI=
X-Gm-Gg: ASbGncv7uSNB/GwdM4f+K0mFi4sLBJxoYHT6kaFLmDKmp93cQlzBQpOmwizBJa23yGD
	4X0HQj/NyvhAUMs7WLGZssRZmEdodbtGzznbH8nQvBo3TEZUMnJ6dulO29U+zxzjxL1/DJsCfEe
	lQwDpoDLnZfiyuBOl2xZYPaSzoAbTWET4A/B7Ot7lnZHosb1AU3GD3hlexvJQ9yyqQUqS3GboCO
	6auBKHxFiiI9dD05tHpxoQHdkH9cztNgsosV+fUp64L+c4fWaVlVe8T4dMrA5zx8eVp8yC0POju
	1fPKlWizcCqmKwJgpvbD9Etez1QpWPaRN7DB69i/9zhhV3QvV94L1/U=
X-Google-Smtp-Source: AGHT+IEYJNouzQaBO57RIFJdSjytY+rAwJnE1qi8JXnfhXTA6dO5SUQ1nlRCfzkPu1uKMj9aLcCzVw==
X-Received: by 2002:a05:620a:bc3:b0:7c5:79e8:412a with SMTP id af79cd13be357-7d3bc37d979mr35927485a.2.1749758609646;
        Thu, 12 Jun 2025 13:03:29 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8ed35b1sm77151285a.88.2025.06.12.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:29 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 13:02:18 -0700
Subject: [PATCH net-next v2 5/5] docs: netconsole: document msgid feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netconsole-msgid-v2-5-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
In-Reply-To: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Add documentation explaining the msgid feature in netconsole.

This feature appends unique id to the userdata dictionary. The message
ID is populated from a per-target 32 bit counter which is incremented
for each message sent to the target. This allows a target to detect if
messages are dropped before reaching the target.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 Documentation/networking/netconsole.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index a0076b542e9c..59cb9982afe6 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -340,6 +340,38 @@ In this example, the message was sent by CPU 42.
       cpu=42    # kernel-populated value
 
 
+Message ID auto population in userdata
+--------------------------------------
+
+Within the netconsole configfs hierarchy, there is a file named `msgid_enabled`
+located in the `userdata` directory. This file controls the message ID
+auto-population feature, which assigns a numeric id to each message sent to a
+given target and appends the ID to userdata dictionary in every message sent.
+
+The message ID is generated using a per-target 32 bit counter that is
+incremented for every message sent to the target. Note that this counter will
+eventually wrap around after reaching uint32_t max value, so the message ID is
+not globally unique over time. However, it can still be used by the target to
+detect if messages were dropped before reaching the target by identifying gaps
+in the sequence of IDs.
+
+It is important to distinguish message IDs from the message <sequnum> field.
+Some kernel messages may never reach netconsole (for example, due to printk
+rate limiting). Thus, a gap in <sequnum> cannot be solely relied upon to
+indicate that a message was dropped during transmission, as it may never have
+been sent via netconsole. The message ID, on the other hand, is only assigned
+to messages that are actually transmitted via netconsole.
+
+Example::
+
+  echo "This is message #1" > /dev/kmsg
+  echo "This is message #2" > /dev/kmsg
+  13,434,54928466,-;This is message #1
+   msgid=1
+  13,435,54934019,-;This is message #2
+   msgid=2
+
+
 Extended console:
 =================
 

-- 
2.47.1


