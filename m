Return-Path: <linux-kselftest+bounces-46029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02FC71847
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFB103490E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959F136349;
	Thu, 20 Nov 2025 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOIB5VMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE732BB17
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597728; cv=none; b=rG1LF2uoy259ObP97kY1c9au1c0plokIH8WNIgRyvd0rLgUR0cOA+Myi/jziEJoea9Gh7fmXgb5XTCNAPmjef0KweQYRXciDkprQNL43NUeFLnfk8sbOqPg9GQsFGsYKr7+zOChcBvofEeVwWW+bzKQ8n9KnxpkwFbW/XbLrf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597728; c=relaxed/simple;
	bh=ZWbIRr7n2aoMbY8heM7aapqtIXZdjA83PeUvT6BwCdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FTqL+l0TEl37OPJ/EzkoV9DL1vbynWpFYaxfLszzs8dBHQuG60fMsHo5wCj5W9U0D7xg75a+vVGtC3IMDxVJoDm3KQMK8SjVwKGQLvm0xj0yN+UAE6JBGXxxocaBG1iyk9pxhBbBoi7Zujn7noK8z0HF86TL3TQkiKw13q33LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOIB5VMa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c8d1be2eso38587f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597725; x=1764202525; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGhZ791IGgFpw2D5wv3W1q8tnRzQiHL6cpc8pYhiPAo=;
        b=JOIB5VMavhMC4Avx9GGANtqlP1wnKDieHRJpH7CnwCMIOpnyTp2mDMYmmmwK+Wd2D8
         BJBrhyC3lp0eopSson9Rw9g9qSZViBbG/+Blx+5zrjh3kp/cJPWim6mGLpUIPlbBGlZx
         gFldImLZsSfgLNJDob1RPnE+uS2nLwYv0+rFUdbfdzt04kyR8o1kBM3woKLpHZDAsMUj
         YaesFnNS2hxt68TEAhHOBi9sdUvLPnPJfImqhTnvyDGF49edM522SNd2TVl0nA8U3evm
         mOo0GS0dqzSKAuLWTpzbJoXp7TzPzhtSt9WquNsntoyvRYIjCj+nBequW/zgV/cgx365
         MsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597725; x=1764202525;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGhZ791IGgFpw2D5wv3W1q8tnRzQiHL6cpc8pYhiPAo=;
        b=g56P3dmbS0dwB3kDcNf2JMfM816kGlV7/W9g4V6Uw0x5EM9PNJre+jEch/9LZaoAj1
         NLNs9tMkIpVeF4HCTi/CTcXvzd861Fa+5tm/TH36by0jwolwZy6Qhh0EU8vObZ3x9qMN
         neOJ6sHSxOEBUBGn+tojwqokCOcFqEH4K4iTw9FoQX4fOz55XEFi5CtUQ4mBJJ29ykjO
         O97WOkLdkmbzwb/BsQTzwYBGXRVIiGZkkxkdrcrBOxxDPINWOxZsSEDDjSX2A+u5p7xj
         nTnyl8zMiuL5voV/EC9g/VJrqkzLwn6ey4rMmFES4gbF7idGPEtJkHc8FSp4y5UaARY7
         0VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM0+CrFUa3o30hger2UvJATp9A2T2HzSYs3eOne5lCqz8tQ67qhf/1Wnbs2CHs2HoDXpQDFoiWAt6jcrfLOBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pvvSAa7pRLRlXxTMZD8E+F7zwwG5CykpO7RScVoGCnu5dpNo
	LoIsqROQr2dg7ivSWmFoj+mb3aUEqLP1sYWuC7c3VbkR97QGEUs/Vrzs
