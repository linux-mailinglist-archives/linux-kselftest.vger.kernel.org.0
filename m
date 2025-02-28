Return-Path: <linux-kselftest+bounces-27901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF61A499F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E971753A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C82702D6;
	Fri, 28 Feb 2025 12:50:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447972702C4;
	Fri, 28 Feb 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747058; cv=none; b=DwHw5yzt+CaBKf0L4eqJ7hMINsrd+3SVf49Vij7R/1XVeLy5iBWSz4mScBDMVazuKSbGnPFDjmTSqZoBJymrTtVRJCy3dJT9IYjrpbjPOsxnRJev/bdLpmNcmu0iDoArH3AKjTLPo3s81Ci/hoGZE/vlmF2Vg8s/2s0//IvI/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747058; c=relaxed/simple;
	bh=5s36+uRL/02Q1alJ+zf5ZXsH4JYRJD4bq5zmKryA7Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRcuoCUBVssFCj65sNrdgjLF3KAYJoPGkZHh/TQJkprJvyi3ooMgE1Hhn8dfts7x5X6t1Wv2VtMEUj9NJdmrXF09VpKsDhpSsWjN2dRXg5nFM/RsYmTbPNJSeVzyCJdOiZd9Ejkp5cUaFPTN7fYrAgOWxQPovMOPEMNkWeJQ1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so1054732a12.2;
        Fri, 28 Feb 2025 04:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747053; x=1741351853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUGkRMeXsvu7yfZpPCWdlYXf+xaRPJbvh1f0fKDSXnM=;
        b=GUFT7HiVIrOlvawWgtMmJuTzeeryhI/NpQRPF/HiVnGbDS+/845dtk0onp/wgN/xIY
         noVhgMVIE+GnOju44DMRqokUQG7/vG/tRD4itJwt/cBcYyB6gRCIIJq+sqZprtJBrd5l
         mA6S7bYKgoo+I1M6YK7Yep1VXVWNie4dVwxUazDzFZ0kFHMd2/VbizgH+TQNO6NOFrNa
         aS/A7pQ5FQJOQ+dnc1jZBvo/zDgJSFd3dlfqRz0SZWlilukO4akjmI3MxYqbgHOa6zz9
         +9Mk5eMtalG2QZrkye0Ae6F0MZgfKEXRCxKduXAWp423YKgH45XehHJbxpJs2c2DvJ//
         k9BA==
X-Forwarded-Encrypted: i=1; AJvYcCU62XnalJkvxO/HywHgsh8KU5XzE+aRMDQF8S8lvCETSXw7UhRMtDdb477m32OzboZ6nRPDb4cErhfS2fuU@vger.kernel.org, AJvYcCV/lDTlDWDERv6ZiZ8gz6FSQIDSWnhZHrXIaiJnJiP71wfttc13xVifUyWTmUY6CB7LSDYduhkpflGW2eUpLzIN@vger.kernel.org, AJvYcCWvgEMfagVwb9KvBrNHSL/ZhvSfaAbx0WUTl7xPemlOVR9VrF+hiM0EkR4W1NWphIe+J7762fdDusw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA94i2IVDFfXs9xYEwKm5u0OqX3P6Ut7WvN8mEqyS7/cExnDBB
	UzqneRJeUlAunuCn6w4P7C7pf6Y+cH6IAVXfOf2BY+1eoEcaIhTV
X-Gm-Gg: ASbGnctCTESitFzrxkedNq/cJtrduHnjdrPNPrMuR6sxhKvoWk69nkLtRz7L+Cwpe42
	f2VG2DhODdZQ6r511A0B+luQG3fBkgOvo+yhTAQ8FXa0EHXqr8fjN8/X7hm8aJGrApyyXtoa6GS
	08mm/AExo5JbVgT6pFe/EuFfTG/BqfoXZapfhj16s//JzHC3FUHZoz0+WAyCR6BCjkkRz+CMHjx
	NtSDU6ZTzfPZChiGSCAmkELunXLFBWw3tS8NUpx68QkeY5iqlXzqCkrMZyHcKiglm3uYOOXc+Uo
	wOjjJ/Iejos7cYvu
