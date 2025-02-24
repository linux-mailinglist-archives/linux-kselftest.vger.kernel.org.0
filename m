Return-Path: <linux-kselftest+bounces-27334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE3A41956
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EA27A4635
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E2E2441B8;
	Mon, 24 Feb 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsVlEx5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE423CEF8;
	Mon, 24 Feb 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390027; cv=none; b=BDDzq6PEd0NhF/5CQkDuD5hhPK5Q1YBrk4oUH2bIo2XivwXwzcyBwRccY2Qr4xiFHyKbEXVORD7Nyw3+9Y8AhNNFwIOkkJ+9OX8mhO2rI26sqfG9n6SFWpF2xP62cNcJqo7Nn2HB2sH/CG1GMH7L4bepwMpi8l17iPZs0CoVWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390027; c=relaxed/simple;
	bh=ilXjny4q/Us+KcVpV3D4oZwsNv29nwKsDXaZzHNSPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2khzHeCj0arvq/affW79oFJkMOOYLpyEfZH47u7mz6768x/rOft70HGFge+sMaQOp4WPTLj73SuFkX9VyXY3XTmyusQwmJd6uxJST/263LgR7y+JRSnXTzwtcjIMZlEPK0oGdYSCOcoUWqAyYUC4JxMyr4tK+Zl+5GU99dqeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsVlEx5H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e83d65e5so75348405ad.1;
        Mon, 24 Feb 2025 01:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740390024; x=1740994824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bevg+LVVnCsvNGhct+JIEKUyr6Ml9IDUZSl7fki44E8=;
        b=gsVlEx5HAMX9irJOPUUvm4yIKrpcM8NGNgqZRCjZ58bCvKn9Sy8cLKDo2zNXP37F4D
         LoD0muVP44HqnowqDT+bLDbbjNIdPUIFbR5nFf9crqZYlG/Fb1WzTf61GhZpw2CMPp7w
         6OMkASWX67LUvXOi6mTKxd73NDJACROMJ+V0dWEjwongg9ar+UxipGh+W5N30P+QgNy/
         Dmy2RROvMXyoTzrKvo33bWK7t3F/O2p1F7VZOrn3S81XTwPniHmmxHH8hYxtGtpjWzYo
         icQFrcsNrQ4LJRe9si/Gna4tCGsear9nf30KsX+ceLODPlip5SZKiOAJp0js2zQZYUoe
         snBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740390024; x=1740994824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bevg+LVVnCsvNGhct+JIEKUyr6Ml9IDUZSl7fki44E8=;
        b=HIMyF9Xpr/w1BUxcSITlHyl0fHtddsEDDzWV1r+qw2mY7SH8SXKLuIHqe0HAePiDKF
         UI64OeArn8ZbOVRYAcYFhqj5KbUW34vLF+PW3I1rwoHfHF6axhkVzZeR7yF7g+8Yjd26
         38DHkd0wjtaCvNma9k8hkvOlwIULwW0nNt+pN5O8rfoNcRscPc81vDIDTaRtkVLw5RgQ
         CUZa7M7wJPU+cHcyCM8dxlzBa6ufneBrt5tqmnqIWuUALhmmQVL03GznPDMRMoD+8yMV
         xpQ0Diig1t+BadGN2s+/gvcvqMQNVTlsXU//Ek9WFQGnATwy1omDOh+/lY7o/58KiL4X
         0kfw==
X-Forwarded-Encrypted: i=1; AJvYcCUstS2ThEf9KssIcMHI8zLlOpf6KXpmi1jCdUD+LofeZibfWYZMVrWtQC/l7o7aZrK0q4OJv9utwA1b8/g=@vger.kernel.org, AJvYcCXrm8amlij6id1uwUwqIWDBU2UW5yD6sJdi3MeOLIdOjbmGfKkKvULwqUHMA9CjtaPsTBHPA6WlJo+RSDoKzKPj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7mqINpX4VG0UiMbkDjNIxFzG0nNbKbK9Bz5N3O3xBEGMxEOm
	ajod6piEa1dmUeOQyN1orhvOGFgnJilT+ZLSAG4skCl6g9sJtfKh6Dfv6gIa0qCEKg==
X-Gm-Gg: ASbGncvaI0Gw/qSqS9hioS5ZGS9Qjb4tD3J1IpR0mG5uw8TxUsb9yp5Zi8nqkCpNtVT
	mryBXQ8Vjy6kmZ1tS8uguOH/4G0BVQvBIGA9guW3urYFIIhd5SDrQb3kTSQGnP5ip1P8fZUYFM6
	Nzo5G7NFxJlCl8WuXzTOJIiBZhYEKsI5+cL+n2gbKGBQjbJkUUNWnvpTZv6ianBZxtDQq4OO9ol
	jJSmPNf8VBv/Ff+3W5STovFElY93BCifnSUaelLb/AfUPYOIYwXiZ5PfyJuuLSpIAKzAphWhYgH
	oQXbOH7RajZCs1IrTYDkl/hnhdAd8pF+HP5Pc/kJ3eDd6g==
X-Google-Smtp-Source: AGHT+IGrYjhnd1mtJatruaBZmgzR0U8jgZlGpbLb6oKcHDPmebw2maz/URmQwGWhntaF6zbsrDic9w==
X-Received: by 2002:a17:902:e88d:b0:220:f91a:4650 with SMTP id d9443c01a7336-2219ff55febmr182062595ad.19.1740390024315;
        Mon, 24 Feb 2025 01:40:24 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d453sm173056105ad.115.2025.02.24.01.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:40:22 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next] selftests/net: ensure mptcp is enabled in netns
Date: Mon, 24 Feb 2025 09:40:13 +0000
Message-ID: <20250224094013.13159-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions may not enable MPTCP by default. All other MPTCP tests
source mptcp_lib.sh to ensure MPTCP is enabled before testing. However,
the ip_local_port_range test is the only one that does not include this
step.

Let's also ensure MPTCP is enabled in netns for ip_local_port_range so
that it passes on all distributions.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/ip_local_port_range.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.sh b/tools/testing/selftests/net/ip_local_port_range.sh
index 6c6ad346eaa0..4ff746db1256 100755
--- a/tools/testing/selftests/net/ip_local_port_range.sh
+++ b/tools/testing/selftests/net/ip_local_port_range.sh
@@ -2,4 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ./in_netns.sh \
-  sh -c 'sysctl -q -w net.ipv4.ip_local_port_range="40000 49999" && ./ip_local_port_range'
+  sh -c 'sysctl -q -w net.mptcp.enabled=1 && \
+         sysctl -q -w net.ipv4.ip_local_port_range="40000 49999" && \
+         ./ip_local_port_range'
-- 
2.46.0


