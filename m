Return-Path: <linux-kselftest+bounces-21945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C741E9C75AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599BA1F21E6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5513B791;
	Wed, 13 Nov 2024 15:11:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713241C92;
	Wed, 13 Nov 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510676; cv=none; b=obOm1EG4tmIhmyX04RjDQvCP370FiVri7UkC6imtRk9RpXEmaQKcwa2zSL6bcpB/mYC60QIrMERejqhV3a7eDVdWTae9KWoT3eBUzlX77ASDaPXPaymgeVcJSiNiwmCgx+JwlLxGdNWLazD0H3C9lKZeiRTYJEh81eJv8ZDTItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510676; c=relaxed/simple;
	bh=204Wn2qsK5rOrAZSyLR7u1wLs1ibJXckOK6wHbpTxUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dp1Es32ExBE+8DoAxymnrZaK+3RmEEPYEFCb5PeXoUHg16H8CdEgYoJ0zoMKVJNvySkd1nsnkxgCy5JbSfnTuTRGHcEHnjryH87SYXuO+py31I3+A4dl7sVTr0rwqCE33GrTTNesP/k1GW3XQOul0hbtlNSXb8tro4to3U3oIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso8876063a12.3;
        Wed, 13 Nov 2024 07:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510673; x=1732115473;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfH2TWb+7izI2j1spFXvVtJDceylhlPJ8QxX+qATM/c=;
        b=iXabiftDcduATXHvvVE+y4JCm6MiIFTTg5rfCFCldbvna+2IQk6I0ksBz6GW6ghmii
         sAyuewgwLm4qZbUs7WT0l98uLeK7onFMsgNZa59GTynZg3w61bKHukm3Ff+lUcIa5kFh
         tv9R06LLoSYOx+MXcYNXfeNGVoDp4J/78dcnWvs2Orr6SZNUvB2MWrrYWQ8MN9YXtxNK
         dgAHbeRAxU8/KtchyCb04UpvIjyelMLJfFoWyinowwBRusuFMNBPBR81Qvgfz74cyEzN
         XcBG6GTgw0aKqmTVGmZHjia+TrbnLy26+TDdNy13ckYYgIlpBMkihp0PPnjQui7VQ1YR
         A0+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJwIV8VKsv/bgIBuOVB5+Z0AYAbc38TGKh32ZTpA6lh466xxFmQX7MlpwnPVCkevy+imB83tQZ01FT7sfs7+mt@vger.kernel.org, AJvYcCVSxTI55CjLq4X2nhM8yibgT0PdVr72gvLq6cdkEK0yflIKLHBQNZcbbS+ifi9kjEDcrgLFVN3J1KF1UAau@vger.kernel.org, AJvYcCW8nbjij2b0cBGLDmKBpBJBqmobutw4ApVka7zBexzImW8THuYvbQ5urvHhsFQmelVaRf2xUPXOXR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFbq4YvYRC3tyl4za0q23aahCbfI27tzdpZexNQlAF6MUQYDd
	LfKfpm0ivWbeVV2JzQlKmDSuTRvP85eblllZEhzUES2JGkJQtr2p
X-Google-Smtp-Source: AGHT+IF1NxHGcflTbidDLYgdUbYwZmYAvAC0JX8PD7lFuIIcJ53aG/MY4w/pvD1kjWeweqwh3Cm3RA==
X-Received: by 2002:a05:6402:354f:b0:5cf:6592:4680 with SMTP id 4fb4d7f45d1cf-5cf65924a53mr2396889a12.17.1731510673288;
        Wed, 13 Nov 2024 07:11:13 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf3d301d96sm3603334a12.39.2024.11.13.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/4] netconsole: Add support for CPU population
Date: Wed, 13 Nov 2024 07:10:51 -0800
Message-Id: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHvBNGcC/x3MQQqDMBAF0KsMf23AWKExVylF2vRbZzNKEkUQ7
 17oO8A7UZiVBVFOZO5adDFE8Y0gzS/70ukHUdC1Xe99G5yxpsXGtG4u8Tb4O0OY+jcawZo56fH
 PHjBWZzwqntf1A7MXVD9mAAAA
