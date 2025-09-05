Return-Path: <linux-kselftest+bounces-40859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D4B46011
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E8AA623B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FE371E9B;
	Fri,  5 Sep 2025 17:25:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CF3568F9;
	Fri,  5 Sep 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093131; cv=none; b=SgXGwEFPxFGxF+0InlYpsu8FnVv5C+y4JCWLdw3c0+hUDEsq4G+H0msWO4LH9DrPVJu0um6mKrQ/dkLfcLbfgA518aXuLk2Iu/lJloat6NG7NoDbnSjWtKWUmV4s31IOO66bv/v5bwk44tikjYMD+icK3MIEAuJxBI4kirZpXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093131; c=relaxed/simple;
	bh=bfYwUE4OVS5dIORTV1s7iqAOdSg5SLSB644QnoX7bxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7GnEeofcwFcxLxySoEn483SfmLhLONh9X1TCnIu524zcyPqO78+jaanci9Ljk2xrboA/KcbJdsQw3ngBC0lONcUy1fw6vUTgL0Bo1cmIgPa5SE0OHiFcKt+ayVgD2NKpm7SwIiDxcf6ufEEoUHkFglsC7vmjW/bprMnPaFhXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so767385a12.2;
        Fri, 05 Sep 2025 10:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093128; x=1757697928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEMO7BCjA9GH881UcwMUUQsdkiwQYebSV0QqX91LYWI=;
        b=p3gun5lddJbeSyCfBCuwpiooATdPITl7b0E99cpTn8gUutvVcgApatAj+KsipwTTIQ
         7xy9/mPzg8Ru0JnGxFp2vmvwB0WAfsz9Yb4svprjqPXHKSXz4agJ2VMSwnr6Fx3bXOqB
         wIMH6Bch5Su2UEtgifI0hTREfplLCX34tcK1GtvjEhXnyOqDSja/AZI7YBQ4mvoJCj3o
         l32cO890oN1SinvTm6vgJE4tINC7dSHBO32xn1Z5zNPfiJwWAoAQUkiwCun9aWZwcDD1
         uzIMEoFAWvc6zJQvTc36CzkHKxi7neKQGID05THeRgUIdDl5dkxVzCvfqDsVqA/H2d+V
         paYA==
X-Forwarded-Encrypted: i=1; AJvYcCWJnzrEFw12xlIxKL/gQikODn9MNid6noRnevLILJvcfn/ZZoOeR+LkRmBxK17pQEIgwUs7MV33mVndZJswCSs=@vger.kernel.org, AJvYcCXBoNcEbFAe7fXBV7zT76ofIgNlqq2cRXP0fN2ne9CHEGF8RvGpJ+aFbM38GBtxaMKhUHm3lYcz@vger.kernel.org, AJvYcCXLH8CtdsPLu2+0dSdJT5bNrb8isyCQG91gr8h8kt0inajHW67ulmcdBmsR3/+TyCowgSjsRhKB@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW1CxN0Wd4yR53uWXGWukj1aIRdCNYCtlQf6+sLI2Tcq85THU
	oW0pXqcp1v/BxwaHgRjCwVmqsK90kurZDh2e9lvFU6QDVg9n2QH0N1wY
X-Gm-Gg: ASbGncsta3/ER5w0GMaXeywEYzFEO6bgRCufLLTV8TiBZyWfjaUkyawx8klPtuoBJTz
	5vQXPPYrAYmTzEesHFhHwyBwft6KAnsYmx/jQwGH0qwSHT5NP28lt9BOnEncSr2GEyk/RgvlIaG
	YVPT+ZE8PBbGSWissHjFunwrhvnMMBqZfzfLSwetMS14v2G1dxQpSK05P2e/A3Y1UYCUCO6Ie0p
	q7lU6ArPRlrpqggriZ8tXbP7hn9omBlv2LjHKC6C/iAo/TV3HrmBSAurs3FCOXaVX8TFznFPQ6B
	DsHb5+Q8rslYXx/sPPAm4QBQsVepMWZ0jPdEnUqp60fn2dXMwqLztzdF+VI0Y9TT3s7P28Fduj+
	HZotj5/jZBuDdCsmScVvG4t8D
X-Google-Smtp-Source: AGHT+IGDHg85vszzUUpPyeKq3DBDkfnWUoJrh3oa+OUrFLf7pI3+IsDMGFppu1ss9rEUW6+3dWJ5MA==
X-Received: by 2002:a05:6402:44d5:b0:620:e309:6c67 with SMTP id 4fb4d7f45d1cf-620e3096ec9mr3379621a12.2.1757093127982;
        Fri, 05 Sep 2025 10:25:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc575b94sm16098463a12.53.2025.09.05.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:25:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:25:08 -0700
Subject: [PATCH net v3 2/3] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-netconsole_torture-v3-2-875c7febd316@debian.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
In-Reply-To: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=leitao@debian.org;
 h=from:subject:message-id; bh=bfYwUE4OVS5dIORTV1s7iqAOdSg5SLSB644QnoX7bxU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoux0CPTyvJRGj9VPc/H4/0CDC+ynTYtupnkgIO
 cnvSjJDMXKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsdAgAKCRA1o5Of/Hh3
 bVwZEACwgoH3hyAiWCL0sp4QmkyT/FDNZQT4zEDqBj4Ksz3H2Ij5kPEKhf277hsJJBum/94ssFg
 2WUFtGoUVj9a68JE1I98wzX7Jlp40tKFZSgfxSgnZGEij/r45/qo8cm41S2OTptHpJZH8xNe+27
 fYDAh1xpANBR2TWq2/sNDTRNE49CSWaYLskhnXnA3hWbRJXRIEmj43RbO4Mfv/ifYxSASKqlgM0
 2ve4I7YkJhlBINAWjF0J5OjkggW3muayiWiwRDG/qtixPT9pOpTDs+wFuqPEkfzamS2kcXWtl78
 KTX8pAEOAiBw8fNCWSkkAdAPEQ3vUT5+bAQrfxHOSVl8/PYPaV+SjhpX6ORbvg4MoQ0NAIFgta3
 MV/MNRTcwpnVefx0Md/HdCowVsuvb/r0oFlCQvc+5dA9unY+UdVNM8H+bYMLMNZEw/aNmx8UXkd
 xPhTTGavcPvoCt4sIvFgPvHXXz76b/GiA+1JMblUGHOIWuf9X+69W8otl9oJ91xN34pDf890dQM
 KwOFztzXkexmpWWxCqEXn8XklPyJ5GfHTUXrmLH4HGxSAESNZIGkDwI/59MgQBe1tqglo1RCI64
 jBIeCQlJ6AC01xiYA9N1WQ2BaOKDdb39KKX3tkHR8wZKULHHbfOvak1ayZjJfF3uZ7ly9Y1x6NR
 04WMDGzxAhPspDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index b6071e80ebbb6..4fc102407e3a6 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3


