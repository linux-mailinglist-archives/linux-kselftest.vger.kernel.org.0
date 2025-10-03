Return-Path: <linux-kselftest+bounces-42712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE06BB6911
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAC819E2616
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8787B280014;
	Fri,  3 Oct 2025 11:57:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D6266B59
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492642; cv=none; b=qqJLNCp9uyrtDy2BRHleFAfSC72nm/+vt1OochDW7/u3WtDcTX0LxkalPmZ+y/Kb0F+imO6i2BIGLZxspxG0BZt4JpuF48hma9JBgiDgNv0JPoj3Zfj3Mrk1iz22r331x+zBk6sLgqKTGLbvEO0YZteWK4FV6XOdzwSMrk/9gQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492642; c=relaxed/simple;
	bh=h6er2ckpwVF7GuNqAHxEQy4OA/+J1C6yr4ND2RJuFwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fyHduCaghZd3g70g/MG1brJHG5HCr3rrh5d1o6KM9JpSnLBB7Qz5+eVKCdN1y41514vJVrA14hJTCU2HQ5bEZU4IO/UQ4SdM0zIRqh/mjKCRLyTWh53vuJfM7pmqxFBqqG0eETn9AMv0ETftPGf5C/z/2IyVFlz5Oz9poZN+CV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b256c8ca246so475011266b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Oct 2025 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492639; x=1760097439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/RwV8Q4hBWil9Gk7UQBXPk1Pu4CPKtI2/nJ64HEYjA=;
        b=FNabyMdYqHAVvLVcFLa7A8lQcwTLbgrCYE1WNWMRCzFkWWmnTMunCy7w01K57fhpne
         d8TKvOmqKHXQH0S8hV3GiGnKfhgAiiaFzqWHE0aLjZ3RGoq2arvDbscHc5CpcWekuNsU
         UiwEA/mTWz0uGgVzAjaPnI7JGdi+wzokC0As2Io4Ci+ZD49VW4M4bOSVWjN5Gvb/wsdX
         /M2Mjh0heFAQkDSYG4fU8fsSZmZMfP+NCFy3S2Wqsp68wSpGa0+KH8ellMmXv+iYFTeJ
         Tad5mnKJrnk2QxjPdiFdMCMYCy5D7a78zolubK9LH0DF/AC7ez19qZauu5PD/b9veaKq
         7M6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9P3dn7qpW6/uBuf2k1/j+wLP8iB8e7HnMoKNGzNAsPYff/9us6TRLnwf36YshkpP8nqON6U6U7LHkx2X2rVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7DgphvHCt7bmOeeHdBVmNN0WxC0otfn+t+BlyjZA6TWaFAt4
	euSITdbpC8imdd64MHnC/qwjinW1AaX4XqkcDcvGh0uou5wiMQgP2T6X
X-Gm-Gg: ASbGnctCNQbhi2E+0R2bwXontUo8m1K8p4LI8bFOwhnR7YjvcLxTzDHTU1iBVzMz7q7
	rMcTNm+PPTTqACAvwWLAEhdcNlilyuBjcBChalM/p7Fou7DB8GDr0nsol52sVFCXu1CuPTWD4h8
	NK5Q8fjY51fnk6vdT+6oe/EnHX26VEVibBPSGXvEKEAi25afwNMVS8+8mUfhfs+mbgjyKtLRypu
	qwOqcqlSkN8GMOPQ1kZfKegcaMzLh0ViKp281EhA/v2imatuhX45a5D0GcSyGqXkRvzHz6bsm/o
	jD84FvsAHuB/l33zHZKQC4J6cSeogIfHm6dsusoBvdTDIY0/hMz+DNmin95HdqCJ9Efg0lqIQrA
	+gBhfgiWNCsa2B56ij+/b/HAAtOB1+zu5d8FtUz4kjqkDOZ4=
