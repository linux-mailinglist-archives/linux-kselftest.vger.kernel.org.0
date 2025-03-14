Return-Path: <linux-kselftest+bounces-29059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A51A618CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5287A8F32
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437A2040A6;
	Fri, 14 Mar 2025 17:59:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C5802;
	Fri, 14 Mar 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975193; cv=none; b=BIjm32KipcKgg0CVEk5npIXQWqcy0VTe8Uwkbkx4JGYYzcZq3aTGfHIBS9V8OYwfFGQEnahBqk43aBnld4D9VHdH4r/r6WJJeRdn8c8SOmugH/B+b8vl8JGxoYlrzeASXXUYjWy0498rEPFDHP+oR+wJH5REQs7svk0jWBhVtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975193; c=relaxed/simple;
	bh=z+hyA79TBor9nfo/BG+geJXkAW0YDbn3zU9dqjRz9+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qLx6vllV1xuunwO172HjBR7kzNdypRDay1UXFYRaM1iqtTV9bOlfQa5dQOMcIFgGtP/o8A7SeOMMfxmD4aoKs6CxxGbzUn4a13x/jH370jSFtd/xeJGjvQMHTiFjApLQkkh0Y4cNuW7hHfndXax3MDAau0tlO95i5LxJ7VdRRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so422965966b.2;
        Fri, 14 Mar 2025 10:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975189; x=1742579989;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u06Wqt5UnTCx1/rDxRjIUZ8ark85C9sk7HH7Q+RzTx4=;
        b=i3m965UEFesfuMHqRKbPTZcNIgAMpGlRqD8s4kcxGAt0sQ/hUnIzNvuRsYn7I/ps55
         McROizZXpoJd7rXBnl2cNd6yU87p0Rxkqh2ocsDPnADUUaR9nCHlM37tAaAuwNLgGm6t
         woCV12gUpFzxEPizvhDTS4OoGIC0GregXCVCQu2TfJ2ZVfw8bMkPeIPVA3fbOdb/9kqD
         xDJqaGr7lN5kR9O2K3oIiZyBhbQohAJjRDedigw8Nb97+V0xOKhXxL13AmD1Nml5u7g9
         OV8R+sbMageNOYFORcSmbd2o2Gi5r68PqWITUqRZTVj/ANygcRhSsKZPA41N2zi27sGc
         P12Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFZDGEUGfZOV5rVQ1u3fbTd3kU3jE7y4SFqMjEg7W99egb1gK1in+zBmkc+2a9gR0FchF/X2V3LOM=@vger.kernel.org, AJvYcCVb3n+dIPfQ8UWwRjGpL+y2hYEK3H2NZOw5Ja437g1hc/lx0/QSETitb8jsAnysyI+eP+N+AD1wjOb6PawJC496@vger.kernel.org, AJvYcCWbftD7m4juOPLiVvYeipWamvUpduMqkCK0rDO/Bgfw9oU/rGwVXWHYsZ2I5NKzC0uI+1Z/6zmeIHRA2gby@vger.kernel.org
X-Gm-Message-State: AOJu0YwznLxIFJyT34igIgKpXvuRiBDCYTRzE7LjEwQEZAwwtYjcjXOX
	tzmu2kfuVvY2TCxoKIyU3xaOSBidC9Mlxi9kr/DGFnZ+0xy+6HJPb4tCVw==
X-Gm-Gg: ASbGncuVVTnvOBrfzRRanIE164kC0PK6CwMy4ukzwF0RfQhgRmKQLesmWncOedHus5L
	RX9cZXxgL3cHCpivPCX2gA5Wyfwpjf6lRSyjZsrdNKSDNfvuDBBK6Cpey5K8iK0z1OyjCG8bvwy
	7KYn6urm31r3yrNNemrfAVuhzHRT863xbHwPZ7+I9/qRB/cBMrkLKE4QiS6hYae1JY1Lo2AXo4N
	2dDrVMfukZL6JREeD5DfLa5MYRI00LI/Wz6BiN8Yi5PR23fZHmY4k1jtHnFHbG1aGThNh531HT6
	k+JB+PiJn21as914bgsMLp5vp4bpznt4
X-Google-Smtp-Source: AGHT+IFYDxKMBWIGzBC4CKcYNP3rqPlnMH3TYElMbnrF8utngO3Q5U/WETtPDhdVpn1KtZoWtTyV2w==
X-Received: by 2002:a17:907:60d3:b0:ac3:1763:cc32 with SMTP id a640c23a62f3a-ac330272de0mr357638566b.29.1741975188697;
        Fri, 14 Mar 2025 10:59:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0b4csm252667166b.122.2025.03.14.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/6] netconsole: Add support for userdata release
