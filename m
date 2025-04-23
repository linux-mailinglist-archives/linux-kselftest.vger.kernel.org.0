Return-Path: <linux-kselftest+bounces-31455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286FA99AC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B223AB43C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B81926C3A9;
	Wed, 23 Apr 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R3bsEbHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A2244684
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443748; cv=none; b=fdPIGwwnekmtmOgB/MPqCSVcB2TiRPTNGdDAq7kaRIFIxh/Tnyz2zupg+3GqHl4eCwD+vQntBaWvwpbr4s9r+xNXXYGuERaDAdRGGp2OtBrV/6FblulBV5ccWoJkyuQLbYxBTOhc1Bfc6EKXugWH6Uxxhu9XOcsXfFZysQ2cqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443748; c=relaxed/simple;
	bh=VQOLPE77VFynA3OuP+UbKKlDLBd4nZcwYEnXe3Z4ge0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTglCEvC5gTQXjN0M+PcDDJCly9wxDcUoD9WBnY226dSViDDc2lIhW6sqs0NTh1Y5t+oX7UZIHM+EHH8Ll7xDhR6bNIMmYoyUUNFHQxmMCZn/tCtXfxmVP8g1Ief+hSbyxjCQshc7/mX7/MyQM2aWmqTM45T8YkuVtRjwF1WsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R3bsEbHl; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso5952266d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745443744; x=1746048544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCLEBLaRRQintuh2DWGEvr+93VgxR5KQlNFuF1s8elg=;
        b=R3bsEbHl9k2XqkAG7VrttB9h0tJ+LLbqMhDgYj68NVu0/IEuF54hp1SoZYxQ/LUdR8
         itGUpTUfUBM01vhn7NqHG8qOiXuvIoNbLHusrvykp+OHvqVIQ4uxebZ/SsuudI/124C6
         mJKupJqejpnQVmKPcmLItLAYF/RH+w3rnWLGVcoFCbndPZn2MAB/PlrePnCp6iko/LUy
         UN3Jbr0vV7LVlHt+5h35V/VfzAXtfFEyWT3x7NjuR687uEZjLtaRRv2BoimDGUxACFz9
         cjLjq6aZPUf+B9DCg6qN8HZHMueuMC/0fDUHqNyc+nyeww1FxU0AjeEzcSnhTyI7Al6e
         MJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443744; x=1746048544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCLEBLaRRQintuh2DWGEvr+93VgxR5KQlNFuF1s8elg=;
        b=qLTHaE+lnCneEjPflHvvguCdmuOOE/uuMF8YbIr4zqhQ6M7ufCqIQF8kbT6bbvMMl+
         2ihuqTs/0GXWK7eb6SAv3B+yiw8xAwrQpm78DdVicDnV+SS1Mddnf9wgv5srPRx73hk3
         R7+UwBWP9o8cMdbh6MfaSAtvGg79RzYwaHq1Ja6b+MQ9UUACrIlVWETXFSExS97bKgZB
         vl1XPypjbmRhpCxYoYCvZ5lolyNN0ew9/4LaYLry7pZRbaJSD23hSiAJScvLwvN4DjSC
         G+QYv7+dp7IpKVdH6mGjRAcwDAf0tpI9qjtDzRxQ0k3iTggQEJO16X6uGxSf+1gjtkyR
         J9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlCcv8RNuYkFe2cCn5CV7Hlyv1ibSjDQoVBzaKXs0s/dGgFOA+qmdss8PXVcDTwADhkl6Q5gZgwxEgWXmPeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDYTuoHc/th/hMUlY99qzNsbtY95yOj0PaEJGe39say0yToJ9
	pI8nxX9l4a+5ASzL4aF+FVtVNL+xTtYcNQU0I6ab2yN/o0AnuTRg5UzCZ3440BtW7MkOX2+H3vS
	VEqKfl9Feha8JJ+WMXirPPj4NwvnnxVUAuyxKTpfqRInrUujm
X-Gm-Gg: ASbGncuJiLRPFMNXR6KDX6jVrJj/pqwNqtwFYUiqedgepBsDzbQ1kSWEyRv4a5tBnaX
	lSCaAG/HtF84enCMfGxz4w4Z4wh3lcXcc4Y1rGh5W84uVCmkL4KGLncuIL4dI3QrNiJcuMpRelY
	OWk7f0kziiD7hX2Paz0+WHedkZyqLYCSpqDAFtpB6tojtOr1Y7PtZS06n3rlJFM2ZUWuOeCbzJ6
	GdQEJwqGYdsneUjNvHExkhZshkAoamyeqK9qww6QVBAfbNsQhVXqFKSRDhAwypQlREYFFC9Gz2z
	q/Inls+Ie8zsVWbXbDSA3CMAQR7If8Y=
X-Google-Smtp-Source: AGHT+IHnxwparxBZcK/VdcwSG32LkVIXSTRmpTrN+S3RXdjd04hZ9i9TCbHB9cDNMgycgsgCMiBSIn3HDpqA
X-Received: by 2002:a05:6214:500d:b0:6ea:d629:f492 with SMTP id 6a1803df08f44-6f4bfc7a7d9mr3649076d6.29.1745443744638;
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f2c2b1e111sm5267576d6.37.2025.04.23.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F2CA43409F5;
	Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EBDFBE40E4A; Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 23 Apr 2025 15:29:03 -0600
Subject: [PATCH 2/2] selftests: ublk: common: fix _get_disk_dev_t for
 pre-9.0 coreutils
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-ublk_selftests-v1-2-7d060e260e76@purestorage.com>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
In-Reply-To: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some distributions, such as centos stream 9, still have a version of
coreutils which does not yet support the %Hr and %Lr formats for stat(1)
[1, 2]. Running ublk selftests on these distributions results in the
following error in tests that use the _get_disk_dev_t helper:

line 23: ?r: syntax error: operand expected (error token is "?r")

To better accommodate older distributions, rewrite _get_disk_dev_t to
use the much older %t and %T formats for stat instead.

[1] https://github.com/coreutils/coreutils/blob/v9.0/NEWS#L114
[2] https://pkgs.org/download/coreutils

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/test_common.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 9fc111f64576f91adb731d436c2d535f7dfe5c2e..a81210ca3e99d264f84260aab35827e0c00add01 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -17,8 +17,8 @@ _get_disk_dev_t() {
 	local minor
 
 	dev=/dev/ublkb"${dev_id}"
-	major=$(stat -c '%Hr' "$dev")
-	minor=$(stat -c '%Lr' "$dev")
+	major="0x"$(stat -c '%t' "$dev")
+	minor="0x"$(stat -c '%T' "$dev")
 
 	echo $(( (major & 0xfff) << 20 | (minor & 0xfffff) ))
 }

-- 
2.34.1


