Return-Path: <linux-kselftest+bounces-25669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7CA27072
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A11A18893F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10246212B17;
	Tue,  4 Feb 2025 11:35:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBD211A31;
	Tue,  4 Feb 2025 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668948; cv=none; b=R2QxxnreBGVTKjXQPJjx0WGwvgastTbG1Hs2jVVEtkrrg+Q01B7WWTXvD8KAzf7v+2XZRatH86PlXrf9V4uGcpHzPehR6j+7yBLfqNAPdp5PN5EGz4bZ4JmR7dSqq33oFCppCjOFkr8+YYDn1P/b2kbcCS1dHyhJoRboJ0qQAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668948; c=relaxed/simple;
	bh=2pUaLVwLHOwxMYDPKEmqQLY0Bgk29Kn0tTJ8gIKafis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrCeVChsvKzOBjWv6Kp3ZlRwyNIJilv8Q3WEhq79CxEiSSBCYyFXz4ydhic3Ldgfia6YJ9OuVEXVQFe1LdWn1Lx0CxqXS90H0GFJNrQD0s630HKqf8szpH/dx6XJX6+iD4ebRsI9pVqhJZnWaSEo9Z8N1biq+nT+66IyXfTVP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab70043cd05so847517166b.0;
        Tue, 04 Feb 2025 03:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668941; x=1739273741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PPqcIXQzYEFsqNlbLKuHZEq4XrZtJwQTMEp1c3me10=;
        b=NrNTyVXTMMz/Z4on3YxpLZdDHnlvK5egX9Fix244TFZ44itUygaXJmR9KgpmmEXSd6
         uZ1fy8Dl4GFSzALhP6Ji550SqNP2ZgzouiFqhXwyiRShY4j6/k7wSDE//CTe3y2E+V6p
         J/RLgrdkWWrVT1gPkw0kb9dlwo02NAybjcHlbb4WGr4NEg7lrPTAGMHzt+LEdGLrVJ66
         ubFm/yR2H0yhdZi0R5oKtgdTZU7qvJVoYYTSMQYz2i84tsned5NJyUz6VcrnJ2aRWi6F
         K7IBXhbIyf7jgVec0912flzxaVHgpOJj4UA5KMAV9NbmP5Z515bxzcUHtb0nygVRqluL
         E1tw==
X-Forwarded-Encrypted: i=1; AJvYcCUaBmveCwcrTzh2dDGw6IvKUItUQsbjyh8OT3eIVfRwkMyFN8p8XWvFoyn4lFpV+zobqbfq9FvcxLluPOuN@vger.kernel.org, AJvYcCX371YXP+y5XqKoCyrIu7b4cf3nqown3Pxut580OH77jraCIpLbNbZuNgGN/sd4Hv4K4YI5alz6Zrs+IyyzCvFg@vger.kernel.org, AJvYcCXuAjz/nz9nBaDUlhDFyzd4u5ZY4Q91/ehhZ67IJrEIO8jiQLBMEefVnFYp2wK2kFizd7MbS6empDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBYXeCbRMPcZfMZx/pNE3EghEJJsJzbh8YZyIdhA0/rMOnPXc
	vkdaQV+hm27MvInZQ5n5ed02UX6+gJM6JSmBhTMuLfiGJLqLvwJY7i3prA==
X-Gm-Gg: ASbGncs649lptlPxVtPU9mncbEEtpukOMnqSQrEXiFIqQYoRhIrNvtlAh7GZsrq+pvu
	vCNFJDR5UPp7NYKpbqVLRy0s/NFaXH8uaP4MprEPDcGB2/IfmxdCd7Bu1/t+LVFuOgsYXN8/zqH
	/r5zWDutNtwJlfoKIqLStS716ZQ4YUEamTEGpPlrtXhdGqj745abzmvUM5Q4apF88k7AjlxvY77
	JtDL8IVITgoisy/hNcoq3cFZa3vaLBqDfC0hQOmlp2ujqvSsx+r/5BGQPlOJAZQkxbj5L623+J3
	USKXhcs=
X-Google-Smtp-Source: AGHT+IHCyfaueKIUNYUPir9gO/xg7NSDPC0F+tsupVOVvkWrV6oAN6co9B3Ale6w9VUTWBCuMyZH6w==
X-Received: by 2002:a17:907:7255:b0:ab7:e71:adb5 with SMTP id a640c23a62f3a-ab70e71b1bcmr1353777066b.35.1738668941218;
        Tue, 04 Feb 2025 03:35:41 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab71166a8e0sm545657466b.158.2025.02.04.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:40 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:16 -0800
