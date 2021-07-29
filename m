Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8555E3DAA67
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhG2Rhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhG2Rhj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:37:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCF160F42;
        Thu, 29 Jul 2021 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627580256;
        bh=cqrIBm2+sPklmC33fnKs89kCRIiPSCWLJxj9sFAPJDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8LK8n4f3Ok3kQ2k+PRuT/K75+0RTmp/aBrZpaZYCygKwc4xt3JP5epoUnIrcaNlf
         J/w69jWmEaSVaT5diYraUjpSQ9wndv2gF0EknbMJ+EjILBRUhApg/kWOeU6+JPbpWr
         KzYjvbcuNspLBHs4e6K9gBKwgh12uDiC2U8Zzsm/L2kSOQZNlgd2M81jM7cLrF39k/
         UeiG/YAXceFljLRt8tRLVCexSxbKWfe04WqXHUEE0QRQWmrBGV+jca5vwlDeVirHcm
         ncYgP9SOUeruySnLyDjli2sPUdJejLlfOofy/NrZ3YokpxzVMaAvd1n9eZewIS1yo6
         Mqhh/Q3IinyRw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 4/4] kselftest/arm64: Add a TODO list for floating point tests
Date:   Thu, 29 Jul 2021 18:37:13 +0100
Message-Id: <20210729173713.4534-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729173713.4534-1-broonie@kernel.org>
References: <20210729173713.4534-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; h=from:subject; bh=cqrIBm2+sPklmC33fnKs89kCRIiPSCWLJxj9sFAPJDg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAudIpAt85pVYYwEvPdu3ySEq4insB+GbRbW9Wt46 aWTg8G+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQLnSAAKCRAk1otyXVSH0LuQB/ 9qqmY9aNIXsJ435N/UpULhUjREijRfIqfAVltCqUpOLH5tdkK/WGSaAK68jfzwXBpTyyjx9PF/HONV C4jgtHE/GQjtlK+tFoFKG6EgvkDx1NxJPslapD73aa9itICxfEv6/FXfo0/GdHv3bsZagF/GEnVrE/ heOJj/eC+JpFoRTslY9F96XG6Cp0RiaRxlEICt2emzvt7hdKa5YDo8yCf5sZhfqfZaXXsiIfJDrCup d8w5SHDAnVXwgy5gJNbsBPU6BH4OUD1pG1+le1hTT4AJBXOJpN3jrgeBYC/V6q+RWbHI8B7PiEGSYG XN2/mv7yAOPXy/azUsL7Zw6qBLBw4G
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write down some ideas for additional coverage for floating point in case
someone feels inspired to look into them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/TODO | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO

diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
new file mode 100644
index 000000000000..eada915227cf
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/TODO
@@ -0,0 +1,3 @@
+- Test unsupported values in the ABIs
+- More coverage for ptrace (eg, vector length conversions).
+- Coverage for signals.
-- 
2.20.1

