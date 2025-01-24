Return-Path: <linux-kselftest+bounces-25108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB3A1B8DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C333AFFF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0821B8E1;
	Fri, 24 Jan 2025 15:17:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B0156879;
	Fri, 24 Jan 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731842; cv=none; b=pJ0gEld900vuDKmwU7+F6XGgdMobBrklG+Va6gdY/W6fvPrwNHGUMtKutHBvmoKzZr/FipkI2qKHIWIG6FR8zLsWtJmlQijMbWXoJWMGZbPfXlWajmSqj/di4paMrqs0eDlDD3AKdMFtbqyO3oCUBHObdMIM4I0KmcDfXdFhtDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731842; c=relaxed/simple;
	bh=2pUaLVwLHOwxMYDPKEmqQLY0Bgk29Kn0tTJ8gIKafis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv93pW+lDRH+vLdKloQ18JjgUj18MBDRU4GGL0rOUCXp01e460e7VsPEB18l4liqJ9f8Bjx/JUyBxri1Lv6OhZ8PoLF2urWflOtp9pAZIcT6SRFFCuII4CvORkJAICAoP758FemUntqeeKmSXPkVRsGbxhP7wzSVEvRZLQgV4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa69107179cso460980566b.0;
        Fri, 24 Jan 2025 07:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731837; x=1738336637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PPqcIXQzYEFsqNlbLKuHZEq4XrZtJwQTMEp1c3me10=;
        b=giu6h2pfOU6wUEeART5mACIbA/Xb1MjYr97EgN/YPp2yhzf1XjP+WPf65Dmat+bUDR
         U9hd5gUSnjhIJQxFjXjLdgJYpTNvyY3yDzgFJT/my4N1WmnShjiC7ESw3G9wTFn6a9HX
         7qvJjK0DqqGUDrIZigPAUKR/CqoHUraNsrXm4hB/3Z2N6EDk4RFSfy8eT1hDb50WfBX3
         7n5Iy/D8hfY7T9eGvMMXkX89yOecjeQNxKalk0RJvBZyLdFKAxzYmxxyYcI6ODX/Tp4X
         EwFe2X8B8LxpZJJjjdeb14bCgQLZdB7G95MwX7mCysb9pRJs/SUAQFNNXzqvp1k+cSK0
         hwTA==
X-Forwarded-Encrypted: i=1; AJvYcCUWkpxwLm5N8dpG1AfYhI1Q9bVaXWjMwxzdHgI28T2koiMnGqrnYgUe6KBQ0PfEsi9ZW5tdNMI6jjXQb9yj@vger.kernel.org, AJvYcCUYyQV1G+pUxtNiZz/7lr3fcKeR3d7V/l3wdrAOIZjbUxZ4izLrcp0FRHnCbZapM9Xca0IfINCLQbcd6iaaIoem@vger.kernel.org, AJvYcCUhlhqP/Jyd4ZoMwEtQUX7CFXgwd9ZHeUGKEuTq2gX70KzFveRoKpWaglJSVZQ6jqm4ilBKX4dn0FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGblGp0mPwF3vMs671reID2HxmK+GregDZo9CFWWkK5bXE9+cw
	dgQ95ZPdldHoYiklQbW8rn8QP238xFQRI3iFsjqFYc00ANyq+B+Yi1ejMw==
X-Gm-Gg: ASbGncsRkOdLv3790b4S2Lq10zrd1Wdr/kM+bFHn2wYJed1I0L0OvqwUFvrOdx4zRsS
	aIK4nF90zR96kV8uJ7MpIhRM2jxeiIUYK52vHS2Wo6vyp3HhG/fn1PGHW6OpPYReEd1oEHsZgB3
	4HK0ALwQ1kUcfUkKWh1SPBBy5vhkXFGns9HEc0LgQ9PeImtqoC5AglKGJbdK4qEQkXRrhgyo6Bc
	oQmT2w+CTLDEeCBtf4t1GzUydPSRODJGtZN46QURuWR3nOd6xm8IlwS1w5hQnFJptqQm5o=
X-Google-Smtp-Source: AGHT+IHmMArBUhVtg/1WJ0WUAhLRWzfR+vlFz0bqngO0k9VoWPbYyjW3luib/bc7xGTkRb7/Ph1S8Q==
X-Received: by 2002:a17:906:1788:b0:ab3:47cc:a7dd with SMTP id a640c23a62f3a-ab38b15d31dmr2428769466b.25.1737731836596;
        Fri, 24 Jan 2025 07:17:16 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8a72csm143089866b.79.2025.01.24.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:47 -0800
Subject: [PATCH RFC net-next v3 8/8] netconsole: docs: Add documentation
 for CPU number auto-population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-8-12a0d286ba1d@debian.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
In-Reply-To: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67rzqpaFBm/uAykxQpqzIDmyYNpJQXNmvQwJ
 trRp/RdZ3mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6wAKCRA1o5Of/Hh3
 bZbKD/94RwRqeg+0IfuSnuirUkVEZlJNvpAGF3RTwwEneET8cc+ZnBDYQeMq1Q5M+RoICwHg4r/
 XjRIg/B1NhXjEobrvkQz6ewWBO1jutkMN43d+ZRzv9czSs5/lSpdvyzFnx14hQ78bq5ZCZVdsOr
 Tj6BXrPJOG45I1VHRVO2or8ysG3c+VlPH2Fie5Y+eGzFsGEJymIDx6g1nTtgiW3OZMJ5CUidwJl
 YFdTkk4oaiRDbOi9ZLMJnBZdxfHOdeiGZHoGdDlYQgNbI/H86vtK4zeefqO0UNMJHO4NVVYuJrl
 fbEK7EYTB4qsm8xK5Q1gddvm+ebxC1oowvtf+ZW727ajc0B19oFYTXyopoDmtNr6KdapRdGOQgT
 8ElwRxAPTjI6Ft7hUT2sKcymUdwzRHF4dr9OJzfbDXwLJcSUIeWG0WIjFIuIP3SGrofY7+C3u4P
 YE+Qxm1xVJbSgiBeGLd92oHlcLlGLYNnaWSZ11Iiirxzeb/688yQTVMy0Go6GG10hXaMywbzFus
 ppWBGvhkpR5WfnEQnkQNa/aSP9v9OhEPL4r58yPCnRIUzJrcd5bz+W2y+VcpO1HpX7layA3Ca5h
 IiD6+tfnJ0JfrOdQJqqInR8w900kdB4fAU3XSz3c3kTspjnPDycVrZQ3ZO3mLS6NwwW992TUENu
 i34h2scdJYJBqdw==
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