Date: Fri, 14 Mar 2025 10:58:44 -0700
Message-Id: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVu1GcC/x3MUQqDMBAFwKss79tAYpVCrlJKCfHFBspasqEI4
 t2FzgHmgLFVGqIcaPxVq5siShgE+Z10pasLomD04+xvYXLKnje1V+OHyeiWHEooc06+3DEIvo2
 l7v/xAWV3yr3jeZ4XrJYGqmsAAAA=
X-Change-ID: 20250314-netcons_release-dc1f1f5ca0f7
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=leitao@debian.org;
 h=from:subject:message-id; bh=z+hyA79TBor9nfo/BG+geJXkAW0YDbn3zU9dqjRz9+g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6S4a+zwK4lGwwA+aGwJjrXmT2MwHOv+zZrA
 bYT+jmp9b6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bWu6D/wJxlbJLBPQE4vG6FDiDWy6obPrTsCZczJVm5bojuSYwD/uo7BNVU/twjlWGYrinGY/Kwk
 LP4y9m3lS0T2C+241+BXHobAoJVxelun1i6bt1MTJ29cAoeEmwN38buPBmoIKJnYOz9UCPn9ZLF
 cEm3VEJzIH6iCdHwlP7qjbLT30Hdcqugqbt5OrWHcyDT+yK+ZrPh2leNq81EWGdFZB+meJO/RWW
 NduRUCalj9CM0v9jlR/u6gHuNs/aTr+Qf2pievPpT+j5H0N1XJtLg8xbB832HFtcTwcHOhb2umh
 vasUpsRTfBpnf/zHq+GLigb630wbsYh2oPsAuGQK6IVhJMown2OZnnfMq+bIquCqnYwb5WeiKhs
 6Zmoq4W1sBpbhcPKxIxzkEcK9PGMETzTeVkHAYwCluISQ6HV0DiQ8p34n1hj8p5d/qVhnZwy6nG
 F5FLD1oIGeNyaNUTRBSF8/RMrPicu5PzhoBy8J3xAq2IjeApfEvZz+uDJDUoahC/7KJNXn9Smga
 nRPWVI2ywynhiTgQWSiZEzznfbRu2y/v5GeK0MYBKc5HXvoltJlOhLdjISnVie7x4CjY6i+boZi
 x5PXvkWjvVeIMsQOtgitg+ICE48M6IcxelWdnaG6PXaIrskv0Et6N8cqnxMX+++jtlFy6DarKsg
 MrEVh2FsQIwuKJA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I am submitting a series of patches that introduce a new feature for the
netconsole subsystem, specifically the addition of the 'release' field
to the sysdata structure. This feature allows the kernel release/version
to be appended to the userdata dictionary in every message sent,
enhancing the information available for debugging and monitoring
purposes.

This complements the already supported release prepend feature, which
was added some time ago. The release prepend appends the release
information at the message header, which is not ideal for two reasons:

 1) It is difficult to determine if a message includes this information,
    making it hard and resource-intensive to parse.

 2) When a message is fragmented, the release information is appended to
    every message fragment, consuming valuable space in the packet.

The "release prepend" feature was created before the concept of userdata
and sysdata. Now that this format has proven successful, we are
implementing the release feature as part of this enhanced structure.

This patch series aims to improve the netconsole subsystem by providing
a more efficient and user-friendly way to include kernel release
information in messages. I believe these changes will significantly aid
in system analysis and troubleshooting.

Suggested-by: Manu Bretelle <chantr4@gmail.com>
Signed-off-by: Breno Leitao <leitao@debian.org>

---
Breno Leitao (6):
      netconsole: introduce 'release' as a new sysdata field
      netconsole: implement configfs for release_enabled
      netconsole: add 'sysdata' suffix to related functions
      netconsole: append release to sysdata
      selftests: netconsole: Add tests for 'release' feature in sysdata
      docs: netconsole: document release feature

 Documentation/networking/netconsole.rst            | 25 ++++++++
 drivers/net/netconsole.c                           | 71 ++++++++++++++++++++--
 .../selftests/drivers/net/netcons_sysdata.sh       | 44 +++++++++++++-
 3 files changed, 133 insertions(+), 7 deletions(-)
---
base-commit: 941defcea7e11ad7ff8f0d4856716dd637d757dd
change-id: 20250314-netcons_release-dc1f1f5ca0f7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


