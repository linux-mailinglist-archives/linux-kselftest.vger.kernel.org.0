Return-Path: <linux-kselftest+bounces-24577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA0A124F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC687A54C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5C243845;
	Wed, 15 Jan 2025 13:35:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F02442C9;
	Wed, 15 Jan 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948147; cv=none; b=L3OdYjtYXBtvbJyd6pyycWsTGMwp0HCEbG1gzcl/3KYKBSEeh6+odsxBH3Cx9r64HOjSnTJ9wsmLq8QSdQi1UKwDn12RmCeoz4OISpkJgpSjx5qzhxJ3lST23M0xllSvqXdhJGamYQAylYz+fcnU5WaHLdAHIhXLBUBezTcsD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948147; c=relaxed/simple;
	bh=0oHhKbeC5HsGd9axRgZ+a+1v3+X8oAJistl2Zqr0Tnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0hzLzwzQZ1kxAC2/bXEKTvOV7M2IwEoSwCUjRiTyiTupLudUk9xFR+IqlURaT5NmsTYdTNCKBCmpxmymxk5xP4jxMqaHJEOVzajQp7SNPh0lBXDMAvnakeBlHDU6ku5yxm0rnOIA9Rsy/o5w4MSRftffER+RPecGjGI9vL4PVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so13357353a12.2;
        Wed, 15 Jan 2025 05:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948142; x=1737552942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxJoZ54lWmY7y03qGdohZy+9vBhB4XRFoa82rjM9rKk=;
        b=ebdrYflHbzu+ZScAYAs0y/tXwH+WHjpz3Pxp00Hy2mr2CCZctE8rw1O7aqnTTwpjU0
         e8Ykda+iE1vpRPyIQJgmDSWbC2tpzo+ZwBdnwAOWOw1q9TAW6PVM0A3CUulnhgNT1ohE
         89WIpTFbLqWNI5eRhjPahzlVRSy5b5xWAKbCxj7wcZRzJuO9B7dRxq+VfeoUnmHo/p2d
         ZK/pU/+cHkHYheNMe5DlsCGLYU5j7nQiN+COVVh2BTahjy+fI1T/F5fQ5DWvgE2Vn/lg
         /3diNFpzkkM2K3FARw05ixKYVWsUBCCEJ/esyh7ynuOH96iQoZRHDf99zwdDQx7dKc1P
         da0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV3FBzlShXTb9I//HNFe0oRQ+tPJbLUOYe0u/uHK0/KVgyo4txsPlXJ5oFEtoc8OWBb2DSGhZgKBM5mWk3ApU9@vger.kernel.org, AJvYcCW4QOJ0UIlLBqZwPyHeFfwSRTuzah8C9wxT19WDPToXX8E6I0rMpAHNHK+kMQ26/cHHciD9YHrLQgmug7va@vger.kernel.org, AJvYcCWvLC0CSJcbg0ZjwU7VjhZLTuTzdY8b2ChTh+GUZRWn524KjiDfrM8YVRhGbUTYFhZ4XhEduIo4lBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzthCOsOIOW5hH+vG5F7J0q7UfmfJ3qCFjZVaLUQshc4gITf3
	UZIV3B3Vk0inbGpARhqbRiAf8wtv3hdpUWim5JHClQE3kUeGfUVT
X-Gm-Gg: ASbGncuY2Vggy1iCRTf9KwOyC0JF8HIPUB9oLvPDNWqty1yDxUU8jl0adh4kgOkHjrb
	QxsSoN8nuztTDugVI6OH5RoXfljcUZElqB3ixlNBHkpZdEp8FLHLbXskA8pLtwephfikXDzR7bZ
	bTXk1LjWSnCZ0HPxKMzrK32sBFSyNPY6K/jWl1nk38MEKR1slOTFtB9uY0mBaGRBll5Xx4fucr5
	MzEM28gmwxPEZa7SxbjuUk6OSRpO2/wRym0wbof2p7/osTc
X-Google-Smtp-Source: AGHT+IHkbMdfObs31g/uxBDWJkg3DCJ8vK/UdUPgmYZzzc/BSJGQRpU0xtCIkd0BMW5M3kic6vM1VA==
X-Received: by 2002:a17:907:3f9b:b0:aac:1e96:e7cf with SMTP id a640c23a62f3a-ab2ab6c6720mr2639494066b.20.1736948142064;
        Wed, 15 Jan 2025 05:35:42 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab33d6254ffsm194073066b.6.2025.01.15.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:41 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Jan 2025 05:35:22 -0800
Subject: [PATCH net-next v2 5/5] netconsole: docs: Add documentation for
 CPU number auto-population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-netcon_cpu-v2-5-95971b44dc56@debian.org>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
In-Reply-To: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, max@kutsevol.com, 
 thepacketgeek@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; i=leitao@debian.org;
 h=from:subject:message-id; bh=0oHhKbeC5HsGd9axRgZ+a+1v3+X8oAJistl2Zqr0Tnw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mjnDag4eJcR1nVn8Jbgr8LMjboW0P5wsfwy
 aSp+YMMyCuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bczFD/0QNg2h1j+sLpHXLQ4IvAtAtrNtBi612SGfuWrHIHVGzFejxKTwJghwqGDUg2VjqNypy8a
 nBHMPr3olE7nzhdTWcdUGxdsXi3nyjOPkK5f7k5XoUPK3LGdQPppgGb6/OhE1+nyzVcktSuFNSE
 vbKeGIAfJOEQObqtXvShf7f4H7Ry2Jzljq5fOG1WCibK+NfnGu0zPdE9qXG5Hr4ulneBOxR0nQY
 4mWbfWlafW5qKtcgI2LxJMpduLabYOPWrTrsAOYQUo4chcxj5Q1/u9kTKjfMzUZ/AjKkGeikZgH
 Mlqg/w/s75M4iTrNg72IRk4WLSay6PSzHeiWBiwGQ8WYxd+SNKHaA+sn2C9D0JXBYa/Z56ovOrM
 tv5m19brudoy2npvbV/lOnzVvXsxocst5TVqrn8+6oybRivekRuMB6y/B7Ydzrenbae6FG3CX0g
 HITfZIsfXYxtf7N8BOFr2AyrY5aknnlfviIJpFajV9emQRzxGSCdhgDGj3LYuciii8ung4AHlB4
 jTQts/+BcS6o7ikQeVv5PldMxL41Njod4yp9RDF5KKORx000vyLTiFpcIqYIJwoGRJxnpyeX6WM
 1J8MmbVZSIUBj1aEp0P/OIg7ecg/ezOtYpnfNcZe4dYh7pouHrl1De4RgTAOoznQedXcOSv1yRW
 a/diSrNDPrmytSQ==
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
index 94c4680fdf3e7e1a0020d11b44547acfd68072a5..bc9ccebdae7adadd7c57aef20a726536d7ab3173 100644
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
+populate the CPU number that is sending the message.
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


