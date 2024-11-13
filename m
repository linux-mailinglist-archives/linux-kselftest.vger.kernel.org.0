Return-Path: <linux-kselftest+bounces-21948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4F9C75B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71961F221DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9F200B89;
	Wed, 13 Nov 2024 15:11:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318A1F9A80;
	Wed, 13 Nov 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510683; cv=none; b=E5tK36JQXm60qoUveCDGqNMhLC47jUcS1sQM+VmmaMt3ycXev5q531NI6Lu+hUSXai1N1vqpTZJ753nU4CtGFFvYYfDW1/ybflq7g1RPNeq+JkGGN/varSBYDu/YQnsKL6aqWiIFJf/POJbC392cfjgCGjsv79KPFcA8uSKZdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510683; c=relaxed/simple;
	bh=IpyXc0ozD1GMB+Il96IkWK5dAeJgnotpsHJ8YdD/teM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9GDv2XC903iuF4Xx2ICyo3BFfktnGHeC+7xvQLZfl8dNOyJea+yacFxkpgHyhrnIhUYBh4TAEiNbQ8Q68z+iykgmDozu+45vGqorYQw+uiSNq6VM+/QVmFC7azWonmmpiMNHpOr0g3rwxFHm2aP1PLS47V8sKZhV8FzSdyW0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so7809698a12.3;
        Wed, 13 Nov 2024 07:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510679; x=1732115479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S6/os6Qv1ZJNXWnYiunu3TXRi78fgOLap6v5ztnDQE=;
        b=krW2KAjqImoaLtsMIJ0XyEVVTx+fvXqCDhXaDiOGV/H8x3YMEIvOBt5IAQVg09YMQi
         qv7/5bz+kI693V3OnRKGfdDcCNl7n/UpKVabcYG7MxiXIWusvhLpThsEihNhI/gikeeY
         s/7wkEp7v+rxhn871gmHhKPvTAO14pLBQDd2De1cWezBU54l+vbHBQtqfzlTcxN/0Ph0
         EJSKxK8o5k9/lmb8Z/GpuYQZ7TeDXZ0wUXbHTWzJC8NhvB5BZ13AzE8Cp2huzCmSSfCF
         PYVc6e0gGfMEVb8tYFxoB7ul1gEls8+p6tXXnqSomQkZbCos8haXOSmvhtEBl/5lLE46
         LKTA==
X-Forwarded-Encrypted: i=1; AJvYcCU9AV+SzhaZCsITaD7NwYIOXJR05Jsiu2ulIy0PjqosBjqWcnF3n8RDWv0KTerL3iFEfb9h0Ghc4B7r9UlL@vger.kernel.org, AJvYcCVCG5Rz5rQNibt4RBUrzTiRKeOF7xGmHDFleYDuKvnL8DCKBrhDWKkp0qnTW8ohn3uziXYb2sOCdVo=@vger.kernel.org, AJvYcCVbgCQ+xpVSQaTZz0yu1anTTBsj3AS38ImMd3Vj1fGGZmjcya/sokMttYvdOyEzMo27NvMvhqqZMoVGjpsCAjjN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6xJE53AIt123ozRJMFMOlZEIqcOU/OQS+etzgVjBnL5ieytZ
	60DyPh9fgigKVQUZsj8oVa3zjagY+LhElRQ3sPOZY4CMYpLT+7NT
X-Google-Smtp-Source: AGHT+IEooQZHxOiMQIn34HIP+DH8p3aE6At6BOsjxnDBiugb63EK8ejjNK/O5fpurmhQZP2JWmILNA==
X-Received: by 2002:a05:6402:4311:b0:5cf:f82:eb65 with SMTP id 4fb4d7f45d1cf-5cf0f82eca8mr14928484a12.9.1731510679496;
        Wed, 13 Nov 2024 07:11:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e9c1sm7150081a12.30.2024.11.13.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:18 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 Nov 2024 07:10:54 -0800
Subject: [PATCH net-next 3/4] netconsole: docs: Add documentation for CPU
 number auto-population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-netcon_cpu-v1-3-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
In-Reply-To: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, thepacketgeek@gmail.com, 
 vlad.wing@gmail.com, davej@codemonkey.org.uk
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=leitao@debian.org;
 h=from:subject:message-id; bh=IpyXc0ozD1GMB+Il96IkWK5dAeJgnotpsHJ8YdD/teM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNMGNzGRw6kxr2xG4dDZWgxH4YZ0MO8P17DbTm
 zuXW0wPnA6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzTBjQAKCRA1o5Of/Hh3
 bXu/D/9ZPm74waC8ijNe4fg4/CahtsYlyec/NF+SAZ9vDqSx4mlF5v9Z/qwc+Hp4lzlug3NTo1k
 MzvOCTWK+fn28Ny2ImckvQ3rrYgCFoHdRnvqGep6rC76ZVSiy1X9cAqJ9VyycvbDdGJdRsgh429
 ZYu4nrTn3H2w/kYqt1xjhsIBKyabNY3oROeAMeFlmg4dnSy7QIdtocsdwIhEZs0vM+o+WzBHZCK
 VyiTURNjwKAgpt4kTVkli4yA+0ziwR97h4khTYoCUNqg8r8kXcArN6L7X88f8iQvg+h+dUBhSsp
 JVuUMK5aMAdote/BInKBMAJab60LcmY4jWq06qCmrs5GEffzN7Cja/ISyeGGN43af5l6O00P5zg
 eaPjcOt3Hes7byvM+6PZBuvqu2SZyaT3Bajj9bZCVbhVrxC1dGMfTYmg7lfJuxTWDq0Ai49pf0z
 O+9+SwHO+VE5T30RQAMEoQBL6J0KX4Zc+Hbd5UKY4qVghkR3IF6FrVUkfhvcPdmx/zTndqbRfY5
 26Cr0ukcwtkUPK5wsuss1IDPo1XPJRMEHxXygq3MuLc4WjFRGS65K1j3v6tL2Y7GqbMRazfrXED
 DfEoCeVwoioYVL94BwVLOEV3zrFekhJ+xVfR/NGBbL16FcjLhFLFFnOIG1ws4nodvPu9cG+lPz1
 U5hWPn8TV/mxb2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update the netconsole documentation to explain the new feature that
allows automatic population of the CPU number in the userdata field.

The key changes include introducing a new section titled "CPU number
auto population in userdata", explaining how to enable the CPU number
auto-population feature by writing to the "populate_cpu_nr" file in the
netconsole configfs hierarchy.

This documentation update ensures users are aware of the new CPU number
auto-population functionality and how to leverage it for better
demultiplexing and visibility of parallel netconsole output.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7af0e687b76176c9171eb1b19013bd..a1b269196be390b5f88a6eca77f6676c67c05720 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -237,6 +237,50 @@ Delete `userdata` entries with `rmdir`::
 
    It is recommended to not write user data values with newlines.
 
+CPU number auto population in userdata
+--------------------------------------
+
+Inside the netconsole configfs hierarchy, there is a file called
+`populate_cpu_nr` under the `userdata` directory. This file is used to enable or
+disable the automatic CPU number population feature. This feature
+automatically populate the CPU number that is sending the message in the
+userdata field.
+
+To enable the CPU number auto-population::
+
+  echo 1 > /sys/kernel/config/netconsole/target1/userdata/populate_cpu_nr
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


