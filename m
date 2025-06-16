Return-Path: <linux-kselftest+bounces-35116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7299ADB78E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037E317225D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682772868B7;
	Mon, 16 Jun 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtigiTAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350028750B;
	Mon, 16 Jun 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093795; cv=none; b=KPeMJwI/9jSQ8/YJx6Vn5UXb5Yr9HsXSJU7kpvfv0A4GGZ5A/FLpzAN1Vfw/hCWoxjlYpIN2NLeiY5eVL711eucVX/zkPHbxD5IUZZW1VSbKlKrxG2fxIZHlCGnHeVvJe8MBaI5GP0Oq8IeSZfqm98IUphZ+0/OgNvR+H5fLq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093795; c=relaxed/simple;
	bh=snCdIYgJY/Gbrh8KSW/7Yf7EmPtoKnw/JLZpyosYBMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RivSF4LzjOiMuFi1dN44TU6yOecVhqZAgmZJ+sT1mvooHoIZngkIgDWlIz4Q8wmvqE98H27saNJRFY8q60d4DrUsA2The/mvIO05It0c1Mgmf/fbkbpPyu5k+eAfmhvqIgWgPUCPYmg16W5kaRpqriUU+5vGA65UuWtJWkB3/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtigiTAG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a5901854e3so6733711cf.3;
        Mon, 16 Jun 2025 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093790; x=1750698590; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OALMEOmmOpixaGW3XVaHA/qsUtEIHB6pfWcetx0wYBI=;
        b=RtigiTAG1C+x217cFfbh2LT1wyznLxUJvUY6kugXE0Ht1pQ5bSh9gf6QyRJOm4gQZR
         NBHKplh+OM+lL9k5IlKU+GV1c7CUat0MtNy+juYl6Gm59620GbBWg9oyUOf7q7bq1atB
         qBmaabOw1jTuOPKM/fyeh4lkcJW+Q+0MkJ0/FjriS7dzLL5JSbzXJ7UdH9hTsL/MSJ92
         BlTIfXA+vY4m5gSvKetmeII55UurJ63EWnviETMz/OEpn1RfGI1QUz4Iv84TS+8DT9jP
         X6KgBKLBb8rZ8y1o3aJBQpB6vPdCF5DEFfISZltzSfWD/3YvJ//MtOw3DcxKGGnlSUs7
         9Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093790; x=1750698590;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OALMEOmmOpixaGW3XVaHA/qsUtEIHB6pfWcetx0wYBI=;
        b=IMFvQaOhHcb4STPsdYycBq9QkarWL5slzOGutvu72bchbV1QuZ05IrMXwWZY37A2MB
         q9wksIpp4GX5bMNs27D+1dTChinHeV6zrWdfa/9YNd0nUyE5qFzSMoAZPisvTjVFx82z
         pONEoLNUURnumYqiM6+J0msHFY+ofHehiFNtTJviuPnvWNcAG+hB3+38SxoGe26K3Zzw
         ItQHoMwrykmzRz1YdAyeJ3oXgD3Wl+PImMDUokIMJmlVMieNcyqdZx4g1WetmhEXUP9m
         CXn24cZZIGt2iCmZyWqeIVpCBzxINd6Gf0misuYGZ5xkTKmNPbWM7WT5PTCQYDQ/hkAO
         sMZg==
X-Forwarded-Encrypted: i=1; AJvYcCUdGedhy5X5YvRikwSLUMl4qxCgFM6EdTSj+KhIu0XLU9XsK6dqeglkPJkTe78DCYrJrDKVA9h9b5yaiSxvm1ve@vger.kernel.org, AJvYcCVWFu2v8sXXikTXSjt7KkkUERvl2or1EEe1YhU5N9uluLH+NydLltp/rc8shAAAq1ZzwZH8DKmqM9nQKQ/5@vger.kernel.org, AJvYcCW3htfPOfUC0CHhR//b5IDEIbI1zKbvqkzdcSxyirVU3KdrN4NH3+70YERHJBrSScSWyh+/e+zidak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQ+VHN+lKIpqUbxiuGL183erqoTFkI67IX0/o04eqa4F0B0g1
	nP03/ya7MSJ+aHBy8HwkmYRIeYQQ/NV2T7n62ktWBO6Lpji2wXL39eWh
X-Gm-Gg: ASbGncvF+3a5ls4jY2+iibcwTQU+m6YVHJk/Wg9HAROxYMtYSHRNGSFbIj0hfbaO4gV
	wNHKAG2kh39I3c+nmUVsa6xE46a6XZ0i40GYRMTMrtzw69qmt4WG4xccG/p4g1i9XejbHrRaeAz
	sZlhxwSDsBv6xx/ncM5/0MdBCQAkmrNJsST1JRpHjQ817jpyXrnMzA4p6NMv9gAjrYdQhcOYOeS
	zVdwyWqPzkqiLaqydUe3fmt0xtVmJFlZjkQ/3GxkvXmNUlwTFjWlpcyA4an+09Gm4f93kZACabA
	enRfAT7Hv73cY5cDGmI/9n88zjgYdPJcrDpIBACYsNouW1ftM/8gfTlA04ZMKR3Mtw==
X-Google-Smtp-Source: AGHT+IG4F/SKra4kDBY1mPCktsz6zBpNw1ox5hr7Trsf+8D+LFwgE6p+83sUUeGbBLJPIl0Gg/unCg==
X-Received: by 2002:ac8:57c1:0:b0:4a4:3cac:2c7a with SMTP id d75a77b69052e-4a73c5f4049mr51963041cf.11.1750093790247;
        Mon, 16 Jun 2025 10:09:50 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a3112b8sm51333551cf.31.2025.06.16.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:09:49 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v3 0/5] netconsole: Add support for msgid in
 sysdata
Date: Mon, 16 Jun 2025 10:08:34 -0700
Message-Id: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJPUGgC/23NTQrDIBAF4KuEWdei5qdJV71H6ULNJBlotGiQl
 JC7V+wm0C4fb943GwT0hAGuxQYeIwVyNoXyVICZlB2RUZ8ySC5r3vCOWVyMs8E9kc1hpJ7prjT
 N0GJnGg5p9vI40JrJO6TrtFgXeKRmorA4/86/osj9lxXil42CcSYubaVqMaAWeBtnRc+zcXPGo
 jwC8g8gE9BXRiht2korcwT2ff8AgDaplvsAAAA=
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

---
Changes in v3:
- Add kdoc documentation for msgcounter.
- Link to v2: https://lore.kernel.org/r/20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com

Changes in v2:
- Use wrapping_assign_add() to avoid warnings in UBSAN and friends.
- Improve documentation to clarify wrapping and distinguish msgid from sequnum.
- Rebase and fix conflict in prepare_extradata().
- Link to v1: https://lore.kernel.org/r/20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com

---
Gustavo Luiz Duarte (5):
      netconsole: introduce 'msgid' as a new sysdata field
      netconsole: implement configfs for msgid_enabled
      netconsole: append msgid to sysdata
      selftests: netconsole: Add tests for 'msgid' feature in sysdata
      docs: netconsole: document msgid feature

 Documentation/networking/netconsole.rst            | 32 +++++++++++
 drivers/net/netconsole.c                           | 66 ++++++++++++++++++++++
 .../selftests/drivers/net/netcons_sysdata.sh       | 30 ++++++++++
 3 files changed, 128 insertions(+)
---
base-commit: 08207f42d3ffee43c97f16baf03d7426a3c353ca
change-id: 20250609-netconsole-msgid-b93c6f8e9c60

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


