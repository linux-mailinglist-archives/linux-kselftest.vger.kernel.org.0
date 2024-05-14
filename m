Return-Path: <linux-kselftest+bounces-10164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11338C4B2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 04:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA982864F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585211879;
	Tue, 14 May 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0tJbCJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482CAD24;
	Tue, 14 May 2024 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654053; cv=none; b=ga2wqmgGxY8WBNeIlnQTL/hFJBFkWP70oqlBwnIP+WE1Xl1VeMYMHDucCdMqQhdj1Bct6OuYkXoqNQVOJUNrodxApz6o2icwtCsfYVDhH7GaasNmplHumscfQ17l2vpMdTCts7aKiiSiVepU6HokNu3RGbwA4SWmbR660aVCZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654053; c=relaxed/simple;
	bh=Fj4L+WmJwBpI33hWG+XhSdn5v/27r+qCR0+i4uR74Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYNV+mDXUCpUMSSf2iA4mwNggi1/0aXZIaClhMfYZTz1B5i7Jsr5OzPD6fwuosCoMTZ67j+SjGja3kjBp68Er6qMqF8W29oKqLC/S5GMhaaX4cnU6ezfK0rS8XfHz5E7pFDivcGT5bWF0p1+dHldW0iKagPbvoUZ4iFJhIjEtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0tJbCJy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44e3fd382so4155979b3a.1;
        Mon, 13 May 2024 19:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715654051; x=1716258851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KncoJsONQXdGs8dpSt8iIGQs9fO0BdlhjynEZlhIVCk=;
        b=e0tJbCJyTMEkOEytoEuoWPAwA2ZR5GFMi3CY+mWXmRzWyG14NT0qeaPMAKYCYM3niS
         DtG+lmJspo2vVPqiVmkeL3hpMoQQAQMrTJeIqWSLgclV4N9L/ITM+iKhyS5ojHOS7V1+
         XKEnL3DEimpvfYx7kEAjgumVL4+bqm2FcPurtg+7YYRwd1VYMY3dpjz35s0/4lS8KpnB
         7g6Ny6yzV3SHvZ/pqf3E57BCAz5G+SnPZrVaVuEG35oe8b3jhegbzJn8tDNUJOuxLfLU
         5n8CggDD2FgnxaC+rJrmh8Hq1vxo6s+1C+y/qL/JVpltUqUT/rKBGiTWrKsJNdvF/ca/
         KFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715654051; x=1716258851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KncoJsONQXdGs8dpSt8iIGQs9fO0BdlhjynEZlhIVCk=;
        b=QXDVZBtJqLKcR/0D34Vmb1FjUW400GCclEQZeSEkwcVCoLol+zA71UYkfkSkN/votp
         VrWMLXAhphJhaW+TC6hSFlTA7ts62wv7feXEgjP7POA9E56rBZ3cIxepUTkaDHD0Z3Ii
         4MnL2XH5iB8KXqPpbxobFD8DMZUpTQxfskZzHRmUYd6wYmo5+IHXssjvDzqeYvpqIW2V
         jz2cgevquv4aLRBp641Un44mR/yuYiyZTxz/zTfR57XujUOCuC23Nw7BAsWPy2W/v3k9
         xZABF4v37KbAmjZFaJ7lG7QDSJ0cCrHaLerfNeyCvjn6hgX1Xbp6+6iAZVWOyCIujve6
         tyTA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAhqjtOJDBwD/Uquyw8JH8f6HYU3MgR9pJ81ye9gfZ/Y+JSeZG8LhLYGEZFlvo2xTrMnDceWcUOL2R6Ewzn0TkgcNu798szcA8PI4sDaC
X-Gm-Message-State: AOJu0YxqiOIlpXq801T5TLhUvQAlVfAVo1yQBs12KI/7J5KUFLAy+2l1
	2y4bZr4jQfiRTLwKI+iI5BQebOnDQ08ALEAIu/oXGfsnZsezrlmtDQU3f5kRpJo=
X-Google-Smtp-Source: AGHT+IFfea6LdpiGGC40sAYZGj4ALwsOvNL8Ai5AGYQdrZlHQTPYfzgBnPhpgl7aB0oT7edFpiG2/A==
X-Received: by 2002:a05:6a20:a12a:b0:1ad:80ed:41 with SMTP id adf61e73a8af0-1afde238daemr12434379637.58.1715654050940;
        Mon, 13 May 2024 19:34:10 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c6fsm86475955ad.156.2024.05.13.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 19:34:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests/net/lib: no need to record ns name if it already exist
Date: Tue, 14 May 2024 10:33:59 +0800
Message-ID: <20240514023400.1293236-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to add the name to ns_list again if the netns already
recoreded.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f9fe182dfbd4..56a9454b7ba3 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -73,15 +73,17 @@ setup_ns()
 	local ns=""
 	local ns_name=""
 	local ns_list=""
+	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
 			eval readonly ${ns_name}="$ns"
+			ns_exist=false
 		else
 			eval ns='$'${ns_name}
 			cleanup_ns "$ns"
-
+			ns_exist=true
 		fi
 
 		if ! ip netns add "$ns"; then
@@ -90,7 +92,7 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		ns_list="$ns_list $ns"
+		! $ns_exist && ns_list="$ns_list $ns"
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
-- 
2.43.0


