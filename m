Return-Path: <linux-kselftest+bounces-33687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3BAC2BF4
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E1D1BA7CE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7202147F9;
	Fri, 23 May 2025 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GP5T/Cx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053E20E03C
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041531; cv=none; b=t1StdMOm3DZhpKxwabUah+j+B+qChoXxFPRbKkrFrOdP7+J1ZdfrKAWHC6GJadYa7JQicAJLjKOwKwiko1Tl/i0r87PRNkl49J2Y8WO4KiKszwqSppTWrY/MxbhBhVzB2b6rXK9ZsRZUvy+ZrR30nhJc2UTusBbmQV0yu3J6f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041531; c=relaxed/simple;
	bh=9rYPKS3IkwaspgeOz1hzpgqqYYOG90/XOMW2S+mD9cs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jv6Qwe8SLL7u5GDXKGpcp1q6vNlA1+XDAWwgpX1lvmxYtNoFvOg3xBJQY7ugYN3LslSwgvBMahRcNuPb/FpkAQyN2I8Qt/58NjkMetzX/nuz3M2iNv3/EX/OjmTnSAHJA01VJGJGj9W8dSV5K/xVMHZvAoB/dpdsrdfYx9uQZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GP5T/Cx0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9338430eso267851a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041529; x=1748646329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icGujaXCVLgdWaCxrvdB+Dto4Xl/Q6c4Aw4p2a3+dLU=;
        b=GP5T/Cx0mINMDSblRxxLBV3f5Kpm9c3UZt0K/4cVFDeXtF8VHLmDPV2W784d4UbAE2
         bJPdj1pb8kjtYn46XxsHiVo7GetFdxG1EYUyAVAcfgkdClzxVcoukcX9PaarmIDtkE/V
         +V2OWqIIaDnRmFfXFWOSQVNkilJgILS5mFkmibOAGemnahc3TILLgVoonHScAUk950pG
         Rabatm1B79CeTEUydi3Fjm5L0qO+CHBRxFCt3v1ZorDLXXEZQHzg9Z3grTRQ94ilzvPM
         nLya3I8tQ90JHOW/pmSFKp8JB8zxVLAFr7EmpcLLVHNZ6xo+pNGQRUaQe1r0dbaBXHSQ
         iPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041529; x=1748646329;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icGujaXCVLgdWaCxrvdB+Dto4Xl/Q6c4Aw4p2a3+dLU=;
        b=ki5iptLJps26tXLhZ9c1VQeUc6skOKTR/o0bz6VMFW+7FAJ1r2FJTFcCq4gfn6/OVX
         Kx+G3M1r2dBGTx1IZM3XqqU4PZmo1tkXTtQ/AjU3gWF8e/8lBzW/rMFboV+Xm42TThcJ
         I6Iw496EJ11YyAl1Vh5VYGUCGwBWOI9N/IhBUekLT1geN1DzmeJxR2NLGZam+85D4XFr
         IdruMfn9QiOeMSfT5Aov/ecI3bV3NoQq8ekMDebpJYZPocipXvR5CmOsUdB7jG2ucuwq
         CByHjGt16eMhH4dMFN5dtTmckSp/1KpDl4fD9lTpc51sS6HaVU/vSUq02iuVCcvEmq7V
         KfGg==
X-Forwarded-Encrypted: i=1; AJvYcCVl5vZQksPour+vPTLusiJeZWPFBASM4huUfcOVPqTKarIsg1OyWswAAJtzcZU8AEchasvNc6KEAagj1ffsDSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51IZG5d6+/+6+U4Sjnyhnfe+rQHVFasZ3zfCp2fpPVzXzT9lg
	piSxVacbLmaucC5Ei2tOLrHiefg2Cw5T6AEPKNuIqDxJ2dzlc8j/Bql4kibVQvErG0lJcuYuAID
	O53xUjEmN3+g03Bw7ujlD5SvjgQ==
X-Google-Smtp-Source: AGHT+IGLCJYSb/gerbp2mnm8tKrOMIQ2qPWJx7DGYLvN0wjem5BMDpyyR/OTnhhele6VXx+h9t/DQl3dRZlfO9Ir7w==
X-Received: from pjbqb9.prod.google.com ([2002:a17:90b:2809:b0:308:6685:55e6])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33cc:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-311103c1461mr1207377a91.19.1748041528770;
 Fri, 23 May 2025 16:05:28 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:16 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/8] Devmem TCP minor cleanups and ksft improvements
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

v2: https://lore.kernel.org/netdev/20250519023517.4062941-1-almasrymina@google.com/

Changelog:
- Collect acks and tested-bys (Thanks!)
- Drop the patch that removed ksft_disruptive. That seems to not have
  any relation to behavior when test fails.
- Address comments.

---

Minor cleanups to the devmem tcp code, and not-so-minor improvements to
the ksft.

For the cleanups:
- Address comment from Paolo post-merge.
- Fix whitespace.
- Add improvement dropped from Taehee's fix patch.

For the ksft:
- Add support for ipv4 environment.
- Add support for drivers that are limited to 5-tuple flow steering.
- Improve test by sending 1K data instead of just "hello\nworld"

Cc: sdf@fomichev.me
Cc: ap420073@gmail.com
Cc: praan@google.com
Cc: shivajikant@google.com


Mina Almasry (8):
  net: devmem: move list_add to net_devmem_bind_dmabuf.
  page_pool: fix ugly page_pool formatting
  net: devmem: preserve sockc_err
  net: devmem: ksft: add ipv4 support
  net: devmem: ksft: add exit_wait to make rx test pass
  net: devmem: ksft: add 5 tuple FS support
  net: devmem: ksft: upgrade rx test to send 1K data
  net: devmem: ncdevmem: remove unused variable

 net/core/devmem.c                             |  5 +++-
 net/core/devmem.h                             |  5 +++-
 net/core/netdev-genl.c                        |  8 ++-----
 net/core/page_pool.c                          |  4 ++--
 net/ipv4/tcp.c                                | 24 ++++++++-----------
 .../selftests/drivers/net/hw/devmem.py        | 18 +++++++-------
 .../selftests/drivers/net/hw/ncdevmem.c       | 16 ++++++++++---
 7 files changed, 44 insertions(+), 36 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.49.0.1151.ga128411c76-goog


