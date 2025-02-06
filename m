Return-Path: <linux-kselftest+bounces-25910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB319A2A6E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585FE1692B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D4230276;
	Thu,  6 Feb 2025 11:06:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4422F3AB;
	Thu,  6 Feb 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839983; cv=none; b=oBaQnX+whqjdxcwyUu7QUjJZOW6ow4peXTRTNK4n9EVw4av3svD5qhbxdx/yL5yq/QNOnmKW/eNykUa0IhfjRyF2jW1U5TPnNln6nF4N4fMVGyKcjMJUumKVkCkM2Klors5qKjTr1WSp2XJpUvua3Ze0AfP43us4QeH7i0WJcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839983; c=relaxed/simple;
	bh=tamcCxHm3y1DTBqjP1FY4004ODbiDOOle1ZuKGQMC/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Er5XyY5Sl4tcVq1OdwAM2P+plEGele6FAcLDSMCttqos/nLMDJwgz+PqbzXTRtI+jW3zqKTNvGZxYa9k8F42efTdY+xbq9Agl0EiYpIYh83CxAo3yHRUmKQSwmROtw7HD2/hvlt0Op92XDjJc8guo9NV0sWJGfcG9Uoj3qTuTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeef97ff02so136057466b.1;
        Thu, 06 Feb 2025 03:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839978; x=1739444778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpvAfT2xKK2DzPTMuzs3BntCPv5+DBlkGoA1AwbPHIc=;
        b=hvUFP3bTUPvF102P0VqNyXxi10Qv29CBXCSuD0yvRuujgacW0wOih0aRCCdT5DrFyD
         +Yn/Eml84LUVj4QSmlk+yMqFsVISfpEHCXkkHGfvJGK7yIISP4HBkrGqv2yt2NBmvgX2
         kqDK5YOKXKxvTZ9xs2CZmYQkFZQILzEwLyLXsF8srjLDKYo6dw2voPyQhe3eYT1mSueq
         NLqUcLLIA/DZ9BKeVQ3LZ812nYx+CEjFB2zATHylU42tizMFPipwZ4M3cVdsh6OWBdHw
         /SYiny1WDOx6RtRRP8EAIKdausko7dbhB9cSL2jqxBr8AVbmbDOG4tnpCbm/VRRip3g6
         wolg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0zyXyPVOXW4X4n0/qU/N9hbe1u7J5J7MJmQh7BAn6ZVhTfWwxZgy/U/CLllLaJ2qiNuFzf86/zrsyfHPhbhr@vger.kernel.org, AJvYcCUSkDnNObyH3/t/2S0AxlVBi9TX2Fp1sXWyB1+e9noOKI0ALu5FG9zzgjHD1IWc27lg1TF3NH/ppfo=@vger.kernel.org, AJvYcCXNtYG4cVx/22mgUp8/8Uof06BSgkKLjJd2KWJJtBc+bGLHsyB72K197RYwHi8W+4OIz0qm8cgcHyt0FFKF@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiSCwGE1ajsMHYKQSCA0AjqOpdrjgvHZlGezUrrdzJhgtK8q4
	p2jmUDrX12J1vFEymdA0rrouCzDID3+TdFGSoB1eLE4bZvBfXEls
X-Gm-Gg: ASbGnctVG43YZ65hGFI3WizlsCWDNv4To4wVpqv10/dztMWPqXa+dVil+yuqiAtZJtw
	zd9B8eDoXHSL035PZJ9nGF9QVc4NibDt8zgAYDi1n5RojyoqQfu8veke2V47EpDqKlR2sAi8qXO
	MiiTrE97ZC5cXzSyugRQcvMBjyraHI0/pxwc5VKvj4Qyllg8c6qNbuYBzpNb5S+r3yyMFOHo8tH
	SAGWrce+Jnt2apyCOXBNmJSaVls3keS/3ZLnaMLYCRASRn2Z0NjZRGEQXB1u6Gcz063jUSC6VrW
	trrQew==
X-Google-Smtp-Source: AGHT+IEXjLuBa1sEdPanHbL309t415dJgNNLyYgGBO6Jyc44lhGdhmYjk1F095sezbxN70cTox5t9g==
X-Received: by 2002:a17:907:7b96:b0:ab7:6c4e:8e52 with SMTP id a640c23a62f3a-ab76c4e9dfdmr429966966b.5.1738839978140;
        Thu, 06 Feb 2025 03:06:18 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e73a4sm82544666b.108.2025.02.06.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:59 -0800
Subject: [PATCH net-next v5 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-8-859b23cc3826@debian.org>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=leitao@debian.org;
 h=from:subject:message-id; bh=tamcCxHm3y1DTBqjP1FY4004ODbiDOOle1ZuKGQMC/k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJea6w5eCWTb5GW4BldBdPwcZG1M0KDuBZcua
 mxmxb3Uq7iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bUNID/425UN9lskLXEizCZaIfjB3/tMcvhX6/cNzqJNcQrO/tt3S5x7EoSpWxBaVMUImw9+A7NZ
 vl8rfEDsQkhqIrE4mWbAhPa2WwHbYwj3OIbldhmriysTjtA3a6hdl+klJerN8xnj3Ow1QtMvtBc
 TBy2CPy2hxf+lr5Si92pXeUHXSSR4QGrRWBw+1XONZOqlNpuodUq2uMbmUnn0qtNl9EN6snHXT4
 PDuxHbMSHhKE+mPhdFLmCxdttkr4rT0C6SRDZ0rqI2PJqRXMv7vj7+ve8CN9AK1LpAXQpfCvOGS
 wMjKD+fUegV9xulQxfVD/IGELYrnyYvW8NsARBdnA8wQA65oSCv4xa4+inG3CyY2eDrqvspOEXn
 86pI6BXxgIN14bzfuhlXFpi74+F2FZULvYBncZ/NgX5ZMH9G7SWCl0uIvMvQC3Ee+gPTy0LcFGi
 PcnXokaoTwL15swRG6oPoNXyRmlYS0F0ew0/DdSVPG9tBg7nqSq/axa6A/gJ8mvHMDPT125/SE2
 5FV6WCPLCuY4p5VxKNin3ZTQDIfkcqhJFg6KecEhzl8W0bbkhwkgjoopxlcmsEkP213i9llkHUc
 h/+6TMGrkmhNMGdRWnTJZg4DzCcbaXFzfuMk5uH1wG+f1D5vyiTw+68Q7x86dFNr1QGSkZI224t
 QZgn23mBl2yPV4g==
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