X-Google-Smtp-Source: AGHT+IGtjq4x3XYr2OFjkJoxs1xtadtAUHVomu1JMfIOr0fCbctUtY5aqtvagq+Sm/ChPTAPR5PimA==
X-Received: by 2002:a17:906:229a:b0:abf:4708:863e with SMTP id a640c23a62f3a-abf4708a570mr4773166b.39.1740747053167;
        Fri, 28 Feb 2025 04:50:53 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9ac0sm285436666b.5.2025.02.28.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:52 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:23 -0800
Subject: [PATCH net-next v2 7/8] netconsole: docs: document the task name
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-7-f53ff79a0db2@debian.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=leitao@debian.org;
 h=from:subject:message-id; bh=5s36+uRL/02Q1alJ+zf5ZXsH4JYRJD4bq5zmKryA7Q4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEe9XH+/xnXLvr+TG5YiWu6FkZREXtdsxbnt
 vgA8+OmkxyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bc5VD/9mpmLYDeYwlgrCp+XrSCi23L91I2Hw3NTYa82gX8/yWe1tyxR+p/GsdbexFoRtsgMrzrX
 9ObxmR+utnHZEBtcbEl9zkbmlAl75SsxEiMgmgRbUzKO6afjTq0K4TC0kU5ko39F32CKTC5fUuF
 yj9l92AuxUrsQ/eHbEEPuDhO+ZODH3zlCVk6gQUcL4zH/BnwbWasjDYaRCgGn7a3vnnnFflSncy
 RdUc6YLj63DL74qaTyYtZq0J0QSsBLdNxQSg0fI8/BJgOK2xc7axwo/v2UUPED84SNROuPJ9NY0
 5jHSuXsNEfUf0fPNVtnLH7Az5ZsjfSVZ+VrbnTUkEUmL8w3ULvXQApSCqpMfyHAmj7XWMxzHaZW
 GYiVua7pDjrGjGvxz1gAg6xgXd09DXc92wCKIa2303nNhJEXZM0taotwawp/cEks/wsW0wbu9CV
 V1pRzoxfV7I2YWjXwAtCA2p1GtLvcuhPP+dlmRwP7BnbgwwGoMeiF/AmNF8xHDs0zq3lxHsB4Jq
 BqEagEE92wrAM726uT4wkMD85dJa+I2Ebw8QaFozPytKlgBLUBoFuITSAaB6hWHKntSBZY35N3z
 BdYtV0oqwQC+1QIsw4fr5DAnAAHSodVCHvRoaxLJuneo9m0CNqGaEgIJYsS8I+oTnkjIbouC4b/
 UIsxJLe9o56LG6w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add documentation for the netconsole task name feature in
Documentation/networking/netconsole.rst. This explains how to enable
task name via configfs and demonstrates the output format.

The documentation includes:
- How to enable/disable the feature via taskname_enabled
- The format of the task name in the output
- An example showing the task name appearing in messages

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/netconsole.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 84803c59968a3..ae82a6337a8d8 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -240,6 +240,34 @@ Delete `userdata` entries with `rmdir`::
 
    It is recommended to not write user data values with newlines.
 
+Task name auto population in userdata
+-------------------------------------
+
+Inside the netconsole configfs hierarchy, there is a file called
+`taskname_enabled` under the `userdata` directory. This file is used to enable
+or disable the automatic task name population feature. This feature
+automatically populates the current task name that is scheduled in the CPU
+sneding the message.
+
+To enable task name auto-population::
+
+  echo 1 > /sys/kernel/config/netconsole/target1/userdata/taskname_enabled
+
+When this option is enabled, the netconsole messages will include an additional
+line in the userdata field with the format `taskname=<task name>`. This allows
+the receiver of the netconsole messages to easily find which application was
+currently scheduled when that message was generated, providing extra context
+for kernel messages and helping to categorize them.
+
+Example::
+
+  echo "This is a message" > /dev/kmsg
+  12,607,22085407756,-;This is a message
+   taskname=echo
+
+In this example, the message was generated while "echo" was the current
+scheduled process.
+
 CPU number auto population in userdata
 --------------------------------------
 

-- 
2.43.5


