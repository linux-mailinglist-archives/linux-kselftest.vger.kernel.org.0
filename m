Return-Path: <linux-kselftest+bounces-40835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962AB45918
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265B65C4B68
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089E352FF3;
	Fri,  5 Sep 2025 13:31:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647528C006;
	Fri,  5 Sep 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079080; cv=none; b=cH8f3pusQMaXsuRiKkw6/rfS/V2VCR5hPfyQ2qgtioYDE9/8khjiyjTEf0JonK5v344cUe3GqJFJrcuqf/xfC4BoydmIOjqteTU/t4a/AzDCPZAIDhdxCitrUiykPJXbtnyjfJw5SB2leUUbyqjvRwejQtXDMsc8nkWBJENimr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079080; c=relaxed/simple;
	bh=NoKwmTJUYLKfmC/7JQpmjhqcq1JUe/w514iDj8S6SUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bClj9VnoBlLKE2ps1NRO1VCa8IFpinAiHSAqxseqMxuzOVkrQ9Rq7B/C9OpEcAE5F77nEw99l+2UjGd50m8FOvwmUy9LekJm14F8TszlnWXf0s1oTovAqc5XQmAYfeqmP7Vv+wmmiGgcZzrjWK0XzM9BsxJW18k99lDtXKE6Vf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61ebe5204c2so2976652a12.3;
        Fri, 05 Sep 2025 06:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079075; x=1757683875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlcISxy+uYc4UHHLs0ieFDsMJU71g5X/yGaPnL2WT6s=;
        b=vXvz8R5pcDsTZz8f38PZ6j/AVpcu9Qhl15EkquDGKHFpRMdGaDYS+gmJECQkX/yb4K
         5o4Kz8XQClpl09KcaM7GgizE0CmsjF9klhxQ7pvOmtUjX8cpJyzbQh4e85ahNPhMFkYl
         IB0or2pqxaUCmRoobLBuHCuj+KbglVzRFc1Askm6+1i6sk3QKaD9BPDP7/95TFQXO8nq
         tBptj7bKSFj/uaVYfOFokM1Q6tmZEF4Wbqz223YHCxNgxaLVaYSVyNQemqZsKqyNvZHq
         UDMJM0cL4ISlvmR6lqDPmSHbLk0jyDdxw64TZ7x1PvhaXNovcdc6f9qlVxdzUBqBQDlh
         frOw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwF30dKfZPaG5VuRS9ens3oU0pnh8k2FVDHz5Apr5pvBA6z7sbhBKdS6pVaNY5zMpDGghB1Vh7JK7VCGfNStM@vger.kernel.org, AJvYcCW6dw0Whibyux3feLPj3TT7KvDJSoOv0WZmNE2Sa429xjieqqN+h4sP7UkeKtVmuHCtsbzhJjcTne2tIU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhqRWX1QUwOx7z3K6XzQvEHP61ZocDPGBIiOFCPB04y7WDjIL
	wNWs7Db3oKBJTL0naZWpX2OGkC40gljXo1mIF0IX8sYx2pKw55meT+dxQR95dNcI
X-Gm-Gg: ASbGncszSgM4qZejPr4/6icI3yJv52C7ssOtDFJmrMid5uvNG1L/rMFc6vb+BMy89lT
	p5qSshfTQVzt/B8eLedDCLOnj3Uuso5X2LoC5bFSawXPhow8UunVLLc0afnc4J3eKVuSMKS7dyl
	dCe5jVBSZU7bL8Ov2TFQQmlLWaWwMU/nM5s57yfR6nGTVKRjfip3gsbiyYMF+2OK/6BNMKWP99G
	zlYx4ac23ki75mriINbAQ+cJSJIyWHtosaS7ccM3uMVZ65ZVFyfO+LzbW8JA1aF9G1Cgjq+XItu
	uvIZcIe9uLyzWeAhY1L0anTJeXNbjA1GHy6F2K4YEgmx0nJOBbQZ2o1Pdc3CDKy7wJkNAT1O/UV
	n0Zlqd3AhhIFwvEeSDkIPpNGprPwh4L9p6aX7lFSUmCRgUQSd2oPN9vKva6rcARwwv2YEpw==
X-Google-Smtp-Source: AGHT+IGa7IfkD/aIr4kqAr+Fq82wH+IojkpX1q8y5Ai6Tb4PPaANZsPAX1Bl1reQBUK0yfYgALsjOw==
X-Received: by 2002:a17:907:7b96:b0:afe:d6b1:a87b with SMTP id a640c23a62f3a-b01dd005dd4mr2205012866b.59.1757079075280;
        Fri, 05 Sep 2025 06:31:15 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-56-72.nat.epc.tmcz.cz. [89.24.56.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm1547277666b.85.2025.09.05.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:31:14 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 0/2] net: dst_metadata: fix DF flag extraction on tunnel rx
Date: Fri,  5 Sep 2025 15:30:54 +0200
Message-ID: <20250905133105.3940420-1-i.maximets@ovn.org>
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

Ilya Maximets (2):
  net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
  selftests: openvswitch: add a simple test for tunnel metadata

 include/net/dst_metadata.h                    | 11 ++-
 .../selftests/net/openvswitch/openvswitch.sh  | 88 +++++++++++++++++--
 2 files changed, 90 insertions(+), 9 deletions(-)

-- 
2.50.1


