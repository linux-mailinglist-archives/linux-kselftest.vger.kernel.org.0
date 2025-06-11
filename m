Return-Path: <linux-kselftest+bounces-34731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5FAD58FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573BB1782BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C532BEC57;
	Wed, 11 Jun 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtBKBOaO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DD2BD5B6;
	Wed, 11 Jun 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652682; cv=none; b=T+DeZNUV4ArF6yvfpwZsvTRWaE4PtkHrOhaF/NUbv+sgUYr7w7oYwdLnvO0aeY0hCG7omUP4UUv5r+tDmODlA7mbuq+IBC9oygB4exI1ejF0V5VDViB9COrfIaj44KU7R+JnvAGUO+2Z/CzqQljMeI5XcVABOmylqimlGGM+ooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652682; c=relaxed/simple;
	bh=tOzgL0KY9yFrjchFg5tvk0J/AejOvH97Tt3OuAqyGZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEV0sLsItpP/XmXMxAaidgJ4jZlicIs8t59Fot/nUVkNs0/b8JVDlKWmJRKFZmHGs3iG9Q/BmiisWWOHoIm5gRzdIbnZcf9HtGKqmr0zk3GVA6mjUfH1Fay97f+/g4cq6k1gmnu3OqISLpuziLrvev4cPTPGtfykeIWad0euNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtBKBOaO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fac4e2fcd1so144046d6.0;
        Wed, 11 Jun 2025 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652679; x=1750257479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEWFUemvl7siyfmS6XSp2BMVs4pqCozC91INbpbQZrY=;
        b=BtBKBOaOaRWiPauG8AGmK0BnMFHDRD1TBBwGUqHJ4KatXjnWyn5CffwDCgai9MkhUe
         9vbFMvuauXgFesDJdqxcyhbJLz8K6lYzMDaKl0ilz+CoHlmZ95xshZmlcl2bT+82NVvC
         JLEbFiaQh00rIl6J5biOmSHGvUgoAYGOnFngwWBc2lFBy+DSeBI6VtEJKkgsEs//KV5l
         jIDTwXcRMPDyyJtH/eapUteX5l23Cgwtuh1TqexQFuU4M50jYmN00qYzzAFGUhyphqHi
         Mt3Z2W5N8kccQNTKE9cYJtbeBOYZkrwgdtSLgPnt4QMDDLd+qrFWtmOXK59hZF7Bg9Eb
         nPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652679; x=1750257479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEWFUemvl7siyfmS6XSp2BMVs4pqCozC91INbpbQZrY=;
        b=qYluR5EpSHnjpLj3XFFqJG8+8jBQkjO8yy4G5nRxhFRBKKkN40/PdM8qR8UrgFKOr6
         /+OTOjMKVdqXJbvR6eiEZsa/GWLiqCOlNZ50jsfVztIzB7T9kvzfGzb6DsQ4UeGu7e9h
         Rdn4VoBbMHT8HUTl0emSHxC2PMWkbNjjt5mGkOUpyBqA8tlX2pjfC2UzoV1m71JPE7rr
         LtqRJ5cVnvE7yv+N26dVqe6puErkrOlMtNkYc7umJisf1t8++d1n7cOESYqKB+gtTHRS
         fwWwHLIDecAnfEL8/QgpUTgbRmleF5PxJshcYqY705JmJAxqVJOqSSYX0TVb4k5IVlyq
         nHlA==
X-Forwarded-Encrypted: i=1; AJvYcCU0qmUQ+EvMl1+H+l8OthJ3HD9xy84dfQNVUwOfJKHzKK9sIs7lV+U+dt5+T4cJR4TvRWI3v8a02EdEf9K8@vger.kernel.org, AJvYcCVbOBKg0C58OMo5u0MWrAAa2Z3gz8OzGmQcSnQCo7PQz/wSteDdx8QlSDFekWdG7npIy18PpZAf1lY=@vger.kernel.org, AJvYcCXJypFgIsrzUxk3iUgQON7lgJRgeoQjoCRAuETlt5jXhGKmsvBpUyU3d5H1gDt4lV9ASaXzY13+FaScFidtZ8ol@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TVH+czVCLpmFQDL6WQLY1b00VPj3VxH0D2a3uY+anTS/AP6Q
	IYmkKnuSSvjsjNiduDmhhAycGkWSbes1UZKj4e5scJ7Dq+H2RP1Z1F3uIF8aJEgfnEU=
X-Gm-Gg: ASbGnctjQFYTVDgii2tb+Gj6YPOOoa2XZtkUSyVO98Xz70dszhM8xwvaH8Y4SR7tnBC
	EaCfBwogocssnMBXE7h1o5XSADIlT5UJVzUJosrdmX/4jJSO0HHVfDE9hQS/tEnKn4K5InoHt5E
	tMOmIEZaUldbcXN34jFwHKZWQdAJ9booS93yqrZIKQUUWHAlz0d4Gt3MiOlhtR6d1sHv3bUTdIt
	79+JTc9C8QKihl5buRGb9Y9GysD6kuJlYWGEDB0GfX9Kfq58DEPcaYPMexF3pfImdFNP4xsjM9J
	Jn9AofbzcpUT7A+InsR9YiwRd2leUArf5UWRmuZZw6pDl5ULUp8QhbE=
X-Google-Smtp-Source: AGHT+IHJUXXQFyBk9F2cncTLJpxIYvehgFqAwrqxUqIhkdJDPaNUQfAOqJdsZttNUJYQKPxTN6q6Ng==
X-Received: by 2002:a05:6214:2509:b0:6fb:fe9:e90d with SMTP id 6a1803df08f44-6fb2c38cb32mr22229576d6.10.1749652678841;
        Wed, 11 Jun 2025 07:37:58 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:8::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1ce20sm82252766d6.67.2025.06.11.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:58 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 11 Jun 2025 07:36:07 -0700
Subject: [PATCH net-next 5/5] docs: netconsole: document msgid feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netconsole-msgid-v1-5-1784a51feb1e@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
In-Reply-To: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
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
 Documentation/networking/netconsole.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index a0076b542e9c..42a0acf2eb5e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -340,6 +340,28 @@ In this example, the message was sent by CPU 42.
       cpu=42    # kernel-populated value
 
 
+Message ID auto population in userdata
+--------------------------------------
+
+Within the netconsole configfs hierarchy, there is a file named `msgid_enabled`
+located in the `userdata` directory. This file controls the message ID
+auto-population feature, which assigns a unique id to each message sent to a
+given target and appends the ID to userdata dictionary in every message sent.
+
+The message ID is built from a per-target 32 bit counter that is incremented
+for every message sent to the target. This ID can be used by the target to
+detect if messages were dropped before reaching the target.
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