X-Change-ID: 20241108-netcon_cpu-ce3917e88f4b
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=leitao@debian.org;
 h=from:subject:message-id; bh=204Wn2qsK5rOrAZSyLR7u1wLs1ibJXckOK6wHbpTxUw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNMGN2cXjlk8XVlkoAArsLkDkSve+y9ORYjZhv
 YrRAgTnc+6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzTBjQAKCRA1o5Of/Hh3
 bXlcD/9zVglC/YeywwWUwxoBHe4J/snIZyHQ8LVl1n2Gp6AUK57Vn/AJ7N3JhZZs84gF8k7O+jo
 ffvGPr3B0AL6+On08cbdEZZMsfR+q9/DHdnnE+oQpFpItlWynGQIEVWP+aYTzaXj/vd2bCpCl0J
 xR6nPdqPOO8QEaKh84Ieicn3yH0+APRTCh07QB4fgnMG9RQnluGMvnAeHjHx/NEhcRQYz4ZYIzT
 0KhVCE+0f//Chh1zAQmcy+j8+4+J0Y6O9csOxpfTS31o/h9bELP95HDHD9AAUwACJhNKk6ZIkoY
 k7KRQVgvjQVRgqnEvjICdegdAu+yeHDlwyyXkbmm6DxX3k/Z/q/KnOkMeAYqK850Syjps4R36p3
 PQeJ+BEGTGvReMWfJ7fIBA2o/2/gKdOXKf9UmBAuzPqQ4K+nK7++0oQoteAD9vnG5XkXjSvmAig
 4PiWxH/j3rZHXmSczg4yIZJz4+b1Pi/CpEfPAzrglOOajG7SjTVa8Tm0VWCu+UMophxpijV1KjZ
 HbC+arGJx+sBK32B5eiEdMWtryyoaEhvPcH5Wg/G/zFgtrfPsys7KrvnkoMCbee8NmqcchQwrh4
 Os3FHTNrSfnSoRJgchxm5VpTH72z55gMcD74SNwlkISvDtZ3mOSfgCv5yrzOC2jInjGuVDIQ6Iu
 n3zq1Tk63c+KhDg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current implementation of netconsole sends all log messages in
parallel, which can lead to an intermixed and interleaved output on the
receiving side. This makes it challenging to demultiplex the messages
and attribute them to their originating CPUs.

As a result, users and developers often struggle to effectively analyze
and debug the parallel log output received through netconsole.

Example of a message got from produciton hosts:

	------------[ cut here ]------------
	------------[ cut here ]------------
	refcount_t: saturated; leaking memory.
	WARNING: CPU: 2 PID: 1613668 at lib/refcount.c:22 refcount_warn_saturate+0x5e/0xe0
	refcount_t: addition on 0; use-after-free.
	WARNING: CPU: 26 PID: 4139916 at lib/refcount.c:25 refcount_warn_saturate+0x7d/0xe0
	Modules linked in: bpf_preload(E) vhost_net(E) tun(E) vhost(E)

This series of patches introduces a new feature to the netconsole
subsystem that allows the automatic population of the CPU number in the
userdata field for each log message. This enhancement provides several
benefits:

* Improved demultiplexing of parallel log output: When multiple CPUs are
  sending messages concurrently, the added CPU number in the userdata
  makes it easier to differentiate and attribute the messages to their
  originating CPUs.

* Better visibility into message sources: The CPU number information
  gives users and developers more insight into which specific CPU a
  particular log message came from, which can be valuable for debugging
  and analysis.

The changes in this series are as follows:

Patch "Ensure dynamic_netconsole_mutex is held during userdata update"

Add a lockdep assert to make sure  dynamic_netconsole_mutex is held when
calling update_userdata().

Patch "netconsole: Add option to auto-populate CPU number in userdata"

Adds a new option to enable automatic CPU number population in the
netconsole userdata Provides a new "populate_cpu_nr" sysfs attribute to
control this feature

Patch "netconsole: selftest: test CPU number auto-population"

Expands the existing netconsole selftest to verify the CPU number
auto-population functionality Ensures the received netconsole messages
contain the expected "cpu=" entry in the userdata

Patch "netconsole: docs: Add documentation for CPU number auto-population"

Updates the netconsole documentation to explain the new CPU number
auto-population feature Provides instructions on how to enable and use
the feature

I believe these changes will be a valuable addition to the netconsole
subsystem, enhancing its usefulness for kernel developers and users.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (4):
      netconsole: Ensure dynamic_netconsole_mutex is held during userdata update
      netconsole: Add option to auto-populate CPU number in userdata
      netconsole: docs: Add documentation for CPU number auto-population
      netconsole: selftest: Validate CPU number auto-population in userdata

 Documentation/networking/netconsole.rst            | 44 +++++++++++++++
 drivers/net/netconsole.c                           | 63 ++++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 18 +++++++
 3 files changed, 125 insertions(+)
---
base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
change-id: 20241108-netcon_cpu-ce3917e88f4b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


