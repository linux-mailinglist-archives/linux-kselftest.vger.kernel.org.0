Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1E408B3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbhIMMoh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 08:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhIMMoh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C86C60FC0;
        Mon, 13 Sep 2021 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537001;
        bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnnBgC2fW/3J0LuQWXX69BJiLMOb3CNaaqbcHeUNhKEqMDxK2DAp6jJs/4hZ24PkV
         yFdlbFXofgJJ1HzfYcwAGdhu5OMFy453KLkmIEqu6peeGsSTt4jdygtDV7rCZhGu9R
         /kobpvH4R+OJO03fw8KHF6PIE8pDB7+us5GhYPqcXdzHD5FB/HIjZz475WwRcmEegu
         8xhC/bnESTbSdExEirsPBXW9BzzW9PFjC+BqhYWa+Og+cOM68HB7vJYiyTLl1DpnoS
         SCbSi2/lnUcfzJvwM9kf1Ay8oLngk3zltWSXmdom/xNLFKnyyxZMVFVJ7uDSZ1pWm5
         kilp60RhWm4XQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/4] selftests: arm64: Fix printf() format mismatch in vec-syscfg
Date:   Mon, 13 Sep 2021 13:37:08 +0100
Message-Id: <20210913123711.51274-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913123711.51274-1-broonie@kernel.org>
References: <20210913123711.51274-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; h=from:subject; bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=; b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhP0XzFfNKGnLFWLyli3f4LmQge9pq7YMt+YL9ck0m EvunI0qJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9F8wAKCRAk1otyXVSH0D1oB/ d8QBXxLHdu12m4axhxQNTZp0jwE1nMwX8YNO/O4qYkhJGweMoZZpbs20jBPisH+ZCXr0hBd9sXpQbA MORNM/SM1rsZ42ys9voNK3UoHJZEjjArYz0trppwgwqAWcjhyII3iu2npRDxmY87ObjJ3FC1ahDv8T Ps89IbUvetuzIsJKPB3Ml7KjFD1cvWGBC2VMBtekiWhWp/BDPxSPesL3lI3FjbWzgq0G4J6Msmonqc fUtReEtHXZfVPUBtjvkN2JcxcMxNiOi7M/DEM3UV/9lJ2RpmVQUqBDFLhL9/zmdIV8kyC+saDJhOMC SoxKjVJs++PifnImPKl9TrXjHeerw=
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The format for this error message calls for the plain text version of the
error but we weren't supply it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index c02071dcb563..b2de002ee325 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -109,7 +109,7 @@ static int get_child_rdvl(struct vec_data *data)
 
 		/* exec() a new binary which puts the VL on stdout */
 		ret = execl(data->rdvl_binary, data->rdvl_binary, NULL);
-		fprintf(stderr, "execl(%s) failed: %d\n",
+		fprintf(stderr, "execl(%s) failed: %d (%s)\n",
 			data->rdvl_binary, errno, strerror(errno));
 
 		exit(EXIT_FAILURE);
-- 
2.20.1

