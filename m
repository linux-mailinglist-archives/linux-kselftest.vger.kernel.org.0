Return-Path: <linux-kselftest+bounces-34726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBEAD58E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9103A4B04
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D726E6F8;
	Wed, 11 Jun 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA9scOt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48E1865FA;
	Wed, 11 Jun 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652652; cv=none; b=RqsvIYDD4e5TICI2gPAlnW4yoggGzgMR/MdjOvNQD3rOph748EdKerEdCgu/76zYq6FZljgbfVmKawvNshXhMkmhnP4B8VQwCahTiJV50knZuX0bw7qG2/Uyr0hiJIxIwfQUkeVXwhWiSURAivzRxGadRgUgfWrkx5zSg1EEvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652652; c=relaxed/simple;
	bh=lP770bZ1D8klIhRSLVtQSTgWgmEEE7/etBWV1RRYVPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q/rGqwhNXPoZY+kfQLVdJwOs6QaG+PijkVuvY56qU36TxfE13VwKf1d0W3OcG6wA6Xk8Pe8HrwfCTltRQBgwA8wAHCdNKLcGGBJXn44XDrkKsbOKPTlg5Z04xzx/au8Uhad/PunXCNoQyhvY5PlcxFa0tkdP6Fxr+o0zxyMPsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA9scOt8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fae8838c1aso307936d6.2;
        Wed, 11 Jun 2025 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652649; x=1750257449; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgV3v5SPPWzgcce8CqjU5pHfWiAeujETQN1ykorZ1jI=;
        b=fA9scOt8qC0qbJsmwdm1HELYKX+mRe/RIKCd1Rpi0p3j0fezRaGVEADeZwXE0KgddH
         6NUeXhBCF0RmKln3f9jCmW8J3/Q8r7fWdajmEADc2Bl489snE+UqR8mij/MZvOCxEwDm
         N8NsN6MtjLh0ASLmUVkZcVAajJ/rVGYyt+30y/BOPqlE7J/cnm+ti1ALtlqOQp4nZqmq
         p4RnmQUNPigIQhtOCdA0VZ/DQGAyT3Pg5mXDsNYE5nSV3GT2fQ3nwP0ELuQg6LTpASxL
         4mNBJ56HD4Xf+hNh/OnJcH2e1TbTPO3AB4DRCI6GxctiXxFSj47wyxgjmK385RrWfcKK
         L5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652649; x=1750257449;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgV3v5SPPWzgcce8CqjU5pHfWiAeujETQN1ykorZ1jI=;
        b=gd3bh0GIi7MnS3+t2BzWblMxCX8KwBdaVSU6G7Dv0aDujpYXK4re/q01HCsr7UuiWt
         HjYOLoYpv0F7eGHm8CXFPzfzul19nfpCl3yQx7eYzliTY2BZ0k1Z/xblNdGlWgSoXhhm
         A7RWNVTJu7HUBEQNuZC9oc62My3A+2BJurh0lCLzpCEkRwaun0B/h37v5SYSfpg6EoT8
         Q97punqivE2IcP558ldp/ZJ8q3hYbE++PifdNZmr4DCn5ZxqC2RHIn1a860SwRQNAJWw
         FFDDOvSNk4X373hWsNdtOXnW+9v0AHywL/fbQTcsBCzkXDScfJa4alqFPbCtqgTo8Wmq
         y/fA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Wzmoo5HyiqpxGqmP1hvQtsb+kgEm0R6cp9hRSGdK65+x1jcqwutLqJXfKdmFJ9Te2r/58X0KM98=@vger.kernel.org, AJvYcCV3hiNffiQ31hP9bWCE8PnIZZKWtmfnNr3l2NID+DRXHcni047W0z28M3xezTBxXm574MTIVkLnbwiUHmLn@vger.kernel.org, AJvYcCXsmWGAZSiuxVhe8s2W/O6OFYLVLmJ+5Q2kS/2cqCEY3/GJW+HYLSfAZF77wLw634Ah7mylHO2BHwsqpfnD5D99@vger.kernel.org
