Return-Path: <linux-kselftest+bounces-5527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1686AE82
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773161C24833
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C366CDC8;
	Wed, 28 Feb 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsG8VPCk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90F7351E;
	Wed, 28 Feb 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121445; cv=none; b=dkFNxGKj4FpsPAoiiMiQdxEdlU2wydykgDlwMEcEcXygI/mDPgEpJX5peAXo65+Tcxdr+8qyY9OQgJRiH+993K50d5rSvH8wCCDdJxjQVdjmJ1aNDqgc44YWDYpdC2Q0F9H2dIxthFO1aLZa52oroQV425D0DhIlZJl/0Bn4FWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121445; c=relaxed/simple;
	bh=rcSNTBiRF+f+3t3RzyuU+qKQ8ru2QZn9y+YmrmBALig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHQFyOBcuAtYP28Fh7tew2DmU6xhYzIRWEtwwgbhGbu10PyPIVDfkL67J1wleYfKdH2vwL3YCQYedcUjOtDCYMpwdwb0iqRM5NSt9on4b5iXUN1vZ54Z5dboH5HqornVy8HZhaMd4Jy7I5Oh/zFi1hjeIibIJ/17554pcggpl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsG8VPCk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcc7f4717fso7467195ad.0;
        Wed, 28 Feb 2024 03:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709121443; x=1709726243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=hsG8VPCkQ4SPnzuYE5BesN9VIC7c2/XUIqQraZGAOZhuVqTHdYVW1Q9fypO3Fzc5kR
         GI7X88eVsFVSl+45kvJNx6YJHulGv8Vs96p+v4kAaw/xIwULrwJMYkR3Vm833BqHb2VA
         dnr0lQEk1UocIdnLIDXFKVqlQ52Is8E7IlASrAz5bWgMFpEjpD67HlYXTNmQJImtUyOY
         Bvs4F3qnh4DbWWB0+D0stcJVJtDn5g9IcgbSQR0S6NMrkk/Csp+w8lKbnLyJof8fakBO
         mODL7BWEBSTiNwdXIvZHH5bV/FOfQnKNJQ5QBhwK/Eosgs91m60DP5jn8XyWvNNI5QjM
         YhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121443; x=1709726243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=cbzsVkB4E72TYKHymJY42M2gP6JpximJk2raPmni0IDfownt8hx56qo2cR22Pf45MA
         P2wvwgLZJpcjewf2JjAgOI2muDOmWO79pDxSwP1eqbRL50VU0Vw+7bYqv/Dt+9PbJfB1
         ag2UNX7tHbfZyH9h0leYR+146EHR779Ta4ibx/EKA5tuRmvJwQ6DuVbPO8/FYxUaGt6J
         gBZXvUY43go8oIGkC0Hzd4UcFUzVq43oYjZaBubZVcQuEPwgI0yNdReNfV3wpxLkN2wg
         ZhYQbuUzkNLvghtIn4JLSPz1DVVwOUnhc5UT2f9Na6F0z3y2204RP64UnbvHhHuPvI5a
         wypQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmX/XG9AC4RQwsAFqLojI4xD8koj85hLgIvvZTBPm7ahuH+GHOxlg2Im57POwceXnTPsnDzY1S1YQbQhdB9GiqgoFJJ6b5rcDKAChASIarpciGb382phznsvotATD3dL+EXJOkr//VYRMNdCV7
X-Gm-Message-State: AOJu0YwCl7AIH4FKCG4oQMF/9h2W17jzV4VdE56zJV9uk+O7hsXEBbGk
	T9i6nmk6Mu4pVEx1B0JKcKYAgx1yXiLYfQQ1rK4rqkyRIBnB3Cqk
X-Google-Smtp-Source: AGHT+IF51RV9A4dYFGcyQ378LWI5tKCNm6KT+pRauZgzs8Pdzqw0S11E1x9Hv/cyW2/s+TaVikNpyg==
X-Received: by 2002:a17:902:fc87:b0:1db:4941:f703 with SMTP id mf7-20020a170902fc8700b001db4941f703mr14753116plb.15.1709121443368;
        Wed, 28 Feb 2024 03:57:23 -0800 (PST)
Received: from localhost.localdomain ([115.99.206.243])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090270c800b001dc23e877c9sm3141647plt.106.2024.02.28.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:57:22 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH net-next] Correct couple of spelling mistakes
Date: Wed, 28 Feb 2024 17:27:07 +0530
Message-Id: <20240228115707.420200-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes :
	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
 tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 616d3581419c..31252bc8775e 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -869,7 +869,7 @@ bloom_simple_test()
 bloom_complex_test()
 {
 	# Bloom filter index computation is affected from region ID, eRP
-	# ID and from the region key size. In order to excercise those parts
+	# ID and from the region key size. In order to exercise those parts
 	# of the Bloom filter code, use a series of regions, each with a
 	# different key size and send packet that should hit all of them.
 	local index
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
index 7d7829f57550..6c52ce1b0450 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
@@ -49,7 +49,7 @@ for o in llrs rs; do
 Active FEC encoding: ${o^^}"
 done
 
-# Test mutliple bits
+# Test multiple bits
 $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
 check $?
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-- 
2.34.1