X-Google-Smtp-Source: AGHT+IEBrRSxx7/yWNcZNy8YRDCLrMWcGHLTzaM2/PNk5nSyIVA/cP+iPZEBnhkQGX8ARqi8DjEZGg==
X-Received: by 2002:a17:907:3ea1:b0:b0f:4ae:c83 with SMTP id a640c23a62f3a-b49c4498ba6mr344101166b.63.1759492638759;
        Fri, 03 Oct 2025 04:57:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a684sm421586966b.52.2025.10.03.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:57:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v7 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Fri, 03 Oct 2025 04:57:11 -0700
Message-Id: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABe632gC/33QzUrEMBQF4FcJWc+Vm/+0K99DRJL0ZiYgjaS1K
 EPfXexCKq2uD3zncO58olZo4j2780ZLmUodec/chfF0C+OVoAy8Z1yiNNihhJHmVMepvtLLXNv
 83gh8TlJlDCl0Hb8w/tYol48NfeIjzfz5wvitTHNtn1vRIrboP3MRIABVsmit6Tx1jwPFEsaH2
 q6bt8i9oU8NCQjGOUODGZKy9mCovWFODQUI3pnkMsVBiaOhd4Zwp4YGBAwmquizF4kOhtkb/tQ
 wgOAcSUMYNMXjDvtjCPzjU/v9h1YxG5lt1L+NdV2/AHrD85kOAgAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2814; i=leitao@debian.org;
 h=from:subject:message-id; bh=h6er2ckpwVF7GuNqAHxEQy4OA/+J1C6yr4ND2RJuFwM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo37odxqpA+Bf5hgG25++y6b8FaPNRtqZCUr/ay
 00v+QBdVMWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN+6HQAKCRA1o5Of/Hh3
 bRkNEACIT6uj/iC4elMIBuLj5AIVM8ML+EhKcTH/EJDXfFAWwVViRTCJYYOwnKP114T/phZVedn
 ARbxrO/CAiuVV/KE4XX5cov3N0oD0IixD4b6+Pzyi1FxdRMbpsJ1C6pZx5kwXm75/rf21BS0vkM
 Lv08oYaIKrbtotGthCuEWjSWLpu3lUV5xAjd4VmZrYrXncXsCNOs0nUEknpjLmy2cobwDY0gOox
 m9bJPSVKK4EFGhjdAoM5FECpO6CXpWUbik4nenqtTJrnZNQtdEbBIyEJcW1a5nhZUwVB3cZz8Yd
 NOfuGIkACRF64A3sfOx2uayTHJpPY8eDNmIub1P13fIJEPhb2QZ5qNWkb9aliVM0xj3QcYAhaKK
 RXkrlLDyoXgOWF2GC3Ehi+MoCYLR8EinZaegb411cBoljTaSTEULI3D98XZYmIk0J+IHgwdjnCG
 O8g6ixgqTYN58QS989ZXvjL/b/Qpw3D0Rt8xct2GcmJeNRNwqokkfJP5iPNHIBfLcztq+NhhrQ4
 W2shjO7Hj8wqHJ/xlX37LZeK0yUYJH213IpE1Jx1DikKB7IDl8ozxlsrmk04Tjt2XsoQ3bE/zzH
 mufB1QtG301tMBRR0aek0m5VTNrTwwT8MbhGaJEHygNKBhoDDzWIvkiH+8Utnf1r10ixPMxfXCI
 JYl5qYFAhntecAQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v7:
- Rebased on top of `net`
- Link to v6: https://lore.kernel.org/r/20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org

Changes in v6:
- Expand the tests even more and some small fixups
- Moved the test to bonding selftests
- Link to v5: https://lore.kernel.org/r/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org

Changes in v5:
- Set CONFIG_BONDING=m in selftests/drivers/net/config.
- Link to v4: https://lore.kernel.org/r/20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org

Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 221 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 188 ++++++++++++++++--
 .../selftests/drivers/net/netcons_torture.sh       | 127 ++++++++++++
 7 files changed, 530 insertions(+), 20 deletions(-)
---
base-commit: 7ae421cf78bd795513ec3a7d7ef7ac9437693e23
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