X-Gm-Message-State: AOJu0YxPR7emUP4B//hmrCRssmLwmfL8bt+D9AuCzui2DocR+M4esvo/
	A5GOKTh5DaZg++fzZVKCwbh+sK0dPHh+oPOqmFub6ui++/VMt0cd72kiDRjKce4Iajg=
X-Gm-Gg: ASbGncsjMbQ9l4jd6QMDhAwofAqILml/abb5wqQj9lNsljYaMeta77zvoKD0mGuHGpy
	69jwClcBwIGFrw3aoYSZO80wt1xpvLUkk52C1gMNhPg0AvbQI5AKhZxK4qVBVE8SmL029yraGnx
	kxvlftK+4TbrOmomeT9jmUk0Pul1+Gj1zjV4ZdFcQg5NpOsoDZ92gnkAqVbrtIoeimwYPdpwxsW
	qghtLiffAKylq8I8AssB0obCmPF1bnXhIeowjCUol35rc+4Ytw2b2jB7QbYaLxO2XPZ9a8JdkOp
	H3hImyu7aNBov2zFL7u5IHzgrWJjCYN4V913ujYikKIz9LyoKY894Ng=
X-Google-Smtp-Source: AGHT+IFZqBVl/qLyo7aucRRJSwROpq10T0edSvlAYOD6FEKlO5S9bmObYcShGgPbt1faHpN6NIml4w==
X-Received: by 2002:a05:6214:b6d:b0:6fa:ed19:2566 with SMTP id 6a1803df08f44-6fb2c31ea88mr22241426d6.2.1749652649092;
        Wed, 11 Jun 2025 07:37:29 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61d73csm871410885a.98.2025.06.11.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:28 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next 0/5] netconsole: Add support for msgid in sysdata
Date: Wed, 11 Jun 2025 07:36:02 -0700
Message-Id: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKUSWgC/x2MQQqAIBAAvxJ7TrAiyb4SHcpWWygNNyKI/t7Sc
 WBmHmDMhAx98UDGi5hSFKjKAtw6xYCKFmGodd1qo62KeLoUOW2odg60qNk2zvgOrTMaJDsyerr
 /5QBiS3GfML7vB9Cghm9sAAAA
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This patch series introduces a new feature to netconsole which allows
appending a message ID to the userdata dictionary.

If the msgid feature is enabled, the message ID is built from a per-target 32
bit counter that is incremented and appended to every message sent to the target.

Example::
  echo 1 > "/sys/kernel/config/netconsole/cmdline0/userdata/msgid_enabled"
  echo "This is message #1" > /dev/kmsg
  echo "This is message #2" > /dev/kmsg
  13,434,54928466,-;This is message #1
   msgid=1
  13,435,54934019,-;This is message #2
   msgid=2

This feature can be used by the target to detect if messages were dropped or
reordered before reaching the target. This allows system administrators to
assess the reliability of their netconsole pipeline and detect loss of messages
due to network contention or temporary unavailability.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Note to maintainer:
This will conflict with a fix I sent recently to net:

c85bf1975108 netconsole: fix appending sysdata when sysdata_fields ==
SYSDATA_RELEASE

Please let me know if I should rebase at some point and send a v2.

---
Gustavo Luiz Duarte (5):
      netconsole: introduce 'msgid' as a new sysdata field
      netconsole: implement configfs for msgid_enabled
      netconsole: append msgid to sysdata
      selftests: netconsole: Add tests for 'msgid' feature in sysdata
      docs: netconsole: document msgid feature

 Documentation/networking/netconsole.rst            | 22 +++++++
 drivers/net/netconsole.c                           | 67 +++++++++++++++++++++-
 .../selftests/drivers/net/netcons_sysdata.sh       | 30 ++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250609-netconsole-msgid-b93c6f8e9c60

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


