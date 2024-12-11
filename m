Return-Path: <linux-kselftest+bounces-23149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FAE9EC55B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC57D284763
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BE1C5CA1;
	Wed, 11 Dec 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuI3LAyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6E1C683;
	Wed, 11 Dec 2024 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901100; cv=none; b=MLz8crlBC+49M1kdoaA80DxIbqFA+0NvnFysjXzCbhCsykEojYtxY/56CA+m+r3ZG/il+xJi6X2GUZ4eIjvNustUYE5IEo9157/rGnCTydE0VS9OFvY+BI6kJFNLbajchlNQ1KjqyL3zh3uuG85yKAV64MGyika5947HnLAMsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901100; c=relaxed/simple;
	bh=+zrW/sEQHLCXEdlnh4ewKuA7gyTvwbY5kYNfw5E+tcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILHTt2q/dOn08Z5M8UrpX4ehouUWCzEjTNkIDkw2Xndf+tBs+tXt9MRfmwejbPs/m8+aCAzla2pNLwUqpl6cuMZnpDenGnW6Oif/OBQRHFgWmluQCjSNciX3kJqQfwOSbU0oFnGS9liVnZj43mQIc8NUW92AHeNwv0UwlGdicIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuI3LAyZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21669fd5c7cso22196565ad.3;
        Tue, 10 Dec 2024 23:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733901098; x=1734505898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXLsII9ou7VEfa6a6+9bBGq76GyGQPeptzkS+G4lHA8=;
        b=fuI3LAyZAAPFnNdvhtsjCP1k+qjLTFQ3Tk6cCiunwzHYqgGsEwshU4ceKyTaohaWJk
         u5IrfULWS0D0/xZw53UYS9GGur+lzKVCh88s4vbpdSJ2lo0yG8cyXXjGm5RINNaIHSUO
         F1FgPdNsJ/EttFclrjJ4jewC86O5wibAjYuq24pTFJpeMPQmpLOyPaZL8RsmXCb8867q
         WjSIkYmDZWWpdWiWX7cPR2Tpn9gZncJZduxqD0GZJaWEEURShidhkuV8scH7ar1cHndF
         z0RpjDgcTRZWnTlgAljKh7iLIHFT82sKO/VsRqKWWaNAUL6POroQAoCqSvfHjJiER/yv
         dJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733901098; x=1734505898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXLsII9ou7VEfa6a6+9bBGq76GyGQPeptzkS+G4lHA8=;
        b=IT37V79QBLXI9csVV5ljxddeLsmwz5d0qsF/GB7BdQMDKNVZco/vxxGwgPrNOD9nC7
         18VwAf9lfnMJeOerqMhUNs72suQvE+wF3oVyJ+77nCUucyHCRpKqIcrhfsuW+W78Rtzl
         6MujqSPpHAaNYcYSAlvlikM8R4uNow01vcQIWtDqXBtXUCJ2Gdl6YofT2U2t4EICStFn
         egCizc5SFQfty3piUgTpRnlxqWPlycpq7kz8Hed/jcR0j3dAaFg23nnrIOlHzy1E5c9Q
         W2Sr7ENlY1PtyVRhsjOhm07JW4aYVDHGSLzKMS3BHVdFqgPVm03cb8fl/xG5IaukxHrn
         MEpg==
X-Forwarded-Encrypted: i=1; AJvYcCVBkS7XqQfY6NwfwguV6B/Q8YGumre+hqaMIta6R6mMfEyXWyCzUpRJupKDv+Sg2JNOjxBKpBR+AoFD33M=@vger.kernel.org, AJvYcCWuTSUI6Z0OSqcVbOM1AGQAP/Q6V/cxSt1fWuW5VQDu9w52WBQMvCh5QLboJ5iv5kipLHEWBhbqKnbgc1EZ0QT9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dNr6DLFNtn1WLOhFHE/YfeuT/UT7zUz7h/NGfSM/zGi9JiVs
	9H0V1bYJnZl71ASvqZEoiKiu1y2V0bScC+/wDExgGcapcszEd4qvksB65RIX
X-Gm-Gg: ASbGnctt/CTSSKLfl0eD83N7aYoHWqCirphAQIRJLvKE3sU5b7v+tO1yrktWUghjGUp
	xmlo4NSW7r/9H4jDLmhEKP+TOhZIUQuptvMSdtEOjWfycRWuGP1/75dBGPgDxXb7nPS2dIo43rR
	BYYc598MrT0wre//6NK6fCq9EaFfqqdBZ939zDdeSb3E8YHmkJSHcu74sEyeMOGdl04xkNwY8Va
	GXCYuDFQ6NmcW/6tHZwfh18B+edRv/XBveoNGcCOI/k2pb5jkO9vppGpno7xnOiNuM3lM4VSQ==
X-Google-Smtp-Source: AGHT+IEWxcNazcjI1JnBvLQUbK242tFl+GCUpm+6ZolIK4xsADaOQAJw4NEOIuAW2Zp6dNIkp16bmg==
X-Received: by 2002:a17:903:32c6:b0:215:9642:4d6d with SMTP id d9443c01a7336-217783b2d7dmr30236875ad.17.1733901097631;
        Tue, 10 Dec 2024 23:11:37 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f44sm100311205ad.118.2024.12.10.23.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:11:37 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] bond: fix xfrm offload feature during init
Date: Wed, 11 Dec 2024 07:11:25 +0000
Message-ID: <20241211071127.38452-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes the xfrm offload feature during setup active-backup
mode. The second patch add a ipsec offload testing.

Hangbin Liu (2):
  bonding: fix xfrm offload feature setup on active-backup mode
  selftests: bonding: add ipsec offload test

 drivers/net/bonding/bond_main.c               |   2 +-
 drivers/net/bonding/bond_netlink.c            |  17 +-
 include/net/bonding.h                         |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 155 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 6 files changed, 173 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

-- 
2.39.5 (Apple Git-154)


