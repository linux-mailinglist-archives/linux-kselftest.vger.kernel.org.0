Return-Path: <linux-kselftest+bounces-44828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22BC37023
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219B61A265EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879E337BB6;
	Wed,  5 Nov 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZQ1StzT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CB32F74C
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362428; cv=none; b=u1WtB1h7rQQzEL/hvcLC0aA114GmYjJpvB59HaDHJPePkvXrI++fgsft7zwvvdt+DVvwsQj72Dh3Ewd1MWKW6ivUrTn4cRQJmBDmvArjr7yRBkHPoHkEDRklBbUNDtSOXW6nP/mUuN+gloYguYLMo2RYHlAKXtdkAU+phiFs68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362428; c=relaxed/simple;
	bh=30t5zBtaGQTxkltEhveJdNA/C7vUJtmxHeQKBmULzL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PaxUvSFTg8UCLfGXu3+1UKulGk7P38WyBlznwPDG1o6WA5k1+5foko6hMddSHenRP+TSfmH6ktYfPvo+NRvhATfl6zgRbAnu/nXow1++aUWK9k55ndqcd1nEr4sbp1nYZHYkyhxL9dI49svP7y0HCCHK0q0TGTuoXDr5/D9Xxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZQ1StzT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775dbde730so15305e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362425; x=1762967225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KlH5oH4aa9xdiatpr7ssWlzRF67+KUJgkYqzSsS5JA=;
        b=aZQ1StzTzfUHcphbHnNYEC9Cs8ysFOMY0A1WezAV/DYvf67OG+LJX3s7PDZBd+RAKG
         IxJALnUx+fr4HZbGP3oNrN1CM/m+r82XKcycG0uzf8jFAHA3BhMyNvOcx/4Wmgq6NpcC
         X/PC4Z+G1b21S8jJ82RPm5vZTIzX9RdNpcuJv4ag7cKcKl3dkoI+9O4HeqlDeF9SQSBk
         XXqQZ5oazFt2E7ladl/v1NwjHdbHKM7ZR2WQ9ZgJOPy24I8bmj+9zFOiQZ3DVAVhCr5b
         p/ROw52D/ZuxiW3uBP3ySedD2XmTG3x9B5luNvPkePwCuCA5raPHnReuAfwIrUaf9tb3
         NLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362425; x=1762967225;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KlH5oH4aa9xdiatpr7ssWlzRF67+KUJgkYqzSsS5JA=;
        b=s0NoPuIICcdqqtK9QWMbCnpLWXNm6FPJqYcsWy7wFZkc7xPtLd61vAvLh0BSzxPglk
         xh/l/nUm18b0cSz97TjrIfuo+PpB5nnX1KyxL1FS1qRO7DlrEfr3AOx+/8w8dLIG/m2S
         5b8tkZPlX2JopEjA3m91QUuG6rmYkL3IGKwy0O5FOf9wrNrNsDwqLY5NnwKcKWmF/nSj
         rdbnff4JfrCKX11TLbVXq3OZYYZDrPRVeL01wMZ2YaUBSDO/ppYbZUP3UQOMoe6KpfZU
         SaNCEdaPeZAaPVGQoNVEQs4sXSBn50vDZMoQc9DDlsNyaunzcTXs3A0qo27XbOxJkHoK
         hwtw==
X-Forwarded-Encrypted: i=1; AJvYcCW1e/dZ1s/VsBjSDkrj6F2QPF0sC88GeE6ib5bv62Obq5LCBu0b/6LHlMcOEzbbpvx1LFgB0eUu4sIvEYddIms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINaMhbJdHOkhUDgWboVR3UKgxLb3B80O7DHmVZH7hMN88NwS+
	IreRilVfdPAaxavA6r/kQtFk/LNjoJkOu6NuA2jcgNrv3gMMCnGSXVQo
X-Gm-Gg: ASbGnculqrAujOHmNgj+jUeluZ1Jck/LdlBraYR8YyxqF+3cEZNG5siYqYUFg1HjRQ1
	5pVtzDAhw3LMSR+4Zssm57ctLyosteled4rgl0tzNW+VACjSn6onUCrsG7AfuYsML90czb8nbUJ
	dGnye6XwfkKVPCrdsPxT1fURZiO5CLvzXtT6HOndtoj9cAHVLVQyTEw+3smjxyP0TGKw+SEpySR
	1KGAti0G+evBj30Rjnwxgr9nB7aqU/q5LPhfNKiesjtWU9JQVy21QYsCw1j/uI5q5exgbU9ZS9x
	fesjjeAzw0poNLkpnnBsN/OWveS4hB+8Dhf/WvBDzRHXjBpAI7NBBiwp2lEczkTqKUxC60Ux1wd
	GwCMZpr8Dx1nEQbawXiwwRrw3VN373bJfO0ziJxzsSw5WsUWAfnMgcZi0kPtsIAPJ+JWe9PYjiH
	IjHzKvYEOwOEXT68s=
X-Google-Smtp-Source: AGHT+IE2dFdyfyFz3wz1sJuNDVRHLZQy+AvcViqxwXwXlz2xC+2bmQlgIw1MzTy6Ou29bwSkDaIpLw==
X-Received: by 2002:a05:6000:420b:b0:429:c8f6:587c with SMTP id ffacd0b85a97d-429e3276ccemr1752428f8f.0.1762362425021;
        Wed, 05 Nov 2025 09:07:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12774255f8f.3.2025.11.05.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:04 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next 0/4] netconsole: Allow userdata buffer to grow
 dynamically
Date: Wed, 05 Nov 2025 09:06:42 -0800
Message-Id: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKEC2kC/x3M0QrCMAxA0V8ZebbQFrapvyIyYhM1oKm0ZVTG/
 t3g4304d4PKRbjCedig8CpVslqEwwDpifpgJ2QN0ccxeD875Zay1vzihb6Kb0kL91aQsKGL4UY
 nmuM0TkewxafwXfp/fwGTpnuD677/AGaySZl4AAAA
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
Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

 drivers/net/netconsole.c                           | 338 +++++++++------------
 .../selftests/drivers/net/netcons_overflow.sh      |   2 +-
 2 files changed, 152 insertions(+), 188 deletions(-)
---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251007-netconsole_dynamic_extradata-21bd9d726568

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


