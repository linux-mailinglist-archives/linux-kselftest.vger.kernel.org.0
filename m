Return-Path: <linux-kselftest+bounces-45164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F1C42F11
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E6188CBBC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E423B605;
	Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEz1gbYN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366122538F
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617716; cv=none; b=ADMGwCe+2Shh0BPuoNvG4FCWb9Q8BEwxX/YHCgzGG9Co2oZh9tssqQuoEHNmlVUI3ljRlZBPct9NzdWduRyeaGBpjLPDwkDZMEW9XSdCEzeKCQAOxOPaPey4wHoONruTRnEQwEA77ro5SCX7V/xdtynxpxkkr2WBEcWuVdPXUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617716; c=relaxed/simple;
	bh=km2A2/M2INKPEdopMbzPv/EYa58WkO98Q3inMzUAOZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSEV5vi68WYW1l3utloTF7J3VmYFD6hXBnmG/M8r0asQc3BDMDfhnN+8Hax17VRzAZmhFHrLPOxTbYbqpyYwmg1APjr7VOo5NmLWVIV1sqs9FfGYmBJ/ptPXL/uhBmQIi6l8bZoKLNqi4V1YpFrvE+Wr7sLlKIxuv3XgGQg9cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEz1gbYN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso104442a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617713; x=1763222513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=nEz1gbYNZTr+rY281OkDfVTVMJOLc4X6QjFxBC9LAZ6BQlvjldWNY7MC51maNxajvv
         K76ixutlesig4bGJn3/tQbTAZD+9LjqXfkYN3ZNkPv9YMmx9R1TWTYiTkP4jMfbVfbMj
         QPQofkdom/dslCxMGfDjmeCG2jFWqc95wNhhomCJwYCYvEBi7vPakUaO4Go9soQbDxX/
         85Qgbw1LR6y5VBWmiukoCMv2pfiv7mj32mtj5SBiPwpbGgiOG4Is8KWic90lyB2fZaxD
         6wckIObZNl0douKZYkw2e+f+aUateFRu9xWBu4SVhQuf+MtkZpE2g+NIAK0o2Y0I1S6z
         RoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617713; x=1763222513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=UoM5ApW/BkJTKYqgsG2RL3sq14k9Hzn0p162auCcLunbQ0HwtM+fswwbvgOl90IYP6
         Y5RrFe2dzQ1hT/dHFdiBRkWSnikvpJFE1Hqlh8B3/ylax0u1bWbnsmOWshurY/qsALpk
         t5PDuxc1kTeQptxllxMSrWU8+E7w7YP9oMbHGtDFFUvOaY+CM/zlph8fovIJp/OiDoUY
         gSkxGTeCcqvxLb59PeaMlRuKvQWdaClP+yOwnPAfgH+mY8ey6dwz4JyfasN2iUS6WvlC
         0h0HeQsv5rGP4cLTmiyouG3VDs1lmjjPvEB0NU63DWN52nF2paKPUzud+6EjgPQEkuSq
         OFHA==
X-Forwarded-Encrypted: i=1; AJvYcCUbKyU6S762ZW36BKA/EIQr1XgqrfL5gjI+vUD5LhWtjWiwnVGjHn49jYVrjxSdyYKzjqq5Crdz2CE9UqEntmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLvqbuAo/d5uRRghxwoRWgaRmd+EYOtMSSsGnoOzqqoc0mXJM
	vA9c9KoThVuG2BVe92mnn2PgspmvwqD+B4S6EhrNdadQ0542mHneh11e
X-Gm-Gg: ASbGncsKpxGBat9GDLgzhKOqQ93DEKNXvHmiERFmBp324y9pJtrEnRZNMM9ehUVx8MX
	r+Kiv7YT/npprN/NXMlEwL7Q7VMS8kuvxxEiwUIUugWkECzwpQ5qKw/6sltfuOMwUU8EMk0uWUH
	DpRNsTxKgJev8rZVC9wDhgXVqunBca1feWCFQA+7CJG/m5aougom04ZNZxTTtvgzaBJsMcSe2BL
	JGL2q74mWKptL0hEIerJr1qzJd0z0QyAbUTxV8OQNI9+0rPL0aIq+v+308ZhjC6zXu+Y/U+hIev
	wk8y9PqbBWpARUMh/RGZTKPW25Kp8wMjRiSYj/WObY8LXdtQl1alxhf+Gb+eNbfrH7P6NDYnUsX
	XWqj7kdal8dtkDWkDpKnMdhl9kUU5LPLOD/shLUWw3bgNTYKbBEFrEnGEBxhs+rZ1pHxF6wCJ
X-Google-Smtp-Source: AGHT+IEXDETrGkQl7MwHVPnvPebwCXZubSUcSknCNmpO3Ei+QqK+KDEUJEIjXX7gb8KeZQyo0pNbCg==
X-Received: by 2002:a17:902:d507:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-297e571bce3mr36484105ad.56.1762617712966;
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f6cdsm95463135ad.71.2025.11.08.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:53 -0800
Subject: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exits, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bc16b13cdbe3..01ce16523afb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3