X-Gm-Gg: ASbGnctRn47tIYcGVxyDOioW3fLOIATnGd3zQlFwLzafLc/AmAjFzMgvNitnyIW1Svc
	ntbOHKXOHUegI1ycrvX2yrdcVjqp6JKszOPTN+Pb/fqsSMj2YeIegfCKE7rHnI0thQc2myEvxxl
	V9aVb8fRdOl7pq4FUJTI9RvIj8gjyok83o++MwHBBBNg7iYZJKba/u7Re5Bub6i4zAt2bmA6KS3
	S09RK3wXDL9q4un19EuDheUrNX0pmy0OcAqsDz1zt6txj/w5tO3eHsSOAWYorKvZSria9Mw6sJu
	0ZuFzCWiIaVnPTLdz0k2AZN6crGdZizXs3hJVd/5M0kS8IXn72xSnCmQEZ7kXxPGoKgbA9ORz3Y
	7CmlILKFx8gzTgW7Fg3I2+flGhWROjfXm9zMWiqtNEvYfXsvrvZEJVQBqAlxa72XpnIAmZkQiKX
	lNb3cjzcm4ybd4Nny1zufFsmmEniZcUPkKNrSO0Q==
X-Google-Smtp-Source: AGHT+IEMTSv3dIL2/ZMldxuzVoEdRjDPFb3TccQKkSzeYDnuSagtLzuQoAMP2Jf9CdKrkeJOK/wNCQ==
X-Received: by 2002:a05:600c:444c:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-477b8d8e81bmr5154015e9.3.1763597725203;
        Wed, 19 Nov 2025 16:15:25 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b03bsm76258005e9.9.2025.11.19.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:24 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v3 0/4] netconsole: Allow userdata buffer to grow
 dynamically
Date: Wed, 19 Nov 2025 16:14:48 -0800
Message-Id: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhdHmkC/4XNTQ7CIBQE4KsY1mJ49N+V9zCmofBqSSwYIKRN0
 7uLrLrS5WQy32zEo9PoyfW0EYdRe21NCsX5ROQkzBOpVikTzngFjDXUYJDWePvCXq1GzFr2uAQ
 nlAiCchhUpxpeV3VLEvF2OOol83eSlmm9BPJIzaR9sG7NvxFyny+AVb8vIlBGoeRtx4ax7Ir6N
 mMQF2nn7EZ+sKD4Y/Gv1cqxGVEB40dr3/cPZucg2R0BAAA=
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The current netconsole implementation allocates a static buffer for
extradata (userdata + sysdata) with a fixed size of
MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS bytes for every target,
regardless of whether userspace actually uses this feature. This forces
us to keep MAX_EXTRADATA_ITEMS small (16), which is restrictive for
users who need to attach more metadata to their log messages.

This patch series enables dynamic allocation of the userdata buffer,
allowing it to grow on-demand based on actual usage. The series:

1. Refactors send_fragmented_body() to simplify handling of separated
   userdata and sysdata (patch 1/4)
2. Splits userdata and sysdata into separate buffers (patch 2/4)
3. Implements dynamic allocation for the userdata buffer (patch 3/4)
4. Increases MAX_USERDATA_ITEMS from 16 to 256 now that we can do so
   without memory waste (patch 4/4)

Benefits:
- No memory waste when userdata is not used
- Targets that use userdata only consume what they need
- Users can attach significantly more metadata without impacting systems
  that don't use this feature

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v3:
- Split calculating the lentgh of the formatted userdata string into a
  separate function calc_userdata_len().
- Exit update_userdata() immediately if we hit WARN due to too many
  userdata entries.
- Use offset instead of len to save userdata_length in update_userdata() 
- Link to v2: https://lore.kernel.org/r/20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com

Changes in v2:
- Added null pointer checks for userdata and sysdata buffers
- Added MAX_SYSDATA_ITEMS to enum sysdata_feature
- Moved code out of ifdef in send_msg_no_fragmentation()
- Renamed variables in send_fragmented_body() to make it easier to
  reason about the code
- Link to v1: https://lore.kernel.org/r/20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com

---
Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

 drivers/net/netconsole.c                           | 386 +++++++++++----------
 .../selftests/drivers/net/netcons_overflow.sh      |   2 +-
 2 files changed, 195 insertions(+), 193 deletions(-)
---
base-commit: 45a1cd8346ca245a1ca475b26eb6ceb9d8b7c6f0
change-id: 20251007-netconsole_dynamic_extradata-21bd9d726568

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


