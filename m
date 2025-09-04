Return-Path: <linux-kselftest+bounces-40799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF495B444EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4687A8F9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800C30FC0D;
	Thu,  4 Sep 2025 18:00:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422F1BC3F;
	Thu,  4 Sep 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008857; cv=none; b=D2EZ8sDlKGRN6W2U5RECN2r8kmunAQt4bUUmGpjxl3TT5p7tI55ujwz/K9cLQSokGZsRcBABqukFxerxGkYtW4Xf7KbwUm8t0MSBLyw6oZKqlyWdndDwht3TkZv0X8Qm2obOVQmSmgeKAq4hqoVLHKJQ5s+sIE2F7IK7lXL+jDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008857; c=relaxed/simple;
	bh=vJ5gL1VwVWP/Wa59Dh+3eVnLAZFSUVUUExvnrFApKBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KrX5BeL4QYrGpgFhGqG8zftjBfBa8jcrXsvuCTsxXjRl0bQbpNWF8Rc2VXwciWajFKSYQJ+KUl4AEfY7s19BxZogtIGXVdXOkB4ESxv3vP47pEJpFLAx+//yC46pndgzfN6QlNqsxG5fo35/6LL/ZSrTLU4cOSsgj816gRJw1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0431c12df3so232439266b.1;
        Thu, 04 Sep 2025 11:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008854; x=1757613654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3n+ONPjGr+2b1CnAooiYBUOUKVP4hQ3PxC9he43hDk=;
        b=LVTVOxRkvinZOvuBtuScgP8VNs2BFDlYxgt6AtQZVAYSrxinV7GUYmywHU1pgWfSx9
         pwOhh5PyuDMvd+9+YhYkzRvTn3dvWaVvxVJrHPBuWZ7WqofKFafOsQWNogrsedJleDRz
         w+IwO4Df413PY1e9rPfWR0M3ZX+u7p0tz2/U8XBnXHmleKXcuvzgUfB9DKUEdqSQWjzB
         roeW4m/fXKz+rU1Mgm5kr8JBDIkXho9WO4y3bMmJH8ZFo62FTjgMzKryW5SCXmXY4psr
         uHXMkWvk67OCLAff6G7ISXlPGApkBqWRM1DaMRwFvOJa/TNgPBE869kgs7rPPPPWeQNJ
         UBLw==
X-Forwarded-Encrypted: i=1; AJvYcCU1g59m86WoXy27VX26cRV+omZkvXqYzWL5Pmywky8/zes+JpYSeJpmeSkEB3PuimwjiFWUvx721d4PGzDnGv8=@vger.kernel.org, AJvYcCVfVqPbsh9Jeuwdmr3uGjcX2t7T2XhaAEA31DAtN/N5gv/5IHN2lH2+tAjF795NfFP3mmEJMusd@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+7t3+MoymB9ROgbdVIGMGVuhBNKStevlkZ7yif+Z1ZSBtj8D
	FlJzsKV9KuuwINNSF0Gy8sgSAOIo8rKE7epSKwkVkqG1bRqgeiNO7oEP
X-Gm-Gg: ASbGncswv0yCbnLGdOSmc4TixMV0+oTvbldhaoQMTt65jZjzWLiIBkBKbveuyXplpaP
	T6/hFvgav3eTdld0b3nOupGjw3UO9v9eecF5/06QqufwtelMy02fN6eoSWPEl1FK7T9e9YVNprL
	I4N0d+Tu8ZPUByupOsq2Dtk6LNR+lyOB3sK5YeLWX+i3FK2TkGz475avnIraud6n96GutgbOIto
	5/5fdfCcxsjejwOmMJBkJc/NGtx2m1bFgIQyAbqEJA2kdDvklMuBNzdJNHltHqimOZT7gJS8PBy
	sR0iaUgrN/NDGTC+kc3/N0AtPGKY/Qg72ucTkOvbV8PW8oJzQ97nB44FOltMWaNopj+qKVoK/bN
	NdBB40t5JATvGByflJRPdG7E=
X-Google-Smtp-Source: AGHT+IFDJbDeNiudT4GtMsvSqsfgOXkqxOf5FjaPtp8Wa29CBgy8GW7QPb5zAm+EQHdyU3HcwcV8FA==
X-Received: by 2002:a17:907:720d:b0:b04:5a68:8688 with SMTP id a640c23a62f3a-b045a688d9dmr1028869966b.44.1757008854070;
        Thu, 04 Sep 2025 11:00:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04279a59ffsm1070724766b.60.2025.09.04.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:00:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/2] net: selftest: Introduce netconsole
 torture test
Date: Thu, 04 Sep 2025 11:00:39 -0700
Message-Id: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjTuWgC/33NQQqDMBBA0auEWZsSI4px1XuIlDSOOlAmZZKKR
 XL3ggfo+sP7JyQUwgSDOkFwp0SRYVC2UhA2zytqmmFQYI1tjTNWM+YQOcUXPnKU/BHU/RJssxg
 fvHNQKXgLLnRc6AiMWTMeGaZKwUYpR/let72++j94r3WtTRM603Wt69HdZ3yS51uUFaZSyg+mH
 arevwAAAA==
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=leitao@debian.org;
 h=from:subject:message-id; bh=vJ5gL1VwVWP/Wa59Dh+3eVnLAZFSUVUUExvnrFApKBc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoudPUon2VN3/OBqKOFjiJSB2CbK61HWIXFlXlU
 VXRdrV4a02JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLnT1AAKCRA1o5Of/Hh3
 bQ4kD/9JLzOpyHCBfD3XAgPF2GKvY4zX/Sd/NP2qhBQzbVI+UJm9cvQ5ZfMWMEiE8H/yxySSCEU
 3DQy+X+4gxQP6X4eQ76D2x1+9CD7IjAGcCjejg6+Okpfba0iit+5Omya7bzUHqqaSQK9tSyj5ML
 7XhTMNY6D99xJ2ETeNX3cLD+/1FAiMfGehQr41miBfYK1VL0XlfXXojCRhzdgb+xujj2PNBvF3x
 6+gbjQN+B3+9nSUhiaq3GLY6YI7W+0nvy0nggQKrjiwQHmFsgKq7y0k4ENRpYWQXMgj6fr1IJ1p
 FKoefHUERB/qMOM3kiYti7tlONl+1hvKG7KphR6WBGGokeO5YtB4iFFm29M9MP3siOGgKVj9KvL
 e1Hle52NJSo0F8xM1HmrY3E304e3FltdLIzMZ5+S7BNX3HablCPHlihvA8/w8JgOQ75R7UwtaH1
 UHNXrtcwA0Ew9eztkoPn7BPSeO/hKNr/Rgtf60232HzL2aKuOzBaWhXFT74FI6zy0HfJeA9T/jK
 O/LMg87mBPiith3SVSmI+0TkPY/uQWez+G4hARM56qUUld4DTdYdFpYfLlJBL6Hvp9stvsm2iLs
 MxiaZ23ipz50Ri1PWWaiL5w9Kp/RKHc9mVV0SHqYEIMdS1aVwuEdmsydQ1qg1nr33quhMXgkUT9
 gXSX3fNTTZ1WXMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a netconsole test that puts a lot of pressure on the netconsole
list manipulation. Do it by creating dynamic targets and deleting
targets while messages are being sent. Also put interface down while the

In order to do it, refactor create_dynamic_target(), so it can be used to
create random targets in the torture test.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (2):
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test

 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 +++--
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++++++++++
 3 files changed, 147 insertions(+), 11 deletions(-)
---
base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


