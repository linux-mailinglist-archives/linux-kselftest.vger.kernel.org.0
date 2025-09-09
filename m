Return-Path: <linux-kselftest+bounces-41056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F3B50346
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE2E1C6475A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBE352FF5;
	Tue,  9 Sep 2025 16:54:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841742264D5;
	Tue,  9 Sep 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436888; cv=none; b=glzdCl0GouL9xU8CslBW3fLhodY9byXzFZtiqGadzqHmPACNPC8Tmw1/1GCeZ0Gs1jlt39aMJuQ6tj+BUmIQ0wA4bFAXjcIswAZSW8XpGD3ibgbUCOHUzUMAwr4jNbm0u+Ex45DPhRLsdHOuXB4rKagYQP1wRIxYwNqis0OpdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436888; c=relaxed/simple;
	bh=bxDJ1Uw4J0KpleKnQNyutRybOnKsD5XTqIf7LZmhlfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNpD0sRhPF718Bcm/RfIk/ON3Xte7m0vMmtO7lxfTFUO4BMVn1CDVXlIuGJ3UrgZ9R8dgOgSKzBxnT3CQR2k/hr8OXJrn6DMJfTtaQUIXboB7epUtkbTGXaTY6DbP91ipJWuHymVqfJEg6jY58QCQxHPSk/MEhfEXAunL/QyhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso4639422a12.3;
        Tue, 09 Sep 2025 09:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436885; x=1758041685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNTwRNFBMsyW1WoHdowH0Y6o+cSls4bW7O/Ck2bq7h8=;
        b=sYF1/Idu13KA/JIaREX+jOfM/7u9jXQ7YCyGIn3BSLgCr/OWE7151PW4XYLAw9naT7
         ldJe3rBrt+lzYIBymN7qDmMU7hjaz2I76jeYoZyhaf94YeVPCOjcXjEZNpgJg/ZX9FdL
         BF9IwQdPN830AIfkoMkw9hE986sOGPbIvZp6qKZnkWL1zX5gQASHigqsKv7ybZ5QDSiS
         g60JQ94pJ9OP976RNIlKzgYinF49+9K4zB67rO8BeVPVpKRy+rWXXKTpJ37CLtOswUpb
         IoLl6BV3yXeK1RGio68WX2RDfBH0DbkwA+lWIrZzwVF8sJbpSwrc2icgmZGZYSHI/AIk
         CAQA==
X-Forwarded-Encrypted: i=1; AJvYcCUeQYRUtkD0ZzabCT9EDlMEoBj7MZy5wtgSuXNEUcm5spAEQBiOJnGm5e2KdmvqJ4kwc/Lmf5SMUmI+DVg=@vger.kernel.org, AJvYcCWrDVVJ6mrZ5f/Fqu36k/BSFncPNOaj5rOkvIZbjc+Fo2f0EBt7msmm7gsSJ0T4Dd1nt+6qBfOVVM0ijTSPZtoG@vger.kernel.org
X-Gm-Message-State: AOJu0YyAk2l/8/Q2HjGmmFy8G+GsCPhnc4Ju+Otxwwj5UJAZ0Yrl4kTZ
	YLUZjDdq620FB4gPT0/wQuF5VIpDXbGaWX+kHrWMMRYInqrcx5Q65npXcEPlPM/f
X-Gm-Gg: ASbGnctcSNHxmc/bMr7wvY0OQ+MLqTNuop+FcW0bS8I6TBCeuIa5JRUCo6IHgqICEx4
	Umetxj/aZxOM5ut7A88qg3iOvkljgmMdehJVBRe+rX5ihoHeKyuP1jP45k+7GPACOcXr+dO0o83
	R3RPCRPzxmSozvJE6iSbpD1WU01+h/w6xLhoa4eBUphR4N6SlnQEiYnSaa5VCJg9V1wqlo2f0PS
	Dlh4xYnYURo8x6UMX/2kFSr2kEM88WHxNHbfhbbBeOUZgAOP22+UIda91p1k4+ynLHqrwBOODlu
	8Bh6vY/AbxOfePl3jWXw8223Ko6H/TFkHMREa5R0OxBXb7zt205eFyOMfesRybLl9DMTr1YRgK9
	/68E9Wi3jOdYVUWLHzlhd/0pGHatoK/bbHJhjAd821cQ51nhsfzUB+TsM0ZGTig==
X-Google-Smtp-Source: AGHT+IFCWaywXA4laKwHuBxK3xcg+y9szPbeUAo5eHR/2wV7hbFsTBbCwRXsWsz8ZadmzmBc2Nmxmg==
X-Received: by 2002:a05:6402:1ecf:b0:62a:82e8:e1f6 with SMTP id 4fb4d7f45d1cf-62a82e8e4afmr5766936a12.36.1757436884570;
        Tue, 09 Sep 2025 09:54:44 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-97-40.customers.tmcz.cz. [78.80.97.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f90cesm1497326a12.44.2025.09.09.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:54:44 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 0/2] net: dst_metadata: fix DF flag extraction on tunnel rx
Date: Tue,  9 Sep 2025 18:54:14 +0200
Message-ID: <20250909165440.229890-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two patches here, first fixes the issue where tunnel core doesn't
actually extract DF bit from the outer IP header, even though both
OVS and TC flower allow matching on it.  More details in the commit
message.

The second is a selftest for openvswitch that reproduces the issue,
but also just adds some basic coverage for the tunnel metadata
extraction and related openvswitch uAPI.


Version 2:
  * Added missing tun_dst NULL check.
  * Added Reviewed-by from Aaron for the selftest.

Version 1:
  https://lore.kernel.org/netdev/20250905133105.3940420-1-i.maximets@ovn.org/


Ilya Maximets (2):
  net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
  selftests: openvswitch: add a simple test for tunnel metadata

 include/net/dst_metadata.h                    | 11 ++-
 .../selftests/net/openvswitch/openvswitch.sh  | 88 +++++++++++++++++--
 2 files changed, 90 insertions(+), 9 deletions(-)

-- 
2.50.1