Subject: [PATCH net-next v4 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-8-9480266ef556@debian.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
In-Reply-To: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; i=leitao@debian.org;
 h=from:subject:message-id; bh=2pUaLVwLHOwxMYDPKEmqQLY0Bgk29Kn0tTJ8gIKafis=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+8Sx5tY+XOi3a1CcmSvKXupO1Hflji0JvP
 kGtZ1lphD+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bQ4nEACZUwIqUq8eeC7HBNxcADsyp9IxDLdVgHJp1/faFHA5nEda5PJE2Rgxf2enEQTh7yr49x3
 Y8CW7ZSk4uK8NFjVVmnWAvBOFe9FVLvP7SWswe5cU5yvBMuMAZZEsBZ6ZbwPDHv1PZylN/QQvMZ
 /nEyieCeWDFOBV0YVmX7gXPxkdjh1BWrxkIcevek/fb7K4WdWMI3bSMhVsnbaiPFKdgw9OUuxr8
 MbC0ooUwRUGUmorSCNbCF7EMbSvmqSb9RJQh+pdmEatxP0kY2NKfjZ54+Y7Gnqlu8VBALieepKq
 1OSFUAKrJQpRlv4BcSzEXghk7Eh1hxaoBw0RlvBeguyiK8GUev+cnsokATcwdr7QBCkUhibYpM/
 gSd1+mU/55+P8r2HiZ3JWyVIsp7F1Z7xAji2keN+uqySeMFi3WfpZkwzQlQ4cZ7EgS7X+E+uTil
 UcE26rjnDjIuMivbikAcIXNKAC9N3nZuUWONSLtrkhniHYDCf1rtDdpCRXQouqvIWD/ZaDJN5Xe
 mbHBDf7p4kHLg1lmpiNxDhsQzExojGkuBJU+0sdVa7Zn0sEWb6dtJTI7U5s3lSnrl+ONmqJ4jUf
 4HzSSbmvwhRIxk5RuQNnXgd74sT5ms6rc0voDB3eZnMdr3eJs/hgVgOMH+1k2vd27ETGGUTJkb/
 ItbN1bm9VVncpVw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update the netconsole documentation to explain the new feature that
allows automatic population of the CPU number.

The key changes include introducing a new section titled "CPU number
auto population in userdata", explaining how to enable the CPU number
auto-population feature by writing to the "populate_cpu_nr" file in the
netconsole configfs hierarchy.

This documentation update ensures users are aware of the new CPU number
auto-population functionality and how to leverage it for better
demultiplexing and visibility of parallel netconsole output.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 94c4680fdf3e7e1a0020d11b44547acfd68072a5..84803c59968a3237012fab821f432eb531aba45c 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -17,6 +17,8 @@ Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
 
 Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
 
+Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
+
 Please send bug reports to Matt Mackall <mpm@selenic.com>
 Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
 
@@ -238,6 +240,49 @@ Delete `userdata` entries with `rmdir`::
 
    It is recommended to not write user data values with newlines.
 
+CPU number auto population in userdata
+--------------------------------------
+
+Inside the netconsole configfs hierarchy, there is a file called
+`cpu_nr` under the `userdata` directory. This file is used to enable or disable
+the automatic CPU number population feature. This feature automatically
+populates the CPU number that is sending the message.
+
+To enable the CPU number auto-population::
+
+  echo 1 > /sys/kernel/config/netconsole/target1/userdata/cpu_nr
+
+When this option is enabled, the netconsole messages will include an additional
+line in the userdata field with the format `cpu=<cpu_number>`. This allows the
+receiver of the netconsole messages to easily differentiate and demultiplex
+messages originating from different CPUs, which is particularly useful when
+dealing with parallel log output.
+
+Example::
+
+  echo "This is a message" > /dev/kmsg
+  12,607,22085407756,-;This is a message
+   cpu=42
+
+In this example, the message was sent by CPU 42.
+
+.. note::
+
+   If the user has set a conflicting `cpu` key in the userdata dictionary,
+   both keys will be reported, with the kernel-populated entry appearing after
+   the user one. For example::
+
+     # User-defined CPU entry
+     mkdir -p /sys/kernel/config/netconsole/target1/userdata/cpu
+     echo "1" > /sys/kernel/config/netconsole/target1/userdata/cpu/value
+
+   Output might look like::
+
+     12,607,22085407756,-;This is a message
+      cpu=1
+      cpu=42    # kernel-populated value
+
+
 Extended console:
 =================
 

-- 
2.43.5


