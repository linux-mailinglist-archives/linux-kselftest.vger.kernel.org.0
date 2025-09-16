Return-Path: <linux-kselftest+bounces-41622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DEB5BEF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26B54881ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BD296BB4;
	Tue, 16 Sep 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KgbTqTF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A11E9B1C
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060372; cv=none; b=OM7dJvkiy9yg9hcvVVM0yT23Qu9fqZ33x/6Q/HfqPVAOOct8iYRifWEal3y0/V6UCqq4WlcJENJ+XYE4BI0yJLxH1WvOhrQQ2ShwtXWhT/czQg7EN2vdU72nPqnj17SBNboI5nuKHrFv6ljdrE9hg27+Av5tC7RJ1+MG6/OQvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060372; c=relaxed/simple;
	bh=O6AFxv2rcQekB70jDscAE0h46bRh5B6ciyiol8NPklo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7hDNoYZDwkgcnHiAc2v34v5G1A3CFXiP9uvPPZw/GDffmWXL98W2wsnuTt7F695A76UnmqMNnb1H2X25AJqv0UtmXrWBqiAo2RrUKSclZaxYgnvXKK9p25iVCIGT4nJCl6x6hDfP6pjhGJ8Zb2aR7lOAhm/Ucntk3p2u7fK0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KgbTqTF6; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-267dff524d1so7917985ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URU8cpb810BL84te6erVF0rZVZMOdMRIWlwwvewIU3Y=;
        b=KgbTqTF6tVUPkFmJfbH2XBJ9uf3YITRO1ppHLk0ksS4pdQKHfc2MWvtwnLFzFP3Vp+
         aL9N/n1q6prjlkEoSGYCijdRqYUcLCWJrJbbG7kLDxQVZEMNlLc9VZiA1nz12WOMf7WX
         GQS6pfj7EvQvHDk3qgXkfQ0Qf+55mG9+BoJsFDPKeplOoP24kuFvsE5Kc614hoaXOO6n
         BvF3f02WRWBxw8SeKf3ffhId+j5vGhLLcJ7FuPJphZfFjOQhkStwQCYDRDp7W7O7rcMn
         IDpNEFcT+eucLg8YQWw6euo5MydBMRW3llBBjxv2ud/S63UuH+yJLii5JMDotNQEfJv1
         oWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URU8cpb810BL84te6erVF0rZVZMOdMRIWlwwvewIU3Y=;
        b=cjbN/TydYD45aSGQC4x6JW92+SNoFaCRAbPQDdYOHUXU7s1cBp64poaO2H0CpHYOU8
         +nyqUwOpzzVi38ijZNUzxj+7M4689cWTyBqzual8gkCd8n7ssaN+xvGKvrStXgk/MY1d
         rZzE0FJUgPikpTrmxdE/Kc2I052o9Nt+t6TzCpxM7fLOexVs4Slc/k2MSwADVcdpAVJd
         kyA4kpzfNh6/swukNTS0FPquVfWw/fT69X5M36CRszaSv5FztIAV9usFXFRK4fC5WzWa
         pvqXmD5jAjO7gaRd31VGKZ6gHuxVqK4DMpDYRBXWJ5NRhIYcqluHqaJA0Kgn1F6yi5RA
         +gsw==
X-Forwarded-Encrypted: i=1; AJvYcCWNOZfF/4Dy4q1NXp6M/5BmRJEd0C3NlnFn9kEh7sOhKZI7LbDtD5NgCawThrjRhS+ai6yWIsmb4TvGH4LH4Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjOfkMGxxJYqibRvURbHuf3l/H5XHB2VfUTA6D2RF8xYXZgVD
	rkUxnfxPUxpaT+ooO+QYEE3cQ1jHp6h8qJXcLiiTI0ugHdPzzlXm07ThKqpwtDl0OeG3dpo2soM
	xQU5BD3HIHx12qHIRsPvxoQRcCSW+Ecp+a8or
X-Gm-Gg: ASbGncuIoekMW9GK/tz/jLIupGM1+vwfCkLSUwLz/n35mhCKTpk9gGI10SphvEB6Uw3
	sI3nYpvL7p2YkwWYft5Eru2467+WlCESFTKPzj6eeDTG5PsRfBeQuvPsGz55kk7FSzjSq6CLfMy
	12ywHWLEmYzdpQMAixAki84ZwuYbnNM/tJRaZSPDueLtujjgHJLwA+oDtjF0B1eL4vrq2jYkPBU
	J1MUlsrh14oI1z6HyJdhURMfKwretEOumkFNnJZz5jASISlOQkwQAyi/0YfaBSxL+tgulUIna6X
	gSj4620MKQ+QLqWPFc5RDtWRbLm4NdMjnEDEKCjrMFTu50UO2qRfdhAg/A8p8uBlLpBYphdJMA=
	=
X-Google-Smtp-Source: AGHT+IGhjrS0yeLgkgtHFsVSqkeM5EALRxY7xkF7ANB453NveU5cvNrdW/AhOprgzqEc6fqLFtySHktbSA6v
X-Received: by 2002:a17:902:d48f:b0:266:702a:616b with SMTP id d9443c01a7336-266702a6ed5mr129310065ad.18.1758060369693;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32ed2673d71sm63225a91.2.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C5CEB340325;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CBA08E41748; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:56 -0600
Subject: [PATCH 2/3] selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON
 to feat_map
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-2-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
feat_map, which results in the feature being reported as "unknown." Add
UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
+		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;

-- 
2.34.1


